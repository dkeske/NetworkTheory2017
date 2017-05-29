A = load("simgraph.txt")
function [size volume] = compute_statistics(A)
size = size(A)(1);
volume = nnz(A)/2;
endfunction

function [A] = load_sparse(filename)
A = load(filename);
A = sparse(A);
endfunction
function [B] = load_sparse_as_identical(filename)
A = load(filename);
B = zeros(10);
for i = 1:size(A)(1)
  B(A(i, 1), A(i, 2)) = 1;
  B(A(i, 2), A(i, 1)) = 1;
  endfor
B = sparse(B);
endfunction
nnz(A) non zero elements in A 
returns the number of edges in network (*2)

function [degrees] = compute_degrees(A)
  degrees = sum(A);
  endfunction
  
function [avgdegree] = compute_avgdegree(A)
  degrees = sum(A);
  avgdegree = mean(degrees);
  endfunction
  