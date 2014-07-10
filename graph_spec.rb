require 'pry'
require './graph'

describe Graph do
	before :each do
		edges = [[1,4],[2,5],[3,2],[6,3]]
		@graph = Graph.new(6, edges)
	end

	it "instantiates the graph with edges" do
		expect(@graph.edges).to eq [[1,4],[2,5],[3,2],[6,3]]
	end

	it "instantiates the graph with vertices" do
		expect(@graph.vertices).to eq [1,2,3,4,5,6]
	end

	describe "deleting a vertex" do
		before :each do
			@graph.delete_vertex(3)
		end

		it "removes a vertex from the vertices array " do
			expect(@graph.vertices).to eq [1,2,4,5,6]
		end

		it "removes the vertex's corresponding edges" do
			expect(@graph.edges).to eq [[1,4],[2,5]]
		end
	end

	it "returns vertices with no incoming edge" do
		vertices = @graph.non_terminal_vertices
		expect(vertices).to eq [1,6]
	end

	it "returns vertices with no incoming edge (2)" do
		@graph.delete_vertex(1)
		@graph.delete_vertex(6)
		@graph.delete_vertex(4)
		vertices = @graph.non_terminal_vertices
		expect(vertices).to eq [3]
	end
end