defmodule Solution do
	defp readInput do
		IO.read(:line)
        |> String.trim("\n")
		|> String.split(" ")
		|> Enum.map(&String.to_integer/1)
	end

	def solve do
		IO.gets("")
		a = readInput
		IO.gets("")
		b = readInput
		b -- a
        |> MapSet.new
        |> MapSet.to_list
        |> Enum.sort
		|> Enum.join(" ")
		|> IO.puts
	end
end

Solution.solve
