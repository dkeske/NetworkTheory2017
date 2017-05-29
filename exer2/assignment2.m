filename = "out.loc-gowalla_edges"
function [A] = load_sparse(filename)
  E = load(filename);
  n = max(max(E));
  A = sparse(E(:,1), E(:,2), 1, n, n);
  A = A + A';
endfunction 

function [size volume] = compute_statistics(A)
  size = size(A)(1);
  volume = nnz(A)/2;
endfunction 

A = load_sparse(filename);

[size, volume] = compute_statistics(A);

function [degrees] = compute_degrees(A)
  degrees = sum(A);
endfunction 

degrees = compute_degrees(A);

function [C] = degree_distribution(A)
  degrees = compute_degrees(A);
  freq = hist(degrees, 1:max(degrees));
  C = freq;
endfunction  
 
C = degree_distribution(A);

scatter(1:max(degrees), C);
set(gca, 'XScale', 'log', 'YScale', 'log')
xlabel("Degree(d)");
ylabel("Frequency")
print -deps degree_frequency.eps

function [P] = cumulative_degree_distribution(A)
  C = degree_distribution(A);
  P = flip(cumsum(flip(C)));
  P = P/max(P);
endfunction

P = cumulative_degree_distribution(A);
uniq_deg = unique(degrees);

stairs(1:max(degrees), P)
set(gca, 'XScale', 'log', 'YScale', 'log')
ylabel("P(X>=d)");
xlabel("Degree");
axis ("tight", "on");
print -deps cumulative_degree_distribution.eps

function gini = gini_coefficient(degrees)
  nominator = 0;
  degrees_sorted = sort(degrees);
  for i = 1:length(degrees_sorted)
    nominator += i * degrees_sorted(i);
  endfor
  
  gini = ((2 * nominator) / (length(degrees_sorted) * sum(degrees_sorted))) - ((length(degrees_sorted) + 1)/ length(degrees_sorted))
endfunction    
  
gini = gini_coefficient(compute_degrees(A)); 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  