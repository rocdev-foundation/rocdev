defmodule Rocdev.ChatInviter do
  @moduledoc """
  Provides access to Slack API.
  """

  use Tesla

  plug Tesla.Middleware.Tuples
  plug Tesla.Middleware.BaseUrl,
    Application.get_env(:rocdev, :slack_invite_base_url)
  plug Tesla.Middleware.Query, [
    {"token", Application.get_env(:rocdev, :slack_invite_api_token)}
  ]
  plug Tesla.Middleware.FormUrlencoded

  def invite(email) do
    with {:ok, response} <- post("/users.admin.invite", %{email: email}),
         {:ok, body} = Poison.decode(response.body),
         true <- body["ok"] do
      :ok
    else
      _ -> :error
    end
  end
end