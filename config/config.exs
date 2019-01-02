use Mix.Config

config :crypto_bot,
  slack: [
    api_key: System.get_env("SLACK_API_TOKEN")
  ],
  crypto: [
    provider: CryptoBot.CryptoCompare,
    base_url: System.get_env("CRYPTO_BASE_URL"),
    api_key: System.get_env("CRYPTO_API_KEY")
  ]
