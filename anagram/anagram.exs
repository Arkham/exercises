defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    map = build_frequency_map(base)

    candidates
    |> Enum.reject(&(String.downcase(&1) == String.downcase(base)))
    |> Enum.filter(&match_frequency_map?(&1, map))
  end

  defp build_frequency_map(string) do
    string
    |> String.downcase()
    |> String.graphemes()
    |> Enum.reduce(%{}, fn(char, acc) ->
      Map.update(acc, char, 1, &(&1 + 1))
    end)
  end

  defp match_frequency_map?(string, map) do
    map == build_frequency_map(string)
  end
end
