defmodule RocdevWeb.MeetupController do
  use RocdevWeb, :controller
  require Logger
  alias Rocdev.MeetupAPI

  def index(conn, _params) do
    render(
      conn,
      "index.html",
      past_events: past_events(),
      upcoming_events: upcoming_events()
    )
  end

  defp past_events do
    case MeetupAPI.past do
      {:ok, events} -> events
      {:error, reason} ->
        Logger.warn fn ->
          "Past Meetup event retrieval failure: #{reason}."
        end
        []
    end
  end

  defp upcoming_events do
    case MeetupAPI.upcoming do
      {:ok, events} -> events
      {:error, reason} ->
        Logger.warn fn ->
          "Upcoming Meetup event retrieval failure: #{reason}."
        end
        []
    end
  end
end
