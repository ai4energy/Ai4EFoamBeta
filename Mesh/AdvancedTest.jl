using Meshes
using MeshViz
import GLMakie
using Test

#======================= PolyArea ==============================#

outer = [Point2(0.0, 0.0), Point2(1.0, 0.0), Point2(1.0, 1.0), Point2(0.0, 1.0), Point2(0.0, 0.0)]
hole1 = [Point2(0.2, 0.2), Point2(0.4, 0.2), Point2(0.4, 0.4), Point2(0.2, 0.4), Point2(0.2, 0.2)]
hole2 = [Point2(0.6, 0.2), Point2(0.8, 0.2), Point2(0.8, 0.4), Point2(0.6, 0.4), Point2(0.6, 0.2)]
poly = PolyArea(outer, [hole1, hole2])
viz(poly)
@show typeof(poly)

@test typeof(poly) <: PolyArea
@test PolyArea <: Polytope

br, _ = bridge(poly)
unbr, _ = poly |> unique |> bridge
viz(br)

#======================= sample ==============================#

points_hom = sample(poly, HomogeneousSampling(100)) |> collect
viz(points_hom)

points_mind = sample(poly, MinDistanceSampling(0.01)) |> collect
viz(points_mind)

#======================= Discretization ==============================#

discr_fan = discretize(poly, FanTriangulation())
discr_sim = simplexify(poly)
discr_rg = discretize(poly, RegularDiscretization(10))

@test typeof(discr_sim) <: SimpleMesh

for i in 1:3
    discr_sim = refine(discr_sim,TriRefinement())
end

fig = GLMakie.Figure(resolution = (800, 400))
viz(discr_sim, showfacets = true)

hexagon = Hexagon((0.,0.), (1.,0.), (1.,1.),
                  (0.75,1.5), (0.25,1.5), (0.,1.))

mesh = discretize(hexagon, FanTriangulation())

mesh = refine(mesh,TriRefinement())
viz(mesh, showfacets = true)


#======================= Meshes ==============================#

tria 
ms = 

#======================= partition ==============================#

d = CartesianGrid(10,10)
p = partition(d, UniformPartition(100))

sample(boundary(poly), HomogeneousSampling(1))

