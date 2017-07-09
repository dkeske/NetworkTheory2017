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

function [A] = load_sparse_arxiv(filename)
  E = dlmread(filename, ' ',[2, 0, 2673133, 1]);
  n = max(max(E));
  A = sparse(E(:,1), E(:,2), 1, n, n);
  A = A + A';
endfunction 

function [degrees] = compute_degrees(A)
  degrees = sum(A)';
endfunction 

#Task 1

facebook = "out.facebook-wosn-links";

FB = load_sparse(facebook);
# Number of friends for every user
degrees = compute_degrees(FB);

function [avg_fof] = f(u)
  avg_fof = (FB * degrees) ./ degrees;
endfunction

fof = f(degrees);

display("Number of d(u) < f(u)")
sum(fof > degrees)
display("Number of d(u) equal f(u)")
sum(fof == degrees)
display("Number of d(u) > f(u)")
sum(fof < degrees)

display("This confirms the friendship paradox. The distribution of friendhip is skewed")
display("This means that the average is bigger than the median")
display("And so, on average, we have less friends than our friends.")


display("Avg number of friends in a network")
mean_friends = mean(degrees)
display("Average number friends of friends have")
mean_fof = mean(fof)
display("Since in more cases the number of frieds of friends is higher, the average is also higher")

# Task 2
filename = "prediction-graph.txt";
A = load_sparse_normal(filename);

A_squared = A * A;
A_squared = full(A_squared)
[x,e] = eig(A);
e_squared = power(e,2);
e_squared = x*e_squared*x'

nnz(A_squared == e_squared)
nnz(A_squared)
nnz(e)

display("they are not the same. Eig is an aproximation, so small differences exist")

A = full(A);
display(" common friends: 7 and 10")
nnz(A(7,:) & A(10, :))
display(" common friends: 7 and 15")
nnz(A(7,:) & A(15, :))

A_7 = A_squared(7,:);
[A_7_sorted, indices] = sort(A_7, "descend");

to_remove = A(7,:) == 1;
to_remove(7) = 1;
to_remove = find(to_remove == 1)

for i = [1:length(to_remove)]
  A_7_sorted(find(indices == to_remove(i))) = [];
  indices(find(indices == to_remove(i))) = [];
endfor
 
display("Prediction scores")
A_7_sorted
display("Predicted nodes")
indices 

display("top of recommandation list")
indices(1)


### Task 3

# 3 exp(a*A) = Uexp(a*lamda)U' ; a = 0.1

a = 0.1
[vecs, vals] = eig(A);
#for i = [1:16]
#  vecs(i) = vecs(i) * sign(sum(vecs(i)));
#endfor

vals = diag(vals);

exp_A = vecs * diag(exp(a * vals)) * vecs';

exp_A(1,2)
exp_A(1,3)
exp_A(1,4)
display("1-2 has the highest prediction. This is expected as they are closest")

exp_A(7,1)
exp_A(7,16)

display("They both have low scores. They are not the same, because there are more path to node 16")


# Task 4
arxiv = "out.ca-cit-HepTh"
arx = load_sparse_arxiv(arxiv);
# For node 1
[x,e] = eigs(arx, 20);
vals = diag(vals);
x = x(1,:);
exp_A = x * diag(exp(a * e)) * x';

exp_1 = exp_A(1,:);
[exp_1_sorted, indices] = sort(exp_1, "descend");

to_remove = exp_A(1,:) == 1;
to_remove(1) = 1;
to_remove = find(to_remove == 1)

for i = [1:length(to_remove)]
  exp_1_sorted(find(indices == to_remove(i))) = [];
  indices(find(indices == to_remove(i))) = [];
endfor
 
display("Prediction scores")
exp_1_sorted
display("Predicted nodes")
indices 



