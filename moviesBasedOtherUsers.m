    u_data = load('u.data.txt'); %Load data from u.data
    
    
    %Couting bloom filter para armazenamento do número de avaliações com
    %nota superior ou igual a 3
    bf = inicializar(5046); %porque sao 1682 filmes
    for i = 1:size(u_data,1) %para todos os users
        if u_data(1,3) >= 3 %se a nota é igual ou superior a 3
            movie_id = u_data(i,2); %ids_filmes
            bf = incrementar(bf,movie_id,3); %incrementar o contador do id do filme no filtro de bloom
        end 
    end
   

    %Find the unique user ids and the corresponding movie ids rated by each
    %user
    [user_ids,~,subs] = unique(u_data(:,1)); %coloca em user_ids os valores da primeira coluna de u_data,~->ignores the second output of the unique function
    movie_ids = cell(length(user_ids),1);
    for i = 1:length(user_ids)
        movie_ids{i} = u_data(subs == i,2);
    end 
    %Create a signature matriz with the MinHash vectors for the sets of
    %movie ids
    k = 100;
    signature_matrix = zeros(k,length(user_ids)); %Initialize
    for i = 1:length(user_ids)
        %Create a set of movies ids using the membro function
        movie_set = membro(bf,movie_ids{i},k);
        %Create a minhash vector using the minhash function
        minhash_vector = minhash2(movie_set,k);
        %store the minhash vector in the signature vector 
        signature_matrix(:,i) = minhash_vector;
    end 

    %Determinar os 3 utilizadores mais similares ao utilizador atual(em
    %termos de conjuntos de filmes avaliados com nota superior ou igual a
    %3)
    user_id = 314;
    user_index = find(user_ids == user_id);
    user_signature = signature_matrix(:,user_index);
    sim_scores = zeros(length(user_ids),1);

    for i = 1:length(user_ids)
        if i == user_index
            %Skip the current user
            continue;
        end
        otheruser_signature = signature_matrix(:,i);

        %Calculate the Jaccard similarity between the current user and this user
        common_elem = sum(user_signature == otheruser_signature);
        total_elem = sum(user_signature ~= otheruser_signature);
        sim_scores(i) = common_elem/total_elem;

        %Find the three users with the highest similarity
        [~,sort_indexs] = sort(sim_scores,'descend');
        most_sim_user_indexs = sort_indexs(1:3);
        most_sim_user_ids = user_ids(most_sim_user_indexs);
    end
    disp(most_sim_user_ids);
    