defmodule Klendar.Repo do
  use Ecto.Repo,
    otp_app: :klendar,
    adapter: Ecto.Adapters.Postgres
end
