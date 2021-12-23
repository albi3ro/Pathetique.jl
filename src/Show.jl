module Show
export show

import Base.show
using ..Pathetique

function print_vector(v::AbstractVector)
    str = "["
    for (i, elt) in enumerate(v)
        if i>1
            str *= ", "
        end
        str *= string(elt)
    end
    return str *= "]"
end

function show(io::IO, op::Pathetique.Gates.Adjoint)
    print(io, "$(op.base)'")
end

function show(io::IO, op::Controlled)
    if length(op.qubits) == 1
        print(io, "C$(op.qubits[1]) $(op.base)")
    else
        print(io, "C$(print_vector(op.qubits)) $(op.base)")
    end
end

end