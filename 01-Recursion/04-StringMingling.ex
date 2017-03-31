defmodule Solution do
    defp readInput do
        IO.read(:all)
        |> String.trim
        |> String.split("\n")
    end
    defp printR([], []) do
        IO.puts ""
    end
    defp printR([headp | tailp], [headq | tailq]) do
        IO.write "#{headp}#{headq}"
        printR(tailp, tailq)
    end
    def solve do
        [p | q] = readInput

        printR(String.split(p, "", trim: true), String.split(List.to_string(q), "", trim: true))
    end
end

Solution.solve
