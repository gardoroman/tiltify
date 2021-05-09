defmodule TiltifyWeb.ErrorView do
  use TiltifyWeb, :view

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("error.json", %{error: message}) do
    %{error: message}
  end  
end
