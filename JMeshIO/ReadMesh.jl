using FileIO

dir = joinpath(@__DIR__, "meshFile/")

for file in readdir(dir)
    path = joinpath(dir, file)
    printstyled("/n======== ", file, "=========/n", color=:green)
    display(typeof(load(path)))
end

asc_mesh = load("JMeshIO/meshFile/ascii.ply")
asc_mesh = load("JMeshIO/meshFile/sphere5.gts")

display(asc_mesh)
typeof(asc_mesh)