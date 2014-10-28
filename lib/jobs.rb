require 'graph'

class Jobs
  def self.run(jobs_constraints=nil)
    return '' if jobs_constraints.nil?		#Return emptry string if no jobs are given

    #1. Check no jobs follow themselves
    if jobs_constraints.select{ |job1, job2| job1 == job2 }.length > 0
      raise ArgumentError, "A job cannot follow itself!"
    end

    #2. Instantiate a graph which represents the jobs
    vertices = jobs_constraints.map{ |job1, job2| job1 }
    edges = jobs_constraints.reject{ |k,v| v.nil? }.map{ |job1, job2| [job2, job1] }
    graph = Graph.new(vertices, edges)

    #3. Determine the sequence of jobs which follows the constraints
    sequence = []
    begin
      v = graph.non_terminal_vertices.first
      sequence << v
      graph.delete_vertex(v)
    end while graph.non_terminal_vertices.length > 0

    #4. If any edges remain then the graph contains a cycle so raise an error
    if graph.edges.length > 0
      raise ArgumentError, "The constraints contain circular dependencies!"
    end

    sequence
  end
end
