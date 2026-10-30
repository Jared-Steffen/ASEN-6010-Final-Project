function plotAngMomAndEnergy(t, N_H, T)

figure

subplot(2,1,1)
plot(t, N_H(1,:), ...
     t, N_H(2,:), ...
     t, N_H(3,:))

ylabel('$^N H$ $(kg m^2/s)$')
legend('$H_1$','$H_2$','$H_3$')

subplot(2,1,2)
plot(t, T)

ylabel('T (J)')
xlabel('Time (s)')

sgtitle('Integrals of Motion')

end