function shingles = createShingles(title,shingleSize)
    title = strtrim(title); %Remove espaços em branco do título de filme

    %Divide o título de filme em shingles 
    shingles = cell(1,ceil(length(title)/shingleSize));
    index = 1;
    for i=1:shingleSize:length(title)
        if i+shingleSize-1 <= length(title)
            shingles{index} = title(i:i+shingleSize-1);
        else 
            shingles{index} = title(i:end);
        end 
        index = index + 1;
    end
end 