module Pathetique

include("Gates.jl")
using .Gates
export Operation, X, Y, Z, RX, RY, RZ, Controlled

include("Matrices.jl")
using .Matrices
export matrix

include("Circuits.jl")
using .Circuits
export *, Circuit

include("Execute.jl")
using .Execute
export apply, execute

print("moduled executed")


end # module
