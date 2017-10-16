defmodule RocdevWeb.SubscriptionControllerTest do
  use RocdevWeb.ConnCase

  describe "GET /unsubscribe" do
    test "with no email param", %{conn: conn} do
      conn = get conn, "/unsubscribe"
      assert html_response(conn, 200) =~ "Unsubscribe</button>"
      assert html_response(conn, 200) =~ "unsubscribe[email]"
    end

    test "with email param", %{conn: conn} do
      email = "sue@leaving.com"
      conn = get conn, "/unsubscribe?email=#{email}"
      assert html_response(conn, 200) =~ "Unsubscribe</button>"
      assert html_response(conn, 200) =~ "unsubscribe[email]"
      assert html_response(conn, 200) =~ "value=\"#{email}\""
    end
  end

  describe "DELETE /subscriptions" do
    setup do
      bypass = Bypass.open(port: 4321)
      {:ok, bypass: bypass}
    end

    test "no email provided", %{conn: conn} do
      conn = delete conn, "/subscriptions"
      assert html_response(conn, 403)
      assert get_flash(conn, :error) =~ "Please enter a valid email address"
    end

    test "invalid email provided", %{conn: conn} do
      email = "not an email"
      conn = delete conn, "/subscriptions", %{unsubscribe: %{email: email}}
      assert html_response(conn, 403)
      assert get_flash(conn, :error) =~ "Please enter a valid email address"
    end

    test "email provided", %{conn: conn, bypass: bypass} do
      email = "sue@leaving.com"

      test_process = self()
      Bypass.expect_once bypass, "PUT", "/suppression-list/#{email}", fn bpconn ->
        send(test_process, :got_request)
        Plug.Conn.resp(bpconn, 200, Poison.encode! %{results: %{}})
      end

      conn = delete conn, "/subscriptions", %{unsubscribe: %{email: email}}
      assert redirected_to(conn) =~ "/"
      assert get_flash(conn, :info) =~ "#{email} unsubscribed"

      receive do
        :got_request -> :ok
      after 1_000 -> raise "Failed to send unsubscribe"
      end
    end
  end
end
