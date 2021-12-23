module Arithmetic
export adjoint, ^, inv, sqrt

using ..Pathetique
import Base.adjoint, Base.^, Base.sqrt, Base.inv

exponent_gates = Union{RX, RY, RZ, IsingXX, IsingYY, IsingZZ}

########## ADJOINT STUFF ############################

"""
An adjointed gate
"""
struct Adjoint <: Operation
    base:: Operation
end

"""Constructor for the `Adjoint` class"""
adjoint(op::Operation) = Adjoint(op)

adjoint(op::Union{I, X, Y, Z}) = op

adjoint(op::exponent_gates) = typeof(op)(-op.parameters, op.qubits)

adjoint(op::Controlled) = Controlled(adjoint(op.base), op.qubits)

function qubits(op::Adjoint)::Vector{Int8}
    return qubits(op.base)
end

################# OTHERS #####################

function ^(op::I, x)::I
    return I()
end

function ^(op::exponent_gates, x::Real)::Operation
    return typeof(op)(op.parameters*x, op.qubits)
end

function ^(op::Union{X, Y, Z}, x::Int)::Operation
    if iseven(x)
        return I()
    end
    return op
end

inv(op::Operation)::Operation = adjoint(op)

sqrt(op::Operation)::Operation = op^(0.5)

end