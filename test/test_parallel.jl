using POMDPToolbox
using POMDPModels

let
    pomdp = BabyPOMDP()
    fwc = FeedWhenCrying()
    rnd = solve(RandomSolver(MersenneTwister(7)), pomdp)

    q = []
    push!(q, Sim(pomdp, fwc, max_steps=32, rng=MersenneTwister(4), metadata=Dict(:policy=>"feed when crying")))
    push!(q, Sim(pomdp, fwc, max_steps=32, rng=MersenneTwister(4), metadata=Dict(:policy=>"feed when crying")))
    push!(q, Sim(pomdp, rnd, max_steps=32, rng=MersenneTwister(4), metadata=Dict(:policy=>"random")))

    @show run_parallel(q) do sim, hist
        return [:steps=>n_steps(hist), :reward=>discounted_reward(hist)]
    end

    @show data = run_parallel(q)
    @test data[1, :reward] == data[2, :reward]

    mdp = GridWorld()
    q = []
    push!(q, Sim(mdp, RandomPolicy(mdp), max_steps=100))
    run(q)
end
