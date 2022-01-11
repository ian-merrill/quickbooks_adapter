# QuickbooksAdapter

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

This project uses `dev.secret.exs` with the clientid and client secret given by a dev account in quickbooks

```elixir
import Config

 config :quickbooks_adapter, Quickbooks,
 client_id: <client_id>,
 client_secret: <client_secret>,
 redirect_uri: "http://localhost:4000/auth/quickbooks/callback"
```

## Phoenix Links

- Oauth2 docs: https://hexdocs.pm/oauth2/2.0.0/readme.html
- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

## Quickbooks Links

- Set up OAuth 2.0: https://developer.intuit.com/app/developer/qbo/docs/develop/authentication-and-authorization/oauth-2.0
- API common workflows: https://developer.intuit.com/app/developer/qbo/docs/workflows

## Oauth2

- oauth2 github: https://github.com/ueberauth/oauth2
