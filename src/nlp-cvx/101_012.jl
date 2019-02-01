function nlp_cvx_101_012(optimizer)
    m = Model(optimizer)
    
    @variable(m, -2 <= x <= 2)
    @variable(m, -2 <= y <= 2)
    
    @objective(m, Max, x)
    @NLconstraint(m, x^2 + y^2 <= 1.0)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, 1)
    check_solution([x,y], [1, 0])
    
end
