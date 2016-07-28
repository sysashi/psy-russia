defmodule PsyRussia.LayoutView do
  use PsyRussia.Web, :view

  def active?(term1, term2) do
    if term1 == term2 do
      :active
    end
  end
end
