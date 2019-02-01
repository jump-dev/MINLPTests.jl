function nlp_cvx_501_010(optimizer)
    # Test Goals:
    # - n dimentional nlp
    # Variants
    #   010 - binding constraint (all variables non-zero)
    #   011 - extra sqrt
    
    function nd_shpere(n=2)
        m = Model(optimizer)
    
        @variable(m, vars[1:n])
    
        @objective(m, Min, sum(-x for x in vars))
        @NLconstraint(m, sum(x^2 for x in vars) <= 1.0)
    
        optimize!(m)
    
        #println(getobjectivevalue(m))
    
        check_status(m)
        check_objective(m, -n/sqrt(n))
        check_solution(vars, [1/sqrt(n) for i in vars])
    end
    
    for n in 1:20
        nd_shpere(n)
    end
    
end
