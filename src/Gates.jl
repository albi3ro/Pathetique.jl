module Gates
export Operation, X, Y, Z, RX, RY, RZ, Controlled
abstract type Operation end


struct X <: Operation
    qubits:: Vector{Int8}
end

struct Y <: Operation
    qubits:: Vector{Int8}
end

struct Z <: Operation
    qubits:: Vector{Int8}
end

struct RX <: Operation
    parameters:: Float64
    qubits:: Vector{Int8}
end

struct RY <: Operation
    parameters:: Float64
    qubits:: Vector{Int8}
end

struct RZ <: Operation
    parameters:: Float64
    qubits:: Vector{Int8}
end

for op in (:X, :Y, :Z, :RX, :RY, :RZ)
    eval(quote
        $op(x::Int) = $op([x])
    end)
end

struct Controlled <: Operation
    base:: Operation
    qubits:: Vector{Int8}
end

end