defmodule Solution do
	def sayHello(0) do
		:ok
	end
	def sayHello(n) do
		IO.puts "Hello World"
		sayHello(n - 1)
	end
end

IO.gets("")
|> String.to_integer()
|> Solution.sayHello()
