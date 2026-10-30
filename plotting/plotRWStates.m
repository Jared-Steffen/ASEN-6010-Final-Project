function plotRWStates(t, cap_omega)

N = size(cap_omega,1);
labels = "RW " + string(1:N);

figure

plot(t, cap_omega')
ylabel('$\Omega (rad/s)$')
xlabel('Time (s)')
legend(labels)

sgtitle('RW States')

end