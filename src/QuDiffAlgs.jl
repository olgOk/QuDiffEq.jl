export QuLDE, LDEMSAlgHHL, QuNLDE
export QuEuler, QuLeapfrog, QuAB2, QuAB3, QuAB4

abstract type QuODEAlgorithm <: DiffEqBase.AbstractODEAlgorithm end

abstract type LDEMSAlgHHL <: QuODEAlgorithm end
"""
Linear differential equation solvers (non-HHL)

ref : arxiv.org/abs/1807.04553
"""

struct QuLDE <: QuODEAlgorithm
    k::Int
    QuLDE(k = 3) = new(k)
end
"""
Linear differential equation solvers (non-HHL)

ref : arxiv.org/abs/0812.4423
"""
struct QuNLDE <: QuODEAlgorithm
    k::Int
    ϵ::Real
    QuNLDE(k = 3, ϵ = 1e-3) = new(k,ϵ)
end

"""
Linear differential equation solvers using HHL

ref : arxiv.org/abs/1010.2745v2
"""
struct QuEuler{T} <: LDEMSAlgHHL
    step::Int
    α::Vector{T}
    β::Vector{T}
    nreg::Int
    QuEuler(nreg = 12,::Type{T} = Float64) where {T} = new{T}(1,[1.0,],[1.0,],nreg)
end

struct QuLeapfrog{T} <: LDEMSAlgHHL
    step::Int
    α::Vector{T}
    β::Vector{T}
    nreg::Int
    QuLeapfrog(nreg = 12,::Type{T} = Float64) where {T} = new{T}(2,[0, 1.0],[2.0, 0],nreg)
end
struct QuAB2{T} <: LDEMSAlgHHL
    step::Int
    α::Vector{T}
    β::Vector{T}
    nreg::Int
    QuAB2(nreg = 12,::Type{T} = Float64) where {T} = new{T}(2,[1.0, 0], [1.5, -0.5],nreg)
end
struct QuAB3{T} <: LDEMSAlgHHL
    step::Int
    α::Vector{T}
    β::Vector{T}
    nreg::Int
    QuAB3(nreg = 12,::Type{T} = Float64) where {T} = new{T}(3,[1.0, 0, 0], [23/12, -16/12, 5/12],nreg)
end
struct QuAB4{T} <: LDEMSAlgHHL
    step::Int
    α::Vector{T}
    β::Vector{T}
    nreg::Int
    QuAB4(nreg = 12,::Type{T} = Float64) where {T} = new{T}(4,[1.0, 0, 0, 0], [55/24, -59/24, 37/24, -9/24],nreg)
end
