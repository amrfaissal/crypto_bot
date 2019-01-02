defmodule CryptoBot.HTTP do
  @moduledoc """
  Module to make HTTP requests.
  """

  alias __MODULE__

  def get(url, options \\ []) do
    request(:get, url, options)
  end

  defp request(method, url, options) do
    options =
      options
      |> Keyword.put(:connect_timeout, 30_000)
      |> add_content_type_header()
      |> add_api_key_header(api_key())

    url = URI.merge(base_url(), url)
    apply(HTTPotion, method, [url, options]) |> process_response
  end

  defp add_content_type_header(options) do
    headers = Keyword.get(options, :headers, Keyword.new())
    headers = Keyword.put(headers, :"Content-Type", "application/json")
    Keyword.put(options, :headers, headers)
  end

  defp add_api_key_header(options, api_key) do
    headers = Keyword.get(options, :headers, Keyword.new())
    headers = Keyword.put(headers, :ApiKey, api_key)
    Keyword.put(options, :headers, headers)
  end

  defp base_url do
    CryptoBot.base_url() || "https://min-api.cryptocompare.com/data/"
  end

  defp api_key do
    CryptoBot.api_key() || ""
  end

  defp process_response(response) do
    HTTP.ResponseHandler.process(response)
  end

  defmodule ResponseHandler do
    def process(%{body: body, status_code: status_code}) when status_code in 400..599 do
      {:error, status_code, decode_body(body)}
    end

    def process(%{body: body, status_code: status_code}) do
      {:ok, status_code, decode_body(body)}
    end

    defp decode_body("") do
      ""
    end

    defp decode_body(body) do
      {:ok, decoded_body} = Jason.decode(body)
      decoded_body
    end
  end
end
