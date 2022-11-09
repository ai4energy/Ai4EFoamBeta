include("../PyMeshIO/ReadMesh.jl")

using Meshes, MeshViz
import GLMakie

path = "D:/software/Gmsh/gmsh-4.10.5-Windows64/t1.msh"
points, keys, vals = read_mesh(path);

points = [Point(p...) for p in eachrow(points)]
connec = connect.([tuple(p...) for val in vals[1:3] for p in eachrow(val)])
mesh = SimpleMesh(points, connec)
viz(mesh, showfacets=true)

