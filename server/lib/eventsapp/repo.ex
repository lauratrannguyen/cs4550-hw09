defmodule Eventsapp.Repo do
  use Ecto.Repo,
    otp_app: :eventsapp,
    adapter: Ecto.Adapters.Postgres
end
