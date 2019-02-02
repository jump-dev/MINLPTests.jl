function nlp_mi_007_020(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - infeasible model, due to integrality

    m = Model(optimizer)

    @variable(m, -2 <= x <= 3, Int)
    @variable(m, y, Bin)

    @NLconstraint(m, (x-0.5)^2 + (4*y-2)^2 <= 3)

    optimize!(m)

    check_status(m,
                 termination_target = JuMP.MOI.LOCALLY_INFEASIBLE,
                 primal_target = JuMP.MOI.INFEASIBLE_POINT)
    
end
