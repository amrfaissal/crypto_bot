defmodule CryptoBot do
  @moduledoc """
  Slack Bot to get real-time pricing of coins and currency pairs.
  """

  @application :crypto_bot

  def provider do
    Application.get_env(@application, :crypto)[:provider]
  end

  def base_url do
    Application.get_env(@application, :crypto)[:base_url]
  end

  def api_key do
    Application.get_env(@application, :crypto)[:api_key]
  end
end
