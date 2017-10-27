defmodule RocdevWeb.PageController do
  use RocdevWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def code_of_conduct(conn, _params) do
    render conn, "code-of-conduct.html"
  end

  def slack(conn, _params) do
    render conn, "slack.html"
  end

  def meetup(conn, _params) do
    redirect conn, external: "https://www.meetup.com/meetup-group-BkuJclOW/"
  end

  def github(conn, _params) do
    redirect conn, external: "https://github.com/585-software/"
  end
end
