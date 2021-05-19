defmodule DnsPacket do
  @moduledoc """
  Parser for dns requests/responses
  """

  defstruct [
    :header,
    :questions,
    :answers,
    :authoritive,
    :additional
  ]

  @doc """
  parse.

  ## Examples

      iex> DnsPacket.parse()

  """
  def parse(request) do
    [header, remaining] = Header.parse(request)
     questions =  Enum.map(1..header.qdcount, fn _i ->
        [question, remaining] = Question.parse(remaining)
        question
      end)

    answers =
      Enum.map(1..header.ancount, fn _i ->
        [answer, remaining] =  Record.parse(remaining)
        answer
      end)

    authoritive =
      Enum.map(1..header.nscount, fn _i ->
        [answer, remaining] =  Record.parse(remaining)
        answer
      end)

    additional =
      Enum.map(1..header.arcount, fn _i ->
        [answer, remaining] =  Record.parse(remaining)
        answer
      end)

    %DnsPacket{
      header: header,
      questions: questions,
      answers: answers,
      authoritive: authoritive,
      additional: additional
    }
  end
end
