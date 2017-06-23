defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) when and shift >= 26, do: rotate(text, rem(shift, 26))
  def rotate(text, shift) when shift == 0, do: text
  def rotate(text, shift) do
    shift_map = build_shift_map(shift)

    text
    |> to_charlist()
    |> Enum.map(& Map.get(shift_map, &1, &1))
    |> to_string()
  end

  defp build_shift_map(shift) do
    Map.merge(build_shift_map_from(?a..?z, shift),
              build_shift_map_from(?A..?Z, shift))
  end

  defp build_shift_map_from(list, shift) do
    {first, second} = Enum.split(list, shift)
    rotated_list = second ++ first
    Enum.zip(list, rotated_list)
    |> Enum.into(%{})
  end
end
