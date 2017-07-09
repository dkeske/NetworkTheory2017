function [A] = load_sparse_normal(filename)
  E = load(filename);
  n = max(max(E));
  A = sparse(E(:,1), E(:,2), 1, n, n);
  A = A + A';
endfunction 

function no_of_triangles = get_no_of_triangles(A_sparse)
   path_3 = diag(A_sparse.'*A_sparse.'*A_sparse);
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
 
% subset of 10000
 function [A] = load_sparse_fb(filename)
  E = dlmread(filename, ' ',[2, 0, 10000, 1]);
  n = max(max(E));
  A = sparse(E(:,1), E(:,2), 1, n, n);
  A = A + A';
endfunction  

function [local_cc] = get_local_clustering_coefficient(A_sparse)
   path_3 = diag(A_sparse.'*A_sparse.'*A_sparse);
   degrees = sum(A_sparse);
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