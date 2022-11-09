using FiniteMesh

cells, points = read_mesh("D:/postgraduate/project/develop/CFD/CodeTest/FvmMesh/mesh/Gmsh/t1.msh")

newcells = Cells(cells.type, convert(Vector{Matrix{Int64}}, cells.index))

mesh = Mesh((newcells, points)..., mesh_connectivity_2D(newcells, points)...)