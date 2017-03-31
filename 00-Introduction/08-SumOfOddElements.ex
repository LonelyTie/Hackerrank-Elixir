defmodule Solution do
    defp sumOddNumbers([], n) do
        IO.puts n
    end
    defp sumOddNumbers([head | tail], n) do
        n =
            if rem(head, 2) != 0 do
                n + head
            else
                n
            end
        sumOddNumbers(tail, n)
    end
    defp readInput do
        IO.read(:all)
        |> String.trim
        |> String.split("\n")
        |> Enum.map(&String.to_integer/1)
    end
    def solve do
        readInput |> sumOddNumbers(0)
    end
end

Solution.solve
