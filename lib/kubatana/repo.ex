defmodule Kubatana.Repo do
  use Ecto.Repo,
    otp_app: :kubatana,
    adapter: Ecto.Adapters.Postgres
end
