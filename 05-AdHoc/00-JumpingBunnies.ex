defmodule Common do
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
		|> String.split(" ")
		|> Enum.map(&String.to_integer/1)
	end
	defp doStuffForEach([head | tail]) do
		doStuffForEach(tail, head)
	end
	defp doStuffForEach([], common) do
		IO.puts common
	end
	defp doStuffForEach([head | tail], compare) do
		doStuffForEach(tail, Common.leastCommonMultiple(head, compare))
	end
	defp compute(tab) do
		doStuffForEach(tab)
	end
	def solve do
		IO.gets("")
		list = readInput
		compute(list)
	end
end

Solution.solve
