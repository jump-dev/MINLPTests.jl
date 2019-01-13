# Test Goals:
# - n dimentional nlp
# Variants
#   01 - binding constraint (all variables non-zero)

function nd_shpere(n=2)
    m = Model(solver=solver)

    @variable(m, vars[1:n])

    @objective(m, Min, sum(-x for x in vars))
    @NLconstraint(m, sum(x^2 for x in vars) <= 1.0)

    status = solve(m)

    #println(getobjectivevalue(m))
    #println(getvalue(vars))
    
    @test status == :Optimal    
    @test isapprox(getobjectivevalue(m), -n/sqrt(n), atol=opt_tol)
    for x in vars
        @test isapprox(getvalue(x), 1/sqrt(n), atol=sol_tol)
    end
end

for n in 1:20
    nd_shpere(n)
end
