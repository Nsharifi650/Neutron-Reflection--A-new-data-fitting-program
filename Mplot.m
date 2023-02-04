%MNPLOT    Auxiliary function for Fminuit: draws a run-time plot in response 
%  of a 'CALL 5' command. DATA is a 2- or 3-row matrix of experimental data
%  (DATA = [X_i;Y_i]; or  DATA = [X_i;Y_i; Delta_Y_i];).  
%  The user function FCN must be capable of switching between the theoretical 
%  function y=FCN(par,x) when its second argument is one row-vector, and the 
%  chi-square function when its second argument is a many-row matrix.  



function dummy=Mplot(par,data,fcn,erma);
% stat = 0;
% if (nargin >2) 	
%   if (ischar(fcn)),
%     l=min(data(:,1)); 
%     r=max(data(:,1)); 
%     x = l:(r-l)/500:r;
%     y= feval(fcn,par,x);
%     stat = (length(y) == length(x));
%   end
% end
% if (stat)
%   plot(data(:,1),data(:,2),'o',x,y,'-');
%   drawnow;
% else 
%   disp('Nothing to plot');
% end
stat = 0;
if (nargin >2), 	
  if (ischar(fcn)),
    %l=min(data(:,1)); r=max(data(:,1));
    x = data(:,1);
    y= feval(fcn,par,x);
    stat = (length(y) == length(x));
  end
end
if (stat),
  plot(data.x,data.y,'*',x,y,'-');
  drawnow;
else 
  disp('Nothing to plot');
end

dummy=[]; % return arg must be assigned
