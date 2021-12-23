module Pathetique

include("Gates.jl")
using .Gates
export Operation, I, X, Y, Z, RX, RY, RZ, IsingXX, IsingYY, IsingZZ
export Controlled, qubits, SingleQubitOp

include("Arithmetic.jl")
using .Arithmetic
export adjoint, ^, sqrt, inv

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
