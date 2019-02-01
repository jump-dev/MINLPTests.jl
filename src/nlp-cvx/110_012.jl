function nlp_cvx_110_012(optimizer)
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @NLobjective(m, Min, exp(x+y))
    @NLconstraint(m, x^2 + y^2 <= 1.0)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, exp(-2/sqrt(2)))
    check_solution([x,y], [-1/sqrt(2), -1/sqrt(2)])
    
end
