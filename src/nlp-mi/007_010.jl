# Test Goals:
# - infeasible model

m = Model(solver=solver)

@variable(m, x, Int)
@variable(m, y, Int)

@NLconstraint(m, y == exp(x))
@constraint(m, x == y^2)

status = solve(m)

check_status(status, target=:Infeasible)
