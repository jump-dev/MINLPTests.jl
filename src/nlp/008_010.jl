function nlp_008_010(optimizer)
    # Test Goals:
    # - dual values
    
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    @variable(m, z)
    
    @NLobjective(m, Min, x + y^2 + z^3)
    c1 = @NLconstraint(m, y >= exp(-x-2) + exp(-z-2) - 2)
    c2 = @NLconstraint(m, x^2 <= y^2 + z^2)
    c3 = @NLconstraint(m, y >= x/2 + z)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, -0.3755859312158738)
    check_solution([x,y,z], [-0.593158583913523, 0.2440479041672795, 0.5406271556211383])
    check_dual([c1,c2,c3], [0.0, -0.8697415278248679, 0.06357861274725801])
    
end
