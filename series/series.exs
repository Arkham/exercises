defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(string, size) when is_binary(string) do
    string
    |> String.graphemes()
    |> cut_slices(size)
    |> Enum.map(&Enum.join(&1, ""))
  end

  def cut_slices(list, size) when size in 1..length(list) do
    last_index = length(list) - size
    (0..last_index)
    |> Enum.map(fn index ->
      Enum.slice(list, index, size)
    end)
  end
  def cut_slices(_list, _size), do: []
end

