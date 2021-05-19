defmodule QuestionTest do
  use ExUnit.Case
  doctest Dns

  @filePath "./test/request/request"

  setup_all do
    # file  = File.read!(@filePath)
    # <<header::size(98), remaining>> = file
    [_header, remaining] = File.read!(@filePath) |> Header.parse()

    [question, _remaining] = Question.parse(remaining)
    %{question: question}
  end

  test "name read from question", %{question: question} do
    assert question.name == "google.com"
  end

  test "type read from question 1=A", %{question: question} do
    assert question.type == 1
  end

  test "Class read", %{question: question} do
    assert question.class == 1
  end

  test "Remaining returned after question parsed", _ do
    [_header, remaining] = File.read!(@filePath) |> Header.parse()
    [_question, remaining] = Question.parse(remaining)
    assert bit_size(remaining) == 0
  end
end
