module Matrices
export matrix

using ..Pathetique
using LinearAlgebra

function num_qubits(op:: Operation)::Int32
    if op.qubits isa Symbol
        return 1
    end
    return length(op.qubits)
end

function matrix(op::X)::Matrix{Int64}
    return [0 1; 1 0]
end

function matrix(op::Y)::Matrix{Complex{Int64}}
    return [0 -1im; 1im 0]
end

function matrix(op::Z)::Matrix{Int64}
    return [1 0;0 -1]
end

function matrix(op::RX)::Matrix{ComplexF64}
    x_mat = [0 1; 1 0]
    return exp(-1im * op.parameters * x_mat/2)
end

function matrix(op::RY)::Matrix{ComplexF64}
    y_mat = [0 -1im; 1im 0]
    return exp(-1im * op.parameters * y_mat/2)
end

function matrix(op::RZ)::Matrix{ComplexF64}
    z_mat = [1 0;0 -1]
    return exp(-1im * op.parameters * z_mat/2)
end

function matrix(op::Controlled)::Matrix{ComplexF64}
    n_control = 2^num_qubits(op)
    n_target = 2^num_qubits(op.base)

    mat = diagm(append!(fill(Complex{Float64}(1), n_control), fill(0, n_target)))
    target_locs = (n_control+1):(n_control+n_target)
    mat[target_locs, target_locs] = matrix(op.base)
    return mat
end

end