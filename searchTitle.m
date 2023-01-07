function sim_titles = searchTitle(string)
    dic = readcell('u_item.txt','Delimiter','\t'); %Read data from u_item
    titles = dic(:,1); %get the movie titles
    titles_number = size(titles,1); 
    k = 100; %columns numver of signature matrix
    signature_matrix = zeros(titles_number,k); %initialize the matrix to store the vectors
    %Creates a minHash vector for each movie title and add to the signature
    %matrix
    for i=1:titles_number
        minhash = minhash4(titles{i});
        minhash = horzcat(minhash,zeros(1,k-length(minhash)));
    %disp(length(minhash)); - não são do mesmo tamanho, é preciso ajustar o
    %tamanho do vetor usando por exemplo a função horzcat
    
    %Add the minhash vector to the signature matrix at line corresponding to
    %the title of the movie
        signature_matrix(i,:) = minhash;
    end 
    
    minhash_search = minhash4(string); %calculan o vetor minhash para a string
    %calcula a sim de jaccard entre o vetor minHash da string de busca e os
    %vetor minhash dos filmes
    sim = zeros(size(signature_matrix,1),1);
    for i = 1:size(signature_matrix,1)
        sim(i)=jaccard(minhash_search,signature_matrix(i,:));
    end
    [~,indices] = sort(sim,'descend');
    five = indices(1:5);
    sim_titles = titles(five);
    for i=1:length(sim_titles)
        fprintf('%s\n',sim_titles{i});
    end
end 