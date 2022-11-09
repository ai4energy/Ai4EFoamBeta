begin
    using Pkg
    pkgNeeds = ["Meshes", "MeshViz","WGLMakie"]
    alreadyGet = keys(Pkg.project().dependencies)
    toAdd = [package for package in pkgNeeds if package ∉ alreadyGet]
    isempty(toAdd) ? nothing : Pkg.add(toAdd)
end

