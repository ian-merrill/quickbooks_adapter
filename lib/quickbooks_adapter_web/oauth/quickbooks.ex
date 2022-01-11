defmodule Quickbooks do
  @moduledoc """
  An OAuth2 strategy for Quickbooks.
  """
  use OAuth2.Strategy

  # ideally capture these values from calling (https://developer.api.intuit.com/.well-known/openid_sandbox_configuration/)
  defp config do
    [strategy: Quickbooks,
     site: "https://sandbox-quickbooks.api.intuit.com/v3/company/",
     authorize_url: "https://appcenter.intuit.com/connect/oauth2",
     token_url: "https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer",]
  end

  # Public API

  def client do
    Application.get_env(:quickbooks_adapter, Quickbooks)
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
    |> OAuth2.Client.basic_auth()
  end

  def authorize_url!(params \\ []) do
    OAuth2.Client.authorize_url!(client(), params)
  end

  def get_token!(params \\ []) do
    OAuth2.Client.get_token!(client(), params)
  end

  # Strategy Callbacks

  def authorize_url(client, _params) do
    client
    |> put_param(:response_type, "code")
    |> put_param(:client_id, client.client_id)
    |> put_param(:redirect_uri, client.redirect_uri)
    |> OAuth2.Client.put_param("scope", "com.intuit.quickbooks.accounting")
    |> OAuth2.Client.put_param("state", "testState")
  end

  def get_token(client, params, _headers) do
    client
    |> OAuth2.Client.put_header("Accept", "application/json")
    |> OAuth2.Client.put_header("Content-Type", "application/x-www-form-urlencoded")
    |> OAuth2.Client.put_param("grant_type", "authorization_code")
    |> OAuth2.Client.put_param("code", Keyword.get(params, :code))
    |> OAuth2.Client.put_param("redirect_uri", client.redirect_uri)
  end
end
