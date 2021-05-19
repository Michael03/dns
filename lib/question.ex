defmodule Question do
  @moduledoc """
  Parse for question sections
  """

  defstruct [
    :name,
    :type,
    :class
  ]

  @doc """
  parse.
  label starts with 11 and is a qname
  """

  # def parse(<<
  #       2::size(2),
  #       remaining::bitstring
  #     >>) do
  #   [
  #     %Question{
  #       name: "qname",
  #       type: "unknown",
  #       class: "unknown"
  #     },
  #     remaining
  #   ]
  # end

  def parse(<<
        length::size(8),
        name::binary-size(length),
        0::size(8),
        type::size(16),
        class::size(16),
        remaining::bitstring
      >>) do
    [
      %Question{
        name: name,
        type: type,
        class: class
      },
      remaining
    ]
  end

  def parse(<<
        length::size(8),
        name::binary-size(length),
        remaining::bitstring
      >>) do
    [question, remaining] = parse(remaining)
    [%{question | name: name <> "." <> question.name}, remaining]
  end
end
