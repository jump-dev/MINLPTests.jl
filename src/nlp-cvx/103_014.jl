function nlp_cvx_103_014(optimizer)
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Min, -x)
    @NLconstraint(m, x^2 <= y)
    @NLconstraint(m, -x^2 + 1 >= y)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, -1/sqrt(2))
    check_solution([x,y], [1/sqrt(2), 1/2])
    
end
