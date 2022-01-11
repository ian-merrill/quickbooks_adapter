defmodule QuickbooksAdapter.Repo do
  use Ecto.Repo,
    otp_app: :quickbooks_adapter,
    adapter: Ecto.Adapters.Postgres
end
