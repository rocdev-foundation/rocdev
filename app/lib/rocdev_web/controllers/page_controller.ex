defmodule RocdevWeb.PageController do
  use RocdevWeb, :controller
  require Logger
  alias Rocdev.Slack.SlackAPIBase

  def index(conn, _params) do
    case SlackAPIBase.members do
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
