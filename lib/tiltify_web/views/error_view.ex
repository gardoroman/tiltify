defmodule TiltifyWeb.ErrorView do
  use TiltifyWeb, :view

  @proper_format "Please format request properly, e.g. rates/EUR/10/USD"

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("error.html", %{info: message}) do
    message <> " " <> @proper_format
  end

  def render("unsupported.html", %{info: base}) do
    "Base #{base} not supported" <>
    "The service only supports EUR at the moment."
  end

  def render("unknown.html", %{info: target}) do
    "Target: #{target} is unknown " <> @proper_format
  end  

end
