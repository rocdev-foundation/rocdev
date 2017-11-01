defmodule RocdevWeb.SlackController do
  use RocdevWeb, :controller

  alias Rocdev.ChatInviter

  def index(conn, _params) do
    redirect conn, to: page_path(conn, :index)
  end

  def register(conn, %{"register" => %{"email" => email}}) do
    case ChatInviter.invite(email) do
      :ok ->
        conn
        |> put_flash(:info, "Invitation sent to #{email}.")
        |> redirect(to: page_path(conn, :index))
      :error ->
        conn
        |> put_flash(:error, "Could not invite #{email}.")
        |> redirect(to: page_path(conn, :index))
    end
  end
end
