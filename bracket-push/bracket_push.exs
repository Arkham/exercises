defmodule BracketPush do
  @bracket_symbols [
    {"[", "]"},
    {"(", ")"},
    {"{", "}"}
  ]

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str
    |> String.graphemes
    |> Enum.reduce([], &add_or_pop_from_stack(&1, &2))
    |> Enum.empty?()
  end

  for {opening, closing} <- @bracket_symbols do
    def add_or_pop_from_stack(unquote(opening), stack) do
      [unquote(opening)|stack]
    end
    def add_or_pop_from_stack(unquote(closing), [unquote(opening)|rest]) do
      rest
    end
    def add_or_pop_from_stack(unquote(closing), stack) do
      [unquote(closing)|stack]
    end
  end
  def add_or_pop_from_stack(_symbol, stack), do: stack
end
