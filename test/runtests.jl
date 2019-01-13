using MINLPTests

using Test
using JuMP


opt_tol = 1e-7
sol_tol = 1e-7

function check_status(status)
    @test status == :Optimal
end

function check_objective(model, val)
    @test isapprox(getobjectivevalue(model), val, atol=opt_tol)
end

function check_solution(vars, vals)
    @assert length(vars) == length(vals)

    for (var,val) in zip(vars, vals)
        @test isapprox(getvalue(var), val, atol=sol_tol)
    end
end


using Ipopt
using Juniper

ipopt = IpoptSolver(print_level=0)
juniper = JuniperSolver(IpoptSolver(print_level=0), log_levels=[])

nlp_solvers = [ipopt]
minlp_solvers = [juniper]


@testset "JuMP MINLP Tests" begin

for s in nlp_solvers
    # global required to support include statements
    global solver = s
    @testset "$(string(typeof(solver))) NLP Tests" begin
        include("nlp-cvx/tests.jl")
        include("nlp/tests.jl")
    end
end

for s in minlp_solvers
    # global required to support include statements
    global solver = s
    @testset "$(string(typeof(solver))) MINLP Tests" begin
        include("minlp-cvx/tests.jl")
        include("minlp/tests.jl")
    end
end

end
