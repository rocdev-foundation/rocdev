defmodule Rocdev.Slack.SlackAPIHelper do
  @moduledoc """
  """

  def handle_response(response) do
    with {:ok, response} <- response,
         {:ok, body} <- response.body do
      {:ok, body}
    else
      {:error, reason} -> {:error, reason}
      _ -> {:error, "unknown"}
    end
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
end