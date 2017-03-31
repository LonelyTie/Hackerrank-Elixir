defmodule Solution do
    defp updateList(list) do
        list |> Enum.map(&Kernel.abs/1)
    end
    defp printList([]) do
    end
    defp printList([head | tail]) do
        IO.puts head
        printList(tail)
    end
    defp readInput do
        IO.read(:all)
        |> String.trim
        |> String.split("\n")
        |> Enum.map(&String.to_integer/1)
    end
    def solve do
        readInput |> updateList |> printList
    end
end

Solution.solve
