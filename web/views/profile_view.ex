defmodule PsyRussia.ProfileView do
  use PsyRussia.Web, :view

  def render("step-" <> <<step::binary-1>> <> ".html", assigns) do
    render_step(step, assigns)
  end

  defp render_step("1", assigns) do
    render("primary_fields.html", assigns)
  end
  defp render_step("2", assigns) do
    render("secondary_fields.html", assigns)
  end
  defp render_step("3", assigns) do
    render("documents.html", assigns)
  end
  defp render_step(_, _) do
    render(PsyRussia.ErrorView, "404.html")
  end
end
