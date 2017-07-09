#@author-Shriharsh Ambhore
#@author-Tara Morovatdar


   
function [A]=load_sparse(filename)
  A=load("-ascii",filename);
  E=max(max(A));
  A=sparse(A(:,1),A(:,2),1,E,E);
  A=A+A';
  endfunction
  

filename="out.facebook-wosn-links"

function [FB]= fbnetwork(filename)
   FB=load("-ascii",filename);
   Cols=[3,4];
   FB(:,Cols)=[]; # removing column 3,4
   E=max(max(FB));
   FB=sparse(FB(:,1),FB(:,2),1,E,E);
   FB=FB+FB';
   
endfunction 

function [degrees]=compute_degrees(mat)
  degrees=sum(mat);
endfunction  

function [f_u]=f(FB,u,degrees)
  u_friend=find(FB(u,:));
  n=max(size(u_friend));
  res=0;
  for i=1:n
    res+=degrees (1,u_friend(1,i));
  endfor
  res=res./n; 
  f_u=res;
endfunction
function [f_value]=friend_of_friend(FB,degrees)
   degrees=compute_degrees(FB);

  #u_friend=find(FB(u,:));
  n=max(size(FB));
  #res=0;
  for i=1:n
    f_value(1,i)= f(FB,i,degrees);
  endfor
  
endfunction
function [s,e,b]=comparison(FB,f_value)
  degrees=compute_degrees(FB);
  b=e=s=0;  
  n=max(size(FB));
  #res=0;
  for i=1:n
    if f_value(1,i)<degrees(1,i)
      s=s+1;    
    elseif f_value(1,i)>degrees(1,i)
      b=b+1;
    else
      e=e+1;
    end 
  
  endfor
  
endfunction

#####Question2########

function [A]= load_sparse(filename)
   A=load("-ascii",filename);   
   E=max(max(A));
   A=sparse(A(:,1),A(:,2),1,E,E);
   A=A+A';
   
endfunction 
function [square_A]= square(A)
   #A=load_sparse("prediction-graph.txt");     
   square_A=A*A;
   square_A=full(square_A);
endfunction
function [e_square_m]= eigen_square(A)       
   [V,D]=eig(A);
   D=power(D,2);   
   e_square_m=V*D*V';
   
endfunction 
function [foaf_recom_list]=user_7_recom(A,square_A)  
  square_m_7=square_A(7,:);
  square_m_7(find(A(7,:)==1))=0;  
  [prediction_score,prediction_list]=sort(square_m_7,'descend');
  prediction_score=nonzeros(prediction_score(2:end));
  prediction_list=prediction_list(2:max(size(prediction_score))+1);
  foaf_recom_list=cat(2,prediction_list',prediction_score)
  
  
endfunction

#####Question3#######
function [V,exp_A,exp_lambda,D]= exponential(A)       
   [V,D]=eig(A);
   exp_lambda=diag(exp(0.1*diag(D)));
   exp_A=V*exp_lambda*V';
   disp("link prediction pair (1,2)"),disp(exp_A(1,2))
   disp("link prediction pair (1,3)"),disp(exp_A(1,3))
   disp("link prediction pair (1,4)"),disp(exp_A(1,4))
   disp("link prediction pair (7,1)"),disp(exp_A(7,1))
   disp("link prediction pair (7,16)"),disp(exp_A(7,16))
   
endfunction 
function [exp_prediction_score,exp_prediction_list]=user_7_recom_exp(A,exp_A)  
  exp_m_7=exp_A(7,:);
  exp_m_7(find(A(7,:)==1))=0;  
  [exp_prediction_score,exp_prediction_list]=sort(exp_m_7,'descend');
  exp_prediction_score=nonzeros(exp_prediction_score(2:end));  
  exp_prediction_list=exp_prediction_list(2:max(size(exp_prediction_score))+1);
    
endfunction




#####Question4#######
function [V,D]= sparseDecomposition(SD)
    [V,D]=eigs(SD,20);
    
endfunction 

function [exp_prediction_list]=link_prediction_for_user1(A,V,D)  
  
  tV=V(1,:);
  exp_lambda=diag(exp(0.1*diag(D)));
  exp_A_1=tV*exp_lambda*V';
  exp_A_1(find(A(1,:)==1))=0;  
  [exp_prediction_score,exp_prediction_list]=sort(exp_A_1,'descend');
  exp_prediction_score=nonzeros(exp_prediction_score(2:end));  
  exp_prediction_list=exp_prediction_list(2:11);
  #exp_prediction_score
  
endfunction

function [exp_prediction_list]=link_prediction_for_user22(A,V,D)  
  tV=V(22,:);
  exp_lambda=diag(exp(0.1*diag(D)));
  exp_A_22=tV*exp_lambda*V';
  exp_A_22(find(A(22,:)==1))=0;  
  [exp_prediction_score,exp_prediction_list]=sort(exp_A_22,'descend');
  exp_prediction_score=nonzeros(exp_prediction_score(2:end));  
  exp_prediction_list=exp_prediction_list(2:11);
  
  
endfunction
function [exp_prediction_list]=link_prediction_for_user333(A,V,D)
 
  tV=V(333,:);
  exp_lambda=diag(exp(0.1*diag(D)));
  exp_A_333=tV*exp_lambda*V';
  exp_A_333(find(A(333,:)==1))=0;  
  [exp_prediction_score,exp_prediction_list]=sort(exp_A_333,'descend');
  exp_prediction_score=nonzeros(exp_prediction_score(2:end));  
  exp_prediction_list=exp_prediction_list(2:11);
  
endfunction