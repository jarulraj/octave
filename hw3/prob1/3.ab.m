% Part a

color_seq = {[1, 1, 1], [1, 0, 0], [0, 1, 0], [0, 0, 1], [0, 1, 1], [1, 0, 1], [1, 1, 0]};
bg_color = [0.71, 0.99, 0.83];

% gaussian noise with zero mean and sigma_n^2 variance
sigma_noise = 0.05; 
noise = @(x1,x2) sigma_noise^2*(x1==x2); 

eps = 1e-10;

% kernels
k_seq = {};
lambda = 0.5; 
d = 2.0;
alp = -2.0;

k_name = {'Linear', 'Rational-Quadratic', 'Squared-Exponential', 'Periodic'}; 

k_seq{1} = @(x1,x2) (x1*x2);
k_seq{2} = @(x1,x2) (1+(x1-x2)^2.0)^(alp);
k_seq{3} = @(x1,x2) exp((x1-x2)^2.0/(-2.0*lambda^2.0));

%k_seq{3} = @(x1,x2) exp(abs(x1-x2)/(-lambda)); % Gaussian

X=-10:0.2:10;
m = zeros(1,length(X));

plot_f = @(x,lower,upper,color) set(fill([x,fliplr(x)],[lower,fliplr(upper)],color),'EdgeColor',color_seq{1});

for type=1:3
    type
    k = k_seq{type}; 

    for i=1:length(X)
        for j=1:length(X)
            K(i,j) = k(X(i),X(j));
        end
    end

    for i=1:length(X)
        sd(i) = sqrt(K(i,i));
    end

    hold on
    plot_f(X, m-sd, m+sd, bg_color)
    set(plot(X,m,'k'),'LineWidth',7, 'Color', [1, 0, 0])

    K = K + eye(length(X))*eps;

    for trial=1:3
        f = mvnrnd(m',K);
        set(plot(X,f,'k'),'LineWidth',3, 'Color', color_seq{trial+2})
    end
    
    xlabel('X');
    ylabel('f(X)');
    legend('', 'u = mean', 's1 = sample1','s2 = sample2','s3 = sample3')
    fig_name = ['3.a.' k_name{type} ];
    title(fig_name);
    fig_name = [fig_name '.pdf'];
    print(fig_name, '-dpdf')
    
    clf
end

% B

type = 3
k = k_seq{type};

sigma_noises = {0.05, 0.5, 5.0};

hold on
for j=1:3
    c = j;
    sigma_noise = sigma_noises{j}; 

    for i=1:length(X)
        for j=1:length(X)
            K(i,j) = k(X(i),X(j)) + noise(X(i), X(j));
        end
    end

    K = (K + K')/2;
    K = K + eye(length(X))*eps;

    sigma_i = sigma_noise^2.0 * eye(length(X),length(X));

    f = mvnrnd(m',K);
    Y = mvnrnd(f, sigma_i); 
    set(plot(X,Y,'k'),'LineWidth', 3, 'Color', color_seq{c+2})
end

xlabel('X');
ylabel('Y');
legend('sigma = 0.05','sigma = 0.5','sigma = 5.0')
fig_name = ['3.b.' k_name{type}];
title(fig_name);
fig_name = [ fig_name '.pdf'];
print(fig_name,'-dpdf')



