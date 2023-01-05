function [] = moviesBasedOtherUsers(user_id)
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
    %user_id = 10;
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
    fprintf("Os três utilizadores mais semelhantes ao utilizador %d são:\n",user_id);
    for i=length(most_sim_user_ids)
        fprintf("%d\n",most_sim_user_ids);
    end
    
    
    % Apresenta os títulos dos filmes que foram avaliados por pelo menos um
    % dos 3 utilizadores e que ainda não foram avaliados pelo utilizador
    % atual
    dic = readcell('u_item.txt','Delimiter','\t'); %Read data from u_item
    %Get the movie IDs rated by the current user 
    user_rated_movies_ids = movie_ids{user_index};
    
    titles = {}; %initialize
    
    for i = 1:3 %for each similar user
        %Get the movie ids rated by the current most similar user
        most_sim_user_rated_movie_ids = movie_ids{most_sim_user_indexs(i)};
        %Find the movie ids rated by the most similar user that have not
        %been rated by the current user 
        n_movie_ids = setdiff(most_sim_user_rated_movie_ids,user_rated_movies_ids);
        %Find the titles of the movies with the new movie IDs
    
        for j = 1:length(n_movie_ids)
            movie_id = n_movie_ids(j);
            movie_title = dic{movie_id,1};
            titles{end+1} = movie_title;
        end 
    end
    
    fprintf("Títulos dos filmes que foram avaliados por pelo menos um dos 3 utilizadores e que ainda não foram avaliados pelo utilizador atual:\n");
    for i=1:length(titles)
        fprintf("%s\n",titles{i});
    end
end
        