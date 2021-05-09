defmodule TiltifyWeb.RateController do
  use TiltifyWeb, :controller

  alias TiltifyWeb.RateServices.ApiCore

  def index(conn, _params) do
    render_error_message(conn, :not_found, "404.html")
  end

  def show(conn, %{"base" => base, "amount" => amount, "target" => target}) do
    with(
      {:ok, _} = ApiCore.ensure_only_eur(base),
      {:ok, response} = ApiCore.make_api_call("EUR", amount, target)
    ) do
      render(conn, "rate.html", rate: response)
    else
      {:error, %{view: "unsupported.html", base: base}} -> render_error_message(conn, :unprocessable_entity, "unsupported.html", base)
      {:error, error_info} -> render_error_message(conn, :unprocessable_entity, "error.html", error_info)
    end
  end

  def show(conn, %{"base" => base}) do
    render_error_message(conn, :unprocessable_entity, "unsupported.html", base)
  end

  defp render_error_message(conn, status, view, info \\ nil) do
    conn
    |> put_status(status)
    |> put_view(TiltifyWeb.ErrorView)
    |> render(view, info: info) 
  end
end
