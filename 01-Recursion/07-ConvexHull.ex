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
		IO.write "%{#{Map.fetch!(head, "x")} #{Map.fetch!(head, "y")}}"
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
		c = Point.farthest(sk, p, q, 0, Map.new())
		# Print.list([c])
		ip = Enum.find_index(hull, &(&1 == p))
		iq = Enum.find_index(hull, &(&1 == q))

		hull = List.insert_at(hull, ip + (ip - iq) , c)

		s1 = Enum.filter(sk, &Point.right?(p, c, &1))
		s2 = Enum.filter(sk, &Point.right?(c, q, &1))
		hull = findHull(s1, p, c, hull)
		hull = findHull(s2, c, q, hull)
		Print.list(hull)
		hull
	end

	defp quickHull(s) do
		[head | tail] = s
		last = List.last(tail)
		hull = [head, last]
		new_set = List.delete(tail, last)
		s1 = Enum.filter(new_set, &Point.right?(head,last, &1))
		s2 = new_set -- s1
		hull = findHull(s1, head, last, hull)
		findHull(s2, last, head, hull)
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
