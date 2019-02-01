OPT_TOL = 1e-7
SOL_TOL = 1e-7
DUAL_TOL = 1e-7

function check_status(model; termination_targe=JuMP.MOI.LOCALLY_SOLVED, primal_target=JuMP.MOI.FEASIBLE_POINT)
    @test JuMP.termination_status(model) == termination_targe
    @test JuMP.primal_status(model) == primal_target
end

function check_objective(model, val)
    @test isapprox(JuMP.objective_value(model), val, atol=OPT_TOL)
end

function check_solution(vars, vals)
    @assert length(vars) == length(vals)

    for (var,val) in zip(vars, vals)
        @test isapprox(JuMP.value(var), val, atol=SOL_TOL)
    end
end

function check_dual(cons, vals)
    @assert length(cons) == length(vals)

    for (con,val) in zip(cons, vals)
        @test isapprox(JuMP.dual(con), val, atol=DUAL_TOL)
    end
end
