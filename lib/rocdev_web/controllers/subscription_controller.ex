defmodule RocdevWeb.SubscriptionController do
  use RocdevWeb, :controller

  def unsubscribe(conn, _params) do
    render conn, "unsubscribe.html"
  end
end