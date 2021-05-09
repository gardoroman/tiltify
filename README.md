# Tiltify

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Setting up the Service

  * This app requires an API key from fixer.io
  * Create an environment variable named CURRENCY_API_KEY and set it with the API key obtained from fixer.io

## Notes on the App
  * to use service navigate to `rates/EUR/amount/target`
  * EUR is required as the base because it is the only based supported on the free tier
  * amount is valid currency amount
  * target is any of the symbols supported by the fixer.io service
