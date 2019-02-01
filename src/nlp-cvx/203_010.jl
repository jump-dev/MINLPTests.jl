function nlp_cvx_203_010(optimizer)
    # Test Goals:
    # - linear objective
    # - intersection convex quadratic constraints
    # - sqrt cone
    # Variants
    #   010 - intersection set
    
    m = Model(optimizer)
    
    @variable(m, x, start=0.1)
    @variable(m, y, start=0.1)
    @variable(m, z)
    
    @objective(m, Min, x+y)
    @NLconstraint(m, sqrt(x^2 + y^2) <= z-0.25)
    @NLconstraint(m, x^2 + y^2 <= -z+1)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, -1/sqrt(2))
    check_solution([x,y,z], [-sqrt(1/8), -sqrt(1/8), 3/4])
    
end
