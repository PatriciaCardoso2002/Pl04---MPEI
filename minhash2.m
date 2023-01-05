function minhash = minhash2(movie_set,k)
    %Initialize
    minhash = inf(k,1);
    %Generate k random permutations of the movie set permutations
    permutations = cell(k,1);
    for i=1:k
        permutations{i} = randperm(length(movie_set));
    end
    %For each permutation,find the first movie that is in the set and
    %update the corresponding element in the minhash
    for i=1:k
        for j = 1:length(permutations{i})
            if movie_set(permutations{i}(j))== 1
                minhash(i) = permutations{i}(j);
            break
            end
        end 
    end 
end 