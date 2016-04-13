# Data types declared in `include/blockmat.h`
# Small type names are the C types
# Capitalized are the corresponding Julia types
using Base.convert

brec(b::Vector{Cdouble}, cat::blockcat, l::Int) =
    blockrec(blockdatarec(pointer(b)), cat, Cint(l))
brec(b::Matrix{Float64}) =
    brec(reshape(b, length(b)), MATRIX, length(b))
brec(b::Diagonal{Float64}) = 
    brec([0; diag(b)], DIAG, length(b))

type Blockmatrix
    blocks::Vector{blockrec}
    Blockmatrix(bs::AbstractMatrix{Float64}...) =
        new([brec(b) for b in [Matrix{Float64}[]; collect(bs)]])
    Blockmatrix() = new([])
end

Base.convert(::Type{blockmatrix}, b::Blockmatrix) =
    blockmatrix(length(b.blocks)-1, pointer(b.blocks))

# TODO: Print-Function for Blockmatrix

# use pointer_from_obj to construct sparseblocks

immutable SparseBlock
    i::Vector{Cint}
    j::Vector{Cint}
    v::Vector{Cdouble}
    n::Cint
end

type ConstraintMatrix
    blocks::Vector{SparseBlock}
    ConstraintMatrix(bs::AbstractMatrix...) =
        new(SparseBlock[b for b in bs])
end


function Base.convert(::Type{SparseBlock}, A::AbstractMatrix)
    A = map(Cdouble, A)
    C = SparseMatrixCSC{Cdouble, Cint}(A)
    m, n = size(C)
    @assert m == n
    nn = nnz(C)
    I = Cint[]
    J = Cint[]
    V = Cdouble[]
    vals = nonzeros(C)
    rows = rowvals(C)
    for col = 1:n
        for j in nzrange(C, col)
            row = rows[j]
            if row <= col
                push!(I, row)
                push!(J, col)
                push!(V, vals[j])
            end
        end
    end
    SparseBlock(I,J,V, n)
end


function create_cmat(c::ConstraintMatrix)
    blocks = sparseblock[]
    next = C_NULL

    for B in c.blocks[end:-1:1]
        unshift!(blocks, sparseblock(next,           # next
                                     C_NULL,         # nextbyblock
                                     pointer(B.v)-sizeof(Cdouble), # entries
                                     pointer(B.i)-sizeof(Cint), # iindices
                                     pointer(B.j)-sizeof(Cint), # jindices
                                     length(B.i),    # numentries
                                     -1,             # blocknum
                                     B.n,            # blocksize
                                     -1,             # constraintnum
                                     1               # issparse
                                     ))
        next = pointer_from_objref(blocks[1])
    end
    return blocks
end


# function Base.convert(::{sparse

export ConstraintMatrix, blockmatrix, convert, sparseblock, constraintmatrix, create_cmat

"""Solver status"""
type Csdp
    n::Cint
    k::Cint
    X::Blockmatrix
    y::Vector{Cdouble}
    constant_offset::Cdouble
    constraints::Vector{SparseBlock}
    pobj::Cdouble
    dobj::Cdouble
end
