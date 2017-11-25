defmodule RocdevWeb.SlackController do
  use RocdevWeb, :controller
  require Logger
  alias Rocdev.Slack.SlackInviter

  def index(conn, _params) do
    redirect conn, external: "https://rocdev.slack.com"
  end

  # Invite and redirect back to home page, which has the form.
  def register(conn, %{"register" => %{"email" => email}}) do
    case SlackInviter.invite(email) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Invitation sent to #{email}.")
        |> redirect(to: page_path(conn, :index))
      {:error, "sent_recently"} ->
        Logger.warn fn ->
          "Slack invite failure: sent_already."
        end
        conn
        |> put_flash(
             :error, 
             "An invitation was sent recently to #{email}."
           )
        |> redirect(to: page_path(conn, :index))
      {:error, reason} ->
        Logger.error fn ->
          "Slack invite failure: #{reason}."
        end
        conn
        |> put_flash(
             :error, 
             "Could not invite #{email}. Please, try again later."
           )
        |> redirect(to: page_path(conn, :index))
    end
  end
end
