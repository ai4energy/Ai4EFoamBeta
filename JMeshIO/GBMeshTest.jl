using FileIO, Meshes
import GeometryBasics
using MeshViz
import GLMakie


ms = load("FvmMesh/mesh/Gmsh/naca0012.msh")

# decompose(TriangleFace, ms)

#========================== define mesh =================================#
points = map(x -> Point(convert.(Float64, getproperty(x, :data))...), GeometryBasics.coordinates(ms))
connec = connect.([tuple(map(x -> Int(getproperty(x, :i) + 1), f)...) for f in GeometryBasics.faces(ms)])
mesh = SimpleMesh(points, connec; relations=true)
viz(mesh, showfacets=true)

#========================== CartesianGrid mesh =================================#
grid = CartesianGrid((10, 10), (0.0, 0.0), (0.1, 0.1))
gridedge = topoconvert(HalfEdgeTopology, grid)
gridbd = Boundary{2,1}(topology(gridedge))
gridbd(1)
viz(grid, showfacets=true)


#========================== mesh topology =================================#

# using Test
# c = [tuple(map(x -> Int(getproperty(x, :i) + 1), f)...) for f in GeometryBasics.faces(ms)]
# @test [points[i] for i in c[1]] == ms[1].points

meshbd20 = Boundary{2,0}(topology(mesh))
meshcobd12 = Coboundary{1,2}(topology(mesh))
meshbd21 = Boundary{2,1}(topology(mesh))
meshbd10 = Boundary{1,0}(topology(mesh))
meshad = Adjacency{0}(topology(mesh))

#========================== API Test =================================#

# Return the number of rank-faces of the topology.
nfaces(mesh, 0) # number of vertice
nfaces(mesh, 1) # number of lines
nfaces(mesh, 2) # number of Ngon

# return number of triangle(top element) of mesh
nelements(mesh) # equal to nfaces(mesh, 2)
nfacets(mesh)   # equal to nfaces(mesh, 1)
nvertices(mesh) # equal to nfaces(mesh, 0)

# Return the -faces of the mesh
elements(mesh)
facets(mesh)
vertices(mesh)

# Return the ind-th of the structure
element(mesh, 1)
facet(mesh, 1)
vertices(mesh)
# lap = laplacematrix(mesh)

#========================== mesh topology test=================================#

lineNum = nfacets(mesh)
owner = [meshcobd12(i) for i in 1:lineNum]
bdlinesIndex = [i for i in 1:lineNum if length(meshcobd12(i)) == 1]
bdlinesPointConnec = map(x -> tuple(meshbd10(x)...), bdlinesIndex)
bdLineMesh = SimpleMesh(points, connect.(bdlinesPointConnec))
viz(bdLineMesh,showfacets=true)

bd = [facet(mesh, i) for i in bdlinesIndex]


viz(Segment((1.0,1.0),(0.0,0.0)))

count(x -> length(x) == 1, owner)

meshbd20(3811)
meshcobd12(1258)
maximum(maximum.(keys(bd.topology.edge4pair) |> collect))

