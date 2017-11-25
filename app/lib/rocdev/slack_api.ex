defmodule Rocdev.SlackAPI do
  @moduledoc """
  Provides access to Slack Invitation API.
  """

  @web_base_url Application.get_env(:rocdev, :slack_api_base_url)
  @web_token Application.get_env(:rocdev, :slack_api_token)
  @invite_base_url Application.get_env(:rocdev, :slack_invite_base_url)
  @invite_token Application.get_env(:rocdev, :slack_invite_api_token)

  def invite(email) do
    HTTPoison.post(
      @invite_base_url <> "/users.admin.invite",
      {:form, [email: email, resend: true, token: @invite_token]}
    )
    |> handle_response
  end

  def members do
    HTTPoison.get(
      @web_base_url <> "/users.list",
      [], 
      [params: [presence: 1, token: @web_token]]
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