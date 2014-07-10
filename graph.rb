class Graph
	attr_reader :edges, :vertices

	def initialize(num_vertices, edges)
		@edges = edges
		@vertices = (1..num_vertices).to_a.map{|v| v }
	end

	def delete_vertex(v)
		@vertices.delete(v)
		@edges.reject!{ |v_start, v_end| v_start == v || v_end == v }
	end

	def non_terminal_vertices
		return @vertices.select do |v|
			@edges.select{ |v_start, v_end| v_end == v }.length == 0
		end
	end
end