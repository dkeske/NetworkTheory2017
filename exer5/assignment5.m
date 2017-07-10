function [A] = load_sparse_normal(filename)
  E = load(filename);
  n = max(max(E));
  A = sparse(E(:,1), E(:,2), 1, n, n);
  A = A + A';
endfunction 

function no_of_triangles = get_no_of_triangles(A_sparse)
   % the diagonal of the matrix holds the loops, we have to remove it
   A_sparse_no_loops = A_sparse - diag(diag(A_sparse)); 
   path_3 = diag(A_sparse_no_loops.'*A_sparse_no_loops.'*A_sparse_no_loops);
   % we have to divide by 2 because the graph is undirected => we calculte everything twice
   % we have to divide by 3 because we count the triangle once for each node
   no_of_triangles = sum(path_3)/6;
endfunction

jz = "out.arenas-jazz";
jazz = load_sparse_normal(jz);
n_jazz = get_no_of_triangles(jazz)

r = "out.reactome";
react = load_sparse_normal(r);
n_react = get_no_of_triangles(react)
   
amz = "out.com-amazon"; 
amazon = load_sparse_normal(amz);
n_amazon = get_no_of_triangles(amazon) 


function [A] = load_sparse_fb(filename)
  E = dlmread(filename, ' ',[2, 0, 817037, 1]);
  n = max(max(E));
  A = sparse(E(:,1), E(:,2), 1, n, n);
  A = A + A';
endfunction  

function [local_cc] = get_local_clustering_coefficient(A_sparse)
   A_sparse_no_loops = A_sparse - diag(diag(A_sparse)); 
   path_3 = diag(A_sparse_no_loops.'*A_sparse_no_loops.'*A_sparse_no_loops);
   degrees = sum(A_sparse_no_loops);
   wedges = degrees.*(degrees - 1);
   local_cc = path_3./wedges';
endfunction        
      
fb = "out.facebook-wosn-links"; 
facebook = load_sparse_fb(fb);
local_cc = get_local_clustering_coefficient(facebook);

% Global clustering coefficient 1
pkg load statistics
global_cc_1 = nansum(local_cc)/size(local_cc)(1)

% Global clustering coefficient 2
n_facebook = get_no_of_triangles(facebook);
degrees = sum(facebook);
wedges = degrees.*(degrees - 1);
global_cc_2 = n_facebook / nansum(wedges) 