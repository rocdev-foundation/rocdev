defmodule Rocdev.MailingList do
  @moduledoc """
  API for interacting with the email list

  The email list is managed by SParkPost, so a lot of this is just wrapping
  the SparkPost API
  """

  alias SparkPost.SuppressionList

  require Logger

  @doc """
  Execute unsubscribe asynchronously - i.e., to be called from api controller

  Always returns :ok immediately
  """
  @spec unsubscribe_async(binary) :: :ok
  def unsubscribe_async(email) do
    _ = Task.start(fn -> unsubscribe(email) end)
    :ok
  end

  @doc """
  Execute unsubscribe synchronously, logging on failure

  Returns :ok on success or :error on failure.  Does not retry.
  """
  @spec unsubscribe(binary) :: :ok | :error
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
