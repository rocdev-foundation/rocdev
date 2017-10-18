defmodule RocdevWeb.SubscriptionController do
  use RocdevWeb, :controller

  alias Rocdev.MailingList

  # raises a good point:
  # https://davidcel.is/posts/stop-validating-email-addresses-with-regex/
  # ¯\_(ツ)_/¯
  @email_regex ~r/.+@.+/i

  def unsubscribe(conn, params) do
    render conn, "unsubscribe.html", email: Map.get(params, "email")
  end

  def delete(conn, params) do
    case get_email(params) do
      {:ok, email} ->
        :ok = MailingList.unsubscribe_async(email)

        conn
        |> put_flash(:info, "#{email} unsubscribed")
        |> redirect(to: "/")
      {:error, _} ->
        conn
        |> put_flash(:error, "Please enter a valid email address")
        |> put_status(403)
        |> render("unsubscribe.html", email: nil)
    end
  end

  defp get_email(%{"unsubscribe" => %{"email" => email}}) do
    if Regex.match?(@email_regex, email) do
      {:ok, email}
    else
      {:error, :invalid_email}
    end
  end
  defp get_email(_), do: {:error, :no_email}
end
