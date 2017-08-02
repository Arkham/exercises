defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @character_set ?a..?z |> Enum.to_list()

  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
    build_list(sentence)
    |> assert_list_match()
  end

  defp build_list(sentence) do
    sentence
    |> String.downcase()
    |> String.to_charlist()
  end

  defp assert_list_match(list) do
    Enum.empty?(@character_set -- list)
  end
end
