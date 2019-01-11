# CryptoBot

Slack Bot in Elixir to get real-time pricing of coins and currency pairs.

## Requirements

- Elixir 1.6 or later

## Installation

TODO

## Usage

TODO

## Configuration

You can customize the bot using the following configuration:

```elixir
config :crypto_bot,
  slack: [
    api_key: System.get_env("SLACK_API_TOKEN")
  ],
  crypto: [
    provider: CryptoBot.CryptoCompare,
    base_url: System.get_env("CRYPTO_BASE_URL"),
    api_key: System.get_env("CRYPTO_API_KEY")
  ]
```

- `provider`: Implementation of `CryptoBot.Provider` behaviour. Defaults to `CryptoBot.CryptoCompare` module.

- `base_url`: Base URL of the provider API.

- `api_key`: API key created to interact with provider API.

## License

MIT License

Copyright (c) 2019 Faissal Elamraoui

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
