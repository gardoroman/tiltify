defmodule TiltifyWeb.RateController do
  use TiltifyWeb, :controller

  alias TiltifyWeb.RateServices.ApiCore

  def index(conn, _params) do
    conn
    |> put_status(:not_found)
    |> put_view(TiltifyWeb.ErrorView)
    |> render("404.html")
  end

  def show(conn, %{"base" => base, "amount" => amount, "target" => target}) do
    rate = %{base: base, amount: amount, target: target}
    render(conn, "show.json", rate: rate)
  end
end
