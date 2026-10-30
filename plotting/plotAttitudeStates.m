function plotAttitudeStates(t, mrp_BN, B_w_BN, opts)

arguments
    t (:,1) double
    mrp_BN (3,:) double
    B_w_BN (3,:) double
    opts.mrp_RN = []
    opts.B_omega_RN = []
end

figure

%% Attitude
subplot(2,1,1)

p = plot(t, mrp_BN');
hold on

if ~isempty(opts.mrp_RN)
    for i = 1:3
        plot(t, opts.mrp_RN(i,:)', '--', ...
            'Color', p(i).Color);
    end
end

ylabel('$\sigma_{BN}$')
legend('$\sigma_1$','$\sigma_2$','$\sigma_3$')

%% Angular Velocity
subplot(2,1,2)

p = plot(t, B_w_BN');
hold on

if ~isempty(opts.B_omega_RN)
    for i = 1:3
        plot(t, opts.B_omega_RN(i,:)', '--', ...
            'Color', p(i).Color);
    end
end

ylabel('$\omega_{BN}$ $(rad/s)$')
xlabel('Time (s)')
legend('$\omega_1$','$\omega_2$','$\omega_3$')

sgtitle('Body Attitude & Rates')

end