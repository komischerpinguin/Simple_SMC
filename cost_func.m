function J = cost_func(vars)
assignin('base', 'K', vars(1));      %gán giá trị K và lambda
assignin('base', 'lambda', vars(2));
try
    simout = sim('pendulum_model', 'SimulationMode','normal','Stoptime','5'); %chạy mô phỏng trong 5s
    J_array = simout.get('J'); %tìm bên trong simout để lấy biến có tên là J
    J = J_array(end); %lấy phần tử cuối của mảng J
catch
    J = inf; %trả infinite nếu J quá lớn
end
end