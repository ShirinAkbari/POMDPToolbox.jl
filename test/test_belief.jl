using POMDPToolbox
using POMDPModels
using Base.Test

pomdp = TigerPOMDP()
bu = DiscreteUpdater(pomdp)
bold = initialize_belief(bu, initial_state_distribution(pomdp), create_belief(bu))

a = 0
o = true
bnew = update(bu, bold, a, o)

@test isapprox(bnew.b, [0.15, 0.85])
@test isapprox(pdf(bnew, 1), 0.15)
@test isapprox(pdf(bnew, 2), 0.85)
