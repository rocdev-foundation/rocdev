defmodule Rocdev.SlackAPI do
  @moduledoc """
  Provides access to Slack Invitation API.
  """
  alias Rocdev.Config

  def invite(email) do
    "#{Config.slack_invite_base_url}/users.admin.invite"
    |> HTTPoison.post(
      {
        :form, [email: email, resend: true, token: Config.slack_invite_token]
      }
    )
    |> handle_response
  end

  def members do
    "#{Config.slack_api_base_url}/users.list"
    |> HTTPoison.get(
      [],
      [params: [presence: 1, token: Config.slack_api_token]]
    )
    |> handle_response
  end

  def handle_response(response) do
    with {:ok, response} <- response,
         {:ok, body} <- process_response_body(response.body) do
      {:ok, body}
    else
      {:error, reason} -> {:error, reason}
      _ -> {:error, "unknown"}
    end
  end

  def process_response_body(body) do
    with {:ok, json} <- Poison.decode(body) do
      if json["ok"] do
        {:ok, json}
      else
        {:error, json["error"]}
      end
    else
      _ -> {:error, body}
    end
  end
end
