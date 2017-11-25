defmodule RocdevWeb.PageController do
  use RocdevWeb, :controller
  require Logger
  alias Rocdev.SlackAPI

  def index(conn, _params) do
    case SlackAPI.members do
      {:ok, %{"members" => members}} ->
        render conn, "index.html", members: members
      {:error, reason} ->
        Logger.warn fn ->
          "Slack member retrieval failure: #{reason}."
        end
        render conn, "index.html", members: []
    end
  end

  def code_of_conduct(conn, _params) do
    render conn, "code-of-conduct.html"
  end
end
