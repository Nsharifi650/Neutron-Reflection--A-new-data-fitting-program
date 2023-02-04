global issameas parfree formulas numpar;
global SLDs bkg monolayer;
lim=[];
fixx=[];
setp=[];
parnames=[];
issameas=[];
formulas={};
parfree=numpar;
ii=0;

for k=1:numpar
    % verify if isSAMEas
    val=get(handles.sameas(k),'Value')-1;
    if val==0
        issameas(k)=k;
        ii=ii+1;
        
        % Get the parameters' names
        name=get(eval(['handles.text2(' num2str(k) ')']),'String');
        if isstr(name)
            parnames=[parnames ' ' name ';'];
        else
            parnames=[parnames ' ' name{1} ';'];
        end;
        
        %setpar

        % I can get everything from the GUI and then overwrite the SLDs in
        % another routine.
        p=get(eval(['handles.values(' num2str(k) ')']),'String');        
        if isstr(p)
            setp=[setp ' set par ' num2str(ii) ' ' p ';'];
        else
            setp=[setp ' set par ' num2str(ii) ' ' p{1} ';'];
        end;
        
        %fixpar
        chk=get(eval(['handles.fixpar(' num2str(k) ')']),'Value');
        if chk==1
            fixx=[fixx ' fix ' num2str(ii) ';'];
            parfree=parfree-1;
        end;
        
        %setlims
        minr=get(eval(['handles.minpar(' num2str(k) ')']),'String');
        maxr=get(eval(['handles.maxpar(' num2str(k) ')']),'String');
        if isstr(minr)
            lim=[lim ' set lim ' num2str(ii) ' ' minr ' '  maxr ';'];
        else
            lim=[lim ' set lim ' num2str(ii) ' ' minr{1} ' '  maxr{1} ';'];
        end;
    elseif val==numpar+1
        %label the par as sameas 0
        issameas=[issameas, 0];
        parfree=parfree-1;
        str=get(handles.sameas(k),'String');
        formulas{k}=str{get(handles.sameas(k),'Value')};
        
    else
        issameas=[issameas, val];
        parfree=parfree-1;
    end;
end;

% Redefinition of the vector issameas
ii=1;
for k=1:length(issameas)
    if issameas(k)==k
        issameas(k)=ii;
        issameas(issameas==k)=ii;
        ii=ii+1;
        toglipar(k)=0;
    else
        toglipar(k)=1;
    end;
end;
par(toglipar==1)=[];

fixBKGSLD=zeros(length(SLDs),3);
AAAAA=findobj('style','radio','-regexp','tag','BKG*','enable','on');
for kk=1:length(AAAAA)
    fixBKGSLD(kk,1)=sscanf(get(AAAAA(kk),'tag'),'BKGSLD%f'); %toggle fit of SLD and BKG
    fixBKGSLD(kk,2)=get(AAAAA(kk),'value');
    fixBKGSLD(kk,3)=get(AAAAA(kk),'value');
end
fixBKGSLD=sortrows(fixBKGSLD,1);
if strcmp(get(handles.FITSLD,'tag'),'SLDoff')
    fixBKGSLD(:,2)=0; % do NOT fit SLDs
end
if strcmp(get(handles.FITBKG,'tag'),'BKGoff')
    fixBKGSLD(:,3)=0; % do NOT fit BKG
end
fixBKGSLD(:,1)=[];
% Set the fisSLDBKG string, knowing that I will pass SLDs and then BKG
numtotpar=length(par)+2*size(fixBKGSLD,1);
AA0=vertcat(fixBKGSLD(:,1),fixBKGSLD(:,2));
passpar=[par,SLDs,bkg];

%to do only if during minimization of bootstrap
if not(strcmp(hObject.Tag,'figure2'))
    if (iscell(hObject.Callback))
        tmphc=hObject.Callback{1};
    else
        tmphc=hObject.Callback;
    end;
    if ((strcmp(func2str(tmphc),'btsp_button_Callback')||strcmp(func2str(tmphc),'Minimize_button_Callback'))&&(EXIT==0)&&(sum(AA0)>=1)&&(minimized==0))
        name='Define Range';
        stpar(1:2*length(AA0))={''};
        numlines=1;
        options.Interpreter='tex';
        options.WindowStyle='normal';
        options.Resize='on';
        A=[SLDs,bkg];
        prompt(1:2*length(AA0))={''};
        for kk=1:length(AA0)
            stpar{2*kk-1}=num2str(0.8*A(kk));
            stpar{2*kk}=num2str(1.1*A(kk));
            if(kk<=(0.5*length(AA0)))
                %I deal with SLDs
                prompt{2*kk-1}=['Start SLD ' num2str(kk) ': '];
                prompt{2*kk}=['End SLD ' num2str(kk) ': '];
            else
                %I deal with BKGs
                prompt{2*kk-1}=['Start BKG ' num2str(kk-0.5*length(AA0)) ': '];
                prompt{2*kk}=['End BKG ' num2str(kk-0.5*length(AA0)) ': '];
                %set default interval 1e-8 to 1e-5;
                stpar{2*kk-1}=num2str(1E-8);
                stpar{2*kk}=num2str(1E-5);
            end;
        end;
        %now I remove anything but AA0=1
        prompt_tmp=reshape([prompt(2*find(AA0==1)-1);prompt(2*find(AA0==1))],[2*length(find(AA0==1)),1]);
        stpar_tmp=reshape([stpar(2*find(AA0==1)-1);stpar(2*find(AA0==1))],[2*length(find(AA0==1)),1]);
        limits_SLDBKG=inputdlg(prompt_tmp,name,numlines,stpar_tmp,options);
        if isempty(limits_SLDBKG)
            waitfor(warndlg('Limits undefined'));
            error('Interrupted by user');
        end;
    end;
end;
jj=0;
for kk=1:length(AA0)
    if AA0(kk)==0
        fixx=[fixx 'fix ' num2str(kk+length(par)) ' ;'];
    else
        if not(strcmp(hObject.Tag,'figure2'))
            if ((strcmp(func2str(hObject.Callback),'btsp_button_Callback')||strcmp(func2str(hObject.Callback),'Minimize_button_Callback'))&&(EXIT==0)&&(sum(AA0)>=1)&&(minimized==0))
                jj=jj+1;
                %lim=[lim 'set lim ' num2str(kk+length(par)) ' ' num2str(passpar(kk+length(par))*0.8) ' ' num2str(passpar(kk+length(par))*1.2) ' ;'];
                lim=[lim 'set lim ' num2str(kk+length(par)) ' ' limits_SLDBKG{2*jj-1} ' ' limits_SLDBKG{2*jj} ' ;'];
            end;
        end;
    end
end;