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
	defp printTriangle(row, col) do
		factorial(row)/(factorial(col) * factorial(row - col))
		|> trunc
		|> IO.write
		if row === col do
			IO.write("\n")
		else
			IO.write(" ")
		end
	end
	defp makeTriangle(size, row, col) do
		printTriangle(row, col)
		cond do
			size - 1 === row && col === row -> :end
			col === row -> makeTriangle(size, row + 1, 0)
			true -> makeTriangle(size, row, col + 1)
		end
	end
	def solve do
		IO.gets("")
		|> String.to_integer()
		|> makeTriangle(0, 0)
	end
end

Solution.solve
