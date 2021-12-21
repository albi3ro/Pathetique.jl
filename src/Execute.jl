module Execute
export apply, execute

using ..Pathetique
using TensorOperations

function num_qubits(circ::Circuit)::Int8
    n_qubits = 0
    for op in circ
        n_qubits = max(n_qubits, maximum(op.qubits))
        if op isa Controlled
           n_qubits = max(n_qubits, maximum(op.base.qubits)) 
        end
    end
    return n_qubits
end

function apply(state::Array{ComplexF64}, op::Operation, circ_num_qubits::Int8)::Array{ComplexF64}

    if op isa Controlled
        qubits = cat(op.qubits, op.base.qubits, dims=1)
    else
        qubits = op.qubits
    end

    state_indices = -collect(1:circ_num_qubits)
    op_indices = cat(zeros(Int, length(qubits)), (1:length(qubits)), dims=1)

    for (i, w) in enumerate(reverse(qubits))
        state_indices[w] = i
        op_indices[i] = -w
    end

    matr = reshape(matrix(op), repeat([2], 2*length(qubits))...)

    return ncon((matr, state), (op_indices, state_indices))
end

function execute(circ::Circuit)::Array{ComplexF64}
    circ_num_qubits = num_qubits(circ)

    state = zeros(Complex{Float64}, repeat([2], circ_num_qubits)...)
    state[1] = 1.0

    for op in circ
        state = apply(state, op, circ_num_qubits)
    end

    return state
end

end