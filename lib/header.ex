defmodule Header do
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
    :id,
    :qr,
    :opcode,
    :aa,
    :tc,
    :rd,
    :ra,
    :z,
    :rdcode,
    :qdcount,
    :ancount,
    :nscount,
    :arcount
  ]

  def parse(<<
        id::size(16),
        qr::size(1),
        opcode::size(4),
        aa::size(1),
        tc::size(1),
        rd::size(1),
        ra::size(1),
        z::size(3),
        rdcode::size(4),
        qdcount::size(16),
        ancount::size(16),
        nscount::size(16),
        arcount::size(16),
        remaining::bitstring
      >>) do
    [
      %Header{
        id: id,
        qr: qr,
        opcode: opcode,
        aa: aa,
        tc: tc,
        rd: rd,
        ra: ra,
        z: z,
        rdcode: rdcode,
        qdcount: qdcount,
        ancount: ancount,
        nscount: nscount,
        arcount: arcount
      },
      remaining
    ]
  end
end
