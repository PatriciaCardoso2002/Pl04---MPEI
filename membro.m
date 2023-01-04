function cond = membro(b,elem,k) %b->bloom filter,elem->elemento,k->função de dispersão
    n = length(b);
    cond = true;
    for i=1:k
        h = DJB31MA(elem,127);
        h = mod(h,n) + 1; %valor entre 1 e n
        if b(h) <= 0 %requer que todos os elementos sejam nao nulos
            cond = false;
            break;
        end
    end 
end 