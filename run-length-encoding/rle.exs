defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.reduce([], fn
      (char, [{char, count} | rest]) ->
        [{char, count + 1} | rest]
      (char, acc) ->
        [{char, 1} | acc]
    end)
    |> Enum.reverse()
    |> encode_to_string()
  end

  defp encode_to_string(list) do
    list
    |> Enum.map(fn
      {char, 1} -> char
      {char, count} -> "#{count}#{char}"
    end)
    |> Enum.join("")
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    do_decode(string, [])
    |> Enum.reverse()
    |> Enum.join("")
  end

  defp do_decode("", acc), do: acc
  defp do_decode(string, acc) do
    case Integer.parse(string) do
      {count, rest} ->
        {first, rest} = String.split_at(rest, 1)
        do_decode(rest, [String.duplicate(first, count) | acc])
      :error ->
        {first, rest} = String.split_at(string, 1)
        do_decode(rest, [first | acc])
    end
  end
end
