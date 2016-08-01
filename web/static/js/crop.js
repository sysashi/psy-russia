export default edit 

const InvalidImgFile = new Error("Invalid image file")

const WIDE = Symbol()
const HIGH = Symbol()
const SQUARE = Symbol()

function edit(file) {
    console.log(file)
    let img = img_from_file(file)
    show_editor(img) 
}

function crop(file) {
}

function show_editor(img) {
$("#image-editor").remove()

  img.onload = function() {
    let img_height = img.naturalHeight
    let img_width = img.naturalWidth

    let ratioW = img.naturalWidth / img.naturalHeight
    let ratioH = img.naturalHeight / img.naturalWidth
    let ratio = Math.min(ratioW, ratioH)

    console.log(`img width: ${img_width}, img height: ${img_height}`)
    console.log(`img ratio W: ${ratioW}, img ratio H: ${ratioH}`)

    
    let wh = editor_wh(dummy_ratio(ratioW))

    let canvas_prop_size = fill_prop(wh.width - 20, wh.height - 20, img_width, img_height, ratio)

    document.body.insertAdjacentHTML("afterend", template(wh))
    $("#done").on("click", (e) => $("#image-editor").hide())
    let canvas = document.getElementById("editor")
    let ctx = canvas.getContext("2d")

    canvas.width = canvas_prop_size.w
    canvas.height = canvas_prop_size.h 

    let centerShift_x = ((wh.width) - canvas.width) / 2
    let centerShift_y = ((wh.height) - canvas.height) / 2
    console.log(centerShift_x, centerShift_y)

    canvas.style.marginTop = centerShift_y + "px"
    canvas.style.marginLeft = centerShift_x + "px"

    pica.resizeCanvas(img, canvas, {}, () => {})

    let editCanvas = document.createElement("canvas");

    $(editCanvas).mousemove(e => {
      let rect = editCanvas.getBoundingClientRect()
     // console.log(e.clientX - rect.left, e.clientY - rect.top)
    })


    let editCtx = editCanvas.getContext("2d");
    editCanvas.id = "edit-canvas"
    editCanvas.width = canvas_prop_size.w
    editCanvas.height = canvas_prop_size.h
    editCanvas.style.marginTop = -canvas_prop_size.h + "px"
    editCanvas.style.marginLeft = centerShift_x + "px"
    let radius = Math.min(canvas_prop_size.w, canvas_prop_size.h) / 3
    editCtx.lineWidth = 2 
    editCtx.fillStyle = "rgba(100, 100, 100, 0.5)"

    editCtx.fillRect(0, 0, canvas_prop_size.w, canvas_prop_size.h);


    draw_circle(editCtx, 
        "rgba(255,255,255,0.8)",
        canvas_prop_size.w / 2, canvas_prop_size.h / 2, 
        radius, 
        0, 2 * Math.PI)
    
    editCtx.save()
    clip_circle(editCtx, 
        canvas_prop_size.w / 2, canvas_prop_size.h / 2, 
        radius - 20, 
        0, 2 * Math.PI)
    editCtx.clearRect(0, 0, canvas_prop_size.w, canvas_prop_size.h)

    editCtx.lineWidth = 2 

    draw_circle(editCtx, 
        "rgba(255,255,255,0.8)",
        canvas_prop_size.w / 2, canvas_prop_size.h / 2, 
        radius, 
        0, 2 * Math.PI)

    $(editCanvas).mousedown(e => {
      $(editCanvas).mousemove(e => {
        editCtx.restore()
        let rect = editCanvas.getBoundingClientRect()
        let x = e.clientX - rect.left
        let y = e.clientY - rect.top


        editCtx.clearRect(0, 0, canvas_prop_size.w, canvas_prop_size.h)
        editCtx.fillRect(0, 0, canvas_prop_size.w, canvas_prop_size.h)

        draw_circle(editCtx, 
            "rgba(255,255,255,0.8)",
            x, y,
            radius, 
            0, 2 * Math.PI)

        editCtx.save()

        clip_circle(editCtx, 
            x, y,
            radius, 
            0, 2 * Math.PI)

        editCtx.clearRect(0, 0, canvas_prop_size.w, canvas_prop_size.h)

        draw_circle(editCtx, 
            "rgba(255,255,255,0.8)",
            x, y, 
            radius, 
            0, 2 * Math.PI)
      })
    })

    $(editCanvas).mouseup(e => {
      $(editCanvas).off("mousemove")
    })

    let image_editor = document.getElementById("image-editor-wrapper")
    image_editor.appendChild(editCanvas)
  }

}

function draw_circle(ctx, strokeStyle, ...params) {
  let oldStrokeStyle = ctx.strokeStyle
  ctx.beginPath()
  ctx.strokeStyle = strokeStyle
  ctx.arc(...params)
  ctx.stroke()
  ctx.strokeStyle = oldStrokeStyle
  return ctx
}

function fill_circle(ctx, fillStyle, ...params) {
  let oldFillStyle = ctx.fillStyle
  ctx.beginPath()
  ctx.fillStyle = fillStyle
  ctx.arc(...params)
  ctx.fill()
  ctx.fillStyle = oldFillStyle
  return ctx
}

function clip_circle(ctx, ...params) {
  ctx.arc(...params)
  ctx.clip()
  return ctx
}

function fill_prop(w, h, imgW, imgH, ratio) {
  let canvas_ratio = w / h
  let image_ratio = imgW / imgH
  let dimentions 
  if(canvas_ratio > image_ratio) { 
    let w = imgW * (h / imgH)
    dimentions = {w, h}
  } else {
    let h = imgH * (w / imgW)
    dimentions = {w, h}
  }

  return dimentions
}

function editor_wh(dummy_ratio) {
  switch(dummy_ratio) {
  case WIDE:
    return {width: 600, height: 400}
  case HIGH:
    return {width: 400, height: 600}
  case SQUARE:
    return {width: 400, height: 400}
  }
}

function dummy_ratio(ratio) {
  if (ratio > 1) {
    return WIDE
  } else if (ratio < 1) {
    return HIGH
  } else {
    return SQUARE
  }
}

function img_from_file(file) {
    let imageType = /^image\//
    
    if (!imageType.test(file.type)) {
        throw InvalidImgFile
    }

    let img = document.createElement("img")
    img.classList.add("obj")
    img.file = file
    
    let reader = new FileReader()

    reader.onload = (function(aImg) { 
        return function(e) { 
            aImg.src = e.target.result 
        } 
    })(img)

    reader.readAsDataURL(file)

    return img
}

const template = (data) => { return ` 
<style>
#image-editor {
position: fixed;
left: 50%;
top: 50%;
background: #8889ae;
z-index: 2;
border-radius: 2px;
border-bottom-left-radius: 0;
border-bottom-right-radius: 0;
}
#image-editor-wrapper {
  height: 100%;
}
#editor {
margin-top: 10px;
margin-left: 10px;
background: #b4b9cb;
}
#image-editor-panel {
background: #B5F6D2;
padding: 2px 0;
}
.i {
margin-left: 10px;
font-size: 20px;
line-height: 30px;
color: #444;
}
#done {
float: right;
margin-right: 10px
}
</style>
  <div id="image-editor" style="margin-left: -${data.width / 2}px; margin-top: -${data.height / 2}px; height: ${data.height}px; width: ${data.width}px;">
  <div id="image-editor-wrapper">
      <canvas id="editor"></canvas> 
  </div>
  <div id="image-editor-panel">
    <span class="i" id="rotate-acw-90">↶</span>
    <span class="i" id="rotate-cw-90">↷</span>
    <button id="done"> Save </button>
  </div>
  </div>
`}
