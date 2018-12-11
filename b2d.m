function dec_value = b2d(crom,lb,ub,nbits,nvar)

    % Funcao converte o cromossomo com representacao em binario para representacao
    % decimal
    % crom = cromossomo
    % lb = vetor com limites minimos
    % ub = vetor com limites maximos
    % nbits = numero de bits
    % nvar = numero de variaveis
    
    bin_value = string(reshape(crom,[nbits,nvar])');
    
    dec_value = zeros(1,nvar);
    
    for i=1:nvar
    
        dec_value(i) = lb(i) + (ub(i)-lb(i))*(bin2dec(join(bin_value(i,:)))/(2^nbits-1));
    
    end
    
    
        
end