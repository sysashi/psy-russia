export default edit 

const InvalidImgFile = new Error("Invalid image file")

function edit(file) {
    console.log(file)
    let img = img_from_file(file)
    show_editor(img) 
}

function crop(file) {
}

function show_editor(img) {
    document.body.insertAdjacentHTML("afterend", template);
    let canvas = document.getElementById("editor")
    let ctx = canvas.getContext("2d")

    img.onload = function() {
        // ctx.drawImage(image, 0, 0, 300, 400, 0, 0, 300, 400)
        console.log(img.naturalWidth, img.naturalHeight)
        var hRatio = canvas.width  / img.naturalWidth
        var vRatio =  canvas.height / img.naturalHeight
        var ratio  = Math.min ( hRatio, vRatio )
        console.log(hRatio, vRatio)
        var centerShift_x = ( canvas.width - img.width*ratio ) / 2
        var centerShift_y = ( canvas.height - img.height*ratio ) / 2
        ctx.clearRect(0,0,canvas.width, canvas.height)
        ctx.drawImage(img, 0,0, img.width, img.height, centerShift_x,centerShift_y,img.width*ratio, img.height*ratio)
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

const template = ` 
    <style>
      #image-editor {
        position: absolute;
        margin: 0 auto;
        left: 0;
        right: 0;
        top: 0;
        height: 400px;
        width: 600px;
        background: lightblue;
        border: 1px solid #888;
        padding: 40px;
        z-index: 2;
      }
      #editor {
        border: 1px solid #888;
        height: 100%;
        width: 100%;
      }
    </style>
    <div id="image-editor">
      <canvas id="editor"></canvas>
      <div id="image-editor-pane">
        <button> Rotate 90 deg </button>
        <button> Save </button>
      </div>
    </div>
`
