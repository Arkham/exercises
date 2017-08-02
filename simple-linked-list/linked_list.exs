defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    :empty
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    {elem, list}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(:empty), do: 0
  def length({_value, next}), do: 1 + LinkedList.length(next)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(:empty), do: true
  def empty?({_value, _next}), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(:empty), do: {:error, :empty_list}
  def peek({value, _next}), do: {:ok, value}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(:empty), do: {:error, :empty_list}
  def tail({_value, tail}), do: {:ok, tail}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(:empty), do: {:error, :empty_list}
  def pop({value, next}), do: {:ok, value, next}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    list
    |> Enum.reverse()
    |> Enum.reduce(new(), fn(elem, list) ->
      push(list, elem)
    end)
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list), do: to_list(list, []) |> Enum.reverse()
  def to_list(:empty, acc), do: acc
  def to_list({value, rest}, acc), do: to_list(rest, [value|acc])

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    list
    |> to_list()
    |> Enum.reverse()
    |> from_list()
  end
end
