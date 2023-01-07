prompt = "Insert User ID (1 to 943): ";
id = input(prompt);
if id >= 1 && id <= 943
    disp("1 - Your movies");
    disp("2 - Suggestion of movies based on other users");
    disp("3 - Suggestion of movies based on already evaluated movies");
    disp("4 - Search Title");
    disp("5 - Exit");
    prompt_option = "Select choice:";
    option = input(prompt_option);
    switch option 
        case 1
            yourMovies(id);
        case 2
            moviesBasedOtherUsers(id);
        case 3
            disp('3');
        case 4
            string = 'toy';
            searchTitle(string);
        case 5
            str = 'A aplicação foi fechada!';
            fprintf("%s\n",str);
    end 
end
