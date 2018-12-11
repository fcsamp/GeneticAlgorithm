clear;clc;
rng default

fob = @(x) x(1).*sin(4*pi.*x(1)) - x(2).*sin(4*pi.*x(2) + pi) + 1;

lb = [-1 -1];       % limites inferiores
ub = [2 2];         % limites superiores

n = 20;             % numero de individuos
d = 2;              % numero de variaveis
tmax = 100;         % numero maximo de geracoes
mr = 0.01;           % taxa de mutacao
cr = 0.8;           % taxa de cruzamento    
mantem = 10;        % individuos mantidos para a prox geracao 

x = zeros(n,d);
fitness = zeros(n,1);
pai = zeros(n-mantem,d);

% cria a populacao inicial e avalia cada individuo

for i=1:n
    
    x(i,:) = lb + (ub-lb).*rand(1,d);
    fitness(i) = fob(x(i,:));
    
end

% ordena a populacao em ordem decrescente

t = 0;                      % inicializa contador de geracoes
conv = zeros(1,tmax);       % armazena as aptidoes
conv_md = zeros(1,tmax);    % armazena a media das aptidoes

while t < tmax

    t = t + 1;
    
    % organiza os individuos do mais apto ao menos apto
    
    [fitness,index] = sort(fitness,'descend');
    x = x(index,:);
    
    best = x(1,:);                  % melhor individuo
    fmin = fitness(1);              % menor valor encontrado
    conv(t) = fmin;                 % curva de convergencia
    conv_md(t) = mean(fitness);     % curva da media de aptidao

    % Selecao
    
    % calcula as probabilidades de selecao de cada individuo
    
    prob = fitness - min(fitness);      % normaliza fitness
    prob = cumsum(prob);                % calcula a soma acumulada das aptidoes
    prob = prob./max(prob);             % divide pela soma de todas as aptidoes
    prob = [0; prob];
    
    % Realiza a selecao de (n-mantem) pais
    
    for i=1:(n-mantem)
        
        r = rand;   % escolhe valor aleatorio
        
        for k=1:n-1 

            if prob(k) <= r && r <= prob(k+1)   % encontra intervalo ao qual o valor pertence

                pai(i,:) = x(k,:);    % seleciona os pais 

            end
            
        end
        
    end 
 
    % Cruzamento 
    
    for i=1:2:(n-mantem-1)
        
        if rand < cr
                       
            % Crossover Simples
            
            % Seleciona um valor dentro da dimensao
            
            a = randi(d,1);  
            
            x(mantem+i,:) = [pai(i,1:a) pai(i+1,a+1:d)];
            x(mantem+i+1,:) = [pai(i+1,1:a) pai(i,a+1:d)];
            
        end
     
    end

    % Mutacao
    
    for i=mantem+1:n
       
        for j=1:d
            
            if rand < mr
               
                x(i,j) = lb(j) + (ub(j)-lb(j))*rand();
                
            end
            
        end
        
    end
    
    % Atualiza a aptidao dos individuos
    
    for i=1:n
    
        fitness(i) = fob(x(i,:));
    
    end
     
end

plot(conv)
grid
title('Convergencia')
ylabel('Aptidao')
xlabel('Iteracoes')
%
% x = -1:0.05:2;
% y = -1:0.05:2;
% [X,Y] = meshgrid(x,y);
% Z = X.*sin(4*pi.*X) - Y.*sin(4*pi*Y + pi) + 1;
%
% surf(X,Y,Z)