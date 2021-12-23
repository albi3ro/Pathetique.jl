module Circuits
export *, Circuit

import ..Pathetique: Operation
import Base.*

Circuit = Vector{<:Operation}

function *(op1::Union{Circuit,Operation}, op2::Union{Circuit,Operation})::Circuit
    return vcat(op1, op2)
end

end