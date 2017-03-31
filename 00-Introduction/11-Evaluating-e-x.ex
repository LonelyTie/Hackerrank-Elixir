defmodule Solution do
	defp factorial(0) do
		1
	end
	defp factorial(1) do
		1
	end
	defp factorial(n) do
		n * factorial(n - 1)
	end

	defp pow(_, 0) do
		1
	end
	defp pow(n, exp) do
		n * pow(n, exp - 1)
	end

	defp e(n, 1) do
		n + 1
	end
	defp e(n, exp) do
		(pow(n, exp) / factorial(exp)) + e(n, exp - 1)
	end

	defp readInput do
		IO.read(:all)
		|> String.trim
		|> String.split("\n")
		|> Enum.map(&String.to_float/1)
	end
	defp doStuffForEach([]) do
	end
	defp doStuffForEach([head | tail]) do
		e(head, 9) |> IO.puts
		doStuffForEach(tail)
	end
	def solve do
		IO.gets("")
		readInput |> doStuffForEach
	end
end

Solution.solve
