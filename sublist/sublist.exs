defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare(a, b) when length(a) < length(b) do
    case is_sublist?(a, b) do
      true -> :sublist
      false -> :unequal
    end
  end
  def compare(a, b) do
    case is_sublist?(b, a) do
      true -> :superlist
      false -> :unequal
    end
  end

  defp is_sublist?([], _), do: true
  defp is_sublist?([first|_] = a, [first|b_rest] = b) when length(b) >= length(a) do
    case a === Enum.take(b, length(a)) do
      true -> true
      false -> is_sublist?(a, b_rest)
    end
  end
  defp is_sublist?(a, [_|b_rest] = b) when length(b) >= length(a) do
    is_sublist?(a, b_rest)
  end
  defp is_sublist?(_, _), do: false

  # defp is_sublist?(a, b) do
  #   a_length = length(a)
  #   b_length = length(b)
  #   difference_length = b_length - a_length
  #   a_first_elem = List.first(a)

  #   Enum.with_index(b)
  #   |> Enum.filter(fn {value, index} ->
  #     value == a_first_elem &&
  #       index in 0..difference_length
  #   end)
  #   |> Enum.any?(fn {_, index} ->
  #     Enum.slice(b, index, a_length) === a
  #   end)
  # end
end
