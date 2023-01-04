function b = incrementar(b,elem,k) %b ->vetor,elem->elemento que pretendemos adicionar,k->número de funções de dispersão
    n = length(b); %tamanho do vector
    for i=1:k
        h = DJB31MA(elem,127 + i); %h é o hashcode,vai ser diferente por causa do hashcode
        h = mod(h,n) + 1; %valor entre 1 e n 
        b(h) = b(h) + 1; %incrementa a posição em 1
        %pretendo mostrar como o vetor ficou por isso dou "return" de b
    end
end