defmodule TiltifyWeb.ErrorView do
  use TiltifyWeb, :view

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("error.html", %{error: message}) do
    %{error: message}
  end

  def render("unsupported.html", %{info: base}) do
    "<h1>Base #{base} not supported</h1>" <>
    "<p>The service only supports EUR at the moment.</p>" <>
    "<p>STATUS CODE 422</p>"
  end  

end
