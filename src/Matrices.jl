module Matrices
export matrix

using ..Pathetique
using LinearAlgebra

x_mat = [0 1; 1 0]
y_mat = [0 -1im; 1im 0]
z_mat = [1 0;0 -1]

matrix(op::X)::Matrix{Int64} = x_mat
matrix(op::Y)::Matrix{Complex{Int64}} = y_mat
matrix(op::Z)::Matrix{Int64} = z_mat

matrix(op::RX)::Matrix{ComplexF64} = exp(-0.5im * op.parameters * x_mat)
matrix(op::RY)::Matrix{ComplexF64} = exp(-0.5im * op.parameters * y_mat)
matrix(op::RZ)::Matrix{ComplexF64} = exp(-0.5im * op.parameters * z_mat)

matrix(op::IsingXX)::Matrix{ComplexF64} = exp(-1im * op.parameters * kron(x_mat, x_mat))
matrix(op::IsingYY)::Matrix{ComplexF64} = exp(-1im * op.parameters * kron(y_mat, y_mat))
matrix(op::IsingZZ)::Matrix{ComplexF64} = exp(-1im * op.parameters * kron(z_mat, z_mat))

function matrix(op::Controlled)::Matrix{ComplexF64}
    n_control = 2^length(op.qubits)
    n_target = 2^length(qubits(op.base))

    mat = Matrix{ComplexF64}(1I, n_control+n_target, n_control+n_target)

    target_locs = (n_control+1):(n_control+n_target)
    mat[target_locs, target_locs] = matrix(op.base)
    return mat
end

function matrix(op::Pathetique.Gates.Adjoint)::Matrix{ComplexF64}
    return adjoint(matrix(op.base))
end

end