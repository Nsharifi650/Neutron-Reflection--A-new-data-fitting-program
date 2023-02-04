function output = SLD_plot(SLD,z,Sig,thickness)

n = length(thickness);

for i =1:length(Sig)
    if Sig(i)== 0
        Sig(i) = 1e-10;
    else
        Sig(i)=Sig(i);
    end
    
end

if n==0 %single interface
    SLD_c = ((SLD(1)+SLD(2))/2) - ((SLD(1)-SLD(2))/2)*erf(z/(sqrt(2)*Sig(1)));
    
else
    for i = 1:length(thickness)
        if z <= sum(thickness(1:i))
            SLD_c = (((SLD(i)-SLD(i+1))/2)*erfc((z-sum(thickness(1:i))+thickness(i))/(sqrt(2)*Sig(i))))+SLD(i+1)-(((SLD(i+1)-SLD(i+2))/2)*erfc((sum(thickness(1:i))-z)/(sqrt(2)*Sig(i+1))));
            break
        else
            SLD_c = (((SLD(n+1)-SLD(n+2))/2)*erfc((z-sum(thickness(1:n)))/(sqrt(2)*Sig(n+1))))+SLD(n+2);
        end
    end
end

output = SLD_c;

%%Ignore the rest of the code

% if n==0 %single interface
%     SLD_c = ((SLD(1)+SLD(2))/2) - ((SLD(1)-SLD(2))/2)*erf(z/(sqrt(2)*Sig(1)));
%     output = SLD_c;
% elseif n ==1 % 1 layer
%     if z < 10
%         SLD_c = ((SLD(1)+SLD(2))/2) - ((SLD(1)-SLD(2))/2)*erf(z/(sqrt(2)*Sig(1)));
% %     elseif z > 30    
% %         SLD_c = ((SLD(2)+SLD(3))/2) - ((SLD(2)-SLD(3))/2)*erf((z-100)/(sqrt(2)*Sig(2)));
%     else
%         SLD_c = ((SLD(2)+SLD(3))/2) - ((SLD(2)-SLD(3))/2)*erf((z-100)/(sqrt(2)*Sig(2)));
%     end
%     output = SLD_c;
% elseif n ==2 % 2 layers
%     if z < 10     
%         SLD_c = ((SLD(1)+SLD(2))/2) - ((SLD(1)-SLD(2))/2)*erf(z/(sqrt(2)*Sig(1)));
%     elseif z < thickness(1)+30    
%         SLD_c = ((SLD(2)+SLD(3))/2) - ((SLD(2)-SLD(3))/2)*erf((z-thickness(1))/(sqrt(2)*Sig(2)));
%     else
%         SLD_c = ((SLD(3)+SLD(4))/2) - ((SLD(3)-SLD(4))/2)*erf((z-sum(thickness(1:2)))/(sqrt(2)*Sig(3)));
%     end
%     output = SLD_c;
%     
% elseif n==3
%     if z < 10    
%         SLD_c = ((SLD(1)+SLD(2))/2) - ((SLD(1)-SLD(2))/2)*erf(z/(sqrt(2)*Sig(1)));
%     elseif z < thickness(1)+30    
%         SLD_c = ((SLD(2)+SLD(3))/2) - ((SLD(2)-SLD(3))/2)*erf((z-thickness(1))/(sqrt(2)*Sig(2)));
%     elseif z < sum(thickness(1:2))+30    
%         SLD_c = ((SLD(3)+SLD(4))/2) - ((SLD(3)-SLD(4))/2)*erf((z-sum(thickness(1:2)))/(sqrt(2)*Sig(3)));
%     else
%         SLD_c = ((SLD(4)+SLD(5))/2) - ((SLD(4)-SLD(5))/2)*erf((z-sum(thickness(1:3)))/(sqrt(2)*Sig(4)));
%     end
%     output = SLD_c;
% end
% 

%% using https://arxiv.org/pdf/1305.6149.pdf
% if n==0 %single interface
%     SLD_c = ((SLD(1)+SLD(2))/2) - ((SLD(1)-SLD(2))/2)*erf(z/(sqrt(2)*Sig(1)));
%     output = SLD_c;
% elseif n ==1 % 1 layer
%     if z < 0
%         SLD_c = (((SLD(1)-SLD(2))/2)*erfc(z/(sqrt(2)*Sig(1))))+SLD(1); %+(((SLD(2)-SLD(3))/2)*erfc((z-thickness(1))/(sqrt(2)*Sig(2))));
%     elseif z< thickness(1)
%         SLD_c = (((SLD(1)-SLD(2))/2)*erfc(z/(sqrt(2)*Sig(1))))+SLD(2)+(((SLD(2)-SLD(3))/2)*erfc((thickness(1)-z)/(sqrt(2)*Sig(2))));
%     else
%     SLD_c = (((SLD(2)-SLD(3))/2)*erfc(z/(sqrt(2)*Sig(2))))+SLD(3)
%     end
%     output = SLD_c
% end
% if n==0 %single interface
%     SLD_c = ((SLD(1)+SLD(2))/2) - ((SLD(1)-SLD(2))/2)*erf(z/(sqrt(2)*Sig(1)));
%     
% else
%     for i = 1:length(thickness)
%         if z < 0
%             SLD_c = ((SLD(1)+SLD(2))/2) - ((SLD(1)-SLD(2))/2)*erf(z/(sqrt(2)*Sig(1)));
%         elseif z < sum(thickness(1:i))
%             a = sum(thickness(1:i))
%             z
%             SLD_c = (((SLD(i)-SLD(i+1))/2)*erfc(z/(sqrt(2)*Sig(i))))+SLD(i+1)+(((SLD(i+1)-SLD(i+2))/2)*erfc((thickness(i)-z)/(sqrt(2)*Sig(i+1))));
%         else
%             SLD_c = (((SLD(3)-SLD(4))/2)*erfc((z-200)/(sqrt(3)*Sig(3))))+SLD(4);
%         end
%     end
% end

end
% 

