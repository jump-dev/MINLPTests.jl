function nlp_cvx_102_012(optimizer)
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Max, x+y)
    @NLconstraint(m, x^2 + y^2 <= 1.0)
    @constraint(m, x + y >= 1.2)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, 2/sqrt(2))
    check_solution([x,y], [1/sqrt(2), 1/sqrt(2)])
    
end
