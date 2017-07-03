defmodule Bob do
  def hey(input) do
    cond do
      String.ends_with?(input, "?") -> "Sure."
      String.upcase(input) == input -> "Whoa, chill out!"
      Regex.match?(~r{^\s+$}, input) -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end
end
