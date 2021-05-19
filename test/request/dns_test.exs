defmodule DnsTest do
  use ExUnit.Case
  doctest Dns

  @filePath "./test/request/request"

  setup_all do
    dns_packet = File.read!(@filePath) |> DnsPacket.parse()
    %{dns_packet: dns_packet}
  end

  test "Questions are parsed", %{dns_packet: dns_packet} do
    assert dns_packet.header.qdcount == 1
    assert length(dns_packet.questions) == 1
  end
end
