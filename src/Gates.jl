module Gates
export Operation, I, X, Y, Z, RX, RY, RZ, IsingXX, IsingYY, IsingZZ
export Controlled, qubits, SingleQubitOp
abstract type Operation end

function qubits(op::Operation)
    return op.qubits
end

#################### SINGLE QUBIT OPS ###############################

"""
An identity gate
"""
struct I <: Operation
end

"""
A Pauli X gate
"""
struct X <: Operation
    qubits:: Int8
end

"""
A Pauli Y gate
"""
struct Y <: Operation 
    qubits:: Int8
end

"""
A Pauli Z gate
"""
struct Z  <: Operation 
    qubits:: Int8
end

"""
A Pauli RX gate
"""
struct RX <: Operation 
    parameters:: Float64
    qubits:: Int8
end

"""
A RY gate
"""
struct RY <: Operation 
    parameters:: Float64
    qubits:: Int8
end

"""
A  RZ gate
"""
struct RZ <: Operation 
    parameters:: Float64
    qubits:: Int8
end

SingleQubitOp = Union{I, X, Y, Z, RX, RY, RZ}

function qubits(op::I)::Vector{Int8}
    return Int8[]
end

function qubits(op::SingleQubitOp)::Vector{Int8}
    return [op.qubits]
end

################ TWO QUBIT OPS ###############################

struct IsingXX <: Operation
    parameters::Float64
    qubits::Vector{Int8}
end

struct IsingYY <: Operation
    parameters::Float64
    qubits::Vector{Int8}
end

struct IsingZZ <: Operation
    parameeters::Float64
    qubits::Vector{Int8}
end

################### WRAPPER GATES ##########################

"""
A Controlled Gate

`base` can be any other Operation. `qubits` is any number of control
qubits.
"""
struct Controlled <: Operation
    base:: Operation
    qubits:: Vector{Int8}

    Controlled(base::I, qubits) = I()
    Controlled(base::Operation, qubits::Vector{Int}) = new(base, qubits)
    Controlled(base::Operation, qubits::Int) = new(base, [qubits])
end

function qubits(op::Controlled)::Vector{Int8}
    return vcat(op.qubits, qubits(op.base))
end


end