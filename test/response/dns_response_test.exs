defmodule DnsResponseTest do
  use ExUnit.Case
  doctest Dns

  @filePath "./test/response/response"
  setup_all do
    dns_packet = File.read!(@filePath) |> DnsPacket.parse()
    %{dns_packet: dns_packet}
  end

  test "Questions are parsed", %{dns_packet: dns_packet} do
    assert dns_packet.header.qdcount == 1
    assert length(dns_packet.questions) == 1
  end

  test "answers are parsed", %{dns_packet: dns_packet} do
    assert length(dns_packet.questions) == 1
    answer = Enum.at(dns_packet.answers, 0)
    assert answer.name === "google.com"
  end
end
