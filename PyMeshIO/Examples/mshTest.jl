include("../ReadMesh.jl")

using Meshes, MeshViz
import GLMakie

# ========== quadrature.msh =============# 
path = "D:/postgraduate/project/develop/CFD/CodeTest/FvmMesh/mesh/Gmsh/quadrature.msh"
points, keys, vals = read_mesh(path);
points = [Point(p...) for p in eachrow(points)]
connec = connect.([tuple(p...) for p in eachrow(vals[end])], Ngon)
mesh = SimpleMesh(points, connec)
viz(mesh, showfacets=true)

mesh_re = refine(mesh, TriRefinement())
viz(mesh_re, showfacets=true)

# ========== square.msh =============# 
path = "D:/postgraduate/project/develop/CFD/CodeTest/FvmMesh/mesh/Gmsh/square.msh"
points, keys, vals = read_mesh(path);
points = [Point(p...) for p in eachrow(points)]
connec = connect.([tuple(p...) for p in eachrow(vals[end])], Ngon)
mesh = SimpleMesh(points, connec)
viz(mesh, showfacets=true)

# ========== naca0012.msh =============# 
path = "D:/postgraduate/project/develop/CFD/CodeTest/FvmMesh/mesh/Gmsh/naca0012.msh"
points, keys, vals = read_mesh(path);
points = [Point(p...) for p in eachrow(points)]
connec = connect.([tuple(p...) for val in vals for p in eachrow(val)])
mesh = SimpleMesh(points, connec)
viz(mesh, showfacets=true)

begin
    connecline = [tuple(p...) for val in vals[1:4] for p in eachrow(val)]
    pointslineindex = Int[]
    for i in connecline
        append!(pointslineindex, i)
    end
    pointslineindex = Set(pointslineindex) |> collect
    linepoints = [points[i] for i in pointslineindex]
    viz(linepoints)        
end


# ========== t1.msh =============# 
path = "D:/postgraduate/project/develop/CFD/CodeTest/FvmMesh/mesh/Gmsh/t1.msh"
points, keys, vals = read_mesh(path);
points = [Point(p...) for p in eachrow(points)]
connec = connect.([tuple(p...) for p in eachrow(vals[end])], Ngon)
mesh = SimpleMesh(points, connec)
viz(mesh, showfacets=true)