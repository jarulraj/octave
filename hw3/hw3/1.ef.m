% Part e

color_seq = {[1, 1, 1], [1, 0, 0], [0, 1, 0], [0, 0, 1], [0, 1, 1], [1, 0, 1], [1, 1, 0]};
bg_color = [0.71, 0.99, 0.83];

% gaussian noise with zero mean and sigma_n^2 variance
sigma_noise = 0.005; 
noise = @(x1,x2) sigma_noise^2*(x1==x2); 

eps = 1e-10;

% kernels
k_seq = {};
lambda = 0.5; 
d = 2.0;
alp = -2.0;

k_name = {'Linear', 'Rational-Quadratic', 'Squared-Exponential'}; 

k_seq{1} = @(x1,x2) (x1*x2);
k_seq{2} = @(x1,x2) (1+(x1-x2)^2.0)^(alp);
k_seq{3} = @(x1,x2) exp((x1-x2)^2.0/(-2.0*lambda^2.0));

%k_seq{2} = @(x1,x2) (dot(x1,x2,length(x1)))^d; % Polynomial
%k_seq{2} = @(x1,x2) exp(abs(x1-x2)/(-lambda)); % Gaussian

X=-10:0.2:10;
u = zeros(1,length(X));

plot_f = @(x,lower,upper,color) set(fill([x,fliplr(x)],[lower,fliplr(upper)],color),'EdgeColor',color_seq{1});

X_star = [0.5, 1, 2, 2.5, 3];
Y_star = [-1; 1; 3; 1.5; 0];
      
m = length(X);
X_orig = X;
X = [X X_star];
n = length(X);         

for type=1:3
    type
    k = k_seq{type}; 
    
    for i=1:n
        for j=1:n
            K(i,j) = k(X(i),X(j));
        end
    end        
    
    A = K(1:m,1:m);
    B = K(m+1:n,m+1:n) + eye(n-m)*sigma_noise;
    C = K(m+1:n,1:m);
    
    u = C'*(B\Y_star);
    cvm = A - C'*(B\C);
    
    for i=1:m
        sd(i) = sqrt(cvm(i,i));
    end

    hold on
    plot_f(X_orig, u'-sd, u'+sd, bg_color)
    set(plot(X_orig,u','k'),'LineWidth',7, 'Color', [1, 0, 0])
    set(plot(X_star,Y_star','o'), 'MarkerSize', 5, 'Color', [0, 0, 0])
    
    cvm = cvm + eye(m)*eps;
    
    for trial=1:3
        f_post = mvnrnd(u',cvm);
        set(plot(X_orig,f_post,'k'),'LineWidth',3, 'Color', color_seq{trial+2})
    end
    
    xlabel('X');
    ylabel('f(X)|Y*');
    legend('', 'u = mean', '', 's1 = sample1','s2 = sample2','s3 = sample3')
    fig_name = ['3.e.' k_name{type} ];
    title(fig_name);
    fig_name = [fig_name '.pdf'];
    print(fig_name, '-dpdf')
    
    clf
end

% F

type = 3
k = k_seq{type};

hold on

lambdas = {0.01, 1.0, 100.0};

for j=1:3
    t = j;
    lambda = lambdas{j};
    k = @(x1,x2) exp((x1-x2)^2.0/(-2.0*lambda^2.0));

    for i=1:n
        for j=1:n
            K(i,j) = k(X(i),X(j));
        end
    end        

    A = K(1:m,1:m);
    B = K(m+1:n,m+1:n) + eye(n-m)*sigma_noise;
    C = K(m+1:n,1:m);
    
    u = C'*(B\Y_star);
    cvm = A - C'*(B\C);
    
    for i=1:m
        sd(i) = sqrt(cvm(i,i));
    end

    hold on
    plot_f(X_orig, u'-sd, u'+sd, bg_color)
    set(plot(X_orig,u','k'),'LineWidth',7, 'Color', [1, 0, 0])
    set(plot(X_star,Y_star','o'), 'MarkerSize', 5, 'Color', [0, 0, 0])
    
    cvm = cvm + eye(m)*eps;
    
    f_post = mvnrnd(u',cvm);
    set(plot(X_orig,f_post,'k'),'LineWidth',3, 'Color', color_seq{4})

    xlabel('X');
    ylabel('f(X)|Y*');
    name = ['lambda = ' num2str(lambda)];
    legend('', 'u = mean', '', name)
    fig_name = ['3.f.' k_name{type}];
    title(fig_name);
    fig_name = [ fig_name num2str(t)];
    fig_name = [ fig_name '.pdf'];
    print(fig_name,'-dpdf')
    
    clf
end



