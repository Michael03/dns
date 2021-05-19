defmodule Record do
  @moduledoc """
  Documentation for `Dns`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Dns.hello()
      :world

  """
  defstruct [
    :name
  ]

  def parse(<<
        1::size(1),
        1::size(1),
        remaining::bitstring
      >>) do
    [
      %Record{
        name: "qname"
      },
      remaining
    ]
  end

  def parse(<<
        length::size(8),
        name::binary-size(length),
        0::size(8),
        remaining::bitstring
      >>) do
    [
      %Record{
        name: name
      },
      remaining
    ]
  end

  def parse(<<
        length::size(8),
        name::binary-size(length),
        remaining::bitstring
      >>) do
    [record, remaining] = parse(remaining)
    [%{record | name: name <> "." <> record.name}, remaining]
  end
end
