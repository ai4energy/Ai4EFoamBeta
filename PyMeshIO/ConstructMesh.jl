include("ReadMesh.jl")

points, keys, vals = read_mesh("../FvmMesh/mesh/Gmsh/t1.msh")

using Meshes, MeshViz
import GLMakie

points = [Point(p...) for p in eachrow(points)]
connec = connect.([tuple(p...) for p in eachrow(vals[end])], Ngon)
mesh = SimpleMesh(points, connec)
viz(mesh, showfacets = true)

mesh_re = refine(mesh,TriRefinement())
viz(mesh_re, showfacets = true)
