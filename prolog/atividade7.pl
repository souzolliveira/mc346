trocatodos([], _, _, []).
trocatodos([V|L], N, V, [N|NL]) :- trocatodos(L, N, V, NL).
trocatodos([L|RL], N, V, [L|NL]) :- L \= V, trocatodos(RL, N, V, NL).