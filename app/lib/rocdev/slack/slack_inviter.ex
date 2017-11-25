defmodule Rocdev.Slack.SlackInviter do
  @moduledoc """
  Provides access to Slack Invitation API.
  """
  use HTTPoison.Base
  alias Rocdev.Slack.SlackAPIHelper

  @base_url Application.get_env(:rocdev, :slack_invite_base_url)
  @token Application.get_env(:rocdev, :slack_invite_api_token)

  @spec invite(binary) :: {atom, term}
  def invite(email) do
    post(
      "/users.admin.invite",
      {:form, [email: email, resend: true, token: @token]}
    )
    |> SlackAPIHelper.handle_response
  end

  @spec process_url(binary) :: binary
  def process_url(url) do
    @base_url <> url
  end

  @spec process_response_body(binary) :: term
  def process_response_body(body) do
    SlackAPIHelper.process_response_body(body)
  end
end