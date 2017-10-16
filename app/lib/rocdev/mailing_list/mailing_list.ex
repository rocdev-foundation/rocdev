defmodule Rocdev.MailingList do
  alias SparkPost.SuppressionList

  def unsubscribe_async(email) do
    _ = Task.start(fn -> unsubscribe(email) end)
    :ok
  end

  def unsubscribe(email) do
    SuppressionList.upsert_one(email, "non_transactional")
  end
end
