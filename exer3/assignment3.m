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

[eg_vec, eg] = eigs(FB,1);
eg = diag(eg);
eg_vec = eg_vec*-1;
    

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

P = sparse(n,n);

[a,b] = find(C==1);
for i = [1:length(a)]
  if c_deg(a(i))>0
    P(a(i),a(i)) = 1/c_deg(a(i));
  endif
endfor

zero_deg = find(c_deg==0);
for i = [1:length(zero_deg)]
  P(zero_deg(i),:) = 1/n;
endfor



%J = ones(1,n)/n;
%G = (1-alpha)*P + alpha*J;
diff = 1e-5;
v = ones(1,n)/n;
while 1
  old_v = v;
  v = (v*(1-alpha)*P) + v*alpha*(ones(1,n)/n)';
  if norm(v-old_v)<diff
    break;
  endif
endwhile
  
max(v)





    
    
    
    