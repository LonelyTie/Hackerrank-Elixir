defmodule Solution do
    defp printListLen(list) do
        getListLen(list, 0) |> IO.puts
    end
    defp getListLen([], n) do
        n
    end
    defp getListLen([_ | tail], n) do
        getListLen(tail, n + 1)
    end
    defp readInput do
        IO.read(:all)
        |> String.trim
        |> String.split("\n")
        |> Enum.map(&String.to_integer/1)
    end
    def solve do
        readInput |> printListLen
    end
end

Solution.solve
