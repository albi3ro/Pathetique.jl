module Pathetique

include("Gates.jl")
using .Gates
export Operation, X, Y, Z, RX, RY, RZ, IsingXX, IsingYY, IsingZZ
export Controlled, adjoint, qubits, SingleQubitOp

include("Matrices.jl")
using .Matrices
export matrix

include("Circuits.jl")
using .Circuits
export *, Circuit

include("Execute.jl")
using .Execute
export apply, execute

include("Show.jl")
using .Show
export show

print("moduled executed")


end # module
