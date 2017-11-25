defmodule RocdevWeb.PageView do
  use RocdevWeb, :view

  def total_member_count(members), do: length(members)

  def active_member_count(members) do
    members
    |> Enum.filter(fn m -> m["presence"] == "active" end)
    |> length
  end
end
