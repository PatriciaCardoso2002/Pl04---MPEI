function sim = jaccard(c1,c2)
    c1 = logical(c1);
    c2 = logical(c2);

    intersection = sum(c1 & c2);
    union = sum(c1 | c2);
    sim = intersection/union;
end 