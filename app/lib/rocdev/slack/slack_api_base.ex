defmodule Rocdev.Slack.SlackAPIBase do
  @moduledoc """
  Provides access to Slack Invitation API.
  """
  use HTTPoison.Base
  alias Rocdev.Slack.SlackAPIHelper

  @base_url Application.get_env(:rocdev, :slack_api_base_url)
  @token Application.get_env(:rocdev, :slack_api_token)

  def team do
    get("/team.info")
    |> SlackAPIHelper.handle_response
  end

  def members do
    get("/users.list", [], [params: [{"presence", 1}]])
    |> SlackAPIHelper.handle_response
  end

  @spec process_url(binary) :: binary
  def process_url(url) do
    @base_url <> url
  end

  @spec process_request_options(keyword) :: keyword
  def process_request_options(options) do
    token_param = [token: @token]
    existing_params = Keyword.get(options, :params, [])
    Keyword.put(options, :params, existing_params ++ token_param)
  end

  @spec process_response_body(binary) :: term
  def process_response_body(body) do
    SlackAPIHelper.process_response_body(body)
  end
end