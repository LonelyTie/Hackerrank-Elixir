defmodule Solution do
    defp readInput do
        IO.read(:all)
        |> String.trim
        |> String.split("\n")
        |> Enum.map(&String.to_integer/1)
    end
    defp loop([], _) do
    end
    defp loop([head | tail], index) do
        if rem(index, 2) != 0 do
            IO.puts head
        end
        loop(tail, index + 1)
    end
    def solve do
        readInput |> loop(0)

    end
end

Solution.solve
