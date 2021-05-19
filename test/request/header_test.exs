defmodule HeaderTest do
  use ExUnit.Case
  doctest Dns

  @filePath "./test/request/request"

  setup_all do
    [header, _remaining] = File.read!(@filePath) |> Header.parse()
    %{header: header}
  end

  test "id read from header", %{header: header} do
    assert header.id == 15579
  end

  test "query read from header", %{header: header} do
    assert header.qr == 0
  end

  test "opcode read from header", %{header: header} do
    assert header.opcode == 0
  end

  test "Authoritative Answer read from header", %{header: header} do
    assert header.aa == 0
  end

  test "Truncated Message answer read from header", %{header: header} do
    assert header.tc == 0
  end

  test "Recursion Desired answer read from header", %{header: header} do
    assert header.rd == 1
  end

  test "Recursion Available read from header", %{header: header} do
    assert header.ra == 0
  end

  test "Reserved read from header", %{header: header} do
    assert header.z == 2
  end

  test "Response Code read from header", %{header: header} do
    assert header.rdcode == 0
  end

  test "Question Count read from header", %{header: header} do
    assert header.qdcount == 1
  end

  test "Answer Count read from header", %{header: header} do
    assert header.ancount == 0
  end

  test "Authority Count read from header", %{header: header} do
    assert header.nscount == 0
  end

  test "Additional Count read from header", %{header: header} do
    assert header.arcount == 0
  end
end
