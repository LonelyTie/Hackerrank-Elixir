defmodule Solution do
	def fib(0) do
		0
	end
	def fib(1) do
		1
	end
	def fib(n) do
		fib(n-1) + fib(n-2)
	end
	def solve do
		n = IO.gets("")
		|> String.to_integer
		fib(n - 1) |> IO.puts
	end
end

Solution.solve
