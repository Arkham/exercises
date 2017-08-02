defmodule RNATranscription do
  @dna_to_rna_map %{
    ?G => ?C,
    ?C => ?G,
    ?T => ?A,
    ?A => ?U
  }

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    to_rna(dna, [])
  end
  def to_rna([], result), do: Enum.reverse(result)
  for {dna, rna} <- @dna_to_rna_map do
    def to_rna([unquote(dna)|rest], result) do
      to_rna(rest, [unquote(rna)|result])
    end
  end
end
