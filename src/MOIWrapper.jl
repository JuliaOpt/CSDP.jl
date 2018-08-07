using SemidefiniteOptInterface
SDOI = SemidefiniteOptInterface

using MathOptInterface
MOI = MathOptInterface

mutable struct SDOptimizer <: SDOI.AbstractSDOptimizer
    C
    b
    As
    X
    y
    Z
    status::Cint
    pobj::Cdouble
    dobj::Cdouble
    options::Dict{Symbol,Any}
    function SDOptimizer(; kwargs...)
        new(nothing, nothing, nothing, nothing, nothing, nothing,
            -1, 0.0, 0.0, checkoptions(Dict{Symbol, Any}(kwargs)))
    end
end
Optimizer(; kws...) = SDOI.SDOIOptimizer(SDOptimizer(; kws...))

function SDOI.init!(m::SDOptimizer, blkdims::Vector{Int}, nconstrs::Int)
    @assert nconstrs >= 0
    dummy = nconstrs == 0
    if dummy
        # See https://github.com/coin-or/Csdp/issues/2
        nconstrs = 1
        blkdims = [blkdims; -1]
    end
    m.C = blockmatzeros(blkdims)
    m.b = zeros(Cdouble, nconstrs)
    m.As = [constrmatzeros(i, blkdims) for i in 1:nconstrs]
    if dummy
        # See https://github.com/coin-or/Csdp/issues/2
        m.b[1] = 1
        SDOI.block(m.As[1], length(blkdims))[1,1] = 1
    end
end

function SDOI.setconstraintconstant!(m::SDOptimizer, val, constr::Integer)
    #println("b[$constr] = $val")
    m.b[constr] = val
end
function SDOI.setconstraintcoefficient!(m::SDOptimizer, coef, constr::Integer, blk::Integer, i::Integer, j::Integer)
    #println("A[$constr][$blk][$i, $j] = $coef")
    SDOI.block(m.As[constr], blk)[i, j] = coef
end
function SDOI.setobjectivecoefficient!(m::SDOptimizer, coef, blk::Integer, i::Integer, j::Integer)
    #println("C[$blk][$i, $j] = $coef")
    SDOI.block(m.C, blk)[i, j] = coef
end

function MOI.optimize!(m::SDOptimizer)
    As = map(A->A.csdp, m.As)

    write_prob(m)

    m.X, m.y, m.Z = initsoln(m.C, m.b, As)
    #verbose = get(m.options, :verbose, true)
    #m.status, m.pobj, m.dobj = easy_sdp(m.C, m.b, As, m.X, m.y, m.Z, verbose)
    m.status, m.pobj, m.dobj = sdp(m.C, m.b, m.As, m.X, m.y, m.Z, m.options)
end

function MOI.get(m::SDOptimizer, ::MOI.TerminationStatus)
    status = m.status
    if 0 <= status <= 2
        return MOI.Success
    elseif status == 3
        return MOI.AlmostSuccess
    elseif status == 4
        return MOI.IterationLimit
    elseif 5 <= status <= 7
        return MOI.SlowProgress
    elseif 8 <= status <= 9
        return MOI.NumericalError
    else
        error("Internal library error: status=$status")
    end
end

MOI.canget(m::SDOptimizer, ::MOI.PrimalStatus) = m.status == 0 || m.status >= 2
function MOI.get(m::SDOptimizer, ::MOI.PrimalStatus)
    status = m.status
    if status == 0
        return MOI.FeasiblePoint
    elseif status == 1
        return MOI.InfeasiblePoint
    elseif status == 2
        return MOI.InfeasibilityCertificate
    elseif status == 3
        return MOI.NearlyFeasiblePoint
    elseif 4 <= status <= 9
        return MOI.UnknownResultStatus
    else
        error("Internal library error: status=$status")
    end
end

MOI.canget(m::SDOptimizer, ::MOI.DualStatus) = 0 <= m.status <= 1 || m.status >= 3
function MOI.get(m::SDOptimizer, ::MOI.DualStatus)
    status = m.status
    if status == 0
        return MOI.FeasiblePoint
    elseif status == 1
        return MOI.InfeasibilityCertificate
    elseif status == 2
        return MOI.InfeasiblePoint
    elseif status == 3
        return MOI.NearlyFeasiblePoint
    elseif 4 <= status <= 9
        return MOI.UnknownResultStatus
    else
        error("Internal library error: status=$status")
    end
end

function SDOI.getprimalobjectivevalue(m::SDOptimizer)
    m.pobj
end
function SDOI.getdualobjectivevalue(m::SDOptimizer)
    m.dobj
end
function SDOI.getX(m::SDOptimizer)
    m.X
end
function SDOI.gety(m::SDOptimizer)
    m.y
end
function SDOI.getZ(m::SDOptimizer)
    m.Z
end
