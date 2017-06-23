defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    build_actions_map()
    |> Enum.filter(fn({mask, _action}) ->
      (mask &&& code) !== 0
    end)
    |> Enum.reduce([], fn({_mask, action}, acc) ->
      action.(acc)
    end)
  end

  defp build_actions_map do
    append = fn(elem) ->
      fn(values) ->
        List.insert_at(values, -1, elem)
      end
    end

    reverse = fn(values) ->
      Enum.reverse(values)
    end

    %{
      0b1     => append.("wink"),
      0b10    => append.("double blink"),
      0b100   => append.("close your eyes"),
      0b1000  => append.("jump"),
      0b10000 => reverse
    }
  end
end