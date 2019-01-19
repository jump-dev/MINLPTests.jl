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
