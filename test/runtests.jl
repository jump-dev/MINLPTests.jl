using MINLPTests

using Test
using JuMP


opt_tol = 1e-7
sol_tol = 1e-7
dual_tol = 1e-7

function check_status(status; target=:Optimal)
    @test status == target
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

function check_dual(cons, vals)
    @assert length(cons) == length(vals)

    for (con,val) in zip(cons, vals)
        @test isapprox(getdual(con), val, atol=dual_tol)
    end
end


using Ipopt
using Juniper

ipopt = IpoptSolver(print_level=0)
juniper = JuniperSolver(IpoptSolver(print_level=0), log_levels=[])

nlp_solvers = [ipopt]
minlp_solvers = [juniper]
poly_solvers = [ipopt]
mipoly_solvers = [juniper]


@testset "JuMP Model Tests" begin

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
        include("nlp-mi-cvx/tests.jl")
        include("nlp-mi/tests.jl")
    end
end

for s in poly_solvers
    # global required to support include statements
    global solver = s
    @testset "$(string(typeof(solver))) Polynomial Tests" begin
        include("poly-cvx/tests.jl")
        include("poly/tests.jl")
    end
end

for s in mipoly_solvers
    # global required to support include statements
    global solver = s
    @testset "$(string(typeof(solver))) MIPolynomial Tests" begin
        include("poly-mi-cvx/tests.jl")
        include("poly-mi/tests.jl")
    end
end

end
