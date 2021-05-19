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

    # questions = []
    # [questions, remaining] = for i <- 0..header.qdcount, i > 0 do
    #    [question, remaining] = Question.parse(remaining)
    #    questions = [question| questions]
    # end
    [questions, remaining] = parse_questions(header.qdcount, remaining)

    [answers, remaining] = parse_records(header.ancount, remaining)
    [authoritive, remaining] = parse_records(header.nscount, remaining)
    [additional, _remaining] = parse_records(header.arcount, remaining)

    %DnsPacket{
      header: header,
      questions: questions,
      answers: answers,
      authoritive: authoritive,
      additional: additional
    }
  end

  defp parse_questions(0, remaining) do
    [[], remaining]
  end

  defp parse_questions(count_remaining, remaining) do
    [question, remaining] = Question.parse(remaining)
    [questions, remaining] = parse_questions(count_remaining - 1, remaining)
    [[question | questions], remaining]
  end


  defp parse_records(0, remaining) do 
    [[], remaining]
  end

  defp parse_records(count_remaining, remaining) do 
    [question, remaining] = Record.parse(remaining)
    [questions, remaining] = parse_records(count_remaining - 1, remaining)
    [[question | questions], remaining]
  end
end
