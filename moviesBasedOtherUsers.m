    udata = load('u.data.txt'); %Load data from u.data
    
    
    %Couting bloom filter para armazenamento do número de avaliações com
    %nota superior ou igual a 3
    bf = inicializar(5046); %porque sao 1682 filmes
    for i = 1:size(udata,1) %para todos os users
        if u_data(1,3) >= 3 %se a nota é igual ou superior a 3
            movie_id = udata(i,2); %ids_filmes
            bf = incrementar(bf,movie_id,3); %incrementar o contador do id do filme no filtro de bloom
        end 
    end
   

    %Find the unique user ids and the corresponding movie ids rated by each
    %user
    [user_ids,~,subs] = unique(udata(:,1));
    movie_ids = cell(length(user_ids),1);
    for i = 1:length(user_ids)
        movie_ids{i} = udata(subs == i,2);
    end 
    %Create a signature matriz with the MinHash vectors for the sets of
    %movie ids
    signature_matrix = zeros(k,length(user_ids)); %Initialize
    for i = 1:length(user_ids)
        %Create a set of movies ids using the membro function
        movie_set = membro(bf,movie_ids{i},3);
        %Create a minhash vector using the minhash function
        minhash_vector = minhash(movie_set,3);
        %store the minhash vector in the signature vector 
        signature_matrix(:,i) = minhash_vector;
    end 