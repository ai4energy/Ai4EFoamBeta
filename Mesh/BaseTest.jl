using Meshes
using MeshViz
import WGLMakie
#====================== Point and Vec ========================#

A = Point{3,Float64}([0, 1, 2])
Aco = A.coords
typeof(Aco)

coordtype(A)
embeddim(A)

B = Point([1, 2, 3])

A - B

coordinates(A) + coordinates(B)

A + Vec(1, 1, 1)

rand(Point2, 10)

#====================== Primitives ========================#

b = Box((0.0, 0.0, 0.0), (1.0, 1.0, 1.0))
b2 = Box((0.0, 0.0), (1.0, 1.0))
viz(b2)

extrema(b)
measure(b2)

vs = sample(b, RegularSampling(10)) # 10 points over the sphere

viz(collect(vs))

#====================== Ploytopes ========================#

t = Triangle((0.0, 0.0), (1.0, 0.0), (0.0, 1.0))
measure(t)

using Test
@test Point(0.2, 0.2) in t

s1 = Segment((0.0, 0.0), (1.0, 1.0))
s2 = Segment((0.5, 0.0), (2.0, 0.0))

@test isnothing(s1 ∩ s2)

p = PolyArea((0.0, 0.0), (2.0, 0.0), (2.0, 2.0), (1.0, 3.2), (0.0, 2.0), (0.0, 0.0))
measure(p)
ori = orientation(p)

c = chains(p)[1]
v = vertices(c)
angles(c) * 180 / pi

@test Point2(1.0, 3.0) in p

#====================== Ploytopes ========================#

g = CartesianGrid((0, 0), (1, 1), dims=(100, 100))
ms = collect(elements(g))

@test typeof(g) <: CartesianGrid

topology(g)

bds = Boundary{2,1}(topology(g))

topo = convert(HalfEdgeTopology, topology(g))
∂₂₁ = Boundary{2,1}(topo)
∂₂₁

elements(ms)

Neighborhood
@allocated elements(g)

