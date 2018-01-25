defmodule RocdevWeb.SocialController do
  use RocdevWeb, :controller

  def github(conn, _params) do
    redirect conn, external: "https://github.com/585-software/"
  end
end
