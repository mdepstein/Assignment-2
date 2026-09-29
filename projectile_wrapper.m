% wrapper function that finds the distance between the projectile and
% target
function dist_delta = projectile_wrapper(X)
    theta = X(1);
    t = X(2);
    
    proj_pos = projectile_traj(theta, t);
    target_pos = target_traj(t);

    dist_delta = proj_pos - target_pos;
end