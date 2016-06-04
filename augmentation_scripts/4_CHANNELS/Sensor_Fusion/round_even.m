function S = round_even(S)
% round to nearest even integer.
idx = mod(S,2);
S = floor(S);
    if(idx~=0)
        S(idx) = S(idx)+1;
    else
        S;
    end
