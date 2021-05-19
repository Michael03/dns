# defmodule Dns do
#   @moduledoc """
#   Documentation for `Dns`.
#   """

#   @doc """
#   Hello world.

#   ## Examples

#       iex> Dns.hello()
#       :world

#   """
#   def parse do
    dns_request = IO.read(:stdio, :all) |> DnsPacket.parse()

    # IO.puts dns_request.questions[0]
    # dns_request = File.read!("./test/request/request") |> DnsPacket.parse()
    question = Enum.at(dns_request.questions, 0)
    IO.puts("Question is " <> question.name)
#   end
# end
