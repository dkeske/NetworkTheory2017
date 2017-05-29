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

compute_degrees(A);

function [C] = degree_distribution(A)
  degrees = compute_degrees(A);
  [a,b]=hist(degrees,unique(degrees));
  C(b) = a;
endfunction  
 
C = degree_distribution(A);

scatter([1 : length(C)], C);
set(gca, 'XScale', 'log', 'YScale', 'log')
xlabel("Degree(d)");
ylabel("Frequency")

function [P] = cumulative_degree_distribution(A)
  C = degree_distribution(A);
  P = fliplr(cumsum(fliplr(C))/sum(C));
endfunction

P = cumulative_degree_distribution(A);

stairs(P)
set(gca, 'XScale', 'log', 'YScale', 'log')
xlabel("P(X>=d)");
ylabel("Frequency");
axis ("tight", "on");

function gini = gini_coefficient(degrees)
  nominator = 0;
  degrees_sorted = sort(degrees);
  for i = 1:length(degrees_sorted)
    nominator += i * degrees_sorted(i);
  endfor
  
  gini = ((2 * nominator) / (length(degrees_sorted) * sum(degrees_sorted))) - ((length(degrees_sorted) + 1)/ length(degrees_sorted))
endfunction    
  
gini = gini_coefficient(compute_degrees(A)); 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  