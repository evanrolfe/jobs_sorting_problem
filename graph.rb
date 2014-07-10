class Graph
	attr_reader :edges, :vertices

	def initialize(num_vertices, edges)
		@edges = edges
		@vertices = (1..num_vertices).to_a.map{|x| x }
	end

	def delete_vertex(id)
		@vertices.delete(id)
		@edges.reject!{ |edge| edge[0] == id || edge[1] == id }
	end

	def non_terminal_vertices
		non_terminal_vertices = []

		@vertices.each do |v|

			vertex_is_non_terminal = true

			@edges.each do |edge|
				vertex_is_non_terminal = false if edge[1] == v	#If this edge terminates at the current vertex
			end

			non_terminal_vertices << v if vertex_is_non_terminal
		end

		return non_terminal_vertices
	end
end