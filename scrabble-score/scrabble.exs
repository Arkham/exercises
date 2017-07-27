defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """

  @letter_values [
    {1, ~w(a e i o u l n r s t)},
    {2, ~w(d g)},
    {3, ~w(b c m p)},
    {4, ~w(f h v w y)},
    {5, ~w(k)},
    {8, ~w(j x)},
    {10, ~w(q z)}
  ]

  @values_hash Enum.reduce(@letter_values, %{}, fn {value, keys}, acc ->
    Enum.reduce(keys, acc, fn key, map ->
      Map.put(map, key, value)
    end)
  end)

  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.graphemes()
    |> Enum.reduce(0, fn character, result ->
      result + Map.get(@values_hash, String.downcase(character), 0)
    end)
  end
end
