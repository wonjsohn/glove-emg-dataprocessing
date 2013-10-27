function  plotting(p2p_index_array,p2p_middle_array,  time,indexData, new_locs_index, new_pks_index, new_neg_locs_index, new_neg_pks_index, x_marker, middleData,new_locs_middle, new_pks_middle, new_neg_locs_middle, new_neg_pks_middle  )

subplot(2,1,1)
plot(time, indexData, time(new_locs_index), new_pks_index, 'rv',  time(new_neg_locs_index), new_neg_pks_index, 'rv'); grid on
legend('index finger');
hold on
x=[x_marker(1),x_marker(1)];
y=[-2, 0];
plot(x,y, 'r', 'LineWidth',2.0);
hold on
x=[x_marker(2),x_marker(2)];
y=[-2, 0];
plot(x,y, 'r', 'LineWidth',2.0);
set(gca,'ylim',[-2 0.5]);

subplot(2,1,2)
plot(time, middleData, time(new_locs_middle), new_pks_middle, 'rv',  time(new_neg_locs_middle), new_neg_pks_middle, 'rv'); grid on
legend('middle finger');
hold on
x=[x_marker(3),x_marker(3)];
y=[-2, 0];
plot(x,y, 'r', 'LineWidth',2.0)
hold on
x=[x_marker(4),x_marker(4)];
y=[-2, 0];
plot(x,y, 'r', 'LineWidth',2.0)
set(gca,'ylim',[-2 0.5]);
title( sprintf( 'mean index AMP: %f, VAR: %f, middle AMP: %f, var: %f', mean(p2p_index_array), var(p2p_index_array), mean(p2p_middle_array), var(p2p_middle_array) ));


end

