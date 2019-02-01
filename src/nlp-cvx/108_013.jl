function nlp_cvx_108_013(optimizer)
    m = Model(optimizer)
    
    @variable(m, x >= 0)
    @variable(m, y >= 0)
    
    @objective(m, Min, x^2 + y^2)
    @NLconstraint(m, 2*x^2 - 4x*y - 4*x + 4 <= y)
    @NLconstraint(m, y^2 <= -x+2)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, 0.8112507770394088)
    check_solution([x,y], [0.6557120892286371, 0.6174888121082234])
    
end
