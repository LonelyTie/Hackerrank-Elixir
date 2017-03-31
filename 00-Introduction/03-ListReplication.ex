defmodule Solution do
    def printVector(:eof, _) do
    end
    def printVector( current, times) do
        current
        |> IO.chardata_to_string()
        |> String.trim()
        |> String.to_integer()
        |> printNbr(times)
        IO.gets("") |> printVector(times)
    end
    def printNbr(_, 0) do
    end
    def printNbr(nbr, times) do
        IO.puts nbr
        printNbr(nbr, times - 1)
    end
end

times = IO.gets("")
|> IO.chardata_to_string()
|> String.trim()
|> String.to_integer()
IO.gets("") |> Solution.printVector(times)
