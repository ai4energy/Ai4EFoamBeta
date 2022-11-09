using PyCall


"""
points are point in Coordinate System
keys are geometries imfo
vals are points'index of a geometry

"""
function read_mesh(file::AbstractString)
    file = isabspath(file) ? file : error("Please use `AbSOLUTE PATH`(begins
    at the root directory)")

    py"""
    import meshio
    def read(file):
        m0 = meshio.read(file)
        points = m0.points
        cells = m0.cells
        keys = []
        vals = []
        for cell in cells:
            keys.append(cell.type)
            vals.append(cell.data)
        return points, keys, vals
    """

    points, keys, vals = py"read"(file)
    for val in vals
        val .+= 1 # python index is zero-based
    end

    counters = Dict{String,Int}([geo => 0 for geo in collect(Set(keys))])
    for geo in keys
        counters[geo] += 1
    end

    printstyled("======== Mesh Information ======\n", color=:green)
    printstyled("Number of Points:\t", length(eachrow(points)), "\n", color=:blue)
    printstyled("Number of Type:\n", color=:blue)
    for (geo,n) in counters
        printstyled("   ", geo, ":\t$(n)\n", color=:yellow)
    end
    printstyled("Info of Geometry:\n", color=:blue)
    for i in eachindex(keys)
        printstyled("   ", keys[i], ":\t$(length(eachrow(vals[i])))\n", color=:yellow)
    end
    return points, keys, vals
end

# allequal(points[:,3])

