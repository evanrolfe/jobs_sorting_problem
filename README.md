## Notes on my solution

The job structure can be represented as a directed graph. For example the structure:

a =>
b => c
c => f
d => a
e =>
f => b

is represented by a graph with six verticies and 4 edges. Each vertex is a job and each edge is a dependency where the terminal vertex is the job that must follow the job at the initial vertex.

If the job constraints given to the algorithm are valid then the graph will be a directed acyclic graph meaning that the graph cannot contain any cycles. Otherwise, a cycle between three vertices, say a,b and c, would mean that job a must follow job b must follow job c must follow job a which is of course impossible.

Therefore, the graph will always contain at least on vertex with no incoming edges, or in terms of the problem: a job with no dependencies. So the algorithm adds the first vertex with no incoming edges to the sequence, then removes the vertex and all edges originated at this vertex from the graph, then continues this process with the next vertex with non incoming edges. The process repeats until no more  vertices left in the graph.

Once this loop terminates, if there are any edges left in the graph then there must exist a cycle and thus the job constraints contain circular dependencies.