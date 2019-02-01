function nlp_cvx_202_011(optimizer)
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    @variable(m, z)
    
    @objective(m, Min, z)
    @NLconstraint(m, x^2 + y^2 <= z)
    @NLconstraint(m, x^2 + y^2 <= -z+1)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, 0)
    check_solution([x,y,z], [0, 0, 0])
    
end
