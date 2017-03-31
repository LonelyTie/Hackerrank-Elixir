defmodule Solution do
	defp readInput do
		IO.read(:all)
		|> String.trim
		|> String.split("\n")
	end
	defp rec_rotate(_, 0, toPrint) do
		Enum.join(toPrint, " ") |> IO.puts
	end
	defp rec_rotate([head | tail], len, toPrint) do
		list = tail ++ [head]
		rec_rotate(list, len - 1, toPrint ++ [Enum.join(list)])
	end
	defp computeString(str) do
		String.split(str, "")
		|> rec_rotate(String.length(str), [])
	end
	defp doStuffForEach([]) do
	end
	defp doStuffForEach([head | tail]) do
		computeString(head)
		doStuffForEach(tail)
	end
	def solve do
		IO.gets("")
		list = readInput
		doStuffForEach(list)
	end
end

Solution.solve
