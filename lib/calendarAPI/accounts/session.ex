defmodule CalendarAPI.Accounts.Session do
  alias CalendarAPI.Accounts.User
  alias CalendarAPI.Repo
  alias Comeonin.Bcrypt

  def authenticate(%{"username" => username, "password" => given_password}) do
    User
    |> Repo.get_by(username: username)
    |> check_password(given_password)
  end

  def authenticate(_) do
    {:error, "Insira o usuario e senha"}
  end

  defp check_password(nil, _given_password) do
    {:error, "Nenhum usuario encontrado"}
  end

  defp check_password(%{password_hash: password_hash} = user, given_password) do
    case Bcrypt.checkpw(given_password, password_hash) do
      true -> {:ok, user}
      _ -> {:error, "Senha invalida"}
    end
  end
end
