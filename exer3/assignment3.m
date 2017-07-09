%Task 1

filename = "prediction-graph.txt"
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

function [A] = load_sparse_directed(filename)
  E = load(filename);
  n = max(max(E));
  A = sparse(E(:,1), E(:,2), 1, n, n);
endfunction 

A = load_sparse_normal(filename);

[VEC, VAL] = eig(A);

VAL = diag(VAL);

min_ = min(VAL)

max_ = max(VAL)

VAL

%Task 2

function [degrees] = compute_degrees(A)
  degrees = sum(A);
endfunction 

facebook = "out.facebook-wosn-links";

FB = load_sparse(facebook);

function [eg_vec, eg] = eigs_reg(A,n)
  [eg_vec, eg] = eigs(A,n);
  eg = diag(eg);
  eg_vec = eg_vec*-1;
endfunction
    

function [val_final, vec_final] = eig_power(A)
  x = compute_degrees(A)';
  diff = 1e-10;
  vec_final = x;
  val_final = 0;
  while(1)
    vec_old = vec_final;
    val_old = val_final;
    vec_final = A*vec_final;
    val_final = norm(vec_final);
    vec_final = vec_final/val_final;
    if abs(val_final - val_old)<diff && norm(vec_final-vec_old)<diff
      break;
    end
  end
end   

[eg_vec, eg] = eigs_reg(FB,1);
    
[val_final, vec_final] = eig_power(FB);

%vec_final = vec_final*val_final;

vec_final_s = sort(vec_final, "descend");

difference = norm(vec_final- eg_vec)

for i = [1:10]
  indicies(i) = find(vec_final == vec_final_s(i));
endfor

indicies
degrees = compute_degrees(FB);

max_deg = sort(degrees, "descend")(1:10)

flag = 0;
for i = [1:10]
  res = find(degrees == max_deg(i));
  if flag == 1
    flag = 0;
    continue;
  endif
  if length(res) == 2
    indicies_d(i) = res(1);
    indicies_d(i+1) = res(2);
    flag = 1;
  else
    indicies_d(i) = res;
  endif
endfor

indicies_d

deg_top_eig = degrees(indicies)

%Task 3

C = load_sparse_directed("out.munmun_twitter_social");
alpha = 0.15;

c_deg = sum(C,2);
n=size(C)(1);

P1 = sparse(n,n);
P2 = sparse(n,n);

c_deg_inv = c_deg.^-1;
c_deg_inv(find(c_deg==0))=0;

P1 = (diag(c_deg_inv))*C;
c_deg(c_deg==0) = -1;
c_deg(c_deg>0) = 0;
c_deg(c_deg==-1) = 1;

P2 = (1/n)*c_deg*sparse(ones(1,n));

diff = 1e-5;
v = ones(1,n)/n;
while 1
  old_v = v;
  v = (v*(1-alpha)*P) + v*alpha*(ones(1,n)/n)';
  if norm(v-old_v)<diff
    break;
  endif
endwhile
  
max_page_rank = sort(v, "descend");
max_page_rank(1:10)

in_degree = sum(C,1);
in_degree_s = sort(in_degree, "descend");

for i = [1:10]
  find(in_degree == in_degree_s(i))
endfor

    
    
    
    