function [A] = load_sparse(filename)
  E = load(filename);
  n = max(max(E));
  A = sparse(E(:,1), E(:,2), 1, n, n);
  A = A + A';
endfunction 

function [size volume] = compute_statistics(A)
  size = size(A)(1);
  %volume = sum(sum(A))/2;
  volume = nnz(A)/2;
endfunction 

A = load_sparse("out.loc-gowalla_edges");

[size, volume] = compute_statistics(A);

function [degrees] = compute_degrees(A)
  degrees = sum(A);
endfunction 

compute_degrees(A);

function [a,b] = degree_distribution(A)
  degrees = compute_degrees(A);
  [a,b]=hist(degrees,unique(degrees));
endfunction  
 
[a,b] = degree_distribution(A);

scatter(b,a);
set(gca, 'XScale', 'log', 'YScale', 'log')
xlabel("Degree(d)");
ylabel("Frequency")

function [P] = cumulative_degree_distribution(A)
  [a,b] = degree_distribution(A);
  P = fliplr(cumsum(fliplr(a))/sum(a));
endfunction

P = cumulative_degree_distribution(A);

stairs(P)
set(gca, 'XScale', 'log', 'YScale', 'log')
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  