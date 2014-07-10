require 'pry'
require './graph'

describe Graph do
	before :each do
		edges = [['a','d'],['b','e'],['c','b'],['f','c']]
		vertices = ['a','b','c','d','e','f']
		@graph = Graph.new(vertices, edges)
	end

	it "instantiates the graph with edges" do
		expect(@graph.edges).to eq [['a','d'],['b','e'],['c','b'],['f','c']]
	end

	it "instantiates the graph with vertices" do
		expect(@graph.vertices).to eq ['a','b','c','d','e','f']
	end

	describe "deleting a vertex" do
		before :each do
			@graph.delete_vertex('c')
		end

		it "removes a vertex from the vertices array " do
			expect(@graph.vertices).to eq ['a','b','d','e','f']
		end

		it "removes the vertex's corresponding edges" do
			expect(@graph.edges).to eq [['a','d'],['b','e']]
		end
	end

	it "returns vertices with no incoming edge" do
		vertices = @graph.non_terminal_vertices
		expect(vertices).to eq ['a','f']
	end

	it "returns vertices with no incoming edge (2)" do
		@graph.delete_vertex('a')
		@graph.delete_vertex('f')
		@graph.delete_vertex('d')
		vertices = @graph.non_terminal_vertices
		expect(vertices).to eq ['c']
	end
end