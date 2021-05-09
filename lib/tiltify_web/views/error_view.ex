defmodule TiltifyWeb.ErrorView do
  use TiltifyWeb, :view

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("error.html", %{error: message}) do
    %{error: message}
  end

  def render("unsupported.html", %{info: base}) do
    "Base #{base} not supported" <>
    "The service only supports EUR at the moment." 
  end  

end
