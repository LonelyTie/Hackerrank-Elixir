defmodule Math do
	def sq(x) do
		x * x
	end
	def sqrt(x) do
		refine x, x / 2.0, 1.0
	end

	def refine(target, _, attempt) when attempt * attempt == target do
		attempt
	end

	def refine(_, adjustment, attempt) when abs(attempt - (attempt - adjustment)) < 1.0e-20 do
		attempt
	end

	def refine(target, adjustment, attempt) when attempt*attempt > target do
		refine(target, adjustment / 2, attempt - adjustment)
	end

	def refine(target, adjustment, attempt) when attempt*attempt < target do
		refine(target, adjustment, attempt + adjustment)
	end
end

defmodule Print do
	def list([]) do
		IO.puts ""
	end
	def list([head | tail]) do
		IO.write "%{#{Map.fetch!(head, "x")} #{Map.fetch!(head, "y")}} "
		list(tail)
	end

end

defmodule Point do
	def left?(a, b, c) do
		((Map.fetch!(b, "x") - Map.fetch!(a, "x")) * (Map.fetch!(c,"y")  - Map.fetch!(a,"y")) - (Map.fetch!(b,"y")  - Map.fetch!(a,"y")) * (Map.fetch!(c, "x") - Map.fetch!(a, "x"))) > 0
	end
	def right?(a, b, c) do
		(((Map.fetch!(b,"y") - Map.fetch!(a,"y")) * (Map.fetch!(c,"x") - Map.fetch!(a, "x"))) - ((Map.fetch!(b,"x") - Map.fetch!(a,"x")) * (Map.fetch!(c,"y") - Map.fetch!(a,"y")))) > 0
	end

	def all_right([], _, _, list) do
		list
	end
	def all_right([head | tail], a, b, list) do
		if right?(head, a, b) do
			all_right(tail, a, b, [head | list])
		else
			all_right(tail, a, b, list)
		end
	end

	def midpoint(a, b) do
		%{"x" => (Map.fetch!(a, "x") + Map.fetch!(b, "x")) /2, "y" => (Map.fetch!(a,"y")  + Map.fetch!(b,"y") ) / 2}
	end
	def median(a, b, c) do
		midpoint(a, b)
		|> distance(c)
	end
	def distance(a, b) do
		Math.sq(Map.fetch!(a, "x") - Map.fetch!(b, "x")) + Math.sq(Map.fetch!(a,"y")  - Map.fetch!(b,"y"))
		|> Math.sqrt
	end
	def farthest([], _, _, _, far) do
		far
	end
	def farthest([head |tail], p, q, far, current) do
		check = median(head, p, q)
		if check > far do
			farthest(tail, p, q, check, head)
		else
			farthest(tail, p, q, far, current)
		end
	end
	def periperimeter([_]) do
		0
	end
	def periperimeter([head | [second | tail]]) do
		distance(head, second) + periperimeter([second | tail])
	end

	def perimeter(poly) do
			distance(List.first(poly), List.last(poly)) + periperimeter(poly)
	end
end

defmodule Solution do
	defp to_coordinates(point) do
		split = String.split(point, " ") |> Enum.map(&String.to_integer/1)
		[x, y] = split
		# IO.puts "#{x} #{y}"
		%{"x" => x, "y" => y}
	end

	defp findHull([], _, _, hull) do
		hull
	end

	defp findHull(sk, p, q, hull) do
		IO.write "current Hull "
		Print.list(hull)
		c = Point.farthest(sk, p, q, 0, Map.new())
		IO.write "SK : "
		Print.list(sk)
		IO.write "farthest :"
		Print.list([c])
		ip = Enum.find_index(hull, &(&1 == p))
		iq = Enum.find_index(hull, &(&1 == q))
		IO.puts "ip : #{ip}, iq: #{iq}"
		hull = List.insert_at(hull, ip + (ip - iq) , c)
		IO.puts "S1 :"
		s1 = Enum.filter(sk, &Point.right?(p, c, &1))
		Print.list(s1)
		IO.puts "S2 :"
		s2 = Enum.filter(sk, &Point.right?(c, q, &1))
		Print.list(s2)
		IO.write "findHull s1 with "
		Print.list([p])
		IO.write "And "
		Print.list([c])
		IO.write "With "
		Print.list(hull)
		hull = findHull(s1, p, c, hull)
		IO.write "findHull s2 with "
		Print.list([c])
		IO.write "And "
		Print.list([q])
		IO.write "With "
		Print.list(hull)
		hull = findHull(s2, c, q, hull)
		hull
	end

	defp quickHull(s) do
		[head | tail] = s
		last = List.last(tail)
		hull = [head, last]
		new_set = List.delete(tail, last)
		IO.puts "HULL"
		Print.list(hull)
		s1 = Enum.filter(new_set, &Point.right?(head,last, &1))
		IO.puts "S1 in quickHull"
		Print.list(s1)
		s2 = new_set -- s1
		IO.puts "S2 in quickHull"
		Print.list(s2)
		hull = findHull(s1, head, last, hull)
		hull = findHull(s2, last, head, hull)
		Print.list(hull)
		hull
	end
	defp readInput do
		IO.read(:all)
        |> String.trim
		|> String.split("\n")
        |> Enum.sort(&(&1 <= &2))
		|> Enum.map(&to_coordinates/1)
	end
	def solve do
		IO.gets("")
		readInput
		|> quickHull
		|> Point.perimeter
		|> IO.puts
	end
end

Solution.solve
