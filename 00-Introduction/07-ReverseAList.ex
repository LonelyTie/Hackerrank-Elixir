defmodule Solution do
    defp readInput(:eof, list) do
        list
    end
    defp readInput(current, list) do
        current = current
        |> IO.chardata_to_string()
        |> String.trim()
        |> String.to_integer()
        list = [current] ++ list
        IO.gets("") |> readInput(list)
    end
    defp printList([]) do
    end
    defp printList([head | tail]) do
        IO.puts head
        printList(tail)
    end
    def solve do
        IO.gets("")
        |> readInput([])
        |> printList
    end
end

Solution.solve
