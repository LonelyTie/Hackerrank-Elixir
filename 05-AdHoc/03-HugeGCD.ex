defmodule Common do
    def greatestCommonDivisor(0, _) do
		1
	end
	def greatestCommonDivisor(a, 0) do
		abs(a)
	end
	def greatestCommonDivisor(a, b) do
		greatestCommonDivisor(b, rem(a,b))
	end
	def leastCommonMultiple(a, b) do
		div((a * b), greatestCommonDivisor(a, b))
	end
end


defmodule Solution do
	defp readInput do
		IO.read(:line)
        |> String.trim("\n")
		|> String.split(" ")
		|> Enum.map(&String.to_integer/1)
	end
	defp toNumber(list) do
		toNumber(list, 1)
	end
	defp toNumber([], _) do
		1
	end
	defp toNumber([head | tail], result) do
		result * head * toNumber(tail, result)
	end
	def solve do
		IO.gets("")
		a = readInput
		|> toNumber
		IO.gets("")
		b = readInput
		|> toNumber
        Common.greatestCommonDivisor(a, b)
        |> rem(1000000007)
        |> IO.puts
	end
end

Solution.solve
