defmodule MailingListTest do
  use ExUnit.Case

  alias Rocdev.MailingList

  import ExUnit.CaptureLog

  describe "unsubscribing" do
    setup do
      bypass = Bypass.open(port: 4321)
      {:ok, bypass: bypass}
    end

    test "successful unsubscribe", %{bypass: bypass} do
      email = "foo@bar.com"

      Bypass.expect_once bypass, "PUT", "/suppression-list/#{email}", fn bpconn ->
        Plug.Conn.resp(bpconn, 200, Poison.encode! %{results: %{}})
      end

      assert :ok == MailingList.unsubscribe(email)
    end

    test "unsuccessful unsubscribe", %{bypass: bypass} do
      Bypass.down(bypass)

      assert capture_log(fn ->
        assert :error == MailingList.unsubscribe("foo@bar.com")
      end) =~ "Error unsubscribing"
    end
  end
end
