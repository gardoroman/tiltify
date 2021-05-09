defmodule TiltifyWeb.RateServices.ApiCore do

    #-------------------------------------------------------------------------
    # The free tier for fixer.io only allows "EUR" as a base pair.
    # Ensure the passed in base pair is "EUR" otherwise return error tuple.
    #-------------------------------------------------------------------------
    def ensure_only_eur(base) do
        formatted_base = String.upcase(base) |> String.trim()
        if formatted_base == "EUR" do
            {:ok, formatted_base}
        else
            {:error, %{view: "unsupported.html", base: base}}
        end
      end

    def make_api_call(base, amount, target) do
        date = Date.utc_today() |> Date.to_string()
        api_key = System.get_env("CURRENCY_API_KEY")
        # "http://data.fixer.io/api/convert?access_key=" <> api_key <> "&from=" <> base <> "&to=" <> target <> "&amount=" <> amount
        # suscription required for convert
        # "http://data.fixer.io/api/convert?access_key=#{api_key}&from=#{base}&to=#{target}&amount=#{amount}"
        # "http://data.fixer.io/api/latest?access_key=#{api_key}&base=#{base}&symbols=#{target}"
        # "http://data.fixer.io/api/symbols?access_key=#{api_key}"
        "http://data.fixer.io/api/#{date}?access_key=#{api_key}&base=#{base}&symbols=#{target}"
        |> HTTPoison.get()
        |> parse_api_call()
    end

    def parse_api_call({:ok, %HTTPoison.Response{body: body}}) do
        {:ok, decoded_body} = Jason.decode(body)
    end
end