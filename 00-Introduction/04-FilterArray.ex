defmodule Solution do
#Enter your code here. Read input from STDIN. Print output to STDOUT
        def printOutput(_, []) do
    end
    def printOutput(limit, [head | tail]) do
        if head < limit do
            IO.puts head
        end
        printOutput(limit, tail)
    end
    def readInput(:eof, list) do
        list
    end
    def readInput(current, list) do
        current = current
        |> IO.chardata_to_string()
        |> String.trim()
        |> String.to_integer()
        list = list ++ [current]
        IO.gets("") |> readInput(list)
    end
end

limit = IO.gets("")
|> IO.chardata_to_string()
|> String.trim()
|> String.to_integer()
list = Solution.readInput(IO.gets(""), [])
Solution.printOutput(limit, list)
