defmodule CalendarAPI.Accounts do

  import Ecto.Changeset
  alias CalendarAPI.Accounts.User
  alias CalendarAPI.Repo
  alias Comeonin.Bcrypt

  def create_user(%{"password" => password} = params) do
    password_hash = Bcrypt.hashpwsalt(password)

    register_changeset(params)
    |> put_change(:password_hash, password_hash)
    |> Repo.insert
  end

  def register_changeset(params \\ %{}) do
    %User{}
    |> cast(params, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_format(:email, ~r/@/)
    |> validate_format(:username, ~r/^[a-zA-Z0-9]*$/)
    |> validate_length(:password, min: 4)
  end

end
