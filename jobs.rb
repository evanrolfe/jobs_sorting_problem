require './graph'

class Jobs
	def self.permute(jobs_constraints=nil)
		return '' if jobs_constraints.nil?		#Return emptry string if no jobs are given

		#1. Instantiate a graph which represents the jobs
		vertices = jobs_constraints.map{ |job1, job2| job1 }
		edges = jobs_constraints.reject{ |k,v| v.nil? }.map{ |job1, job2| [job2, job1] }
		graph = Graph.new(vertices, edges)

		#2. Determine the sequence of jobs which follows the constraints
		sequence = []
		begin
			v = graph.non_terminal_vertices.first
			sequence << v
			graph.delete_vertex(v)
		end until sequence.length == jobs_constraints.length

		return sequence
	end
end