defmodule TiltifyWeb.RateView do
  use TiltifyWeb, :view

  def render("show.json", %{rate: rate}) do
    %{data: render_one(rate, TiltifyWeb.RateView, "rate.json")}
  end

  def render("rate.json", %{rate: rate}) do
    %{base: rate.base,
      amount: rate.amount,
      target: rate.target
    }
  end

end
