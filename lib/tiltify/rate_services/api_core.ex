defmodule TiltifyWeb.RateServices.ApiCore do

    #-------------------------------------------------------------------------
    # The free tier for fixer.io only allows "EUR" as a base pair.
    # Ensure the passed in base pair is "EUR" otherwise return error tuple.
    #-------------------------------------------------------------------------
    def validate_base_currency(base) do
        formatted_base = format_currency(base)
        if formatted_base == "EUR" do
            {:ok, "EUR"}
        else
            {:error, %{view: "unsupported.html", base: base}}
        end
    end

    def validate_target_currency(target) do
        target = format_currency(target)
        if String.length(target) === 3 do
            {:ok, target}
        else
            {:error, %{view: "unknown.html", base: target}}
        end
    end

    def validate_amount(amount) do
        if Regex.match?(~r/^[1-9]\d*(\.\d+)?$/, amount) do
            {:ok, amount}
        else
            {:error, "An improper value was provided. Please make sure that it is a valid currency amount."}
        end
    end

    def make_api_call(base, amount, target) do
        date = Date.utc_today() |> Date.to_string()
        api_key = System.get_env("CURRENCY_API_KEY")
        "http://data.fixer.io/api/#{date}?access_key=#{api_key}&base=#{base}&symbols=#{target}"
        |> HTTPoison.get()
        |> parse_api_call()
        |> handle_response(target, amount)
    end

    def parse_api_call({:ok, %HTTPoison.Response{body: body}}) do
        {:ok, decoded_body} = Jason.decode(body)
        if decoded_body["success"] do
            {:ok, decoded_body["rates"]}
        else
            {:error, decoded_body["error"]["info"]}
        end
    end

    def parse_api_call({:error, _}) do
        {:error, "The service encountered an unknown error. Please try again"}
    end

    def handle_response({:ok, rates}, target, amount) do
        rate = rates[target] |> to_string()
        conversion = 
            Decimal.mult(amount, rate) 
            |> Decimal.round(2)
            |> Decimal.to_string
        response = conversion <> " " <> target
        {:ok, response}
    end

    def handle_response({:error, info}, _, _), do: {:error, info}

    defp format_currency(currency), do: String.upcase(currency) |> String.trim()
    
end