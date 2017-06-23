defmodule ProteinTranslation do
  @protein_codons [
    {"UGU", "Cysteine"},
    {"UGC", "Cysteine"},
    {"UUA", "Leucine"},
    {"UUG", "Leucine"},
    {"AUG", "Methionine"},
    {"UUU", "Phenylalanine"},
    {"UUC", "Phenylalanine"},
    {"UCU", "Serine"},
    {"UCC", "Serine"},
    {"UCA", "Serine"},
    {"UCG", "Serine"},
    {"UGG", "Tryptophan"},
    {"UAU", "Tyrosine"},
    {"UAC", "Tyrosine"}
  ]

  @stop_codons [
    {"UAA", "STOP"},
    {"UAG", "STOP"},
    {"UGA", "STOP"}
  ]

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna), do: of_rna(rna, [])

  def of_rna("", acc), do: {:ok, Enum.reverse(acc)}

  for {codon, _} <- @stop_codons do
    def of_rna(unquote(codon) <> _rest, acc), do: {:ok, Enum.reverse(acc)}
  end

  for {codon, protein} <- @protein_codons do
    def of_rna(unquote(codon) <> rest, acc), do: of_rna(rest, [unquote(protein)|acc])
  end

  def of_rna(_other, _acc), do: {:error, "invalid RNA"}

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  for {codon, protein} <- @protein_codons ++ @stop_codons do
    def of_codon(unquote(codon)), do: {:ok, unquote(protein)}
  end
  def of_codon(_other), do: {:error, "invalid codon"}
end

