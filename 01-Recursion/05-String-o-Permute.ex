# Doesn't pass the last test case
defmodule Solution do
    defp readInput(:eof) do
    end
    defp readInput do
        IO.read(:line)
        |> String.trim
        |> callPermuteStrings
        readInput
    end
    defp permuteStr({"", _}) do
        IO.puts ""
    end
    defp permuteStr(tuple) do
        elem(tuple, 0) |> String.last |> IO.write
        elem(tuple, 0) |> String.first |> IO.write
        elem(tuple, 1) |> String.split_at(2) |> permuteStr()
    end
    defp callPermuteStrings(head) do
        String.split_at(head, 2) |> permuteStr
    end
    def solve do
        IO.gets ""
        readInput
    end
end

Solution.solve
