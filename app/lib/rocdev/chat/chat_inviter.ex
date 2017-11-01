defmodule Rocdev.ChatInviter do
  @moduledoc """
  Provides access to Slack Invitation API.
  """
  use HTTPoison.Base

  @base_url Application.get_env(:rocdev, :slack_invite_base_url)
  @token Application.get_env(:rocdev, :slack_invite_api_token)

  @spec invite(binary) :: {atom, term}
  def invite(email) do
    with {:ok, response} <- post("/users.admin.invite", invite_body(email)),
         {:ok, body} <- response.body do
      {:ok, body}
    else
      {:error, reason} -> {:error, reason}
      _ -> {:error, "unknown"}
    end
  end

  @spec process_url(binary) :: binary
  def process_url(url) do
    @base_url <> url
  end

  @spec process_response_body(binary) :: term
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

  @spec invite_body(term) :: {atom, [{binary, term}]}
  defp invite_body(email), do: {:form, [{"email", email}, {"resend", true}]}

  @spec process_request_body(term) :: binary
  def process_request_body({:form, keyword_list}) do
    {:form, keyword_list ++ [{"token", @token}]}
  end
  def process_request_body(body), do: body
end