function minhash = minhash4(title)
   shingles_size = 3; %Qual será o melhor?
   shingles = createShingles(title,shingles_size);
   k = 100; %qual o melhor numero de k?

   hash_codes = zeros(k,length(shingles)); %Valor de k para cada shingle

   %Valores aleatórios para a função de hash
   a = randi([1,intmax('uint32')],k,1);
   b = randi([0,intmax('uint32')],k,1);

   %calcula os hash codes para cada shingle
   for i=1:length(shingles)
       for j=1:length(shingles)
           hash_codes(i,j) = mod((a(i)*DJB31MA(shingles{i},127+i) + b(i)),intmax('uint32'));
       end
   end 
   minhash = min(hash_codes(1:k));
end