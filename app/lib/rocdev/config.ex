defmodule Rocdev.Config do
  @moduledoc """
  Provide configuration across static and environmental sources.
  """

  def meetup_api_base_url, do: System.get_env("MEETUP_API_BASE")

  def slack_api_base_url, do: System.get_env("SLACK_API_BASE")
  def slack_api_token, do: System.get_env("SLACK_API_TOKEN")
  def slack_invite_base_url, do: System.get_env("SLACK_INVITE_BASE")
  def slack_invite_token, do: System.get_env("SLACK_INVITE_TOKEN")
end
