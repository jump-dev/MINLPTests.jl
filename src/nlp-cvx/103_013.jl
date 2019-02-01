function nlp_cvx_103_013(optimizer)
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Min, x+y)
    @NLconstraint(m, x^2 <= y)
    @NLconstraint(m, -x^2 + 1 >= y)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, -1/4)
    check_solution([x,y], [-1/2, 1/4])
    
end
