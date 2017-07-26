defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    Regex.scan(~r/[-\p{L}\d]+/u, sentence)
    |> Enum.reduce(%{}, fn([word], acc) ->
      word = String.downcase(word)
      Map.update(acc, word, 1, &(&1 + 1))
    end)
  end
end
