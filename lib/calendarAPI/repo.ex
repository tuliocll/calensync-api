defmodule CalendarAPI.Repo do
  use Ecto.Repo,
    otp_app: :calendarAPI,
    adapter: Ecto.Adapters.SQLite3
end
