clear
close all
clc

%% initialization
N = 1500; %number of particles
dim = 100; %must be divisible by 4
time = 500; %total number of time-step
rng(42); %random number generator seed
in = 1; %number of infected at the beginning
rat = 0.90; %ratio of stationary particles to all

x = zeros(N,time); %x position of the particle as a function of time
y = zeros(N,time);

A = zeros(dim^2,2); %enumerate
A(:,1) = kron(1:dim,ones(1,dim));
A(:,2) = kron(ones(1,dim),1:dim);
rng = randperm(length(A), N); %random permutation is used to avoid overlapping

%initialize first positions randomly
x(:,1) = A(rng,1); 
y(:,1) = A(rng,2);

%infect randomly in number of particle. in=1 infected, in=0 not infected
z = zeros(N,3);
z(:,3) = 1;

rng = randperm(N,in);
z(rng,1) = 1;
z(rng,3) = 0;

zdata = zeros(1,time);
zdata(1) = in;

%% figure
figure('units','normalized','outerposition',[0 0 1 1]);

for i = 2:time
    clf;    
    for n = 1:N*(1-rat) 
        %update the position for each particle
        [x(n,i), y(n,i)] = randomWalk(x(n,i-1), y(n,i-1), dim, 0, 0);
    end
    
    x(N*(1-rat)+1:end ,i) = x(N*(1-rat)+1:end ,i-1);
    y(N*(1-rat)+1:end ,i) = y(N*(1-rat)+1:end ,i-1);
    
    for n = 1:N     
        %color change part
        for k = 1:N
            if x(n,i) == x(k,i) && y(n,i) == y(k,i)
                if isequal(z(n,:), [1,0,0]) && isequal(z(k,:),[0,0,1])
                    z(k,:) = [1,0,0];
                elseif isequal(z(n,:), [0,0,1]) && isequal(z(k,:),[1,0,0])
                    z(n,:) = [1,0,0];
                end
            end
        end
    end
          
    nexttile
    hold on
    scatter(x(:,i), y(:,i), 20, z, "o", "Filled")
    xlim([1 dim]);
    ylim([1 dim]);
    title({"When 90% of the Particles are Stationary", strcat("Timestep: ", num2str(i-1))}, 'FontSize', 30)
    axis square
    grid on
    box on
    set(gca,'xtick',(1:dim))
    set(gca,'ytick',(1:dim))
    set(gca,'XTickLabel',[]);
    set(gca,'YTickLabel',[]);
    
    nexttile
    zdata(i) = sum(z(:,1));
    hold on
    title("Number of Red Particles vs Time", 'FontSize', 30)
    plot(1:time,zdata,'r','LineWidth',2)
    plot(1:time,ones(1,time)*max(zdata),'k','LineWidth',1.2,'LineStyle','--')
    xlim([1 i-0.01]);
    ylim([1 N]);
    axis square
    grid on
    box on
    
    ax = gca;
    ax.XAxis.FontSize = 15;
    ax.YAxis.FontSize = 15;
    ax.FontWeight = 'bold';
    %view([90,-90]);
    data(i-1) = getframe(gcf);
end

%% save

mywriter = VideoWriter('video', "MPEG-4");
mywriter.FrameRate = 15;

open(mywriter);
writeVideo(mywriter, data);
close(mywriter);
close all