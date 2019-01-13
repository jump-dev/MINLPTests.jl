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

    check_status(status)
    check_objective(m, -n/sqrt(n))
    check_solution(vars, [1/sqrt(n) for i in vars])
end

for n in 1:20
    nd_shpere(n)
end
