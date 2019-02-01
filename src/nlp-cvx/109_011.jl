function nlp_cvx_109_011(optimizer)
    m = Model(optimizer)
    
    @variable(m, x, start=0.1)
    @variable(m, y, start=0.1)
    
    @NLobjective(m, Max, log(x) + log(y))
    @NLconstraint(m, (y-2)^2 <= -x+2)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, 1.4853479762665618)
    check_solution([x,y], [1.8499011869994715, 2.387425887570236])
    
end
