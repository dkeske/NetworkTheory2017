function [A] = load_sparse(filename)
  E = dlmread(filename, ' ',[2, 0, 817037, 1]);
  n = max(max(E));
  A = sparse(E(:,1), E(:,2), 1, n, n);
  A = A + A';
endfunction 

function [A] = load_sparse_normal(filename)
  E = load(filename);
  n = max(max(E));
  A = sparse(E(:,1), E(:,2), 1, n, n);
  A = A + A';
endfunction 

function [degrees] = compute_degrees(A)
  degrees = sum(A)';
endfunction 

facebook = "out.facebook-wosn-links";

FB = load_sparse(facebook);
degrees = compute_degrees(FB);
fof = (FB * degrees) ./ degrees;

sum(fof > degrees)
sum(fof == degrees)
sum(fof < degrees)

mean_friends = mean(degrees)
mean_fof = mean(fof)

filename = "prediction-graph.txt";
A = load_sparse_normal(filename);

A_squared = A * A;
A_squared = full(A_squared);
[x,e] = eig(A);
e_squared = e * e;

nnz(A_squared == e_squared)
nnz(A_squared)
nnz(e)

# they are not the same because lambda is diagonal

A = full(A);
# 7 and 10
nnz(A(7,:) & A(10, :))
# 7 and 15
nnz(A(7,:) & A(15, :))

A_7 = A_squared(7,:)
[A_7_sorted, indices] = sort(A_7, "descend");

to_remove = A(7,:) == 1
to_remove(7) = 1
to_remove = find(to_remove == 1)

for i = [1:length(to_remove)]
  A_7_sorted(find(indices == to_remove(i))) = [];
  indices(find(indices == to_remove(i))) = [];
endfor
 
A_7_sorted
indices 

# top of recommandation list
indices(1)

# 3 exp(a*A) = Uexp(a*lamda)U' ; a = 0.1

a = 0.1
[v, d] = eig(A)
exp_A = v * exp(a * d) * v'

exp_A(1,2)
exp_A(1,3)
exp_A(1,4)








