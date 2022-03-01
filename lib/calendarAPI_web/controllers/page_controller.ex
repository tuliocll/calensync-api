defmodule CalendarAPIWeb.PageController do
  use CalendarAPIWeb, :controller

  alias CalendarAPI.Accounts
  alias CalendarAPI.Accounts.Session

  def index(conn, _params) do
    render(conn)
  end

  def login(conn, %{"credentials" => credentials}) do
    case Session.authenticate(credentials) do
      {:ok, _} ->
        conn
        |> json(%{ok: true})

      {:error, message} ->
        conn
        |> put_status(401)
        |> json(%{error: true, message: message})
    end
  end

  def login(conn, _) do
    conn
    |> put_status(401)
    |> json(%{error: true, message: "Insira o usuario e senha"})
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, _} ->
        conn |> json(%{success: true})

      {:error, %Ecto.Changeset{} = user_changeset} ->
        IO.inspect(user_changeset)

        conn
        |> put_status(403)
        |> json(%{error: true})
    end
  end
end
