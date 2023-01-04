function minimum = contagem(b,elem,k,n) %n->length of the array
    minimum = Inf;
    for i=1:k
        h = DJB31MA(elem,127 + i); %different seed to guarantee that the hash code will be different
        h = mod(h,n) + 1;
        minimum = min(minimum,b(h)); %colocar o minimo valor 
    end 
end 