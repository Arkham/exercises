defmodule PigLatin do
  @letters ?a..?z |> Enum.map(&to_string(List.wrap(&1)))
  @vowels ~w(a e i o u)
  @consonants (@letters -- @vowels)
  @vowel_groups ~w(yt xr)
  @consonant_groups ~w(ch qu squ thr th sch)

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(~r/\s+/)
    |> Enum.map(&translate_word(&1))
    |> Enum.join(" ")
  end

  for consonant <- @consonant_groups do
    defp translate_word(unquote(consonant) <> rest) do
      rest <> unquote(consonant) <> "ay"
    end
  end

  for vowel <- @vowel_groups do
    defp translate_word(unquote(vowel) <> rest) do
      unquote(vowel) <> rest <> "ay"
    end
  end

  for consonant <- @consonants do
    defp translate_word(unquote(consonant) <> rest) do
      rest <> unquote(consonant) <> "ay"
    end
  end

  for vowel <- @vowels do
    defp translate_word(unquote(vowel) <> rest) do
      unquote(vowel) <> rest <> "ay"
    end
  end
end

