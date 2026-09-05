clear;
set_up;
num_part = 15;
max_loop = 25;
num_vars = 2;
lb = [1,1];
ub = [30, 30];
w = 0.8;
c1 = 1.2;
c2 = 1.7;
positions = zeros(num_part, num_vars); %ma tran 15x2
velocities = zeros(num_part, num_vars);
pbest_pos = zeros(num_part, num_vars);
pbest_val = inf(num_part, 1); %đặt điểm xuất phát là vô cực
gbest_pos = zeros(1, num_vars); %lưu thông số K và lambda
gbest_val = inf; %lưu điểm ITAE
for i = 1:num_part
    positions(i,:) = lb + rand(1,num_vars).*(ub-lb);
    pbest_pos(i,:) = positions(i,:);
end

for iter = 1:max_loop 
    for i = 1:num_part
        current_val = cost_func(positions(i,:)); %lấy tọa độ (K,lambda) hiện tại của part thứ i, nạp vào hàm cost_func
        if current_val < pbest_val(i)
            pbest_val(i) = current_val;
            pbest_pos(i,:) = positions(i,:);
        end
        if current_val < gbest_val
            gbest_val = current_val;
            gbest_pos = positions(i,:);
        end
    end
    for i = 1:num_part
        r1 = rand(1,num_vars);
        r2 = rand(1,num_vars); %giúp parts không bị kẹt ở cực tiểu cục bộ
        velocities(i,:) = w*velocities(i,:)+c1*r1.*(pbest_pos(i,:)-positions(i,:))+c2*r2.*(gbest_pos-positions(i,:));
        positions(i,:) = positions(i,:) + velocities(i,:);
        positions(i,:) = max(positions(i,:),lb); %đảm bảo parts không ra ngoài vùng không gian cho phép
        positions(i,:) = min(positions(i,:),ub);
    end
    fprintf('Loop %d | Điểm ITAE: %.4f, K: %.4f, lambda: %.4f\n', iter, gbest_val, gbest_pos(1), gbest_pos(2));
end
        

