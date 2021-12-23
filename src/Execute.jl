module Execute
export apply, execute

using ..Pathetique
import TensorOperations.ncon

function max_qubit(circ::Circuit)::Int8
    n_qubits = 0
    for op in circ
        n_qubits = max(n_qubits, maximum(qubits(op)))
    end
    return n_qubits
end

function apply(state::Array{T}, op::Operation, circ_num_qubits::Int8)::Array{T} where {T<:Complex}

    op_qubits = qubits(op)

    state_indices = -collect(1:circ_num_qubits)
    op_indices = cat(zeros(Int, length(op_qubits)), (1:length(op_qubits)), dims=1)

    for (i, w) in enumerate(reverse(op_qubits))
        state_indices[w] = i
        op_indices[i] = -w
    end

    matr = reshape(matrix(op), repeat([2], 2*length(op_qubits))...)

    return ncon((matr, state), (op_indices, state_indices))
end

function execute(circ::Circuit, ::Type{T}=ComplexF64)::Array{T} where {T<:Complex}
    circ_num_qubits = max_qubit(circ)

    state = zeros(T, repeat([2], circ_num_qubits)...)
    state[1] = 1.0

    for op in circ
        state = apply(state, op, circ_num_qubits)
    end

    return state[:]
end

end