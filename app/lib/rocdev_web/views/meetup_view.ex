defmodule RocdevWeb.MeetupView do
  use RocdevWeb, :view

  def show_upcoming_events?(upcoming_events), do: length(upcoming_events) > 0
end
