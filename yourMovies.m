function [] = yourMovies()
    udata = load('u.data.txt'); %Load data from u.data
    dic = readcell('u_item.txt','Delimiter','\t'); %Read data from u_item
    user_id = input('Enter the user ID: ');
    saw = udata(udata(:,1) == user_id,2); %Compara o user_id introduzido com cada id do utilizador presente na primeira coluna do ficheiro u_data.
                                          %Depois de encontrar esse id do
                                          %utilizador procura na segunda coluna
                                          %do u_data os ids dos filmes vistos
                                          %pelo utilizador 
    
    titles = {}; %cell array that contains the titles of the movies
    for i = 1:length(saw)
        movie_id = saw(i); %saw contém os ids dos movie vistos por aquele utilizador
        movie_title = dic{movie_id,1};%movie title for the movie with the given id
        titles{end+1} = movie_title; %assure that the movie title is appended to the list of the titles in the correct order
    end 
    %disp(length(titles));
    
    %Racicionio counting bloom filter -> Numero de vezes que um filme foi
    %avaliado por todos os utilizadores 
    %->Para cada filme aplicamos uma função de dispersão que resultará num
    %hashcode, incrementamos em um essa posição no bloom filter
    %->mas como sabemos qual foi de facto o numero de vezes? o valor minimo
    %entre os varios contadores correspondentes ao elemento dá-nos uma
    %estimativa desse numero
    %% 
    bf = inicializar(5046); %porque sao 1682 filmes
    for i = 1:size(udata,1) %para todos os users
        movie_id = udata(i,2); %ids_filmes
        bf = incrementar(bf,movie_id,3); %incrementar o contador do id do filme no filtro de bloom
    end
    movie_id = saw(1); %id do filme que eu quero analisar
    rate_count = contagem(bf,movie_id,3,5046); %determinar a estimativa
    fprintf("O numero de vezes que o filme foi avaliado por todos os utilizadores foi: %d\n",rate_count);
end 