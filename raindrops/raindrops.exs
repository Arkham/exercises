defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """

  @factors_with_values [
    {3, "Pling"},
    {5, "Plang"},
    {7, "Plong"}
  ]

  @spec convert(pos_integer) :: String.t
  def convert(number) do
    @factors_with_values
    |> Enum.reduce([], fn ({factor, value}, acc) ->
      case Integer.mod(number, factor) do
        0 -> [value|acc]
        _ -> acc
      end
    end)
    |> Enum.reverse()
    |> format(number)
  end

  def format([], number), do: to_string(number)
  def format(result, _number), do: Enum.join(result, "")
end
