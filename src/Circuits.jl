module Circuits
export *, Circuit

import ..Pathetique: Operation
import Base.*

Circuit = Vector{Operation}

function *(op1::Operation, op2::Operation)::Circuit
    return [op1, op2]
end

function *(queue::Circuit, op::Operation)::Circuit
    return push!(queue, op)
end

function *(op::Operation, queue::Circuit)::Circuit
    return append!([op], queue)
end

function *(queue1::Circuit, queue2::Circuit)::Circuit
    return append!(queue1, queue2)
end

end