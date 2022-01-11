defmodule QuickbooksAdapterWeb.AuthController do
  use QuickbooksAdapterWeb, :controller

  @doc """
  This action is reached via `/auth/:provider` and redirects to the OAuth2 provider
  based on the chosen strategy.
  """
  def index(conn, %{"provider" => provider}) do
    redirect conn, external: authorize_url!(provider)
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  @doc """
  This action is reached via `/auth/:provider/callback` is the the callback URL that
  the OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.
  """
  def callback(conn, %{"provider" => provider, "code" => code, "realmId" => realm_id}) do
    # Exchange an auth code for an access token
    client = get_token!(provider, code)
    IO.inspect(client.token.access_token)

    # Request the user's data with the access token
    company = get_company!(provider, client, realm_id)

    # Store the company in the session under `:current_company` and redirect to /.
    # In most cases, we'd probably just store the users's ID that can be used
    # to fetch from the database. In this case, since this example app has no
    # database, I'm just storing the company map.
    #
    # If you need to make additional resource requests, you may want to store
    # the access token as well.
    conn
    |> put_session(:current_company, company)
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/")
  end

  defp authorize_url!("quickbooks"),   do: Quickbooks.authorize_url!
  defp authorize_url!(_), do: raise "No matching provider available"

  defp get_token!("quickbooks", code),   do: Quickbooks.get_token!(code: code)
  defp get_token!(_, _), do: raise "No matching provider available"

  defp get_company!("quickbooks", client, realm_id) do
    # TODO: This doesn't seem to be working as advertized
    res = OAuth2.Client.get!(client, "#{realm_id}/companyinfo/#{realm_id}").body
    IO.inspect(res)
  end
end
