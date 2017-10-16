defmodule Rocdev.MailingList do
  @moduledoc """
  API for interacting with the email list

  The email list is managed by SParkPost, so a lot of this is just wrapping
  the SparkPost API
  """

  alias SparkPost.SuppressionList

  require Logger

  def unsubscribe_async(email) do
    _ = Task.start(fn -> unsubscribe(email) end)
    :ok
  end

  def unsubscribe(email) do
    case SuppressionList.upsert_one(email, "non_transactional") do
      {:ok, ""} -> :ok
      {:error, error} ->
        Logger.warn(fn ->
          "Error unsubscribing '#{inspect email}': #{inspect error}"
        end)
        :error
    end
  end
end
