function Lomagundi
% LOMAGUNDI model of Paleoproterozoic ocean chemistry. Aviv Bachan 2013
% 
% 
% 
% 
% 
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%                      Ocean Chemistry Boxes  
% 
%                             _______
%             Fw.MgCO3 -->   |       |   
%             Fw.CaCO3 -->   |       |   --> Fb.CaCO3     
%              Fw.Corg -->   | M.C   |        
%             Fw.FeCO3 -->   |       |   --> Fb.FeCO3            
%            Fw.C_volc -->   | del.C |   --> Fb.Corg
%           Fw.C_extra -->   |_______|
%
% 
%                             _______
%             Fw.CaCO3 -->   |       |
%            Fw.Ca_sil -->   | M.Ca  |   --> Fb.CaCO3     
%            Fw.Ca_hyd -->   |del.Ca |   --> Fb.CaSO4                             
%             Fw.CaSO4 -->   |_______|        
% 
%                             _______ 
%                            |       |
%               Fw.PO4 -->   | M.P   |   --> Fb.PO4        
%                            |       |
%                            |_______|   
%                             
% 
%                             _______ 
%             Fw.CaSO4 -->   |       |   --> Fb.CaSO4 
%             Fw.MgSO4 -->   | M.SO4 |   --> Fb.MgSO4
%            Fw.S_volc -->   |del.S  |   --> Fb.FeS2
%              Fw.FeS2 -->   |_______|   
%  
% 
%                             _______ 
%            Fw.FeCO3  -->   |       |   --> Fb.FeCO3
%            Fw.Fe_sil -->   | M.Fe  |   --> Fb.Fe_sil
%            Fw.FeS2   -->   |       |   --> Fb.FeS2
%                            |_______|   
%  
% 
%              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% 
%               Ocean chem boxes currently turned off.
%                    (See: params.pertb.zeroing)
% 
% 
%                             _______
%             Fw.MgCO3 -->   |       |   --> Fb.MgCO3   
%             Fw.MgSO4 -->   | M.Mg  |   --> Fb.MgSO4   
%            Fw.Mg_sil -->   |       |   --> Fb.Mg_hyd  (=Fhyd_Ca)                          
%                            |_______|   
%  
% 
%                             _______
%             Fw.K_sil -->   |       |   --> Fb.K_RW      
%                            | M.K   |   
%               Fw.KCl -->   |       |   --> Fb.KCl                               
%                            |_______|   
%  
%                
%                             _______
%            Fw.Na_sil -->   |       |   --> Fb.Na_RW     
%                            | M.Na  |   
%              Fw.NaCl -->   |       |   --> Fb.NaCl                              
%                            |_______|   
% 
% 
%                             _______
%              Fw.KCl  -->   |       |   --> Fb.KCl     
%                            |  Cl   |   
%              Fw.NaCl -->   |       |   --> Fb.NaCl                              
%                            |_______|   
%  
% 
%            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%                           Other boxes
% 
% 
%                             _______
%              Fb.Corg -->   |       |    --> Fw.Corg       
%                            | M.O2  |    --> Fw.FeS2      
%              Fb.FeS2 -->   |       |    --> Fw.S_volc * f_reduced   
%                            |_______|    --> Fw.C_volc * f_reduced
% 
% 
% 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%                          Sedimentary boxes
% 
%                             ____________
%                            |            |   --> Fw.subd_FeS2
%                            | M.sed_FeS2 |   
%              Fb.FeS2 -->   |            |   --> Fw.FeS2
%                            |____________|   
% 
% 
%                             _____________
%                            |             |   --> Fw.subd_CaSO4
%                            | M.sed_CaSO4 |   
%             Fb.CaSO4 -->   |             |   --> Fw.CaSO4
%                            |_____________|   
% 
% 
%                             ____________
%                            |            |   --> Fw.subd_Corg
%                            | M.sed_Corg |   
%               Fb.Corg -->  |            |   --> Fw.Corg
%                            |____________|   
% 
%                             _____________
%                            |             |   --> Fw.subd_CaCO3
%                            | M.sed_CaCO3 |   
%              Fb.CaCO3 -->  |             |   --> Fw.CaCO3
%                            |_____________|   
%
%                             _____________
%                            |             |   --> Fw.subd_CaSO4
%                            | M.sed_FeCO3 |   
%             Fb.FeCO3 -->   |             |   --> Fw.FeCO3
%                            |_____________|   
% 
% 
%                             ____________ 
%                            |             |   --> Fw.subd_CaSO4
%                            | M.sed_FeCO3 |   
%             Fb.FeO -->   |             |   --> Fw.FeCO3
%                            |_____________|   


% clean the table
clear all %clear workspace
 
clc %clear command prompt

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% functions to call to make plots in manuscript.
% Uncomment one at a time

% custom %%for playing with the model. Commented. 

Goldilocks_FeS2 %%Produces Figure S4. Exact O2 and CO2 balanced 
                  % perturbation according to eq 8

% Goldilocks_FeSiO3_FeS2 %%Exact O2 and CO2 balanced perturbation 
                         % according to eqs 7 & 8. 

% no_sid_Main  % organic carbon burial unaccompanied by siderite oxidation 
               

% no_sid_SOM    % organic carbon burial unaccompanied by siderite oxidation
                % has 3 runs: without FeS2 oxidation, with FeS2 oxidation 
                % according to the 
                % W+R parameterization, and with FeS2 oxidation with linear
                % parameterization. Makes Fig S5.

% Sid_ox_Pyr_ox  %% organic carbon burial with siderite and 
               % sulfide oxidation with increasing siderite amounts. 
               % Produces Figures S6, and S7 

% Sid_ox_combined  %% Produces Fig 4 in the main text. A figure combining no 
                  % siderite oxidation (no_sid_Main) 
                  % and the siderite oxidation runs of Sid_ox_Pyr_ox.

%  Sid_ox_Pyr_ox_Plan_S %%same as Sid_ox_Pyr_ox but tailored for overlay on 
                       % planavsky data

end

function Goldilocks_FeS2 

            
[params, flags] = settings;

flags.w = 0;     
        
%burial fluxes             
flags.b = 0;      
                
flags.Pyr_Sed = 4;

k = 2.6565;


params.pertb.vars = ...
     {...
     {'Fw.FeCO3', 'Gaussian', 0e6, 100e6, 7e12*k}  %7
     {'Fb.Corg', 'Gaussian', 0e6, 100e6,  13e12*k}   %1.3/ 10 -> 23, 13
     {'Fw.CaCO3', 'Gaussian', 0e6, 100e6, 6e12*k} %0.167 / 36 -> 42 , 6
     {'Fw.FeS2', 'Gaussian', 0e6, 100e6,  6e12*k}  %7427.3 8e8->6e12, 6 
     {'Fb.CaSO4', 'Gaussian', 0e6, 100e6, 6e12*k}
     };

flags.plottingFullScreen = 0;  
 
flags.plot_hold = 'replace'; 
    
params.plotting.n_subplots = [2 2];
%number of subplots row and column

params.plotting.vars_2_plot =...
                     { ...
                     {'C.C'       ,'del.C'        };... 
                     {'C.O2'      ,'C.pCO2'       };...
                     {'M.sed_Corg','M.sed_CaCO3'  };...
                     {'M.sed_FeCO3','Fw.FeCO3'    };...
                     };
 

    
    %call the model
    [t,output,params] = Model(params,flags);
 
    %call plotting function
    Plotting(t,output,params,flags);

    toc
    
    
    %% some specific figure touch-ups
    %set the axes so that the lines show clearly
    figAxes = get(gcf,'children');
    hlims = get(get(gcf,'children'),'YLim');
    set(figAxes(7),'YLim',[(hlims{7}(1))*0.99, (hlims{7}(2)*1.02)] )
    
    %Add plot letters A. B. C. D.
    annotation('textbox',[0.052 0.9 0.06875 0.0619],'String',{'A.'},...
        'EdgeColor','none');
    annotation('textbox',[0.52 0.9 0.06875 0.0619],'String',{'B.'},...
        'EdgeColor','none');
    annotation('textbox',[0.052 0.4371 0.06875 0.0619],'String',{'C'},...
        'EdgeColor','none');
    annotation('textbox',[0.52 0.4371 0.06875 0.0619],'String',{'D'},...
        'EdgeColor','none');
    
    %%
    
    %Modify the labels so that they're publishable
    hlabs = get(figAxes,'YLabel');
    newLabs = {'F^w_{FeCO3}'  'M^{sed}_{CaCO3}'     'pCO_2'    ...
                '\delta_{Carb}'     'M^{sed}_{FeCO3}'    'M^{sed}_{C{org}}' ...
                'pO_2'    'C_C'};
    
            for jjj = 1:length(newLabs)
            set(hlabs{jjj},'String',newLabs{jjj},'Interpreter','tex')
            end
    
    
    
    %%
    
    FeS2_tot = trapz(t,Fw.FeS2 - Fwi.FeS2)/1e18/2;
    CaCO3_tot = trapz(t,Fw.CaCO3 - Fwi.CaCO3)/1e18;
    FeCO3_tot = trapz(t,Fw.FeCO3 - Fwi.FeCO3)/1e18;
    CaSO4_tot = trapz(t,Fb.CaSO4 - Fbi.CaSO4)/1e18;
    Corg_tot = trapz(t,Fb.Corg - Fbi.Corg)/1e18;
    FeO_tot = 0;%trapz(t,Fw.FeO - Fwi.FeO);
    Fe2O3_tot = 0.5*FeCO3_tot + 0.5*FeO_tot + 0.5*FeS2_tot;
    
    
    disp(['     FeS_2       CaCO_3      FeSiO_3       FeCO_3      Fe_2O_3' ...
          '      CaSO_4     CH_2O    alpha'])

    disp([ ' & ' ,  sprintf('%6.2f',-(FeS2_tot)),   ...
       ' & '    ,  sprintf('%6.2f',-(CaCO3_tot)),  ...
       ' &  '  ,  sprintf('%6.2f',-(FeO_tot)), ... 
       ' &  ',  sprintf('%6.2f',-(FeCO3_tot)),  ...
       ' & '  ,  sprintf('%6.2f',(Fe2O3_tot )),...
       ' &  '     ,  sprintf('%6.2f',(CaSO4_tot)),  ...
       ' &  '   ,  sprintf('%6.2f',(Corg_tot))])
   
       %%
       
       
    FeS2_tot = (M.sed_FeS2(1) - M.sed_FeS2(end) )/1e18/2;
    CaCO3_tot = (M.sed_CaCO3(1) - M.sed_CaCO3(end) )/1e18;
    FeCO3_tot = (M.sed_FeCO3(1) - M.sed_FeCO3(end)  )/1e18;
    CaSO4_tot = (M.sed_CaSO4(end) - M.sed_CaSO4(1)   )/1e18;
    Corg_tot = (M.sed_Corg(end) - M.sed_Corg(1))/1e18;
    FeO_tot = 0;%trapz(t,Fw.FeO - Fwi.FeO);
    Fe2O3_tot = 0.5*FeCO3_tot + 0.5*FeO_tot + 0.5*FeS2_tot;
    
    
    disp([ ' & ' ,  sprintf('%6.2f',-(FeS2_tot)),   ...
       ' & '    ,  sprintf('%6.2f',-(CaCO3_tot)),  ...
       ' &  '  ,  sprintf('%6.2f',-(FeO_tot)), ... 
       ' &  ',  sprintf('%6.2f',-(FeCO3_tot)),  ...
       ' & '  ,  sprintf('%6.2f',(Fe2O3_tot )),...
       ' &  '     ,  sprintf('%6.2f',(CaSO4_tot)),  ...
       ' &  '   ,  sprintf('%6.2f',(Corg_tot))])
   
   
   
   
   %%
    
%%export model data to base workspace as one structure 'output'. 
%     assignin('base', 'output', output)
     assignin('base', 'params', params)
     assignin('base','flags',flags)
    assignin('base', 't', t)
   

%If you want a sound to let you know that the simulation is done
% load chirp
% sound(y,Fs)


 
end

function Goldilocks_FeSiO3_FeS2
                   

[params, flags] = settings;


flags.w = 0;     
        
%burial fluxes             
flags.b = 0;      
                    
flags.Pyr_Sed = 4;

%  alpha = 0.5;
 Fborg_max = 3.4653e+13; 
 %the extra flux of organic carbon required to give a +10 permil gaussian


%  for 
     alpha = 0.1795; 

params.pertb.vars = ...
     {...
     {'Fb.Corg', 'Gaussian', 0e6,  130e6,  Fborg_max}, ...   
     {'Fw.FeCO3', 'Gaussian', 0e6, 130e6,  7/13*(1-alpha)*Fborg_max + alpha*Fborg_max}, ...  
     {'Fw.CaCO3', 'Gaussian', 0e6,  130e6, 6/13*(1-alpha)*Fborg_max}, ... 
     {'Fw.FeO', 'Gaussian', 0e6, 130e6,  3*alpha*Fborg_max}, ...  
     {'Fw.FeS2', 'Gaussian', 0e6,  130e6,  6/13*(1-alpha)*Fborg_max}, ...
     {'Fb.CaSO4', 'Gaussian', 0e6, 130e6,  6/13*(1-alpha)*Fborg_max}
     };
 


    %call the model
    [t,output,params] = Model(params,flags);
 
    
    flags.plot_hold = 'hold';

    flags.plottingFullScreen = 0;  
    
    params.plotting.n_subplots = [2 2];
    %number of subplots row and column

    params.plotting.vars_2_plot =...
                     { ...
                     {'M.sed_FeCO3'       ,'del.C'        };... 
                     {'C.O2'      ,'C.pCO2'       };...
                     {'M.sed_FeO','M.sed_CaCO3'  };...
                     {'M.sed_FeS2','M.sed_CaSO4'    };...
                     };

    
    
    %call plotting function
    Plotting(t,output,params,flags);

    toc
    
%  end
    
    %% some specific figure touch-ups
    %set the axes so that the lines show clearly
    params.figAxes = get(gcf,'children');
    params.hlims = get(params.figAxes,'YLim');
    set(params.figAxes(7),'YLim',[(params.hlims{7}(1))*0.99, (params.hlims{7}(2)*1.02)] )
    
    %Add plot letters A. B. C. D.
    annotation('textbox',[0.052 0.9 0.06875 0.0619],'String',{'A.'},...
        'EdgeColor','none');
    annotation('textbox',[0.52 0.9 0.06875 0.0619],'String',{'B.'},...
        'EdgeColor','none');
    annotation('textbox',[0.052 0.4371 0.06875 0.0619],'String',{'C'},...
        'EdgeColor','none');
    annotation('textbox',[0.52 0.4371 0.06875 0.0619],'String',{'D'},...
        'EdgeColor','none');
    
    %%
    
    %Modify the labels so that they're publishable
    params.hlabs = get(params.figAxes,'YLabel');
    params.newLabs = {'F^w_{CaSO4}'  'M^{sed}_{CaCO3}'     'pCO_2'    ...
                '\delta_{Carb}'     'M^{sed}_{FeS2}'    'M^{sed}_{FeO}' ...
                'pO_2'    'M^{sed}_{FeCO3}'};
    
            for jjj = 1:length(params.newLabs)
            set(params.hlabs{jjj},'String',params.newLabs{jjj},'Interpreter','tex')
            end
    
%% 
%deal with the lines
            
%     set([params.hlines{:}],'LineWidth',1.5)
            
    
    %%
    
    FeS2_tot = trapz(t,Fw.FeS2 - Fwi.FeS2)/1e18/2;
    CaCO3_tot = trapz(t,Fw.CaCO3 - Fwi.CaCO3)/1e18;
    FeCO3_tot = trapz(t,Fw.FeCO3 - Fwi.FeCO3)/1e18;
    CaSO4_tot = trapz(t,Fb.CaSO4 - Fbi.CaSO4)/1e18;
    Corg_tot = trapz(t,Fb.Corg - Fbi.Corg)/1e18;
    FeO_tot = trapz(t,Fw.FeO - Fwi.FeO)/1e18;
    Fe2O3_tot = 0.5*FeCO3_tot + 0.5*FeO_tot + 0.5*FeS2_tot;
    
    
    disp(['     FeS_2       CaCO_3      FeSiO_3       FeCO_3      Fe_2O_3' ...
          '      CaSO_4     CH_2O    alpha'])

    disp([ ' & ' ,  sprintf('%6.2f',-(FeS2_tot)),   ...
       ' & '    ,  sprintf('%6.2f',-(CaCO3_tot)),  ...
       ' &  '  ,  sprintf('%6.2f',-(FeO_tot)), ... 
       ' &  ',  sprintf('%6.2f',-(FeCO3_tot)),  ...
       ' & '  ,  sprintf('%6.2f',(Fe2O3_tot )),...
       ' &  '     ,  sprintf('%6.2f',(CaSO4_tot)),  ...
       ' &  '   ,  sprintf('%6.2f',(Corg_tot))])  %,...
%        ' &  '   ,  sprintf('%6.2f',)
       
   
       %%
       
       
%     FeS2_tot = (M.sed_FeS2(1) - M.sed_FeS2(end) )/1e18/2;
%     CaCO3_tot = (M.sed_CaCO3(1) - M.sed_CaCO3(end) )/1e18;
%     Fw_sid_tot = (M.sed_FeCO3(1) - M.sed_FeCO3(end)  )/1e18;
%     CaSO4_tot = (M.sed_CaSO4(end) - M.sed_CaSO4(1)   )/1e18;
%     Corg_tot = (M.sed_Corg(end) - M.sed_Corg(1))/1e18;
% %     Fe2O3_tot = trapz(t,Fb.FeO)/1e18;
% %     FeSiO3_tot = trapz(t,M.sed_FeO(end) - M.sed_Feo(1));
%     
%     
%     disp([ ' & ' ,  sprintf('%6.2f',(FeS2_tot)),   ...
%        ' & '    ,  sprintf('%6.2f',(CaCO3_tot)),  ...
%        ' &  '  ,  '--',  ... 
%        ' &  ',  sprintf('%6.2f',-(Fw_sid_tot)),  ...
%        ' & '  ,  '--',  ...
%        ' &  '     ,  sprintf('%6.2f',(CaSO4_tot)),  ...
%        ' &  '   ,  sprintf('%6.2f',(Corg_tot))])
    

    assignin('base', 'output', output)
    assignin('base', 'params', params)
    assignin('base','flags',flags)
    assignin('base', 't', t)
   


 
end

function no_sid_SOM

[params, flags] = settings;


params.t.run_end = 600e6;

flags.pertb = 1; 

% params.pertb.zeroing = {'Mg','K','Na','Cl','O2'};
params.pertb.zeroing = {'Mg','K','Na','Cl'};

 
 params.plotting.vars_2_plot =...
                     { ...
                     {'C.C'       ,'del.C'        };... 
                     {'C.Ca'      ,'del.Ca'       };...
                     {'C.SO4'       ,'del.S'        };...
                     {'C.O2'      ,'C.pCO2'       };...
                     {'M.sed_FeS2','M.sed_CaSO4'  };...
                     {'M.sed_Corg','M.sed_CaCO3'  };...
                     {'del.sed_Corg','del.sed_CaCO3'};...
                     {'M.sed_FeO', 'Fw.FeO'};...
                     {'Fw.C_volc' , 'del.C_volc'  };...
                     {'f.redox_volc_C','f.redox_volc_S'};...
                     {'Fw.FeS2'    ,'Fb.FeS2'       };...
                     {'Fw.CaCO3'  ,'Fb.CaCO3'     };...
                     {'Fw.Corg'   ,'Fb.Corg'      };...
                     {'Fw.CaSO4'  ,'Fb.CaSO4'     };...
                     {'Fw.PO4'    ,'Fb.PO4'       };...
                     {'C.pH'      ,'C.Omega'      };...
                     {'f.CP'      ,'f.borg'         };...
                     {'C.CO3'     ,'C.Alk'        };...
                     {'M.sed_FeCO3','Fw.FeCO3'    };...
                     {'Fw.O_extra' ,'R.SO'   };...
                     };
 
flags_Sulf = {'off', 'on' ,'on' , 'off', 'off'};

%only relevant if flags_Sulf = on
flags_WR = { [] ,'on' ,'off' , 'off', 'on'};


% Fborg_max = [5.9e+12,6.675e+12,8.1e12,4e12]; 
                 
flags_w = [0.1, 0.11,.12,1.11,1]; 
                 
flags_b = [0.1, 0.11,.11,1.1,1.1]; 

myLineStyle = {'-.' '--' '-' ,'-'};

myLineColor = {'r' 'g' 'b' 'b'};

params_pertb_vars = { 
    { {'f.borg', 'Gaussian', 0e6,  130e6,  2} }...
    { {'f.borg', 'Gaussian', 0e6,  130e6,  2} }...
    { {'f.borg', 'Gaussian', 0e6,  130e6,  2} } ...
    { {'Fb.Corg', 'Gaussian', 0e6,  130e6,  6.675e+12} }, ...
    { {'Fb.Corg', 'Gaussian', 0e6,  130e6,  8.1e+12} }, ...
    };

                 
for i = [1 2 3 ]
    
    params.pertb.vars = params_pertb_vars{i};...
%      { {'Fb.Corg', 'Gaussian', 0e6,  130e6,  Fborg_max(i)} };
%      { {'f.borg', 'Gaussian', 0e6,  130e6,  2} };

 
    flags.Sulf = flags_Sulf{i};
    
    flags.k_WilRem = flags_WR{i}; 
    
    flags.w = flags_w(i); 
                 
    flags.b = flags_b(i);
    
    %call the model
    [t,output,params] = Model(params,flags);
 
    %call plotting function
    Plotting(t,output,params,flags);

    toc 



%%export model data to base workspace as one structure 'output'. 
    assignin('base', 'output', output)
    assignin('base', 'params', params)
    assignin('base','flags',flags)
    assignin('base', 't', t)
   

%If you want a sound to let you know that the simulation is done
% load chirp
% sound(y,Fs)





%% some specific figure touch-ups

figure(3)

mylinewidth = 1.5;
myfontsize = 12;

set(gcf,'PaperPositionMode','auto')
% set(gcf,'InvertHardcopy','off')

AX1 = subplot(2,4,1:2);
hold on
plot(t/1e6,del.C,'k','LineWidth',mylinewidth)
xlim([-50 300])
ylim([-1 11])
xlabel('Time (Ma)','FontSize',myfontsize)
ylabel('\delta^{13}C','FontSize',myfontsize)
axis square
grid on
box on

AX2 = subplot(2,4,3:4);
hold on
plot(t/1e6,C.O2,'g','LineWidth',mylinewidth,'LineStyle',myLineStyle{i},...
    'Color',myLineColor{i})
xlim([-50 300])
set(AX2,'YScale','log')
xlabel('Time (Ma)','FontSize',myfontsize)
ylabel('pO_2  [atm]','FontSize',myfontsize)
axis square
box on 
grid on


AX3 = subplot(2,4,6:7);
hold on
plot(t/1e6,C.pCO2,'b','LineWidth',mylinewidth,'LineStyle',myLineStyle{i},...
    'Color',myLineColor{i})
xlim([-50 300])
set(AX3,'YScale','log')
xlabel('Time (Ma)','FontSize',myfontsize)
ylabel('pCO_2 [ppmv]','FontSize',myfontsize)
axis square
box on 
grid on




end


annotation('textbox',[0.102 0.9 0.06875 0.0619],'String',{'A.'},...
        'EdgeColor','none');
annotation('textbox',[0.4968 0.9 0.06875 0.0619],'String',{'B.'},...
        'EdgeColor','none');
annotation('textbox',[0.2734 0.4014 0.06875 0.0619],'String',{'C.'},...
        'EdgeColor','none');



% cd('/Users/avivbachan/Documents/Research/Postdoc/Lomagundi_Modeling/Manuscript/Nature_submission/Figures/')
 
%  print -f2 -depsc -painters -loose 'no_Sid_Ox_pCO2_drop'

%  cd(CurrentDir)




 
end

function no_sid_Main 

[params, flags] = settings;


params.t.run_end = 300e6;

flags.pertb = 1; 

% params.pertb.zeroing = {'Mg','K','Na','Cl','Ca','O2','C'};
params.pertb.zeroing = {'Mg','K','Na','Cl'};



params.pertb.vars = ...
     {...
          {'f.borg', 'Gaussian', 0e6, 130e6, 2}
%      {'Fb.Corg', 'Gaussian', 0e6,  130e6,  Fborg_max}, ...  
     };


 
 params.plotting.vars_2_plot =...
                     { ...
                     {'C.C'       ,'del.C'        };... 
                     {'C.Ca'      ,'del.Ca'       };...
                     {'C.SO4'       ,'del.S'        };...
                     {'C.O2'      ,'C.pCO2'       };...
                     {'M.sed_FeS2','M.sed_CaSO4'  };...
                     {'M.sed_Corg','M.sed_CaCO3'  };...
                     {'del.sed_Corg','del.sed_CaCO3'};...
                     {'M.sed_FeO', 'Fw.FeO'};...
                     {'Fw.C_volc' , 'del.C_volc'  };...
                     {'f.redox_volc_C','f.redox_volc_S'};...
                     {'Fw.FeS2'    ,'Fb.FeS2'       };...
                     {'Fw.CaCO3'  ,'Fb.CaCO3'     };...
                     {'Fw.Corg'   ,'Fb.Corg'      };...
                     {'Fw.CaSO4'  ,'Fb.CaSO4'     };...
                     {'Fw.PO4'    ,'Fb.PO4'       };...
                     {'C.pH'      ,'C.Omega'      };...
                     {'f.CP'      ,'f.borg'         };...
                     {'C.CO3'     ,'C.Alk'        };...
                     {'M.sed_FeCO3','Fw.FeCO3'    };...
                     {'Fw.O_extra' ,'R.SO'   };...
                     };
 
flags.w = .11; 
                 
flags.b = .11; 
                 
    

    
    %call the model
    [t,output,params] = Model(params,flags);
 
    %call plotting function
    Plotting(t,output,params,flags);

    toc 



%%export model data to base workspace as one structure 'output'. 
    assignin('base', 'output', output)
    assignin('base', 'params', params)
    assignin('base','flags',flags)
    assignin('base', 't', t)
   

%If you want a sound to let you know that the simulation is done
% load chirp
% sound(y,Fs)



%%

figure(2)
set(gcf,'PaperPositionMode','auto')

AX1 = subplot(1,2,1);

mylinewidth = 1.5;
myfontsize = 12;


plot(t/1e6,del.C,'k','LineWidth',mylinewidth)

xlabel('Time (Ma)','FontSize',myfontsize)
ylabel('\delta^{13}C','FontSize',myfontsize)

set(AX1,'FontSize',myfontsize)
axis square
xlim([-50 300])
ylim([-1 11])
grid on

AX2 = subplot(1,2,2);

plot(t/1e6,C.pCO2/1e3,'k','LineWidth',mylinewidth)

xlabel('Time (Ma)','FontSize',myfontsize)
ylabel('pCO_2','FontSize',myfontsize)

set(AX2,'FontSize',myfontsize)
axis square
xlim([-50 300])
ylim([-2 22])
grid on


% [AX2,H1,H2] = plotyy(t/1e6,C.O2,t/1e6,C.pCO2/1e3);
% 
% set(get(AX2(1),'Ylabel'),'String','pO_2  [atm]','FontSize',myfontsize) 
% set(get(AX2(2),'Ylabel'),'String','pCO_2 [10^3 ppmv]','FontSize',myfontsize, ...
%     'VerticalAlignment','cap') 
% 
% set(AX2(1),'FontSize',myfontsize)
% set(AX2(2),'FontSize',myfontsize)
% 
% set(H1,'LineStyle','-','LineWidth',mylinewidth)
% set(H2,'LineStyle','--','LineWidth',mylinewidth)
% 
% xlabel('Time (Ma)')
% 
% 
% set(AX2(1),'YLIM',[-0.05 0.75],'YTickMode','auto', 'XLIM', [-50 300] )
% set(AX2(2),'YLIM',[-2 30],'YTickMode','auto', 'XLIM', [-50 300] )
% set(AX2(1), 'box', 'off')



% set(AX2(2), 'XAxisLocation', 'top','XTickLabel','')
% 
% axis(AX2(:),'square')
% 
% set(AX2(1),'Xgrid','on','Ygrid','on')


% CurrentDir = cd;

% cd('/Users/avivbachan/Documents/Research/Postdoc/Lomagundi_Modeling/Manuscript/Nature_submission/Figures/')
 
%  print -f2 -depsc -painters -loose 'Sid_Pyr_Ox_pCO2_drop'

%  cd(CurrentDir)



%%

% figure(3)
% clf
% 
% 
% set(gcf,'PaperPositionMode','auto')
% set(gcf,'InvertHardcopy','off')
% set(gcf,'Color','none')
% 
% % [left bottom width height]
% 
% AX(3) = axes('Position',[0.15 0.43 0.82 0.465]);
% 
% plot(t/1e6,del.S)
% 
% xlabel('Time (Ma)')
% 
% xlim([0 190])
% ylim([-3.5 35])
% 
% % box off
% 
% % set(gca,'Color','none', 'YTickLabels','')
% set(gca,'visible','off')
% 
% AX(4) = axes('Position',[0.15 0.05 0.82 0.279]);
% 
% plot(t/1e6,del.C)
% 
% 
% xlabel('Time (Ma)')
% 
% xlim([0 190])
% ylim([-1 16])
% 
% set(gca,'visible','off')
% % set(gca,'Color','none', 'YTickLabels','','visible','off')
% 
% % box off
% 
%  CurrentDir = cd;
% 
% cd('/Users/avivbachan/Documents/Research/Postdoc/Lomagundi_Modeling/Manuscript/Nature_submission/Figures/')
% 
% print -f3 -depsc -painters -loose 'Model_d34S.eps'
% 
%  cd(CurrentDir)



 
end

function Sid_ox_Pyr_ox 

[params, flags] = settings;


params.t.run_end = 300e6;

flags.pertb = 1; 

% params.pertb.zeroing = {'Mg','K','Na','Cl','Ca','O2','C'};
params.pertb.zeroing = {'Mg','K','Na','Cl'};


Fw_FeO_max  = [ 6e13 7.5e13 9e13];
Fw_FeCO3_max = [ 2e13 2.75e13 3.5e13];
fborg_max = [ 3.2,3.2,3.2];

% Fw_FeO_max  = [5e13 7e13 9e13];
% Fw_FeCO3_max = [2e13 3e13 3.4e13];
% fborg_max = [3.2,3.4,3.5];



myLineStyle = { '-.' '--' '-' };
myLineColor = { 'r' 'g' 'b' };



    for j = 1:length(Fw_FeCO3_max)




params.pertb.vars = ...
     {...
          {'f.borg', 'Gaussian', 0e6, 130e6, fborg_max(j)}
          {'Fw.FeO', 'Gaussian', 0e6, 130e6,  Fw_FeO_max(j)}
          {'Fw.FeCO3', 'Gaussian', 0e6, 130e6,  Fw_FeCO3_max(j)}
     };


 
 params.plotting.vars_2_plot =...
                     { ...
                     {'C.C'       ,'del.C'        };... 
                     {'C.Ca'      ,'del.Ca'       };...
                     {'C.SO4'       ,'del.S'        };...
                     {'C.O2'      ,'C.pCO2'       };...
                     {'M.sed_FeS2','M.sed_CaSO4'  };...
                     {'M.sed_Corg','M.sed_CaCO3'  };...
                     {'del.sed_Corg','del.sed_CaCO3'};...
                     {'M.sed_FeO', 'Fw.FeO'};...
                     {'Fw.C_volc' , 'del.C_volc'  };...
                     {'f.redox_volc_C','f.redox_volc_S'};...
                     {'Fw.FeS2'    ,'Fb.FeS2'       };...
                     {'Fw.CaCO3'  ,'Fb.CaCO3'     };...
                     {'Fw.Corg'   ,'Fb.Corg'      };...
                     {'Fw.CaSO4'  ,'Fb.CaSO4'     };...
                     {'Fw.PO4'    ,'Fb.PO4'       };...
                     {'C.pH'      ,'C.Omega'      };...
                     {'f.CP'      ,'f.borg'         };...
                     {'C.CO3'     ,'C.Alk'        };...
                     {'M.sed_FeCO3','Fw.FeCO3'    };...
                     {'Fw.O_extra' ,'R.SO'   };...
                     };
 
flags.w = .11; 
                 
flags.b = .11; 
                 

        
        
    %call the model
    [t,output,params] = Model(params,flags);
 
    %call plotting function
    Plotting(t,output,params,flags);

    toc 
    

%% make figure
    
figure(3)

set(gcf,'PaperPositionMode','auto')

mylinewidth = 1.5;
myfontsize = 12;

AX1 = subplot(4,4,[1 2 5 6]);

hold on
plot(t/1e6,del.C,'k','LineWidth',mylinewidth)

% xlabel('Time (Ma)','FontSize',myfontsize)
ylabel('\delta^{13}C','FontSize',myfontsize)

set(AX1,'FontSize',myfontsize)
axis square
xlim([-50 300])
ylim([-1 11])
grid on
box on


AX2 = subplot(4,4, [3 4 7 8] );
hold on
H2 = plot(t/1e6,C.O2);
axis square
xlim([-50 300])
ylim([-0.1 0.4])
grid on
set(get(AX2,'Ylabel'),'String','pO_2  [atm]','FontSize',myfontsize) 
set(H2,'LineStyle',myLineStyle{j},'Color',myLineColor{j},'LineWidth',mylinewidth)
box on

AX3 = subplot(4,4,[10 11 14 15 ]);
hold on
H3 = plot(t/1e6,C.pCO2/1e3);
axis square
xlim([-50 300])
% ylim([-1 11])
grid on
set(get(AX3,'Ylabel'),'String','pCO_2 [10^3 ppmv]','FontSize',myfontsize)
xlabel('Time (Ma)')
set(H3,'LineStyle',myLineStyle{j},'Color',myLineColor{j},'LineWidth',mylinewidth)
box on


figure(4)

set(gcf,'PaperPositionMode','auto')

AX4 = subplot(1,2,1);
hold on
H4 = plot(t/1e6,C.SO4);
set(get(AX4,'Ylabel'),'String','[SO_4]  [mM]','FontSize',myfontsize) 
set(H4,'LineStyle',myLineStyle{j},'Color',myLineColor{j},'LineWidth',mylinewidth)
xlim([-50 300])
xlabel('Time (Ma)')
grid on
axis square
box on

AX5 = subplot(1,2,2);
hold on
H5 = plot(t/1e6,del.S);
set(get(AX5,'Ylabel'),'String','\delta^{34}S  [permil]','FontSize',myfontsize) 
set(H5,'LineStyle',myLineStyle{j},'Color',myLineColor{j},'LineWidth',mylinewidth)
xlim([-50 300])
xlabel('Time (Ma)')
grid on
axis square
box on

%%


    FeS2_tot = trapz(t,Fw.FeS2 - Fwi.FeS2)/1e18/2;
    CaCO3_tot = trapz(t,Fw.CaCO3 - Fwi.CaCO3)/1e18;
    FeCO3_tot = trapz(t,Fw.FeCO3 - Fwi.FeCO3)/1e18;
    CaSO4_tot = trapz(t,Fb.CaSO4 - Fbi.CaSO4)/1e18;
    Corg_tot = trapz(t,Fb.Corg - Fbi.Corg)/1e18;
    FeO_tot = trapz(t,Fw.FeO - Fwi.FeO)/1e18;
    Fe2O3_tot = 0.5*FeCO3_tot + 0.5*FeO_tot + 0.5*FeS2_tot;
    alpha = 1- 7/6*CaSO4_tot / FeCO3_tot;
    
    disp(['     FeS_2       CaCO_3      FeSiO_3       FeCO_3      Fe_2O_3' ...
          '      CaSO_4     CH_2O    alpha'])

    disp([ ' & ' ,  sprintf('%6.2f',-(FeS2_tot)),   ...
       ' & '    ,  sprintf('%6.2f',-(CaCO3_tot)),  ...
       ' &  '  ,  sprintf('%6.2f',-(FeO_tot)), ... 
       ' &  ',  sprintf('%6.2f',-(FeCO3_tot)),  ...
       ' & '  ,  sprintf('%6.2f',(Fe2O3_tot )),...
       ' &  '     ,  sprintf('%6.2f',(CaSO4_tot)),  ...
       ' &  '   ,  sprintf('%6.2f',(Corg_tot)) ,...
       ' &  '   ,  sprintf('%6.2f',alpha) ])
    


% if j==2
%     figure(5)
% end
% 
% if j==3
     
% end
%%

% figure(6)
%  
% set(gcf,'PaperPositionMode','auto')
% 
% ax2 = subplot(1,2,1);
% hold on
% h2 = plot(t/1e6,C.O2);
% axis square
% xlim([-50 300])
% ylim([-0.1 0.4])
% grid on
% set(get(ax2,'Ylabel'),'String','pO_2  [atm]','FontSize',myfontsize) 
% set(h2,'LineStyle',myLineStyle{j},'Color',myLineColor{j},'LineWidth',mylinewidth)
% box on
% 
% ax3 = subplot(1,2,2);
% hold on
% h3 = plot(t/1e6,C.pCO2/1e3);
% axis square
% xlim([-50 300])
% % ylim([-1 11])
% grid on
% set(get(ax3,'Ylabel'),'String','pCO_2 [10^3 ppmv]','FontSize',myfontsize)
% xlabel('Time (Ma)')
% set(h3,'LineStyle',myLineStyle{j},'Color',myLineColor{j},'LineWidth',mylinewidth)
% box on


    
    end


%%export model data to base workspace as one structure 'output'. 
    assignin('base', 'output', output)
    assignin('base', 'params', params)
    assignin('base','flags',flags)
    assignin('base', 't', t)
   


 
end

function Sid_ox_combined

[params, flags] = settings;


params.t.run_end = 300e6;

flags.pertb = 1; 

% params.pertb.zeroing = {'Mg','K','Na','Cl','Ca','O2','C'};
params.pertb.zeroing = {'Mg','K','Na','Cl'};

% Fw_FeO_max  = [0 1e13 3e13];
% Fw_FeCO3_max = [0 1e13 5e13];

% Fw_FeO_max  = [4e13 6.5e13 9e13];
% Fw_FeCO3_max = [2e13 2.75e13 3.5e13];
% fborg_max = [3.2,3.3,3.4];

Fw_FeO_max  = [0 6e13 7.5e13 9e13];
Fw_FeCO3_max = [0 2e13 2.75e13 3.5e13];
fborg_max = [2 3.2,3.2,3.2];

% Fw_FeO_max  = [7e13];
% Fw_FeCO3_max = [3e13];

myLineStyle = {'-' '-.' '--' '-' };
myLineColor = {'k' 'r' 'g' 'b' };



    for j = 1:length(Fw_FeCO3_max)




params.pertb.vars = ...
     {...
          {'f.borg', 'Gaussian', 0e6, 130e6, fborg_max(j)}
          {'Fw.FeO', 'Gaussian', 0e6, 130e6,  Fw_FeO_max(j)}
          {'Fw.FeCO3', 'Gaussian', 0e6, 130e6,  Fw_FeCO3_max(j)}
     };


 
 params.plotting.vars_2_plot =...
                     { ...
                     {'C.C'       ,'del.C'        };... 
                     {'C.Ca'      ,'del.Ca'       };...
                     {'C.SO4'       ,'del.S'        };...
                     {'C.O2'      ,'C.pCO2'       };...
                     {'M.sed_FeS2','M.sed_CaSO4'  };...
                     {'M.sed_Corg','M.sed_CaCO3'  };...
                     {'del.sed_Corg','del.sed_CaCO3'};...
                     {'M.sed_FeO', 'Fw.FeO'};...
                     {'Fw.C_volc' , 'del.C_volc'  };...
                     {'f.redox_volc_C','f.redox_volc_S'};...
                     {'Fw.FeS2'    ,'Fb.FeS2'       };...
                     {'Fw.CaCO3'  ,'Fb.CaCO3'     };...
                     {'Fw.Corg'   ,'Fb.Corg'      };...
                     {'Fw.CaSO4'  ,'Fb.CaSO4'     };...
                     {'Fw.PO4'    ,'Fb.PO4'       };...
                     {'C.pH'      ,'C.Omega'      };...
                     {'f.CP'      ,'f.borg'         };...
                     {'C.CO3'     ,'C.Alk'        };...
                     {'M.sed_FeCO3','Fw.FeCO3'    };...
                     {'Fw.O_extra' ,'R.SO'   };...
                     };
 
flags.w = .11; 
                 
flags.b = .11; 
                 

        
        
    %call the model
    [t,output,params] = Model(params,flags);
 
    %call plotting function
    Plotting(t,output,params,flags);

    toc
    
    
    
    %%
    figure(3)

set(gcf,'PaperPositionMode','auto')

mylinewidth = 1.5;
myfontsize = 12;

AX1 = subplot(2,2,1);

hold on
plot(t/1e6,del.C,'k','LineWidth',mylinewidth)

xlabel('Time (Ma)','FontSize',myfontsize)
ylabel('\delta^{13}C','FontSize',myfontsize)
set(AX1,'FontSize',myfontsize)
axis square
xlim([-50 300])
ylim([-1 11])

grid on
box on


AX2 = subplot(2,2, 3 );
hold on
H2 = plot(t/1e6,C.pCO2/1e3);
axis square
xlim([-50 300])
ylim([-2 25])
grid on
set(get(AX2,'Ylabel'),'String','pCO_2 [10^3 ppmv]','FontSize',myfontsize)
xlabel('Time (Ma)','FontSize',myfontsize)
set(H2,'LineStyle',myLineStyle{j},'Color',myLineColor{j},'LineWidth',mylinewidth)
box on

AX3 = subplot(2,2,4);
hold on
H3 = plot(t/1e6,C.O2);
axis square
xlim([-50 300])
ylim([-0.05 0.5])
grid on
set(get(AX3,'Ylabel'),'String','pO_2  [atm]','FontSize',myfontsize) 
xlabel('Time (Ma)','FontSize',myfontsize)
set(H3,'LineStyle',myLineStyle{j},'Color',myLineColor{j},'LineWidth',mylinewidth)
box on
    
AX4 = subplot(2,2,2);
hold on
H4 = plot(t/1e6,Fw.FeCO3/1e12);
axis square
xlim([-50 300])
ylim([-2 37])
grid on
set(get(AX4,'Ylabel'),'String','F^w_{FeCO3} [Tmol/yr]','FontSize',myfontsize) 
xlabel('Time (Ma)','FontSize',myfontsize)
set(H4,'LineStyle',myLineStyle{j},'Color',myLineColor{j},'LineWidth',mylinewidth)
box on 
    

%%
 FeS2_tot = trapz(t,Fw.FeS2 - Fwi.FeS2)/1e18/2;
    CaCO3_tot = trapz(t,Fw.CaCO3 - Fwi.CaCO3)/1e18;
    FeCO3_tot = trapz(t,Fw.FeCO3 - Fwi.FeCO3)/1e18;
    CaSO4_tot = trapz(t,Fb.CaSO4 - Fbi.CaSO4)/1e18;
    Corg_tot = trapz(t,Fb.Corg - Fbi.Corg)/1e18;
    FeO_tot = trapz(t,Fw.FeO - Fwi.FeO)/1e18;
    Fe2O3_tot = 0.5*FeCO3_tot + 0.5*FeO_tot + 0.5*FeS2_tot;
    alpha = 1- 7/6*CaSO4_tot / FeCO3_tot;
    
    disp(['     FeS_2       CaCO_3      FeSiO_3       FeCO_3      Fe_2O_3' ...
          '      CaSO_4     CH_2O    alpha'])

    disp([ ' & ' ,  sprintf('%6.2f',-(FeS2_tot)),   ...
       ' & '    ,  sprintf('%6.2f',-(CaCO3_tot)),  ...
       ' &  '  ,  sprintf('%6.2f',-(FeO_tot)), ... 
       ' &  ',  sprintf('%6.2f',-(FeCO3_tot)),  ...
       ' & '  ,  sprintf('%6.2f',(Fe2O3_tot )),...
       ' &  '     ,  sprintf('%6.2f',(CaSO4_tot)),  ...
       ' &  '   ,  sprintf('%6.2f',(Corg_tot)) ,...
       ' &  '   ,  sprintf('%6.2f',alpha) ])



    end

end

function Sid_ox_Pyr_ox_Plan_S 

[params, flags] = settings;


params.t.run_start = -2400e6;

params.t.run_end = -2000e6;

flags.pertb = 1; 

% params.pertb.zeroing = {'Mg','K','Na','Cl','Ca','O2','C'};
params.pertb.zeroing = {'Mg','K','Na','Cl'};

% Fw_FeO_max  = [0 1e13 3e13];
% Fw_FeCO3_max = [0 1e13 5e13];

Fw_FeO_max  = [6e13 7.5e13 9e13];
Fw_FeCO3_max = [2e13 2.75e13 3.5e13];
fborg_max = [3.2,3.2,3.2];

% Fw_FeO_max  = [7e13];
% Fw_FeCO3_max = [3e13];


t = cell(1,3);
output = cell(1,3);

pert_start = -2230e6;
pert_end = -2100e6;


for j = 1:length(Fw_FeCO3_max)


params.pertb.vars = ...
     {...
          {'f.borg', 'Gaussian', pert_start, pert_end, fborg_max(j)}
          {'Fw.FeO', 'Gaussian', pert_start, pert_end,  Fw_FeO_max(j)}
          {'Fw.FeCO3', 'Gaussian', pert_start, pert_end,  Fw_FeCO3_max(j)}
     };


 
 params.plotting.vars_2_plot =...
                     { ...
                     {'C.C'       ,'del.C'        };... 
                     {'C.Ca'      ,'del.Ca'       };...
                     {'C.SO4'       ,'del.S'        };...
                     {'C.O2'      ,'C.pCO2'       };...
                     {'M.sed_FeS2','M.sed_CaSO4'  };...
                     {'M.sed_Corg','M.sed_CaCO3'  };...
                     {'del.sed_Corg','del.sed_CaCO3'};...
                     {'M.sed_FeO', 'Fw.FeO'};...
                     {'Fw.C_volc' , 'del.C_volc'  };...
                     {'f.redox_volc_C','f.redox_volc_S'};...
                     {'Fw.FeS2'    ,'Fb.FeS2'       };...
                     {'Fw.CaCO3'  ,'Fb.CaCO3'     };...
                     {'Fw.Corg'   ,'Fb.Corg'      };...
                     {'Fw.CaSO4'  ,'Fb.CaSO4'     };...
                     {'Fw.PO4'    ,'Fb.PO4'       };...
                     {'C.pH'      ,'C.Omega'      };...
                     {'f.CP'      ,'f.borg'         };...
                     {'C.CO3'     ,'C.Alk'        };...
                     {'M.sed_FeCO3','Fw.FeCO3'    };...
                     {'Fw.O_extra' ,'R.SO'   };...
                     };
 
flags.w = .11; 
                 
flags.b = .11; 
                 

        
        
    %call the model
    [t{j},output{j},params] = Model(params,flags);
 
    %call plotting function
%     Plotting(t,output,params,flags);

    toc 
    
    
    
end


assignin('base', 'output', output)
assignin('base', 't', t)
    
%%
disp('Fb.Corg')
    trapz(t{1},output{1}{2,2}-output{1}{2,2}(1) )/1e18 
    trapz(t{2},output{2}{2,2}-output{2}{2,2}(1) )/1e18 
    trapz(t{3},output{3}{2,2}-output{3}{2,2}(1) )/1e18

disp('Fw.FeCO3')
trapz(t{1},output{1}{42,2}-output{1}{42,2}(1) )/1e18
trapz(t{2},output{2}{42,2}-output{2}{42,2}(1) )/1e18
trapz(t{3},output{3}{42,2}-output{3}{42,2}(1) )/1e18

disp('Fw.FeS2')
trapz(t{1},output{1}{30,2}-output{1}{30,2}(1) )/1e18 

%%    
hfig = figure(3);

myLineStyle = {'-.' '--' '-' };
myLineColor = {'r' 'g' 'b' };

mylinewidth = 1.5;
myfontsize = 12;

set(gcf,'PaperPositionMode','auto')
set(gcf,'InvertHardcopy','off')
set(gcf,'Color','none')

% [left bottom width height]

% AX(3) = axes('Position',[0.12 0.48 0.80 0.42]);
AX1 = axes('Position',...
    [
    0.121      0.585          0.81      0.335
    ]);
hold on

H1 = plot(t{1}/1e6,output{1}{112,2});
set(H1,'LineStyle',myLineStyle{1},'Color',myLineColor{1},'LineWidth',mylinewidth)

xlim([-2302 -2050])

H2 = plot(t{2}/1e6,output{2}{112,2});
set(H2,'LineStyle',myLineStyle{2},'Color',myLineColor{2},'LineWidth',mylinewidth)

H3 = plot(t{3}/1e6,output{3}{112,2});
set(H3,'LineStyle',myLineStyle{3},'Color',myLineColor{3},'LineWidth',mylinewidth)


xlabel('Time (Ma)')
% xlim([0 190])
ylim([-3.5 35])
set(AX1,'Color','none',...
    'YTick',[ -7 0 7 14 21 28 35])

set(AX1,'visible','off')

% AX2 = axes('Position',[0.12 0.14 0.8 0.255]);
% 
% plot(t{1}/1e6,output{1}{110,2})
% 
% xlabel('Time (Ma)')
% 
% % xlim([0 190])
% ylim([0 16])
% set(AX2,'Color','none',...
%     'YTick',[0 2 5 8 11 14 16],'YTickLabel',{0,'','', 8, '', '', 16})
% 
% box off



% cd('/Users/avivbachan/Documents/Research/Postdoc/Lomagundi_Modeling/Manuscript/PNAS/Initial_Submission/Figures')
% % 
% print -f3 -depsc -painters -loose 'Plan_Model_d34S_2.eps'   


 
end



function [params, flags] = settings



tic %print how long model run takes. 



flags.pCO2 =2;    
                    
flags.Ca  = 1;           
                   
flags.O2 = 3;    
                   
flags.SO4 = 3;     
                                   
flags.PO4  = 0;    
                    
flags.Pyr_Sed = 2;
                   
params.t.run_start = -50e6;

params.t.run_end = 300e6;

flags.k_mod = 0;   

flags.Sulf = 'on';

flags.k_WilRem = 'on';                      


flags.w = 1.3;     
        
flags.b = 1.3;      
                   
flags.pertb = 1; 

 
params.pertb.zeroing = {'Mg','K','Na','Cl'};

flags.plot = 1; 
    
flags.plotMidRun = 1;
    
params.plotting.n_subplots = [4 5];

params.plotting.vars_2_plot =...
                     { ...
                     {'C.C'       ,'del.C'        };... 
                     {'C.Ca'      ,'del.Ca'       };...
                     {'C.SO4'       ,'del.S'        };...
                     {'C.O2'      ,'C.pCO2'       };...
                     {'M.sed_FeS2','M.sed_CaSO4'  };...
                     {'M.sed_Corg','M.sed_CaCO3'  };...
                     {'del.sed_Corg','del.sed_CaCO3'};...
                     {'M.sed_FeO', 'Fw.FeO'};...
                     {'Fw.C_volc' , 'del.C_volc'  };...
                     {'f.redox_volc_C','f.redox_volc_S'};...
                     {'Fw.FeS2'    ,'Fb.FeS2'       };...
                     {'Fw.CaCO3'  ,'Fb.CaCO3'     };...
                     {'Fw.Corg'   ,'Fb.Corg'      };...
                     {'Fw.CaSO4'  ,'Fb.CaSO4'     };...
                     {'Fw.PO4'    ,'Fb.PO4'       };...
                     {'C.pH'      ,'C.Omega'      };...
                     {'f.CP'      ,'f.CS'         };...
                     {'C.CO3'     ,'C.Alk'        };...
                     {'M.sed_FeCO3','Fw.FeCO3'    };...
                     {'Fw.O_extra' ,'R.SO'   };...
                     };
 
flags.monitorNumber = 1;

flags.plottingFullScreen = 1;    

flags.FigBgColor = 'light';
                     
flags.plot_save = 0;
                
params.plotting.file_name  = 'myfile';

params.plotting.file_path  = '/some/very/long/path';               
                            
flags.plot_hold = 'hold';



end



function []= Plotting(t,output,params,flags)
%% plotting function. Called from control function
    

%check for consistency of number of plots and plotted vars
%give error if inconsistent
if (params.plotting.n_subplots(1)*params.plotting.n_subplots(2) ) ...
        < length(params.plotting.vars_2_plot) 
    error(...
    ['Lomagundi:Plotting',' The number of subplots is not' ...
    ' equal to the number of variables plotted !'] )
end

switch flags.plot %make a plot?
    
    case 1 %yes

    %check and see if a Lomagundi model plot figure already exists
    hf = findobj('type','figure','name','Lomagundi_plot_window');
      
    %if one doesn't exist 
    %or if one does exists but is to be overwritten 
    if or(isempty(hf)==1,...
          and(isempty(hf)~=1, strcmp(flags.plot_hold , 'replace' ))...
          )  
    
        %then close windows
        close all
    
        %set things up for the subplot loop
        l = params.plotting.n_subplots(1) ; %grid height
        w = params.plotting.n_subplots(2) ; %grid width
        nn = length(params.plotting.vars_2_plot); %total number of vars to plot
        
        switch flags.FigBgColor
            case 'light'
%                 FigBgColor = [0.3 0.3 0.3];
                FigBgColor = 'white';
%                 FigBgColor = 'k';
                SubPlotBgColor = 'white';
            case 'dark'
                FigBgColor = 'k';
                SubPlotBgColor = 'k';
        end 
        
        %make a new plot window in the requested monitor
        
        switch flags.plottingFullScreen
            case 1
        monitorPosition = get(0,'MonitorPosition');
        hf = figure('OuterPosition', monitorPosition(flags.monitorNumber,:),...
            'name','Lomagundi_plot_window','Color',FigBgColor); 
            case 0
                hf = figure('name','Lomagundi_plot_window','Color',FigBgColor); 
        end

        %make axes for subplots
        if nn <5 
%            ha = tight_subplot(Nh, Nw, gap, marg_h, marg_w)
            hsp = tight_subplot(l,w,[.17 .2],[.15 .1],[.12 .12]);
        else
            hsp = tight_subplot(l,w,[.05 .08],[.05 .05],[.05 .05]);
        end
        hsp = mat2cell(hsp,ones(length(hsp),1) ,1);
        set([hsp{:}],'Visible','off');
    
        
        %plot the data using loop    
        for ii = 1:(nn)            
            %number of variables to plot in one subpot (1 or 2)
            lines_num = length(params.plotting.vars_2_plot{ii});
                 
            switch lines_num
                case 1 %plot 1 variable
                    subPlotFunc1('NewPlot')
                case 2 %plot 2 variables
                    subPlotFunc2('NewPlot')                    
            end
        
        end
        
        set(hf,'UserData',{'l',l;'w',w;'nn',nn;'hsp',hsp})
        
    else  %if a figure named Lomagundi_plot_window already exists 
          %and should not be overwritten
    
        %get data from the previous figure
        hf_UserData = get(hf,'UserData');
        l  = hf_UserData{1,2};
        w  = hf_UserData{2,2};
        nn = hf_UserData{3,2};
        hsp = hf_UserData{4,2};
        
        
        %plot the new data on the previous subplot axes
        
        for ii = 1:(nn)            
            %number of variables to plot in one subpot (1 or 2)
            lines_num = length(params.plotting.vars_2_plot{ii});
            
            switch lines_num
                case 1 %plot 1 variable
                    subPlotFunc1('OverlayPlot')
                case 2 %plot 2 variables
                    subPlotFunc2('OverlayPlot')                    
            end
        
        end 
        
    
end
   

   

end



function subPlotFunc1(Flag)
                       
    axes(hsp{ii});

    varName =  params.plotting.vars_2_plot{ii}(1);

    y = myGetValue(varName{:},output); 

    
    
    switch Flag
        case 'NewPlot'
            hp = line(t,y{:},'Parent',hsp{ii},'LineWidth',1.5,...
            'LineStyle','-');  

            ylabel(params.plotting.vars_2_plot{ii},...
            'Interpreter','none')
            
            set(hsp{ii},'XColor','b','YColor','b',...
            'XTickMode','auto','XTickLabelMode','auto',...
            'YTickMode','auto','YTickLabelMode','auto',...
            'box','on','XGrid','on','YGrid','on',...
            'Visible','on','Color',SubPlotBgColor,...
            'XLim',[params.t.run_start params.t.run_end])
        
        
    
        if sum(myStrCmp(varName,...
            [params.pertb.vars{:}])) == 1
        set(hp, 'LineWidth',2,'Color','red')
        end 
        
            
        case 'OverlayPlot'

              set(hsp{ii},'XLimMode','auto','YLimMode','auto')  
              line(t,y{:},'Parent',hsp{ii},'LineStyle','-'); 
    end

    
end


function subPlotFunc2(Flag)
                        
    varName1 =  params.plotting.vars_2_plot{ii}(1);
    varName2 =  params.plotting.vars_2_plot{ii}(2);

    y1 = myGetValue(varName1{:},output);
    y2 = myGetValue(varName2{:},output);



    switch Flag
        case 'NewPlot'
            
%             [Ax,hl1,hl2] = plotyy(t,y1{:},t,y2{:});
            
            %left axis and first line
            hl1 = line(t,y1{:},'Parent',hsp{ii}(1) );
            set(hl1,'LineWidth',1.5,'LineStyle','-','Color','b')
            set(hsp{ii}(1),...
            'XColor','b','YColor','b','Color',SubPlotBgColor,...
            'XTickMode','auto','XTickLabelMode','auto',...
            'YTickMode','auto','YTickLabelMode','auto',...
            'box','on','Visible','on','XGrid','on','YGrid','on',...
            'XLim',[params.t.run_start params.t.run_end])
        

            %right axis and second line
            hsp{ii}(2) = axes('Position',get(hsp{ii}(1),'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor','b','YColor','g',...
           'XTickMode','auto','XTickLabel','',...
           'YTickMode','auto','YTickLabelMode','auto',...
           'box','off','Visible','on',...
           'XLim',[params.t.run_start params.t.run_end]);
            
       
            hl2 = line(t,y2{:},'Color','k','Parent',hsp{ii}(2));
            set(hl2,'LineWidth',1.5,'LineStyle','-','Color','g')
            
        
            set(get(hsp{ii}(1),'Ylabel'),'String',...
            params.plotting.vars_2_plot{ii}{1},...
            'Interpreter','none')

            set(get(hsp{ii}(2),'Ylabel'),'String',...
            params.plotting.vars_2_plot{ii}{2},...
            'Interpreter','none') 
        
        
        case 'OverlayPlot'
            

            set([hsp{ii}(1) hsp{ii}(2)],...
                'XLimMode','auto','YLimMode','auto')
            
            
            hl1 = line(t,y1{:},'Color','b','Parent',hsp{ii}(1));
            hl2 = line(t,y2{:},'Color','g','Parent',hsp{ii}(2));
            
            axis([hsp{ii}(1) hsp{ii}(2)],...
                'normal')
            
%             uistack(hsp{ii}(1),'bottom')
            
    end
    
    
    

    


   if and(sum(myStrCmp(varName1,...
            [params.pertb.vars{:}])) == 1, ...
        flags.pertb == 1)
        set(hl1, 'LineWidth',2,'Color','red')
   end

   if and( sum(myStrCmp(varName2,...
            [params.pertb.vars{:}])) == 1, ...
         flags.pertb == 1)
        set(hl2, 'LineWidth',2,'Color','yellow')
   end
   
end



%%save figure to directory as eps. 
switch flags.plot_save
    case 1    
    
        %%%Uncomment one or the other to use:
        
        %%print using screen size:   
        set(gcf,'PaperPositionMode','auto')
     
        %or resize figure to standard two column width (190mm) and a reasonable
        %height 
        
%         set(gcf, 'PaperUnits', 'centimeters')
%         papersize = get(gcf, 'PaperSize');
%         width = 19.0;         % Initialize a variable for width.
%         height = 15;          % Initialize a variable for height.
%         left = (papersize(1)- width)/2;
%         bottom = (papersize(2)- height)/2;
%         myfiguresize = [left, bottom, width, height];
%         set(gcf, 'PaperPosition', myfiguresize);
    
    %print figure 
%     print('-f1','-depsc','-loose', '-painters',...
%         [params.plotting.file_path params.plotting.file_name]);
end




end

function [t,output,params] = Model(params,flags)
%% This is the model function. It's called by the control function.  
% the function accepts parameters and flags from the control function and
% returns an output structure of computed variables. 
 

%% OCEAN ATM PARAMETERS
params.oc.tempi = 20; %[C] Celsius
params.oc.depth = 0;  %[m] meters
params.oc.sal = 1.035;   %[kg/L]
params.oc.Voc = 1.32e21; %[L]
params.atm.M = 1.773e20; %[mols]

%% Sedimentary Params
%Fw_Tot = 61e14 %[gr/yr]
%Sed_Tot = 25000e20 [gr]


%% SOLUBILITES
params.oc.ksp_calcite = 10^-6.37;
params.oc.kO2 = 0.00126; %[mol/L/Atm @25C]

%% MODERN RESERVOIR VALUES

%Modern oceanic values (Zeebe and Wolf-Gladrow 2001 p47)
C_mod.C = 2.0e-3;    %[mol/kg]
C_mod.Alk = 2.2e-3;  %[mol/kg]
C_mod.Ca = 10.3e-3;  %[mol/kg]
C_mod.PO4 = 0.25e-6; %[mol/kg]
C_mod.SO4 = 28.2e-3; %[mol/kg]
C_mod.Fe = 0.72e-6;  %[mol/kg]
C_mod.Mg = 53.3e-3;  %[mol/kg]
C_mod.K = 9.9e-3;    %[mol/kg]
C_mod.Na = 467.8e-3; %[mol/kg]
C_mod.Cl = 545.5e-3; %[mol/kg]
C_mod.Br = 0.8e-3;   %[mol/kg]
C_mod.F = 0.1e-3;    %[mol/kg]
C_mod.Sr = 0.1e-3;   %[mol/kg]
C_mod.O2_atm = 0.2095; %[atm]

%Modern ocean reservoir masses. 
% Multiply concentrations by salinity and volume of the ocean to get mols
M_mod = structfun(@(C_mod) C_mod*params.oc.sal*params.oc.Voc, ...
            C_mod,'UniformOutput', false);
        
%Initial mass of oxygen. Given by percent times number of mols in atmosphere        
M_mod.O2_atm = C_mod.O2_atm*params.atm.M;    

% ~~~~~~~~~~~~~~~~~~~           ~~~~~~~~~~~        
%    Calculated M_mod           G+P table 3  
%       C: 2.7324e+18           3.3e18
%     Alk: 3.0056e+18           ~
%      Ca: 1.4072e+19           1.5e19
%     PO4: 3.4155e+14           ~
%     SO4: 3.8527e+19           4.2e19
%      Fe: 9.8366e+14           ~
%      Mg: 7.2818e+19           8.2e19
%       K: 1.3525e+19           1.5e19
%      Na: 6.3911e+20           7.06e20
%      Cl: 7.4526e+20           8.24e20
%      Br: 1.093e+18            ~
%       F: 1.3662e+17           ~
%      Sr: 1.3662e+17           ~
%      O2: 3.7144e+19           3.8e19

    
       

% Initial alkalinity constant
C_mod.k_Alk = 2*C_mod.Ca - 2*C_mod.SO4 + 2*C_mod.Mg + C_mod.K + C_mod.Na...
- C_mod.Cl - C_mod.Alk;

%Initial carbonate system parameters: pCO2, pH, CO2aq, HCO3, CO3, Omega 
[C_mod.pCO2,C_mod.pH,C_mod.CO2aq,C_mod.HCO3,C_mod.CO3] = ...
    CO3eq(params.oc.tempi,params.oc.sal,params.oc.depth,C_mod.Alk,C_mod.C); 

%calcite saturation state. 
C_mod.Omega = (C_mod.Ca*C_mod.CO3)/params.oc.ksp_calcite; 

%Ion concentration products for solubilities
C_mod.ICP_NaCl  = C_mod.Na*C_mod.Cl;

C_mod.ICP_KCl   = C_mod.K*C_mod.Cl;

C_mod.ICP_MgCO3 = C_mod.Mg*C_mod.CO3; 

C_mod.ICP_MgSO4 = C_mod.Mg*C_mod.SO4;

C_mod.ICP_CaSO4 = C_mod.Ca*C_mod.SO4;

%%Sedimentary masses Phanerozoic average

%Carbon rounded a bit from Holland 1984 p363: 1.7e21 + 5.8e21  = 7.5e21 
M_mod.sed_C_tot = 7.5e21;  %[mol C]
M_mod.sed_C_org = 1.5e21;  %[mol C]
M_mod.sed_CaCO3 = 6e21;  %[mol C]


%propegate ratios of reservoirs to fluxes. 
f_mod.C = M_mod.sed_C_org / M_mod.sed_C_tot;

%Volcanic input
Fw_mod.C_volc = 6e12; %Kump and Arthur 1999
Fw_mod.C_volc_red = f_mod.C * Fw_mod.C_volc;
Fw_mod.C_volc_ox = (1 - f_mod.C) * Fw_mod.C_volc;

% C input weathering and burial fluxes 
Fw_mod.CaCO3 = 34e12; %(Kump and Arthur 99)
Fw_mod.Corg = f_mod.C/(1-f_mod.C)*Fw_mod.CaCO3;
Fb_mod.CaCO3 = Fw_mod.C_volc_ox + Fw_mod.CaCO3; %[mol/y]
Fb_mod.Corg  = Fw_mod.C_volc_red + Fw_mod.Corg ;  %[mol/y]
Fb_mod.subd_CaCO3 = Fb_mod.CaCO3 - Fw_mod.CaCO3;
Fb_mod.subd_Corg  = Fb_mod.Corg  - Fw_mod.Corg;

del_mod.epsC = 25; %(Hayes et al 1999)
del_mod.C_volc = -5;
del_mod.wC_Carb = del_mod.C_volc + f_mod.C * del_mod.epsC;
del_mod.wC_Org = del_mod.wC_Carb - del_mod.epsC; %[permil]
del_mod.bC_Carb = del_mod.wC_Carb; 
del_mod.bC_Org = del_mod.wC_Org;

%Sulfur (Hosler 1988)
%  Garrels and Perry
M_mod.sed_CaSO4  = 240e18; %[mol S]
M_mod.sed_FeS2   = 294e18; %[mol S]
M_mod.sed_S_tot  = 534e18; %[mol S]

% (Hosler 1988)
% M_mod.sed_CaSO4  = 192e18; %[mol S]
% M_mod.sed_FeS2   = 153e18; %[mol S]

%propegate ratios of reservoirs to fluxes.
f_mod.S = M_mod.sed_FeS2/ M_mod.sed_S_tot;

%Volcanic input
Fw_mod.S_volc = 1e11; %Holser et al 1988
Fw_mod.S_volc_red = f_mod.S * Fw_mod.S_volc;
Fw_mod.S_volc_ox = (1 - f_mod.S) * Fw_mod.S_volc; 

% S input weathering and burial fluxes 
Fw_mod.CaSO4 = 7.6e11; %mol [S] G+P
Fw_mod.FeS2 = f_mod.S/(1-f_mod.S)*Fw_mod.CaSO4;
Fb_mod.CaSO4 = Fw_mod.S_volc_ox + Fw_mod.CaSO4; %[mol/y]
Fb_mod.FeS2  = Fw_mod.S_volc_red + Fw_mod.FeS2 ;  %[mol/y]
Fb_mod.subd_CaSO4 = Fb_mod.CaSO4 - Fw_mod.CaSO4;
Fb_mod.subd_FeS2  = Fb_mod.FeS2  - Fw_mod.FeS2;
Fw_mod.S_tot = Fw_mod.FeS2 + Fw_mod.CaSO4;

% G+P Table 3
% Na  15e20
% K   12.97e20
% Mg  25.42e20
% Ca  49.66
% Si  220.03
% Al  56.58
% Fe  17.17
% S   4.91
% Cl  5.9
% CO3 50.84   
% Corg 10.42


Fw_mod.MgCO3 = 0;
Fb_mod.MgCO3 = 0;
Fw_mod.C_extra = 0;


%% INITIAL RESERVOIR VALUES

%need to implement: SO4, Ca, and ALK/DIC cannot be changed independently.
%Removal of all SO4 must be compensated by increased ALK. Increased Alk
%must lower Ca and increase DIC in order to maintain eq. 

% Carbon and Alkalinity   
switch flags.pCO2
    
    case 0 %pCO2 = 502 ppm 
        Ci.C = 2.0e-3; %[mol/kg]
        Ci.Alk = 2.2e-3; %[eq/kg]   
            
    case 1 %pCO2 = 2000 ppm 
        Ci.C = 5.0e-3; %[mol/kg]
        Ci.Alk = 5.2215e-3; %[eq/kg] 
        
    case 2 %pCO2 = 10800 ppm 
        Ci.C = 54.0e-3; %[mol/kg]
        Ci.Alk = 58.5e-3; %[eq/kg] 
   
    case 3 %pCO2 = 10800 ppm 
        Ci.C = 24.0e-3; %[mol/kg]
        Ci.Alk = 28e-3; %[eq/kg] 
end   
  
% Calcium  %(INITIALIZATION)
switch flags.Ca
    case 0 
        Ci.Ca = 10.3e-3; %[mol/kg]  
    case 1
        Ci.Ca = 0.13e-3; %[mol/kg]  
    case 2
         Ci.Ca = 50.0e-3; %[mol/kg]  
    case 3
         Ci.Ca = 1.03e-3; %[mol/kg]  
end

% Phosphate
switch flags.PO4
    case 0
        Ci.PO4 = 0.25e-6; %[mol/kg]   
    case 1 
        Ci.PO4 = 10*0.25e-6;
end


% sulphate  %(INITIALIZATION)
switch flags.SO4
    case 0
        Ci.SO4 = 28.2e-3; %[mol/kg]
    case 1
        Ci.SO4 = 2.82e-3; %[mol/kg]
    case 2 
        Ci.SO4 = 0.282e-3; %[mol/kg]
    case 3
        Ci.SO4 = 50e-6; %[mol/kg]
end
        
% Magnesium
Ci.Mg = 53.3e-3; %[mol/kg]

% Potassium
Ci.K = 9.9e-3; %[mol/kg]

% Sodium
Ci.Na = 467.8e-3; %[mol/kg]

% Chloride
Ci.Cl = 545.5e-3; %[mol/kg]

% Oxygen  %(INITIALIZATION)


switch flags.O2
    case 0 
        Ci.O2 = C_mod.O2_atm; %[mol fraction]
    case 1
        Ci.O2 = 0.1*C_mod.O2_atm; %[mol fraction]
    case 2 
        Ci.O2 = 0.01*C_mod.O2_atm; %[mol fraction]
    case 3
        Ci.O2 = 1e-5*C_mod.O2_atm; %[mol fraction]
end


%Iron
Ci.Fe = 6e-6 /56 * 1e3; % 6 ppm Holland. G+P give 4 ppm
%PPM -> mols: ppm / MW * 1e3 gr/kg


%% Calculate mass of reservoirs  %(INITIALIZATION)

% multiply concentrations by salinity and volume of the ocean to get mols
Mi = structfun(@(Ci) Ci*params.oc.sal*params.oc.Voc, ...
            Ci,'UniformOutput', false);

% Initial mass of oxygen. 
% Given by percent times mass of atmosphere in mols
Mi.O2 = Ci.O2*params.atm.M;



%% Calculate carbonate system parameters  %(INITIALIZATION)

% Initial alkalinity constant
Ci.k_Alk = 2*Ci.Ca - 2*Ci.SO4 + 2*Ci.Mg + Ci.K + Ci.Na - Ci.Cl - Ci.Alk;


% Initial carbonate system parameters: pCO2, pH, CO2aq, HCO3, CO3, and
% Omega, as well as RCO2. 
[Ci.pCO2,Ci.pH,Ci.CO2aq,Ci.HCO3,Ci.CO3] = ...
    CO3eq(params.oc.tempi,params.oc.sal,params.oc.depth,Ci.Alk,Ci.C); %other params

Ci.Omega = (Ci.Ca*Ci.CO3)/params.oc.ksp_calcite; %calcite saturation state. 

%% Ion concentration products for evaporite salts  %(INITIALIZATION)
Ci.ICP_NaCl  = Ci.Na*Ci.Cl;

Ci.ICP_KCl   = Ci.K*Ci.Cl;

Ci.ICP_MgCO3 = Ci.Mg*Ci.CO3; 

Ci.ICP_MgSO4 = Ci.Mg*Ci.SO4;

Ci.ICP_CaSO4 = Ci.Ca*Ci.SO4;


%% Carbon Initialization
% initial masses of crustal reservoirs 
% Mi.sed_C_tot = 7640e18; 
%1180 reduced 6460 oxidized (Holser 1988)
%Holland 1984 p363 uses similar value of 1.7e21 + 5.8e21  = 7.5e21 
%Garrels and Perry 10.42e20 + 50.84e20 = 61.26e+20 =  6.126e+21
Mi.sed_C_tot = 7.5e21; 

fi.C_sed = 0.2; 
Mi.sed_CaCO3 = (1 - fi.C_sed) * Mi.sed_C_tot;
Mi.sed_Corg =  fi.C_sed * Mi.sed_C_tot;


fi.redox_volc_C = fi.C_sed;
Fwi.C_volc = 5e12; 
%4-5e12 Holland 2009. 6e12 Kump and Arthur
Fwi.C_volc_red = fi.redox_volc_C * Fwi.C_volc;
Fwi.C_volc_ox = (1 - fi.redox_volc_C) * Fwi.C_volc;


fi.worg = fi.redox_volc_C;

% res.CaCO3 = 200e6; %[yr]
% Fwi.CaCO3 = Mi.sed_CaCO3/res.CaCO3; %[mol/y]

% res.Corg = res.CaCO3;
% Fwi.Corg = Mi.sed_Corg/res.Corg; %[mol/y]

Fwi.CaCO3 = 36e12; %40 Holland 2012 compare with Phan avg from G+P 11.84e12
%kump and Arthur 36

Fwi.Corg = fi.worg/(1-fi.worg)*Fwi.CaCO3;
%the amount of organic carbon oxidation to keep the redox balanced and 
% the isotopes at 0 permil, 



Fwi.C_extra = 0;

% initial Carbon burial fluxes
fi.borg = fi.worg;   %burial ratio same as weathering ratio same as 
% reduced component of volcanic gasses

Fbi.CaCO3 = Fwi.C_volc_ox + Fwi.CaCO3; %[mol/y]
Fbi.Corg = Fwi.C_volc_red + Fwi.Corg ;  %[mol/y]



fi.subd = fi.worg;
%subduct the difference between the weathering and burial fluxes
%ratio of subducting carbonate and organic carbon is the same as volcanic 
%gasses 
Fbi.subd_CaCO3 = Fbi.CaCO3 - Fwi.CaCO3;
Fbi.subd_Corg = Fbi.Corg - Fwi.Corg;


% phosphate:
fi.CP = 106;
Fwi.PO4 = Fbi.Corg/fi.CP; %[mol/yr]
Fbi.PO4 = Fwi.PO4; %[mol/y]






%% Sulfur: 

%SEDIMENTARY RESERVOIRS

%estimate of modern sulfide and sulfate sedimentary reservoirs 
% 153e18(Side):192(Sate) Hosler 1988 
% 294e18(Side)/240e20(Sate) Garrels and Perry

% Mi.sed_CaSO4_mod = 240e18; 
% Mi.sed_FeS2_mod  = 294e18;


%total sulfur sedimentary reservoir
% M_mod.sed_S_tot = M_mod.sed_CaSO4 + M_mod.sed_FeS2;

%Modern fraction of reduced sulfur in the crust
% fi.S_sed_mod = Mi.sed_FeS2_mod / M_mod.sed_S_tot;


switch flags.Pyr_Sed
    case 0 
        fi.S_sed = f_mod.S;
    case 1
        fi.S_sed = 0.95;
    case 2 
        fi.S_sed = 0.99;
    case 3 
        fi.S_sed = 0.999;
    case 4 
        fi.S_sed = 1;
end

Mi.sed_CaSO4  = (1 - fi.S_sed) * M_mod.sed_S_tot;
Mi.sed_FeS2   = fi.S_sed * M_mod.sed_S_tot;


switch flags.Sulf
    case 'on'

    %total SO2 contribution 
    Fwi.S_volc = 1.3e12; %1.2 - 1.3 Holland 2009 though compare with Hosler 1988: 0.2e12 
    % or Canfield 2006: 0.33-1.32. Higher values probably more appropriate for
    % early Earth


    %distribution of sulfide and sulfate in sed reservoirs likely mirrors
    %redox of volcanic input
    fi.redox_volc_S = fi.S_sed;

    Fwi.S_volc_red = fi.redox_volc_S * Fwi.S_volc; 
    Fwi.S_volc_ox = (1 - fi.redox_volc_S) * Fwi.S_volc; 

    %weathering fluxes
    %pre-anthropogenic long-term direct estimates 
    % for pyrite and sulfate weathering  (Holser 1988)
    % Fwi.FeS2_mod = 0.55e12; %[molS/yr]  (2*0.56 G+P 1973)
    % Fw_mod.CaSO4 = 0.17e12; %[mol/yr] 


    % Mi.O2_mod = 0.2095;

    % pH of pristine rainwater
    % pCO2_mod = 280e-6;

    switch flags.k_WilRem
        case 'on'

            H_mod = pristine_H(C_mod.pCO2);


            %modern pyrite oxidation rate WILLIAMSON and RIMSTIDT 1994
            k_pyr_ox_rate_mod = (10^(-8.19).* ( (C_mod.O2_atm.*params.oc.kO2).^0.5  )...
                ./( (H_mod).^0.11)) .* 31536000;

            %scaling constant of initial fluxes to modern one via mass and rate
            K_Pyr_mod = Fw_mod.FeS2 / (k_pyr_ox_rate_mod * M_mod.sed_FeS2);

            %Initial weathering [H+] 
            H_init = pristine_H(Ci.pCO2); 

            %initial state pyrite oxidation rate
            k_pyr_ox_rate_i = (10^(-8.19).* ( (Ci.O2.*params.oc.kO2).^0.5  )...
                ./(H_init.^0.11)) .* 31536000;

            %initial pyrite oxidation flux
            Fwi.FeS2 = K_Pyr_mod * Mi.sed_FeS2 * k_pyr_ox_rate_i;

            K_Pyr_i = Fwi.FeS2 / (Mi.sed_FeS2 * k_pyr_ox_rate_i);


            %initial sulfate weathering flux (modern scaled to reservoir size)
            Fwi.CaSO4   = Fw_mod.CaSO4 .* Mi.sed_CaSO4 / M_mod.sed_CaSO4;


        case 'off'

            Fwi.FeS2 = fi.redox_volc_S*Fw_mod.S_tot; 
            Fwi.CaSO4 = (1 - fi.redox_volc_S)*7.6e11;

    end



    Fbi.FeS2 = Fwi.S_volc_red + Fwi.FeS2;

    Fbi.subd_FeS2 = Fbi.FeS2  - Fwi.FeS2;


    %need to scale according to sulfate seawater for initial sulfate burial
    %rate

    Fbi.CaSO4 = Fwi.S_volc_ox + Fwi.CaSO4; 

    Fbi.subd_CaSO4 = Fbi.CaSO4 - Fwi.CaSO4;


    fi.CS = Fbi.Corg/Fbi.FeS2;

    case 'off'
        
        Fwi.S_volc = 0;
        
        fi.redox_volc_S = fi.S_sed;

        Fwi.S_volc_red = fi.redox_volc_S * Fwi.S_volc; 
        Fwi.S_volc_ox = (1 - fi.redox_volc_S) * Fwi.S_volc; 
        
        
        Fwi.FeS2 = 0; 
        Fwi.CaSO4 = 0;
        
        Fbi.FeS2 = 0; %Fwi.S_volc_red + Fwi.FeS2;

        Fbi.subd_FeS2 = 0; %Fbi.FeS2  - Fwi.FeS2;


        %need to scale according to sulfate seawater for initial sulfate burial
        %rate

        Fbi.CaSO4 = 0;%Fwi.S_volc_ox + Fwi.CaSO4; 

        Fbi.subd_CaSO4 = 0;%Fbi.CaSO4 - Fwi.CaSO4;


%         fi.CS = Fbi.Corg/Fbi.FeS2;
        
end



% initial Ca input  and output fluxes  %(INITIALIZATION)
Fwi.Ca_hyd = 0; %%though according to DePauolo 2004 2-3

        
Fwi.Ca_sil = Fbi.CaSO4 + Fbi.CaCO3 - (Fwi.CaCO3 + Fwi.CaSO4);
    


% magnesium  %(INITIALIZATION)
Fwi.MgCO3 = 0e12;
Fbi.MgSO4 = 0e12;
Fwi.MgSO4 = 0e12;
Fwi.Mg_sil = 0e12;
Fbi.Mg_hyd = Fwi.Mg_sil; %=Fwi.Ca_hyd;
Fbi.MgCO3 = Fwi.MgCO3;

% Potassium 
Fwi.K_sil = 1.2e12;
Fwi.KCl = 0.065e12;

Fbi.K_RW = Fwi.K_sil ;
Fbi.KCl = Fwi.KCl;


% Sodium  %(INITIALIZATION)
Fwi.NaCl = 3.2e12;
Fwi.Na_sil = 2.5e12;

Fbi.Na_RW = Fwi.Na_sil;
Fbi.NaCl = Fwi.NaCl;


% Chloride
Fwi.Cl_evap = Fwi.NaCl + Fwi.KCl ;
Fbi.Cl_evap = Fwi.Cl_evap;


%Fe


Mi.sed_FeCO3 = 3.5e20 .* 10;
% Fwi.FeCO3 = 2e12;
% Fbi.FeCO3 = 2e12;

Fwi.FeCO3 = 0;
Fbi.FeCO3 = 0;


% Fwi.FeCO3 = 0;
% Fbi.FeCO3 = 0;


Mi.sed_FeO = 4000e18;
% Fwi.FeO = 4.5e12;
% Fbi.FeO = 4.5e12;
Fwi.FeO = 0;
Fbi.FeO = 0;



%O2
Fwi.O_extra = 0;
% Fwi.O_prod = Fbi.Corg + 1.75*Fbi.Pyr + Fwi.O_extra;
% Fbi.O_consmp = Fwi.Corg + 1.75*Fwi.FeS2 + fi.redox_volc_C * Fwi.C_volc + ...
%                + fi.redox_mantle * Fwi.C_mantle + ...
%                1.75*fi.redox_mantle_S * Fwi.S_volc;
% 
% fi.volc_red_2_tot = ( fi.redox_volc_C * Fwi.C_volc +....
%                     1.75*fi.redox_mantle_S * Fwi.S_volc )...
%                     /Fbi.O_consmp;



%Iron
%Fwi.FeCO3 = ?
%Fwi.Fe_sil = 30e12 % Modern from G+P 1973  compare with 1.7857e+13 -
                    %5.3571e+13 [mols/yr] Holland 1984 pp 385
%Fwi.Fe_hyd = 3.5e10; [mols/yr] Holland 1984 pp 385
%Fwi.FeS2 = from above 


%Fbi.FeCO3 = ?
%Fbi.FeO = 30e12 %mols Fe from G+P. 
% Fbi.subd_Fe2O3 = 30e12; %reacts with 0.75e12 CH2O and 30e12 SiO2 to
% produce 30e12 mols/yr of FeSiO3;

%% Isotopic values of initial input fluxes  %(INITIALIZATION)


%Carbon photosynthetic fractionation 
% switch flags.deltaB
%     case 0
    deli.epsC = 25;    %[permil]
%     case 1
%     deli.epsC = 25;
%     case 2
%     % small correction (0.6 permil) is to round off epsC to 30
%     deli.epsC = -((159.5*Ci.PO4+38.39)/(Ci.CO2aq*1e6) - 33) -0.64118;
%     case 3
%     deli.epsC = -((159.5*Ci.PO4+38.39)/(Ci.CO2aq*1e6) - 33) -0.64118;
% end

%Isotopic composition of carbon fluxes %(INITIALIZATION)

%volcanic
deli.C_mantle = -5;  
deli.C_volc = deli.C_mantle;

%weathering of carbonates                     
deli.wC_Carb = deli.C_volc + fi.worg * deli.epsC; %[permil]
% deli.wC_MgCO3 =

%siderite 
% deli.FeCO3 = deli.wC_Carb;
deli.w_FeCO3 = -0.9;

%weathering of organic carbon
deli.wC_Org = deli.wC_Carb-deli.epsC; %[permil]

%another flux (by default set to zero)
deli.C_extra = -5;

%average carbon input isotope value
deli.wC_mean = (...
    Fwi.C_volc*deli.C_volc + ...
    Fwi.Corg*deli.wC_Org +...
    Fwi.C_extra*deli.C_extra +...
    Fwi.CaCO3*deli.wC_Carb...       
          ) ...
      / (Fwi.C_volc + Fwi.Corg + Fwi.CaCO3 + Fwi.C_extra);

% Initial isotopic value of burial fluxes
deli.bC_Carb = deli.wC_mean + fi.borg*deli.epsC;
deli.bC_Org = deli.bC_Carb - deli.epsC;

%for siderite set to carbonate weatherng (for now)
% deli.w_FeCO3 = deli.wC_Carb;




% Calcium isotopes relative to seawater  %(INITIALIZATION)
deli.eps_Ca = 1.2;  %[permil]
deli.Ca_hyd = -1.2;  %[permil]
deli.wCa_carb = -1.2;  %[permil]
deli.wCa_sil = -1.2;
deli.wCa_sulf = -1.2;

%average isotopic value of Ca inputs
deli.w_Ca_mean = (...
    deli.Ca_hyd*Fwi.Ca_hyd +...
    deli.wCa_sil*Fwi.Ca_sil + ...
    deli.wCa_carb*Fwi.CaCO3 +...
    Fwi.CaSO4*deli.wCa_sulf...
            ) ...
    / (Fwi.Ca_hyd+Fwi.Ca_sil+Fwi.CaCO3+Fwi.CaSO4) ;


%isotopic value of burial fluxes
deli.b_Ca_CO3 = deli.w_Ca_mean;
deli.b_Ca_SO4 = deli.w_Ca_mean;
deli.Ca_SW =  deli.b_Ca_CO3 + deli.eps_Ca;


%sulfur isotopic composition. 
%29 permil above 190 muM and linear below. Habicht et al 2002 
function eps_S = EPS_S_func(C_SO4)

    eps_S_1 = (29/190e-6) .* C_SO4(C_SO4 < 190e-6);
        
    eps_S_2 = 29 .* ones(1,length(find(C_SO4 >= 190e-6)));
    
    eps_S = [eps_S_1 , eps_S_2] ;
    
end

%set fractionation according to starting SO4 conditions
deli.eps_S = EPS_S_func(Ci.SO4);

%d34S of avg mantle sulfur dioxide 0 permil Labidi 2012
%garrels and Perry +1
deli.S_volc = +1; 

%split between reduced and oxidized sulfur sedimentary reserviors
%sulfate
deli.S_sed_CaSO4 = deli.S_volc + deli.eps_S*(Mi.sed_FeS2/M_mod.sed_S_tot);
%sulfide
deli.S_sed_FeS2 = deli.S_sed_CaSO4 - deli.eps_S;

%Pyrite oxidation has composition of pyrite reservoir
deli.w_Pyr = deli.S_sed_FeS2; 

%Sulfate weathering has composition of sulfate reservoir
deli.w_Sulf = deli.S_sed_CaSO4; 

%sulfate burial has the value of the ocean = sulfate weathering flux
deli.bS_Sulf = deli.w_Sulf;

%sulfide burial has the value of the pyrite reservoir (SO4 - eps)
deli.bS_Pyr = deli.w_Pyr;

% Mi.sed_FeS2 = 3*Mi.sed_FeS2;

%% Berner weathering params %(INITIALIZATION)
params.berner.G=3.3;
params.berner.Z=0.09;
params.berner.Zc=0.07;

%% Some other sensitivity knobs %(INITIALIZATION)

%These are paramaters that affect the exponent of the dependence so 1 is
%linear, 2 is quadratic, 3 is cubic, etc..




params.p.FwCorg_CO2  = 0.5;  %+

params.p.FwCorg_O2  = 0;   %-

params.p.Sed_Corg = 0;   %-


params.p.FwFeS2_O2 = 0.5;    %+

params.p.FwFeS2_CO2 = 0;

params.p.Sed_FeS2 = 0;


params.p.FwCaCO3 = 0.5; %+

params.p.Sed_CaCO3 = 0;


params.p.FwCaSO4 = 0;

params.p.Sed_CaSO4 = 0;


params.p.FwCaSil = 0.5;



params.p.FwMgCO3 = 1;

params.p.FwMgSO4 = 1;

params.p.FwMgSil = 1;

params.p.FwPO4   = 0.5;




par = 0;

params.p.FwPO4_RPyr    = 0;

params.p.FwCa_Sil_RPyr = par;

params.p.FwCaCO3_RPyr  = par;

params.p.FwCorg_RPyr   = par;

params.p.FwCaSO4_RPyr  = par;







params.p.w = 1; 

% --------------------- %


params.p.FbCaSO4 = .1; 

params.p.bp_Mp = 1;

params.p.FbCaCO3 = 1;   



params.p.FbMgSO4 = 1;

params.p.FbMgCO3 = 1;



params.p.CP_bP   =  1;  %-

params.p.CP_RSO   = 0.475; %+

params.p.CP_RSO4 = 0;

params.p.CP_RO2 = 0;




params.p.CS_bp  = 1;  %+

params.p.CS_RSO = 0.25;  %-

params.p.CS_SO4 = 0;

params.p.CS_RO2 = 0;


params.p.subd_Corg  = 1; %-
params.p.subd_Ccarb = 1; %-

params.p.subd_FeS2  = 1; %+
params.p.subd_CaSO4 = 1; %+



%% preallocate memory and intialize variables for solver
M = Mi;
C = Ci;
Fw = Fwi;
Fb = Fbi;
f = fi;   
del = deli;
dyy = [];
tt = [];

%Make a struct for fieldnames of other structs
Names.Fwi =  fieldnames(Fwi);

% s = whos;

%make a cell array of variable names and values
Input = myStruct2Cell(Fb,Fw,M,C,del,f);

%preallocate for output function
t1 = params.t.run_start; 
Y = []; %Cumulative solutions
T = []; %Cumulative times
plotted = 0;  %inter-run plotting counter

switch flags.plotMidRun
    case 1 
        hPlotMidRun = figure(2);
        set(hPlotMidRun,'Name','d13CRuntimeFig')
end


% nums = num2cell( ( 1:(length(Input)) )',2 );

% Input = [nums Input];

%Make a map structure of the initial input values 
% inputsMap = myMapMakerFun(Fb,Fw,M,C,del,f);

%% The perturbation %(INITIALIZATION)





switch flags.pertb
    case 0
        %do nothing
        
    

    otherwise
        
        %number of points in the interpolation
        params.pertb.n_interp = 2002;
        
        %make an equally spaced time vector. One point at the run start and
        %end and n_interp points between perturbation start and pertubation 
        %end
        
        [params.pertb.tinterp params.t.pert_start params.t.pert_end]...
            = myTinterpFun(params);
            
        
        %make an excursion function with values corresponding to the
        %interpolated time vector. 
         
        params.pertb.Finterp = myFinterpFun(params,Input);
      
    
        
%       plotyy(params.pertb.tinterp{2},params.pertb.Finterp{2},...
%       params.pertb.tinterp{1},params.pertb.Finterp{1}) 

end                       

%% the solver

%Vector of initial conditions 
ic = [ ...
Mi.C       deli.bC_Carb  Mi.Ca           deli.Ca_SW    Mi.PO4...
Mi.SO4       deli.bS_Sulf   Mi.Mg            Mi.K         Mi.Na  ...
Mi.Cl      Mi.O2         params.oc.tempi  Mi.sed_FeS2   Mi.sed_CaSO4...
Mi.sed_Corg M.sed_CaCO3   deli.bC_Org      deli.bC_Carb deli.bS_Pyr ...
0 Mi.sed_FeCO3 Mi.sed_FeO...
]; 


%non Negative boxes: 
nonNegInd = [1 3 5 6 8 9 10 11 12 13 14 15 16 17 22 23];
% nonNeg =  [];


switch flags.pertb %[SOLVER]
    
    case 0
     options = odeset('OutputFcn',@outputfun,...
        'Refine',4);   
     [t,y]=ode15s(@odefun,[params.t.run_start params.t.run_end],ic, options); 
       
    otherwise
    %need to implement loop for solver so that each perturbation start is
    %a new solver     
        
    pertStart = min(params.t.pert_start); 
%     pertEnd  =  max(params.t.pert_end); 
        
%     min_duration = min( min(params.t.pert_end) - pertStart  );    
    
    options = odeset('OutputFcn',@outputfun,...
        'InitialStep',1,'Refine',1,...
       'RelTol',1e-8, 'OutputSel', 1:length(ic) );
        
    [tsol1,ysol1]=ode15s(@odefun,[params.t.run_start pertStart],ic); %the solver up to the pertubation
    [tsol2, ysol2]=ode15s(@odefun,[pertStart params.t.run_end],ysol1(end,:), options ); %the solver after the perturbation   
    
    %concatenate the two solutions
    t = [tsol1; tsol2];
    y = [ysol1; ysol2];
    
end






function dy = odefun(t,y)  % the solver calls this function 
    
    
        
%% Initialization %(SOLVER)

%non negativity constraint on mass but not isotopic mass
% disp(y(22))


% Recalculate masses %(SOLVER)
M.C    = y(1); 
M.Ca   = y(3);
M.PO4  = y(5);
M.SO4    = y(6);
M.Mg   = y(8);
M.K    = y(9);
M.Na   = y(10);
M.Cl   = y(11);
M.O2   = y(12);
M.temp = y(13);




% Recalculate concentrations
C = structfun( @(M) M/(params.oc.sal*params.oc.Voc), ...
        M,'UniformOutput', false);
    
% Recalculate isotopic masses       %(SOLVER)
del.C  = y(2);
del.Ca = y(4);
del.S  = y(7);

del.sed_Corg = y(18);
del.sed_CaCO3 = y(19);

del.S_sed_FeS2 = y(20);
% del.sed_CaSO4 = y(21);


% del.wC_Org  = del.sed_Corg;
% del.wC_Carb = del.sed_CaCO3;





% Recalculate concentrations for non-dissolved element boxes
C.temp = y(13);
C.O2   = M.O2/params.atm.M;
M.sed_FeS2 = y(14);
M.sed_CaSO4 = y(15);
M.sed_Corg = y(16);
M.sed_CaCO3 = y(17);

M.sed_FeCO3 = y(22);
M.sed_FeO = y(23);

% Recalculate alkalinity                %(SOLVER)
C.ALK  = 2*C.Ca - 2*C.SO4 + 2*C.Mg + C.K ...
         + C.Na - C.Cl  - Ci.k_Alk; %[eq/kg]


% Recalculate carbonate system parameters

[C.pCO2,C.pH,C.CO2aq,C.HCO3,C.CO3] = ...
    CO3eq(M.temp,params.oc.sal,params.oc.depth,C.ALK,C.C) ;

C.Omega = (C.Ca*C.CO3)/params.oc.ksp_calcite; 

R.CO2 = C.pCO2 ./ Ci.pCO2;

R.pH  = C.pH ./ Ci.pH;

R.O2  = M.O2 ./ Mi.O2;

R.SO4 = M.SO4 ./ Mi.SO4;

R.SO = R.SO4 ./ R.O2;




% Recalculate ion concentration products (ICP)

ICP.NaCl = C.Na*C.Cl;

ICP.KCl   = C.K*C.Cl;

ICP.MgCO3 = C.Mg*C.CO3;

ICP.MgSO4 = C.Mg*C.SO4;

ICP.CaSO4 = C.Ca*C.SO4;

% Assign fractionation dependancies         %(SOLVER)
% switch flags.deltaB
%     case 0
        del.epsC = deli.epsC;    %[permil]
%     case 1
%         del.epsC = deli.epsC;
%     case 2
%         del.epsC = -((159.5*Ci.PO4+38.39)/...
%             (C.CO2aq*1e6) - 33) -0.64118;
%     case 3
%         del.epsC = -((159.5*C.PO4+38.39)/...
%             (C.CO2*1e6) - 33) -0.64118;
% end


%%%%%%%%%%%%%%%%


del.eps_S = EPS_S_func(C.SO4);





    
    
%% Perturbation dependencies %(SOLVER)
            
switch flags.pertb %(SOLVER)
    case 0 %do nothing
        
    otherwise  %get interpolated values for fluxes at time t
        
        
        
        %loop through all designated fluxes
        for ii = 1:length(params.pertb.vars)
            
        %interpolate value and put in dummy variable    
        interpVar = interp1(params.pertb.tinterp{ii},...
                    params.pertb.Finterp{ii},...
                    t,'pchip');
        
%       %plug value into the appropriate variable
        eval( [params.pertb.vars{ii}{1} ' = interpVar;'] );

        end
end     


%% Input flux dependancies %(SOLVER)
    
    weathering_func();    
    
    
    
    
    
%% Output flux dependencies. %(SOLVER)        

   burial_func()
    
    

    
     
%% The mass balances


%MASS AND ISOTOPE RESERVOIRS
%1. carbon box

dM.C =  Fw.CaCO3 + Fw.Corg + Fw.C_volc ...
        + Fw.MgCO3 + Fw.C_extra + Fw.FeCO3...
        - Fb.Corg - Fb.CaCO3 - Fb.MgCO3 - Fb.FeCO3; %d(MC)/dt

%2. carbon isotope box
dM.delC = (...
        Fw.C_volc   *(  del.C_volc  - del.C ) +...
        Fw.Corg     *(  del.wC_Org  - del.C ) +...
        Fw.CaCO3    *(  del.wC_Carb - del.C ) +...
        Fw.MgCO3    *(  del.wC_Carb - del.C ) +...
        Fw.C_extra  *(  del.C_extra - del.C ) +...
        Fw.FeCO3    *(  del.w_FeCO3 - del.C) ...
        - Fb.Corg   *( - del.epsC)...
        ) / M.C; %d(delC)/dt
    
%     Fw.C_mantle *(  del.C_mantle  - del.C ) +...
    



%3. Calcium box
dM.Ca = Fw.Ca_hyd + Fw.Ca_sil + Fw.CaCO3 + Fw.CaSO4...
        - Fb.CaSO4 - Fb.CaCO3 ; %d(MCa)/dt

    
%4. Calcium isotope box
dM.delCa = (...
        Fw.Ca_hyd   *( del.Ca_hyd   - del.Ca ) + ...
        Fw.Ca_sil   *( del.wCa_sil  - del.Ca ) +...
        Fw.CaCO3    *( del.wCa_carb - del.Ca ) +...
        Fw.CaSO4    *( del.wCa_sulf - del.Ca )... 
        - (Fb.CaCO3 + Fb.CaSO4 )  *( - del.eps_Ca ) ...
        ) / M.Ca; %d(delCa)/dt


%5. Phosphate box
dM.PO4 = Fw.PO4 - Fb.PO4;


%6. sulfur box
dM.SO4 =  Fw.S_volc +...
        Fw.CaSO4 + Fw.MgSO4 + Fw.FeS2 ...
        - Fb.CaSO4 - Fb.MgSO4 - Fb.FeS2;
        

%7. sulfur isotope box
dM.delS = (Fw.S_volc              *( del.S_volc - del.S ) +...
           (Fw.CaSO4 + Fw.MgSO4)  *( del.w_Sulf - del.S ) +...
           Fw.FeS2                 *( del.w_Pyr  - del.S )  ...
         - Fb.FeS2                 *( - del.eps_S ) ...
          ) / y(6);
%       Fw.S_mantle            *( del.S_mantle - del.S ) +...
    

%8. Mg box
dM.Mg =  Fw.MgCO3 + Fw.MgSO4 + Fw.Mg_sil +...
        - Fb.MgCO3 - Fb.Mg_hyd - Fb.MgSO4;


%9. K box
dM.K = Fw.K_sil + Fw.KCl - Fb.K_RW - Fb.KCl;


%10. Na box
dM.Na = Fw.Na_sil + Fw.NaCl - Fb.Na_RW - Fb.NaCl;


%11. Cl box
dM.Cl = Fw.NaCl + Fw.KCl - Fb.NaCl - Fb.KCl;


%12. Oxygen box
dM.O2 =   Fb.Corg ...
        - Fw.Corg  ...
        + 1.875*Fb.FeS2 ...
        - 1.875*Fw.FeS2 ...
        - f.redox_volc_C .* Fw.C_volc ...
        - 1.875*f.redox_volc_S  .* Fw.S_volc ...
        + Fw.O_extra  ...
        + 0.25* Fb.FeCO3 - 0.25*Fw.FeCO3...
        + 0.25*Fb.FeO - 0.25*Fw.FeO;
        

    
% - 1.875*f.redox_mantle_S  .* Fw.S_mantle ...
%     f.redox_mantle_C .* Fw.C_mantle
    
%13. temperature box
dM.temp =  0;


%14. sedimentary sulfides
dM.sed_FeS2 = Fb.FeS2 - Fw.FeS2 - Fb.subd_FeS2;

%15. sedimentary sulfate
dM.sed_CaSO4 = Fb.CaSO4 + Fb.MgSO4 ...
    - Fw.CaSO4 - Fw.MgSO4 - Fb.subd_CaSO4;


%16. sedimentary organic carbon
dM.sed_Corg = Fb.Corg - Fw.Corg - Fb.subd_Corg;

%17. sedimentary carbonate carbon
dM.sed_CaCO3 = Fb.CaCO3 - Fw.CaCO3 - Fb.subd_CaCO3;

%18 isotopic composition of sedimentary organic carbon
dM.del_sed_Corg = (  Fb.Corg .* ((del.C - del.epsC) - del.sed_Corg )) ...
                    ./ M.sed_Corg;

%19 isotopic composition of sedimentary carbonate carbon
dM.del_sed_CaCO3 = ( Fb.CaCO3.*(del.C - del.sed_CaCO3) ) ...
                    ./ M.sed_CaCO3;

                
%20 Isotopic composition of sedimentary sulfides
 dM.del_S_sed_FeS2 = Fb.FeS2 .*((del.S - del.eps_S) -...
 del.S_sed_FeS2)./M.sed_FeS2;
                
%21 Isotopic composition of sedimentary sulfates
% dM.del_sed_CaSO4 = ((Fb.CaSO4 + Fb.MgSO4).*(dM.delS - del.sed_CaSO4))...
%                    ./M.sed_CaSO4


switch flags.pertb
    case 0 
        dM.Forcing = 0;
    case 1
    %21 Input/forcing box. For stability.
    dM.Forcing = 0; %eval(params.pertb.vars{1}{1}); 
end

%22 Siderite sedimentary reservoi
dM.sed_FeCO3 = - Fw.FeCO3 + Fb.FeCO3;

%23 Ferrous iron oxidation
dM.sed_FeO = -Fw.FeO + Fb.FeO;

%zero out any boxes that you would like            
dM = myStructFun( @(X) X*0 , dM, params.pertb.zeroing);



dy = myGetValue(':',dM);
 
  
dyy = dy;
tt = t;

%non neg for sed FeCO3
if y(22)<10
    dy(22)=0;
end

%non neg for sed Fe2O3
if y(23)<10
    dy(23)=0;
end


dM;

end












%% Weathering function
function [] = weathering_func()    

switch flags.w  
    case 0 %flags.w
        %equal to initial steady state value
%         Fw = Fwi;
        
    case 'modern'    
        %equal to modern steady state value
        Fw = Fw_mod;
        
    case 0.1

        
        Fw.Ca_sil = Fwi.Ca_sil .* (R.CO2).^0.3;
        
        Fw.CaCO3  = Fwi.CaCO3 .* (R.CO2).^0.3; 
        
        Fw.PO4 = Fwi.PO4 .* (R.CO2) .^0.3;  
        
        %!
        Fw.Corg = Fwi.Corg .* (R.CO2) .^0.3;


%         Fw.Ca_sil = Fwi.Ca_sil .* (R.CO2).^0.25;
%         
%         Fw.CaCO3  = Fwi.CaCO3 .* (R.CO2).^0.25; 
%         
%         Fw.PO4 = Fwi.PO4 .* (R.CO2) .^0.25;  
%         
%         %!
%         Fw.Corg = Fwi.Corg .* (R.CO2) .^0.25;

case 0.11

        
        Fw.Ca_sil = Fwi.Ca_sil .* (R.CO2).^0.3;
        
        Fw.CaCO3  = Fwi.CaCO3 .* (R.CO2).^0.3; 
        
        Fw.PO4 = Fwi.PO4 .* (R.CO2) .^0.3;  
        
        %!
        Fw.Corg = Fwi.Corg .* (R.CO2) .^0.3;
        
        
         H = pristine_H(C.pCO2);

         k_pyr_ox_rate = (10^(-8.19).* ( (C.O2.*params.oc.kO2).^0.5  )...
        ./(H.^0.11)) .* 31536000;
    
    
        Fw.FeS2   =  K_Pyr_i .* M.sed_FeS2 .* k_pyr_ox_rate;
        
case 0.12

        
        Fw.Ca_sil = Fwi.Ca_sil .* (R.CO2).^0.3;
        
        Fw.CaCO3  = Fwi.CaCO3 .* (R.CO2).^0.3; 
        
        Fw.PO4 = Fwi.PO4 .* (R.CO2) .^0.3;  
        
        %!
        Fw.Corg = Fwi.Corg .* (R.CO2) .^0.3;
        
        Fw.FeS2 = Fwi.FeS2.*(R.O2).^(0.5).*(M.sed_FeS2./Mi.sed_FeS2);
        
        
case 0.13

        
        Fw.Ca_sil = Fwi.Ca_sil .* (R.CO2).^0.3;
        
        Fw.CaCO3  = Fwi.CaCO3 .* (R.CO2).^0.3; 
        
        Fw.PO4 = Fwi.PO4 .* (R.CO2) .^0.3;  
        
        %!
        Fw.Corg = Fwi.Corg .* (R.CO2) .^0.3;
        
        
         H = pristine_H(C.pCO2);

         k_pyr_ox_rate = (10^(-8.19).* ( (C.O2.*params.oc.kO2).^0.5  )...
        ./(H.^0.11)) .* 31536000;
    
    
        Fw.FeS2   =  K_Pyr_i .* M.sed_FeS2 .* k_pyr_ox_rate;
        


         Fw.FeCO3 = params.FeCO3_max .* R.O2.^0.5 .* (M.sed_FeCO3./Mi.sed_FeCO3);
         
         Fw.FeO = params.FeO_max .* R.O2.^0.5 .* (M.sed_FeO./Mi.sed_FeO);

              
        
    case 1 %flags.w 
        
        Fw.Ca_sil = Fwi.Ca_sil .*(R.CO2).^0.3;
        
        Fw.CaSO4 = Fwi.CaSO4 .*(R.CO2).^0.3;
        
        Fw.CaCO3  = Fwi.CaCO3.*(M.sed_CaCO3./Mi.sed_CaCO3).^0 ...
                .*(R.CO2).^0.3; 
        
        Fw.PO4 = Fwi.PO4.*(R.CO2).^0.3;  
        
            
            
    case 1.1
        
        Fw.Ca_sil = Fwi.Ca_sil .*(R.CO2).^0.3;
        
        Fw.CaCO3  = Fwi.CaCO3.*(M.sed_CaCO3./Mi.sed_CaCO3).^0 ...
                .*(R.CO2).^0.3; 
        
        Fw.PO4 = Fwi.PO4.*(R.CO2).^0.3;  
        
         
        H = pristine_H(C.pCO2);

         k_pyr_ox_rate = (10^(-8.19).* ( (C.O2.*params.oc.kO2).^0.5  )...
        ./(H.^0.11)) .* 31536000;
    
    
        Fw.FeS2   =  K_Pyr_i .* M.sed_FeS2 .* k_pyr_ox_rate;
        
        
    case 1.11
        
        Fw.Ca_sil = Fwi.Ca_sil .*(R.CO2).^0.3;
        
        Fw.CaCO3  = Fwi.CaCO3.*(M.sed_CaCO3./Mi.sed_CaCO3).^0 ...
                .*(R.CO2).^0.3; 
        
        Fw.PO4 = Fwi.PO4.*(R.CO2).^0.3;  
    
        Fw.FeS2 = Fwi.FeS2.*(R.O2).^(0.5).*(M.sed_FeS2./Mi.sed_FeS2);
              

    case 1.2
        
        Fw.Corg = Fwi.Corg .* (R.CO2) .^0.3;
        
        Fw.Ca_sil = Fwi.Ca_sil .*(R.CO2).^0.3;
        
        Fw.CaCO3  = Fwi.CaCO3.*(M.sed_CaCO3./Mi.sed_CaCO3).^0 ...
                .*(R.CO2).^0.3; 
        
        Fw.PO4 = Fwi.PO4.*(R.CO2).^0.3;  
        
         
        H = pristine_H(C.pCO2);

         k_pyr_ox_rate = (10^(-8.19).* ( (C.O2.*params.oc.kO2).^0.5  )...
        ./(H.^0.11)) .* 31536000;
    
    
        Fw.FeS2   =  K_Pyr_i .* M.sed_FeS2 .* k_pyr_ox_rate;
            
        
        Fw.FeCO3 = 3.429e11 .* R.O2.^0.5 .* (M.sed_FeCO3./Mi.sed_FeCO3) ...
            .*(R.CO2).^0; 
        
        
        Fw.FeO = 1.5e12 .* R.O2.^0.5 .* (M.sed_FeO./Mi.sed_FeO);
        
%         Fw.PO4 = Fwi.PO4.*(R.CO2).^0.25; Fw.PO4 = Fwi.PO4.*(R.CO2).^0.25;

        
%         Fw.Ca_sil = Fwi.Ca_sil .*(R.CO2).^0.25;

%         Fw.CaSO4 = Fwi.CaSO4 .* (M.sed_CaSO4./Mi.sed_CaSO4).^1 ...
%                 .*(R.CO2).^0.25;    
            
            
%         Fw.Corg = Fwi.Corg .* R.O2.^(0.5).*(M.sed_Corg./Mi.sed_Corg) .^1
%         ...
%                 .*(R.CO2).^0.25;   
            
%         Fw.Corg = Fwi.Corg .* R.O2.^(0).*(M.sed_Corg./Mi.sed_Corg) .^0
%         ...
%                 .*(R.CO2).^0;   
            
            
            
%        Fw.CaCO3  = Fwi.CaCO3.*(M.sed_CaCO3./Mi.sed_CaCO3).^1 ...
%                 .*(R.CO2).^0.25;    
        
    
             

% Fw.FeCO3 = 1e12 .* tanh( log10(R.O2) ) .* (M.sed_FeCO3./Mi.sed_FeCO3);...
% Fw.FeCO3 = 1e12 .* R.O2./(R.O2 + 1e5) .* (M.sed_FeCO3./Mi.sed_FeCO3);...

            


%         Fw.FeO = 1e13 .* R.O2.^0.5 .* (M.sed_FeO./Mi.sed_FeO);...
% %                  .*(R.CO2).^0.25;  

%         Fw.FeO = 1e15 .* tanh( log10(R.O2) ) .*
%         (M.sed_FeO./Mi.sed_FeO);...
%                  .*(R.CO2).^0.25;  
       
      
    case 1.3 %with 1.2 adding PO4 weathering and PO4 burial 

        

    Fw.FeS2 = Fwi.FeS2.*(R.O2).^(0.5).*(M.sed_FeS2./Mi.sed_FeS2);
 
    Fw.CaSO4 = Fwi.CaSO4 .* (M.sed_CaSO4./Mi.sed_CaSO4).^1 ...
                .*(R.CO2).^0.3; 

    Fw.CaCO3  = Fwi.CaCO3.*(R.CO2).^(0.3) .* (M.sed_CaCO3./Mi.sed_CaCO3);
                        
    Fw.Ca_sil = Fwi.Ca_sil.*(R.CO2).^(0.3);  
        
    Fw.PO4 = Fwi.PO4.*(R.CO2).^(0.3);    
       
    Fw.FeCO3 = 7.5e11 .* R.O2.^0.5 .* (M.sed_FeCO3./Mi.sed_FeCO3);
       
%     Fw.FeO = 2e12 .* R.O2.^0.5 .* (M.sed_FeO./Mi.sed_FeO);
       
            

    case 1.31
        
        H = pristine_H(C.pCO2);

         k_pyr_ox_rate = (10^(-8.19).* ( (C.O2.*params.oc.kO2).^0.5  )...
        ./(H.^0.11)) .* 31536000;
    
    
        Fw.FeS2   =  K_Pyr_i .* M.sed_FeS2 .* k_pyr_ox_rate;

           
%         Fw.CaCO3  = Fwi.CaCO3.*(R.CO2).^(0.3);
            
        Fw.Ca_sil = Fwi.Ca_sil.*(R.CO2).^(0.3); 
        
        Fw.PO4 = Fwi.PO4.*(R.CO2).^(0.3);
        
        
        Fw.FeO = 10e12 .*R.O2.^0.5 .* (M.sed_FeO./Mi.sed_FeO);
        
        Fw.FeCO3 = 7/6.*(Fw.FeS2 - Fwi.FeS2) + 1/3*Fw.FeO;
        
        Fw.CaCO3 = Fwi.CaCO3.*(R.CO2).^(0.3) + 1.*(Fw.FeS2 - Fwi.FeS2) ;%+ Fwi.CaCO3.*(R.CO2).^(0.3);
        

    case 1.4 
        
        H = pristine_H(C.pCO2);
        
        Fw.pyr_ox_rate = (10^(-8.19).* ( (C.O2.*params.oc.kO2).^0.5  )...
        ./(H.^0.11)) .* 31536000;
        
        Fw.FeS2   =  K_Pyr .* M.sed_FeS2 .* Fw.pyr_ox_rate;
           
        Fw.CaCO3  =  Fwi.CaCO3 .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G.*params.berner.Zc.*log(R.CO2))...
                .*(M.sed_CaCO3./Mi.sed_CaCO3)...
                ;     
       
            
        Fw.Ca_sil = Fwi.Ca_sil...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G...
                .*params.berner.Z.*log(R.CO2)).^0.65...
                ;
            
       Fw.PO4 = Fwi.PO4...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G...
                .*params.berner.Z.*log(R.CO2)).^0.65;
        
%        Fw.Corg = Fwi.Corg...
%                 .* R.O2  .^ 0.5...
%                 .*(R.CO2).^(params.berner.G.*params.berner.Z)...
%                 .*(1+params.berner.G...
%                 .*params.berner.Z.*log(R.CO2)).^0.65 ... .*
%                 (M.sed_Corg./Mi.sed_Corg) .^ params.p.Sed_Corg;
       
            
       %organic carbon oxidative weathering only above pO2>0.01PAL
       % between 2e-4 PAL and 0.01 PAL methanotrophy and thus kinetics of
       % atmospheric methane oxidation 
       if 0.002095 < C.O2 
        Fw.Corg = Fwi.Corg.* (M.sed_Corg./Mi.sed_Corg)...
                 .* R.O2  .^ 0.5;
       elseif  4.19e-5 < C.O2 < 0.002095
           Fw.Corg =  Fwi.Corg*Psi(M.O2) ;
       end
        
    case 2 %flags.w
        
        Fw.FeS2 = Fwi.FeS2 .* R.O2  ;
        Fw.PO4   = Fwi.PO4   .* R.CO2;
        
    case 2.1 %flags.w
        
        mH = 10.^ (-Ci.pH); 
        
        Fw.pyr_ox_rate = (10^(-8.19).* ( (C.O2.*params.oc.kO2).^0.5  )...
        ./(mH.^0.11)) .* 31536000;
 
    
         Fw.FeS2   =  K_Pyr .* M.sed_FeS2 .* Fw.pyr_ox_rate ...
                    .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                    .*(1+params.berner.G...
                    .*params.berner.Z.*log(R.CO2)).^0.65...
                    ;
        
        R.FwPyr = Fw.FeS2/Fwi.FeS2;
        
        
        
        Fw.PO4 = Fwi.PO4...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G...
                .*params.berner.Z.*log(R.CO2)).^0.65;
            
        Fw.Ca_sil = Fwi.Ca_sil...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G...
                .*params.berner.Z.*log(R.CO2)).^0.65...
                ;
        
        Fw.Corg = Fwi.Corg...
                .* R.O2  .^ params.p.FwCorg_O2...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G...
                .*params.berner.Z.*log(R.CO2)).^0.65 ...
                .* (M.sed_Corg./Mi.sed_Corg) .^ params.p.Sed_Corg;               
        
    case 3 %flags.w
        
        Fw.FeS2 = Fwi.FeS2 .* R.O2  ;
        Fw.PO4   = Fwi.PO4   .* R.CO2;       
        Fw.Corg = Fwi.Corg .* R.CO2 ;
        Fw.CaCO3 = Fwi.CaCO3 .* R.CO2 ;
        Fw.Ca_sil = Fwi.Ca_sil .* R.CO2 ;
        
    case 3.1      
        
        mH = 10.^ (-Ci.pH); 
        
        Fw.pyr_ox_rate = (10^(-8.19).* ( (C.O2.*params.oc.kO2).^0.5  )...
        ./(mH.^0.11)) .* 31536000;
        
        Fw.FeS2   =  K_Pyr .* M.sed_FeS2 .* Fw.pyr_ox_rate;
        
        
        
        Fw.PO4 = Fwi.PO4...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G...
                .*params.berner.Z.*log(R.CO2)).^0.65...
                ;
            
        Fw.Corg = Fwi.Corg...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G...
                .*params.berner.Z.*log(R.CO2)).^0.65 ;


        Fw.CaCO3 = ...
                Fwi.CaCO3 ...
                .*(R.CO2).^(params.berner.G.*params.berner.Z).*...
                (1+params.berner.G.*params.berner.Zc.*log(R.CO2))...
                ;



          Fw.Ca_sil = Fwi.Ca_sil...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G...
                .*params.berner.Z.*log(R.CO2)).^0.65...
                ;   
               
    case 4 %flags.w
        
        Fw.FeS2 = Fwi.FeS2 .* R.O2  ;
        Fw.PO4   = Fwi.PO4   .* R.CO2;       
        Fw.Corg = Fwi.Corg .* R.CO2 ;
        Fw.CaCO3 = Fwi.CaCO3 .* R.CO2 ;
        Fw.Ca_sil = Fwi.Ca_sil .* R.CO2 ;
        Fw.CaSO4 = Fwi.CaSO4 .* R.CO2 ;
           
    case 5 %flags.w
        
        Fw.FeS2 = Fwi.FeS2 .* R.O2  .* (M.sed_FeS2./Mi.sed_FeS2);
        Fw.PO4   = Fwi.PO4   .* R.CO2;       
        Fw.Corg = Fwi.Corg .* R.CO2 ...
                  .^ params.p.FwCorg_O2 .* (M.sed_Corg./Mi.sed_Corg);
        Fw.CaCO3 = Fwi.CaCO3 .* R.CO2 .* (M.sed_CaCO3./Mi.sed_CaCO3);
        Fw.Ca_sil = Fwi.Ca_sil .* R.CO2 ;
        Fw.CaSO4 = Fwi.CaSO4 .* R.CO2 .* (M.sed_CaSO4./Mi.sed_CaSO4);
        
    case 5.1 %flags.w
        
        Fw.FeS2   = Fwi.FeS2 .* (M.sed_FeS2./Mi.sed_FeS2) .* R.O2  .^ 1; ...
        
%         mH = 10.^ (-Ci.pH); 
         
%         Fw.pyr_ox_rate = (10^(-8.19).* ( (C.O2.*params.oc.kO2).^0.5  )...
%         ./(mH.^0.11)) .* 31536000;
         
%         Fw.FeS2   =  K_Pyr .* M.sed_FeS2 .* Fw.pyr_ox_rate;
        
        
        
        Fw.PO4   = Fwi.PO4 .* (R.CO2 );
        
        Fw.Corg   = Fwi.Corg   .* R.CO2 ...
            .* R.O2  .^ params.p.FwCorg_O2;   ...

        Fw.Ca_sil = Fwi.Ca_sil .* R.CO2 ;  
     
    case 5.2      
        
        
%         Fw.FeS2   =  Fwi.FeS2 .* (M.sed_FeS2./Mi.sed_FeS2) .* R.O2  .^ 1
%         ...
%                     .*(R.CO2).^(params.berner.G.*params.berner.Z)...
%                     .*(1+params.berner.G...
%                     .*params.berner.Z.*log(R.CO2)).^0.65;

        mH = 10.^ (-Ci.pH); 
         
        Fw.pyr_ox_rate = (10^(-8.19).* ( (C.O2.*params.oc.kO2).^0.5  )...
        ./(mH.^0.11)) .* 31536000;
         
        Fw.FeS2   =  K_Pyr .* M.sed_FeS2 .* Fw.pyr_ox_rate ...
                    .*(R.CO2).^(params.berner.G.*params.berner.Z) ...
                    .*(1+params.berner.G...
                    .*params.berner.Z.*log(R.CO2)).^0.65 ...
                    .* (M.sed_FeS2./Mi.sed_FeS2) .^ params.p.Sed_FeS2 ;


        
        
        Fw.PO4 = Fwi.PO4...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G...
                .*params.berner.Z.*log(R.CO2)).^0.65...
                ;
            
            
        Fw.Corg = Fwi.Corg...
                .* R.O2  .^ params.p.FwCorg_O2...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G...
                .*params.berner.Z.*log(R.CO2)).^0.65 ...
                .* (M.sed_Corg./Mi.sed_Corg) .^ params.p.Sed_Corg;

            
        Fw.CaCO3 = ...
                Fwi.CaCO3 ...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G.*params.berner.Zc.*log(R.CO2))...
                .* (M.sed_CaCO3./Mi.sed_CaCO3)...
                ;
            

        Fw.Ca_sil = Fwi.Ca_sil...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G...
                .*params.berner.Z.*log(R.CO2)).^0.65...
                ;   
            
            
        Fw.CaSO4 = ...
                Fwi.CaSO4 ...
                .* (M.sed_CaSO4./Mi.sed_CaSO4).^ params.p.Sed_CaSO4...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G.*params.berner.Zc.*log(R.CO2));
        
    case 6     
        Fw.FeS2 = Fwi.FeS2 .* R.O2  ;
        Fw.PO4   = Fwi.PO4   .* R.CO2;       
        Fw.Corg = Fwi.Corg .* R.CO2 ;
        Fw.CaCO3 = Fwi.CaCO3 .* R.CO2 ;
        Fw.Ca_sil = Fwi.Ca_sil .* R.CO2 ;
        Fw.CaSO4 = Fwi.CaSO4 .* R.CO2 ;
        Fw.Na_sil = Fwi.Na_sil .* R.CO2 ;
   
    case 7     
        
        Fw.FeS2   = Fwi.FeS2 .* R.O2  .^ params.p.FwFeS2_O2 ...
                           .* R.CO2 .^ params.p.FwFeS2_CO2 ...
            .* (M.sed_FeS2./Mi.sed_FeS2) .^ params.p.Sed_FeS2 ;
        
        Fw.PO4   = Fwi.PO4 .* R.CO2 .^ params.p.FwPO4;
        
        Fw.Corg   = Fwi.Corg   .* R.CO2 .^ params.p.FwCorg_CO2   ...
                               .* R.O2  .^ params.p.FwCorg_O2   ...
            .* (M.sed_Corg./Mi.sed_Corg) .^ params.p.Sed_Corg ;

        Fw.CaCO3  = Fwi.CaCO3  .* R.CO2 .^ params.p.FwCaCO3...
          .* (M.sed_CaCO3./Mi.sed_CaCO3).^ params.p.Sed_CaCO3;

        Fw.Ca_sil = Fwi.Ca_sil .* R.CO2 .^ params.p.FwCaSil ;

        Fw.CaSO4  = Fwi.CaSO4  .* R.CO2.^ params.p.FwCaSO4 ...
        .* (M.sed_CaSO4./Mi.sed_CaSO4) .^ params.p.Sed_CaSO4 ;
     
    case 7.1     
        
        
        
        mH = 10.^ (-Ci.pH); 
         
        Fw.pyr_ox_rate = (10^(-8.19).* ( (C.O2.*params.oc.kO2).^0.5  )...
        ./(mH.^0.11)) .* 31536000;
         
        Fw.FeS2   =  K_Pyr .* M.sed_FeS2 .* Fw.pyr_ox_rate ...
                          .* R.CO2 .^ params.p.FwFeS2_CO2 ...
                    .* (M.sed_FeS2./Mi.sed_FeS2) .^ params.p.Sed_FeS2 ;
        
        
%         Fw.FeS2   = Fwi.FeS2 .* R.O2  .^ params.p.FwFeS2_O2 ...
%                            .* R.CO2 .^ params.p.FwFeS2_CO2 ...
%             .* (M.sed_FeS2./Mi.sed_FeS2) .^ params.p.Sed_FeS2 ;


        Fw.PO4   = Fwi.PO4 .* R.CO2 .^ params.p.FwPO4;
        
        Fw.Corg   = Fwi.Corg   .* R.CO2 .^ params.p.FwCorg_CO2   ...
                               .* R.O2  .^ params.p.FwCorg_O2   ...
            .* (M.sed_Corg./Mi.sed_Corg) .^ params.p.Sed_Corg ;

        Fw.CaCO3  = Fwi.CaCO3  .* R.CO2 .^ params.p.FwCaCO3...
          .* (M.sed_CaCO3./Mi.sed_CaCO3).^ params.p.Sed_CaCO3;

        Fw.Ca_sil = Fwi.Ca_sil .* R.CO2 .^ params.p.FwCaSil ;

        Fw.CaSO4  = Fwi.CaSO4  .* R.CO2.^ params.p.FwCaSO4 ...
        .* (M.sed_CaSO4./Mi.sed_CaSO4) .^ params.p.Sed_CaSO4 ;
        
    case 8     
        mH = 10.^ (-Ci.pH); 
        
        Fw.pyr_ox_rate = (10^(-8.19).* ( (C.O2.*params.oc.kO2).^0.5  )...
        ./(mH.^0.11)) .* 31536000;
        
        Fw.FeS2   =  K_Pyr .* M.sed_FeS2 .* Fw.pyr_ox_rate;...
%                     .*(R.CO2).^(params.berner.G.*params.berner.Z)...
%                     .*(1+params.berner.G...
%                     .*params.berner.Z.*log(R.CO2)).^0.65... ;
        

        
        
        
        Fw.PO4 = Fwi.PO4;...
%                 .*(R.CO2).^(params.berner.G.*params.berner.Z)...
%                 .*(1+params.berner.G...
%                 .*params.berner.Z.*log(R.CO2)).^0.65;... ;
       


          Fw.Corg = Fwi.Corg;...
%                 .* R.O2  .^ params.p.FwCorg_O2... .*
%                 (M.sed_Corg./Mi.sed_Corg) .^ params.p.Sed_Corg;...
%                 .*(R.CO2).^(params.berner.G.*params.berner.Z)...
%                 .*(1+params.berner.G...
%                 .*params.berner.Z.*log(R.CO2)).^0.65 ... ;


        


          Fw.CaCO3 = Fwi.CaCO3;...
%                 .*(R.CO2).^(params.berner.G.*params.berner.Z).*...
%                 (1+params.berner.G.*params.berner.Zc.*log(R.CO2))... .*
%                 (M.sed_CaCO3./Mi.sed_CaCO3).^ params.p.Sed_CaCO3;




          Fw.Ca_sil = Fwi.Ca_sil;...
%                 .*(R.CO2).^(params.berner.G.*params.berner.Z)...
%                 .*(1+params.berner.G...
%                 .*params.berner.Z.*log(R.CO2)).^0.65;...






          Fw.CaSO4 = Fwi.CaSO4; ...
%                 .* (M.sed_CaSO4./Mi.sed_CaSO4).^ params.p.Sed_CaSO4...
%                 .*(R.CO2).^(params.berner.G.*params.berner.Z)...
%                 .*(1+params.berner.G.*params.berner.Zc.*log(R.CO2));...              

    case x %(flags.w OUTPUT RESTRUCT)
      
        %set to Berner parameterization

        %carbonates and evaporites

        ind = [2 6 9 10 13 14 16 17]; 

        for i = ind
                Fw.( Names.Fwi{i} ) = ...
                Fwi.( Names.Fwi{i} ) ...
                .*(R.CO2).^(params.berner.G.*params.berner.Z).*...
                (1+params.berner.G.*params.berner.Zc.*log(R.CO2)) ;
        end


        %silicates

        ind = [3 7 8 11 12 15]; 

        for i = ind
                Fw.( Names.Fwi{i} ) = ...
                Fwi.( Names.Fwi{i} )...
                .*(R.CO2).^(params.berner.G.*params.berner.Z)...
                .*(1+params.berner.G...
                .*params.berner.Z.*log(R.CO2)).^0.65;
        end

    case y %(flags.w OUTPUT RESTRUCT)

         
        %set proportional to pCO2

        ind = [2 3 6:17]; 

        for i = ind
              Fw.( Names.Fwi{i} ) = ...
              Fwi.( Names.Fwi{i} ).*(R.CO2.^params.p.w);  
        end        
        
    case z
                  %set proportional to pCO2 and redox

%            f.redoxC = M.sed_Corg ./ (M.sed_Corg + M.sed_CaCO3);  

        ind1 = {'Ca_sil','PO4', 'Mg_sil', 'K_sil', 'KCl',...
               'NaCl','Na_sil'};
        Fw = myStructFun( @(X) X.*(R.CO2.^params.p.w), Fwi, ind1);
%             Fw = myStructFun( @(X) X, Fwi, ind);


        ind2 = {'CaSO4','MgCO3','MgSO4'};
        Fw = myStructFun(...
        @(X) X .* M.sed_CaSO4 ./ Mi.sed_CaSO4 .* R.CO2,...
            Fw, ind2); %do not change to Fwi!!


        Fw.FeS2 = Fwi.FeS2 .* R.O2 .* (M.sed_FeS2./Mi.sed_FeS2);

        Fw.Corg = Fwi.Corg .*R.CO2  .*(M.sed_Corg./Mi.sed_Corg);

        Fw.CaCO3 = Fwi.CaCO3 .* R.CO2 .* (M.sed_CaCO3./Mi.sed_CaCO3);
        
        
        
end
    
    
    
end


%% Burial function
function  [] = burial_func() 
    
switch flags.b
    case 0 %flags.b
            %all fluxes equal to their initial values
               
%                Fb = structfun(@(X) X, ...
%                     Fbi,'UniformOutput', false);
                
%                 Fb.FeCO3 = 0;
    
    case 0.1 %flags.b

        
        
        
        
%        Fb.CaCO3 = (Fw.CaCO3 + Fw.Ca_sil);%
       
%        (Fw.C_volc + Fw.CaCO3 + Fw.Corg) - Fb.Corg -Fb.CaCO3
       
          

       Fb.Corg = f.borg .* (Fw.C_volc + Fw.CaCO3 + Fw.Corg);
       
%        Fb.CaCO3 = (Fw.Ca_sil + Fw.CaCO3 + Fw.CaSO4);
%        Fb.CaCO3 = (1-f.borg).* (Fw.C_volc + Fw.CaCO3 + Fw.Corg);

%        Fb.Corg = f.borg .* (Fw.C_volc + Fw.CaCO3 + Fw.Corg);
          
        Fb.CaCO3 = Fbi.CaCO3 * (C.Omega-1)/(Ci.Omega-1);  
        
        Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4);
        
        f.CP  = Fb.Corg./Fb.PO4;  
        
%         f.borg = Fb.Corg ./ (Fb.Corg  + Fb.CaCO3);
        
%         Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
        
%         Fb.subd_Corg  = Fbi.subd_Corg  .* M.sed_Corg  ./ Mi.sed_Corg;
% 
%         Fb.subd_CaCO3 = Fbi.subd_CaCO3 .* M.sed_CaCO3 ./ Mi.sed_CaCO3;
        
%         Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
         
%         Fb.FeCO3 =  Fbi.FeCO3.*(M.sed_FeCO3./Mi.sed_FeCO3);          


case 0.11 %flags.b

 

        Fb.Corg = f.borg .* (Fw.C_volc + Fw.CaCO3 + Fw.Corg);
          
        Fb.CaCO3 = Fbi.CaCO3 * (C.Omega-1)/(Ci.Omega-1);  
        
        Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
        
        Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4);
        
        f.CP  = Fb.Corg./Fb.PO4;  
        


    case 1 %flags.b

%        Fb.CaCO3 = (Fw.C_volc + Fw.CaCO3 + Fw.Corg) - Fb.Corg;
          
%        Fb.CaCO3 = (Fw.CaCO3 + Fw.Ca_sil) ;


%        Fb.Corg = f.borg .* (Fw.C_volc + Fw.CaCO3 + Fw.Corg);
          
        Fb.CaCO3 = Fbi.CaCO3 * (C.Omega-1)/(Ci.Omega-1);  

        
        Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4);
        
        f.CP  = Fb.Corg./Fb.PO4;  
        
        f.borg = Fb.Corg ./ (Fb.Corg  + Fb.CaCO3);
        
%         Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
        
%         Fb.subd_Corg  = Fbi.subd_Corg  .* M.sed_Corg  ./ Mi.sed_Corg;
% 
%         Fb.subd_CaCO3 = Fbi.subd_CaCO3 .* M.sed_CaCO3 ./ Mi.sed_CaCO3;
        
%         Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
         
%         Fb.FeCO3 =  Fbi.FeCO3.*(M.sed_FeCO3./Mi.sed_FeCO3);          

    case 1.1 %flags.b
        
    Fb.CaCO3 = Fbi.CaCO3 * (C.Omega-1)/(Ci.Omega-1);      
    
    Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4);
    
    f.CP = fi.CP .* (Fb.PO4./Fbi.PO4).^1;
        
    Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
    
    f.borg = Fb.Corg ./ (Fb.Corg  + Fb.CaCO3);
        
    case 1.2
        
        
        Fb.CaCO3 = Fbi.CaCO3 * (C.Omega-1)/(Ci.Omega-1);
        
        Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4);
        
        f.CP = fi.CP .* (Fb.PO4./Fbi.PO4).^1;
        
        Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
    
        f.borg = Fb.Corg ./ (Fb.Corg  + Fb.CaCO3);
        
    case 1.3 %flags.b
        
    if C.Ca.*C.SO4 < 10^-2.8041    
        
    Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
    
    else
        
        warning('sulfate supersat ocean')
    
    end
    
        
    Fb.CaCO3 = Fbi.CaCO3 * (C.Omega-1)/(Ci.Omega-1);
        
    Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4);
    
    f.CP  = Fb.Corg./Fb.PO4;
    
%     f.CP = fi.CP;
        
%     Fb.Corg = f.CP.*Fb.PO4;     

    case 1.31
        
    if C.Ca.*C.SO4 < 10^-2.8041    
        
    Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
    
    else
        
        warning('sulfate supersat ocean')
    
    end
        
    Fb.CaCO3 = Fbi.CaCO3 * (C.Omega-1)/(Ci.Omega-1);
        
    Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4);
    
    Fb.Corg = f.CP.*Fb.PO4;    
    
%     f.CP  = Fb.Corg./Fb.PO4;
    
%     Fb.Corg = Fbi.Corg + 13/6.*(Fw.FeS2 - Fwi.FeS2) ;
    
    case 1.4 %flags.b
        
    Fb.CaSO4 = Fbi.CaSO4 .* (ICP.CaSO4 ./ Ci.ICP_CaSO4).^(1);
        
    Fb.CaCO3 = Fbi.CaCO3 .* (C.Omega-1)./(Ci.Omega-1);
        
%     Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4);
    
    

%     f.CP = fi.CP;    
    
    
%     f.CP = fi.CP.* (Fb.PO4 ./ Fbi.PO4).^(1) ...
%                 .* R.SO4.^(1) ... .* R.O2.^(-1);          
    
%     f.CP(f.CP<106) = 106; %lower bound of 106
            
    f.CP  = Fb.Corg./Fb.PO4;    
    
%     Fb.Corg = f.CP.*Fb.PO4;   
    
    %positive powers make f.CS larger and Fb.FeS2 smaller negative powers
    %make f.CS smaller and Fb.FeS2 larger

%         f.CS = fi.CS;
    
%         f.CS = fi.CS .* (Fb.PO4./Fbi.PO4).^(-0) ... 
%                  .* (R.SO4).^(-0) ... .* (R.O2).^(2);             
             
             

             
%     Fb.FeS2  = Fb.Corg./f.CS;
        
%     Fb.FeS2 = Fbi.FeS2 .* (M.sed_FeS2/Mi.sed_FeS2);
    f.CS = Fb.Corg./Fb.FeS2;

    
%     Fb.FeCO3 =  Fbi.FeCO3 .*(R.O2).^(-1);% .*(M.sed_FeCO3./Mi.sed_FeCO3);
%     Fb.FeCO3 =  Fbi.FeCO3 .*(M.sed_FeCO3./Mi.sed_FeCO3);

%     
%     Fb.FeO = Fbi.FeO .* R.O2.^(-1);% .* (M.sed_FeO./Mi.sed_FeO);     
    
            
%     Fb.subd_Corg  = Fbi.subd_Corg  .* M.sed_Corg  ./ Mi.sed_Corg;
% 
%     Fb.subd_CaCO3 = Fbi.subd_CaCO3 .* M.sed_CaCO3 ./ Mi.sed_CaCO3;
%             
%     Fb.subd_FeS2 = Fbi.subd_FeS2     .* M.sed_FeS2  ./ Mi.sed_FeS2;
%             
%     Fb.subd_CaSO4 = Fbi.subd_CaSO4   .* M.sed_CaSO4 ./ Mi.sed_CaSO4;
    
    
        
%     f.redox_volc_C = Fb.subd_Corg ./ (Fb.subd_CaCO3 + Fb.subd_Corg);
%     f.redox_volc_S = Fb.subd_FeS2  ./ (Fb.subd_CaSO4  + Fb.subd_FeS2);
        
    
    case 1.5 %flags.b
        
    Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
        
    Fb.CaCO3 = Fbi.CaCO3 * (C.Omega-1)/(Ci.Omega-1);
        
    Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4);
    
    f.CP = fi.CP .* (Fb.PO4./Fbi.PO4).*(R.SO4);
        
    Fb.Corg = f.CP.*Fb.PO4;       
        
    case 1.6
        
        Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;

        Fb.CaCO3 = Fbi.CaCO3 * (C.Omega-1)/(Ci.Omega-1);

        Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4);

        f.CP = fi.CP .* (Fb.PO4./Fbi.PO4).^2;

        Fb.Corg = f.CP.*Fb.PO4;  
        
        Fb.subd_Corg  = Fbi.subd_Corg  .* M.sed_Corg  ./ Mi.sed_Corg;

        Fb.subd_CaCO3 = Fbi.subd_CaCO3 .* M.sed_CaCO3 ./ Mi.sed_CaCO3;
            
        Fb.subd_FeS2 = Fbi.subd_FeS2     .* M.sed_FeS2  ./ Mi.sed_FeS2;
            
        Fb.subd_CaSo4 = Fbi.subd_CaSO4   .* M.sed_CaSO4 ./ Mi.sed_CaSO4;
            
            
        f.redoxC = Fb.subd_Corg ./ (Fb.subd_CaCO3 + Fb.subd_Corg);
        f.redoxS = Fb.subd_FeS2  ./ (Fb.subd_CaSO4  + Fb.subd_FeS2);      
            
    case 2 %flags.b
        
            Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4).*params.p.bp_Mp;
            
            f.CP = fi.CP .* (Fb.PO4./Fbi.PO4)...
                 .^params.p.CP_bP;

            Fb.Corg = f.CP.*Fb.PO4;        

            f.CS = fi.CS;%.*(Fb.PO4./Fbi.PO4).^(-1);
            
            Fb.Pyr  = Fb.Corg./f.CS .* M.SO4./Mi.SO4;     
            
            Fb.CaCO3 = Fbi.CaCO3 * (C.Omega/Ci.Omega).^params.p.FbCaCO3;  
            
    case 3 %flags.b
        
            Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4).*params.p.bp_Mp;
            
            f.CP = fi.CP .* (Fb.PO4./Fbi.PO4)...
                 .^params.p.CP_bP;

            Fb.Corg = f.CP.*Fb.PO4;        

            f.CS = fi.CS.*(Fb.PO4./Fbi.PO4).^(-1);
            
            Fb.Pyr  = Fb.Corg./f.CS ;     
            
            Fb.CaCO3 = Fbi.CaCO3 * (C.Omega/Ci.Omega).^params.p.FbCaCO3;          
              
            Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
            
    case 4 %flags.b
        
            Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4).*params.p.bp_Mp;
            
            f.CP = fi.CP .* (Fb.PO4./Fbi.PO4)...
                 .^params.p.CP_bP;

            Fb.Corg = f.CP.*Fb.PO4;        

            f.CS = fi.CS.*(Fb.PO4./Fbi.PO4).^(-1);
            
            Fb.Pyr  = Fb.Corg./f.CS ;     
            
            Fb.CaCO3 = Fbi.CaCO3 * (C.Omega/Ci.Omega).^params.p.FbCaCO3;               
              
            Fb.CaSO4 = Fbi.CaSO4 .* (ICP.CaSO4 / Ci.ICP_CaSO4).^1;
               
            
            
            Fb.subd_Corg  = Fbi.subd_Corg  .* M.sed_Corg  ./ Mi.sed_Corg;

            Fb.subd_CaCO3 = Fbi.subd_CaCO3 .* M.sed_CaCO3 ./ Mi.sed_CaCO3;
            
            Fb.subd_FeS2 = Fbi.subd_FeS2     .* M.sed_FeS2  ./ Mi.sed_FeS2;
            
            Fb.subd_CaSo4 = Fbi.subd_CaSO4   .* M.sed_CaSO4 ./ Mi.sed_CaSO4;
            
            
            f.redoxC = Fb.subd_Corg ./ (Fb.subd_CaCO3 + Fb.subd_Corg);
            f.redoxS = Fb.subd_FeS2  ./ (Fb.subd_CaSO4  + Fb.subd_FeS2);
           
    case 5 %flags.b   
        
           Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4).^params.p.bp_Mp;
            
%             f.CP = fi.CP .* ...
%                    (Fb.PO4./Fbi.PO4).^params.p.CP_bP .* ...
%                     R.SO4 .^ params.p.CP_RSO4 .*... R.O2 .^ (-
%                     params.p.CP_RO2) .*... R.SO .^ params.p.CP_RSO;
            f.CP = fi.CP .* (Fb.PO4./Fbi.PO4).*(R.SO4);
                   
            Fb.Corg  = f.CP .* Fb.PO4; 
            
            Fb.CaCO3 = Fbi.CaCO3  .* (C.Omega./Ci.Omega)...
                .^params.p.FbCaCO3; 
            

%%%%%%%%%%%%%%%%%%            
             Fb.CaSO4 = Fbi.CaSO4  .* (ICP.CaSO4 ./ Ci.ICP_CaSO4)...
                 .^params.p.FbCaSO4;


%     omega_CaSO4 = ICP.CaSO4/10^-4.3;
%      
%     if omega_CaSO4<=1
%         Fb.CaSO4 = Fbi.CaSO4;
%     else
%         Fb.CaSO4 = Fbi.CaSO4*omega_CaSO4;
%     end

%%%%%%%%%%%%

                
            
            f.CS = fi.CS.*(Fb.PO4./Fbi.PO4).^(- params.p.CS_bp) ...
                    .*R.SO4 .^ ( - params.p.CS_SO4) .* ...
                      R.O2 .^ (  params.p.CS_RO2) .* ...
                      R.SO .^ ( - params.p.CS_RSO);
                    
                    
            Fb.Pyr  = Fb.Corg./f.CS ;  
            
            
            Fb.subd_Corg  = Fbi.subd_Corg  .* (M.sed_Corg  ./ Mi.sed_Corg).^...
            params.p.subd_Corg;
        
            Fb.subd_CaCO3 = Fbi.subd_CaCO3 .* M.sed_CaCO3 ./ Mi.sed_CaCO3.^...
            params.p.subd_Ccarb;
        
        
            Fb.subd_FeS2 = Fbi.subd_FeS2 .* (M.sed_FeS2 ./ Mi.sed_FeS2 )...
            .^params.p.subd_FeS2;
        
            Fb.subd_FeS2 = Fbi.subd_FeS2 .* M.sed_CaSO4 ./ Mi.sed_CaSO4...
            .^params.p.subd_CaSO4; 
           
        
    case 6 %flags.b
        
            Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4).^params.p.bp_Mp;
            
            f.CP = fi.CP .* ...
                    R.SO .^ params.p.CP_RSO;
                   
            Fb.Corg  = f.CP .* Fb.PO4; 
            
            Fb.CaCO3 = Fbi.CaCO3  .* (C.Omega./Ci.Omega)...
                .^params.p.FbCaCO3;
            
            
    case 6.1 %flags.b
        
        Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4).^params.p.bp_Mp;
            
        f.CP = fi.CP .* ...
                R.SO .^ params.p.CP_RSO;

        Fb.Corg  = f.CP .* Fb.PO4; 

        Fb.CaCO3 = Fbi.CaCO3  .* (C.Omega./Ci.Omega)...
                .^params.p.FbCaCO3;
        
        Fb.CaSO4 = Fbi.CaSO4  .* (ICP.CaSO4 ./ Ci.ICP_CaSO4)...
                .^0.1;    
            
    case 6.2 %flags.b
        
        Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4).^params.p.bp_Mp;
            
        f.CP = fi.CP .* ...
                R.SO .^ params.p.CP_RSO;

        Fb.Corg  = f.CP .* Fb.PO4; 

        Fb.CaCO3 = Fbi.CaCO3  .* (C.Omega./Ci.Omega)...
                .^params.p.FbCaCO3;
        
        Fb.CaSO4 = Fbi.CaSO4  .* (ICP.CaSO4 ./ Ci.ICP_CaSO4)...
                .^0.1;
            
        f.CS = fi.CS.*(Fb.PO4./Fbi.PO4).^(-1);
            
            Fb.Pyr  = Fb.Corg./f.CS ;    
            
            
    case 6.3 %flags.b
        
        Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4).^params.p.bp_Mp;
            
        f.CP = fi.CP .* ...
                R.SO .^ 2;

        Fb.Corg  = f.CP .* Fb.PO4; 

        Fb.CaCO3 = Fbi.CaCO3  .* (C.Omega./Ci.Omega)...
                .^params.p.FbCaCO3;
        
        Fb.CaSO4 = Fbi.CaSO4  .* (ICP.CaSO4 ./ Ci.ICP_CaSO4)...
                .^0.1;
            
        f.CS = fi.CS.*(Fb.PO4./Fbi.PO4).^(-1);
            
            Fb.Pyr  = Fb.Corg./f.CS ;      
            
            
        Fb.subd_Corg  = Fbi.subd_Corg  .* M.sed_Corg  ./ Mi.sed_Corg;

        Fb.subd_CaCO3 = Fbi.subd_CaCO3 .* M.sed_CaCO3 ./ Mi.sed_CaCO3;
            
        Fb.subd_Pyr = Fbi.subd_Pyr     .* M.sed_FeS2  ./ Mi.sed_FeS2;
            
        Fb.subd_Sulf = Fbi.subd_Sulf   .* M.sed_CaSO4 ./ Mi.sed_CaSO4;    
            
    
    case x  %flags.b  
            
            Fb.MgSO4 = Fbi.MgSO4 .* ICP.MgSO4 / Ci.ICP_MgSO4; 
              
            Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
              
%             Fb.Sulf = Fb.CaSO4 + Fb.MgSO4 ;
              
            Fb.CaCO3 = Fbi.CaCO3 * (C.Omega/Ci.Omega).^params.p.FbCaCO3;    
        
            Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4).*params.p.bp_Mp;
            
            f.CP = fi.CP .* (Fb.PO4./Fbi.PO4)...
                 .^params.p.CP_bP;

            Fb.Corg = f.CP.*Fb.PO4;        

            f.CS = fi.CS.*(Fb.PO4./Fbi.PO4).^(-1);
            
            Fb.Pyr  = Fb.Corg./f.CS .* M.SO4./Mi.SO4;
        
            
            
            Fb.subd_Corg  = Fbi.subd_Corg  .* M.sed_Corg ./ Mi.sed_Corg;

            Fb.subd_CaCO3 = Fbi.subd_CaCO3 .* M.sed_CaCO3 ./ Mi.sed_CaCO3;
            
            Fb.subd_Pyr = Fbi.subd_Pyr .* M.sed_FeS2 ./ Mi.sed_FeS2;
            
            Fb.subd_Sulf = Fbi.subd_Sulf .* M.sed_CaSO4 ./ Mi.sed_CaSO4;          
        
    case y  %flags.b
            
            %reverse weathering dependence on pH
            Fb.Na_RW = Fbi.Na_RW .* R.pH;
            Fb.K_RW  = Fbi.K_RW  .* R.pH;
            
            Fb.MgSO4 = Fbi.MgSO4 .* ICP.MgSO4 / Ci.ICP_MgSO4; 
            Fb.KCl   = Fbi.KCl   .* ICP.KCl   / Ci.ICP_KCl;
            Fb.NaCl  = Fbi.NaCl  .* ICP.NaCl  / Ci.ICP_NaCl;
            Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
            
            Fb.CaCO3 = Fbi.CaCO3 * (C.Omega/Ci.Omega).^params.p.FbCaCO3;
            
            %same for dolomite burial
            Fb.MgCO3 = Fbi.MgCO3 .* ICP.MgCO3 / Ci.ICP_MgCO3;
            
            Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4).*params.p.bp_Mp;

            f.CP = fi.CP .* (Fb.PO4./Fbi.PO4)...
                 .^params.p.CP_bP;
            
%             Fb.Corg = Fbi.Corg;
            Fb.Corg = f.CP.*Fb.PO4;
%             Fb.Sulf = Fb.CaSO4 + Fb.MgSO4;
            
            f.CS = fi.CS.*(Fb.PO4./Fbi.PO4).^(-1);
            Fb.Pyr  = Fb.Corg./f.CS;
            
            Fb.subd_Corg  = Fbi.subd_Corg  .* M.sed_Corg ./ Mi.sed_Corg;

            Fb.subd_CaCO3 = Fbi.subd_CaCO3 .* M.sed_CaCO3 ./ Mi.sed_CaCO3;
            
    case z  %flags.b 
             %reverse weathering dependence on pH
            Fb.Na_RW = Fbi.Na_RW .* R.pH;
            Fb.K_RW  = Fbi.K_RW  .* R.pH;
            
            %phosphate burial 1st Order Mp
            Fb.PO4 = Fbi.PO4 * (M.PO4 / Mi.PO4).^params.p.bp_Mp;
            
            %evaporite burial fluxes proportional total the change in ion
            %concentration product (ICP) to initial ICP ratio
            Fb.MgSO4 = Fbi.MgSO4 .* ICP.MgSO4 / Ci.ICP_MgSO4; 
            Fb.KCl   = Fbi.KCl   .* ICP.KCl   / Ci.ICP_KCl;
            Fb.NaCl  = Fbi.NaCl  .* ICP.NaCl  / Ci.ICP_NaCl;
            Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
            
            %same for dolomite burial
            Fb.MgCO3 = Fbi.MgCO3 .* ICP.MgCO3 / Ci.ICP_MgCO3;
            
            %hydrothermal exchange of Mg by Ca at Mid Ocean Ridges
            Fb.Mg_hyd = Fw.Ca_hyd;
            
            %burial of carbonate carbon proportional to change in Omega
            Fb.CaCO3 = Fbi.CaCO3.*(C.Omega/Ci.Omega).^params.p.FbCaCO3;
            
            %organic carbon burial
            f.CP = fi.CP .* (Fb.PO4./Fbi.PO4)...
                .*(R.SO4./R.O2).^params.p.CP_bP;
            Fb.Corg = f.CP.*Fb.PO4; %[mol/y]
            
            %burial of sulfate and pyrite
%             Fb.Sulf = Fb.CaSO4 + Fb.MgSO4;
            
            f.CS = fi.CS.*(Fb.PO4/Fbi.PO4).^(-1);
            Fb.Pyr  = Fb.Corg./f.CS;    
            
            
            
end
    
end







function status = outputfun(t,y,flag)
%% solver output function. Is called at the beginning end and every timestep
%fo the simulation. 


switch flag
    case 'init'
    %do something before the solver starts
    
    Y = ic';
    T = t(1);
    
    
    case 'done'
    %do something after the solver ends    
    if exist('hPlotMidRun');
     close(hPlotMidRun)   
    end
    
     otherwise
%         %need to implement a pause and plot button
         
        deltaT = t-t1;
        min_t_step = 1e-5;
        tElapsed = toc;
        Y = [Y  y];
        T = [T t];
        
        if  or(deltaT < min_t_step, max(y(nonNegInd,end)<0) == 1)
            status = 1;
            
            if deltaT < min_t_step
            warning(['Warning: min timestep (currrently ' ...
            num2str(min_t_step) ' yr) reached !'])
            end
            
            if max(y(nonNegInd,end)<0) == 1
                warning(['Negative Concentrations at y(', ...
                num2str(nonNegInd(y(nonNegInd,end)<0)) ,...
                ')! Simulation Terminated Prematurely'])
            end
                       
        elseif and(tElapsed > 5*plotted, flags.plotMidRun == 1) %feature('IsDebugMode')==0 &&
             figure(hPlotMidRun); plot(T,Y(2,:)); hold on;
             xlabel('Time'); ylabel('\delta^{13}C');
             drawnow
             plotted = plotted+1;
             status = 0;
             
        else
        status = 0;
        end    
        
        t1 = t;

    %%%%%%%%%%%%%%%%%%%%%%    
     %other data to be displayed during the model run 

%       disp({'Fw.C_volc', 'Fw.Corg',  'Fw.CaCO3',  'Fw.MgCO3',  'Fw.C_extra', ...
%           'Fw.FeCO3', 'Fb.Corg' })           
          
%       disp([Fw.C_volc, Fw.Corg, Fw.CaCO3, Fw.MgCO3, Fw.C_extra, Fw.FeCO3, Fb.Corg])
        

end


end
    
%% Output restructuring


%rename vars

% Rename masses
M.C    = y(:,1); 
M.Ca   = y(:,3);
M.PO4  = y(:,5);
M.SO4    = y(:,6);
M.Mg   = y(:,8);
M.K    = y(:,9);
M.Na   = y(:,10);
M.Cl   = y(:,11);

% Recalculate concentrations
C = structfun( @(M) M./(params.oc.sal.*params.oc.Voc), ...
        M,'UniformOutput', false);

% Rename isotopic masses
del.C  = y(:,2);
del.Ca = y(:,4);
del.S  = y(:,7);

% Recalculate masses and concentrations for non-dissolved element boxes
M.temp = y(:,13);
C = rmfield(C,{'temp','sed_CaCO3','sed_Corg', 'sed_FeS2','sed_CaSO4'});
M = rmfield(M,'Alk');
M.O2   = y(:,12);
C.O2   = M.O2./params.atm.M;

M.sed_FeS2 = y(:,14);
M.sed_CaSO4 = y(:,15);
M.sed_Corg = y(:,16);
M.sed_CaCO3 = y(:,17);

del.sed_Corg  = y(:,18);
del.sed_CaCO3 = y(:,19);

del.S_sed_FeS2 = y(:,20);

M.sed_FeCO3 = y(:,22);
% M.sed_FeCO3(M.sed_FeCO3<0) = 0;

M.sed_FeO = y(:,23);

onest = ones(length(t),1);

% Recalculate alkalinity
C.Alk  = 2*C.Ca - 2*C.SO4 + 2*C.Mg + C.K ...
         + C.Na - C.Cl - Ci.k_Alk*onest; %[eq/kg]
    
% Recalculate carbonate system parameteres
[C.pCO2,C.pH,C.CO2aq,C.HCO3,C.CO3,C.Omega] = deal(zeros(length(C.Alk),1));

for i = 1:length(C.Alk),
    
    [C.pCO2(i),C.pH(i),C.CO2aq(i),C.HCO3(i),C.CO3(i)] = ...
        CO3eq(M.temp(i),params.oc.sal,params.oc.depth,C.Alk(i),C.C(i)); 
    
    C.Omega(i) = (C.Ca(i) .* C.CO3(i) )./params.oc.ksp_calcite; 
    
end

R.CO2 = C.pCO2./Ci.pCO2;

R.pH  = C.pH./Ci.pH;

R.O2  = M.O2./Mi.O2;

R.SO4 = M.SO4./Mi.SO4;

R.SO = R.SO4 ./ R.O2;


% Recalculate ion concentration products (ICP)

ICP.NaCl = C.Na.*C.Cl;

ICP.KCl   = C.K.*C.Cl;

ICP.MgCO3 = C.Mg.*C.CO3;

ICP.MgSO4 = C.Mg.*C.SO4;

ICP.CaSO4 = C.Ca.*C.SO4;


% Assign fractionation dependancies (OUTPUT RESTRUCT)
% switch flags.deltaB
%     case 0
        del.epsC = deli.epsC;    %[permil]
%         del.bC_org = del.bC_Carb - epsC;
%         
%     case 1
%         del.epsC = deli.epsC;
% %         delborg = (1-params.fexternal)*(delbcarb - epsC) ...
% %             + params.fexternal*params.delexternal;
%         
%     case 2
%         del.epsC = -((159.5*Ci.PO4+38.39)./...
%             (C.CO2aq*1e6) - 33) -0.64118;
% %         delborg = delbcarb - epsC;
%         
%     case 3
%         del.epsC = -((159.5*C.PO4+38.39)./...
%             (C.CO2*1e6) - 33) -0.64118;
% %         delborg = delbcarb - epsC;
%         
% end


%%%%%%%%%%
deli.eps_S = EPS_S_func(Ci.SO4);

%%%%%%%%%%%%


%forcing
switch flags.pertb %(OUTPUT RESTRUCT)       
    case 0

        Fw = structfun(@(X) X.*ones(length(t),1), ...
                Fwi,'UniformOutput', false);

    otherwise  %get interpolated values for fluxes at time t

        %loop through all designated fluxes
        for iii = 1:length(params.pertb.vars)

        %interpolate value and put in dummy variable    
        interpVar = interp1(params.pertb.tinterp{iii},...
                params.pertb.Finterp{iii},...
                t,'pchip');

       %plug value into the appropriate variable
        eval( [params.pertb.vars{iii}{1} ' = interpVar;'] );
        end

end    


%call the weathering function
weathering_func();


%call the burial function
burial_func();

    
   


   
% A few more things to calculate
del.wC_mean = (...
    Fw.C_volc.*del.C_volc + ...
    Fw.Corg.*del.wC_Org +...
    Fw.C_extra.*del.C_extra +...
    Fw.CaCO3.*del.wC_Carb...       
          ) ...
      ./ (Fw.C_volc + Fw.Corg + Fw.CaCO3 + Fw.C_extra);

del.bC_mean = ( Fb.CaCO3.*del.bC_Carb + Fb.Corg.*del.bC_Org )...
               ./(Fb.Corg+Fb.CaCO3);

% f.borg=Fb.Corg./(Fb.Corg+Fb.CaCO3);



f.CO2O = R.CO2./R.O2;




%some of the components should be expressed in mM
C = myStructFun( @(X) X*1e3 , C, 1:9  );


%put all the various components into one struct
output = myStruct2Cell(Fb,Fw,M,C,del,f,R);


%find all singleton values and expand them to length t

for i =  1:length(output(:,2)),
    LL =  length([output{i,2}] ); 
    switch LL
        case 1 
            output{i,2} = output{i,2}*ones(length(t),1);
    end
end

%output vars to base workspace
assignin('base','Fb',Fb)
assignin('base','Fbi',Fbi)
assignin('base','Fw',Fw)
assignin('base','Fwi',Fwi)
assignin('base','M',M)
assignin('base','Mi',Mi)
assignin('base','C',C)
assignin('base','Ci',Ci)
assignin('base','del',del) 
assignin('base','deli',deli) 
assignin('base','f',f)
assignin('base','fi',fi)
assignin('base','R',R)
assignin('base','ICP',ICP)
assignin('base','C_mod',ICP)


assignin('caller','Fb',Fb)
assignin('caller','Fbi',Fbi)
assignin('caller','Fw',Fw)
assignin('caller','Fwi',Fwi)
assignin('caller','M',M)
assignin('caller','Mi',Mi)
assignin('caller','C',C)
assignin('caller','Ci',Ci)
assignin('caller','del',del) 
assignin('caller','deli',deli) 
assignin('caller','f',f)
assignin('caller','fi',fi)
assignin('caller','R',R)
assignin('caller','ICP',ICP)
assignin('caller','C_mod',ICP)

  
end    
    
function [ pco2,pH,co2,hco3,co3 ] = CO3eq( temp,s,z,alk,dic )
%CO3eq calculates carbonate system parameters from alkalinity and DIC. 
%Modified from Chemical Oceanography and the Marine Carbon Cycle by Emerson
%and Hedges p129 and R. Zeebe's csys code
%%
%inputs 
% temp degC 
% salinity in kg/L 
% depth in m 
% alk in eq/kg 
% dic in mol/kg
% outputs co3 hco3 co2 in mol/kg


% Test parameters.
% Simply uncomment and run in cell mode (ctrl+enter) to see outputs
% temp=20; %[degC] 
% s=1.035;%[kg/L]
% z=0; %[m]
% alk=2.2e-3 ;%[eq/kg]
% dic=2.0e-3 ;%[mol/kg]

%params
s=s*1e3-1e3;
t=temp+273.15; 
Pr=z/10;     
R=83.131;
tbor=0.000416*s/35.0;

%constants
U1=-60.2409+93.4517*(100/t)+23.3585*log(t/100);
U2=s*(0.023517-0.023656*(t/100)+0.0047036*(t/100)^2);
KH=exp(U1+U2);
KB=exp((-8966.9-2890.53*s^0.5-77.942*s+1.728*s^1.5-0.0996*s^2)/t...
    +148.0248+137.1942*s^0.5+1.62142*s-(24.4344+25.085*s^0.5+...
    0.2474*s)*log(t)+0.053105*s^0.5*t);
K1=10^(-(3633.86/t-61.2172+9.67770*log(t)-0.011555*s+0.0001152*s^2));
K2=10^(-(471.78/t+25.9290-3.16967*log(t)-0.01781*s+0.0001122*s^2));
dvB= -29.48+0.1622*temp-0.002608*(temp)^2;
dv1=-25.20+0.1271*temp;
dv2=-15.82-0.0219*temp;
dkB=-0.00284;
dk1=-0.00308+0.0000877*temp;
dk2=0.00113-0.0001475*temp;
KB=(exp(-(dvB/(R*t))*Pr+(0.5*dkB/(R*t))*Pr^2))*KB;
K1=(exp(-(dv1/(R*t))*Pr+(0.5*dk1/(R*t))*Pr^2))*K1;
K2=(exp(-(dv2/(R*t))*Pr+(0.5*dk2/(R*t))*Pr^2))*K2;
KW1=148.96502-13847.26/t-23.65218*log(t);
KW2=(118.67/t-5.977+1.0495*log(t))*s^0.5-0.01615*s;
KW=exp(KW1+KW2);

%solve for H ion
a1=1;
a2=(alk+KB+K1);
a3=(alk*KB-KB*tbor-KW+alk*K1+K1*KB+K1*K2-dic*K1);
a4=(-KW*KB+alk*KB*K1-KB*tbor*K1-KW*K1+alk*K1*K2+KB*K1*K2-dic*KB*K1-2*dic*K1*K2);
a5=(-KW*KB*K1+alk*KB*K1*K2-KW*K1*K2-KB*tbor*K1*K2-2*dic*KB*K1*K2);
a6=-KB*KW*K1*K2;
p=[a1 a2 a3 a4 a5 a6];


r=roots(p);
% dbstop if error


h=max(real(r));

%Calculate HCO3, CO3 ,CO2aq [mol/kg], and pCO2 [microatm]  
% format short g;
hco3=dic/(1+h/K1+K2/h);
co3=dic/(1+h/K2+h*h/(K1*K2));
co2=dic/(1+K1/h+K1*K2/(h*h));



pH=-log10(h);
pco2=1e6*co2/KH;

%check the calculations
% BOH4=KB*tbor/(h+KB);
% OH=KW/h;
% Ct=(hco3+co3+co2);
% At=(hco3+2*co3+BOH4+OH-h);
end


function H = pristine_H(pCO2)  
%calculates the pH of rainwater in equillibrium with CO2

kH = 10^(-1.47); k1 = 10^(-6.35); k2  = 10^(-10.33); kw = 10^(-14);
for i = 1:length(pCO2)
coefs_pH = [ 1, 0 , -(pCO2(i) * k1* kH) - kw , -2*(pCO2(i) * k2* k1* kH) ] ;
HH = roots(coefs_pH);
H(i) =  real(HH(HH>0)) ;
end

H = H';

end

function F = Psi(O2)

psi = log10(O2);

a1 =0.0030;
a2 =-0.1655;
a3 =3.2305;
a4 = -25.8343;
a5 = 71.5398;

F = 10.^(a1*psi.^4 + a2*psi.^3 + a3*psi.^2 + a4*psi + a5);

end

function F = Omega(O2)

d_delta = 2.73e17;

d_gamma = 1.36e19;

F = (1 - O2/(d_gamma + O2)).*(1 - O2/(d_delta + O2));


end

function [Y_struct] = myStructFun(fun,X_struct,ind)
% applies the function to the struct using the index given. Index can
% string or numeric

if iscell(ind) == 1 

Names = fieldnames(X_struct);

logical_ind = zeros(size(Names));

for i = 1:length(ind)
logical_ind_0 = strcmp(ind{i},Names);
logical_ind = logical_ind + logical_ind_0;
end

num_ind = find(logical_ind);

X_cell= struct2cell(X_struct);

Y_cell = cellfun( fun , ...
        X_cell(num_ind),'UniformOutput', false);

X_cell(num_ind) = Y_cell;
    

Y_struct = cell2struct(X_cell, Names, 1); 


    
    
    
elseif isnumeric(ind) == 1

Names = fieldnames(X_struct);

X_cell= struct2cell(X_struct);


Y_cell = cellfun( fun , ...
        X_cell(ind),'UniformOutput', false);

X_cell(ind) = Y_cell;
    

Y_struct = cell2struct(X_cell, Names, 1);    





else
    
    error('Lomagundi:myStructFun',...
        ['Invalid struct field.\n Must be' ...
        'names in cell array or numbers in numeric array'])

end


% clear ind X_struct fun


end

function [cell_out] = myStruct2Cell(varargin)
%takes a struct (or structs) and returns a cell array with two columns. 
% The first has the struct and field names and the other the fields data. 

    cell_out = cell(1,2);
    
%     cell_out = cell( ,2)

for i = 1:nargin

    field_names = fieldnames(varargin{i});

    struct_name = inputname(i);

    combined_names = strcat(struct_name,'.',field_names);

    combined_cell = [combined_names,struct2cell(varargin{i})];

    cell_out = [cell_out ; combined_cell ];
end
    
    cell_out(1,:) = [];

end

function [tinterp t_perturbation_start t_perturbation_end] ...
    = myTinterpFun(params)
% function produces interpolated time vector for forcing fluxes


var_names = ...
    cellfun(@(x) x{1}, params.pertb.vars, 'UniformOutput',false);



multi_ex_ind = length(unique(var_names)) == length(var_names);


switch multi_ex_ind
    case 1

    L = length(params.pertb.vars);

    tinterp = cell(1,L);

    t_perturbation_start = zeros(1,L); 

    t_perturbation_end = zeros(1,L);

    n = params.pertb.n_interp;

    for i = 1:L

    t_perturbation_start(i) = params.pertb.vars{i}{3};


    if isempty(params.pertb.vars{i}{4}) ==1 
        t_perturbation_end(i)  = params.t.run_end;

    tinterp{i} =    [ params.t.run_start...
                    linspace( t_perturbation_start(i),...
                              t_perturbation_end(i),n+1)...
                      ];

    else
        t_perturbation_end(i) = params.pertb.vars{i}{4};


    tinterp{i} =    [ params.t.run_start...
                    linspace( t_perturbation_start(i),...
                              t_perturbation_end(i),n)...
                     params.t.run_end ];
    
                              
                 
    end  
    
    

    end

    case 0
        
    
end

end

function [Finterp] = myFinterpFun(params,Input)
%function accepts Input and perturbation definitions and produces an
%apropriately interpolated flux
    
L = length(params.pertb.vars);

Finterp = cell(1,L);

n = params.pertb.n_interp;




for i = 1:L   

varName = params.pertb.vars{i}{1};    

pertShape = params.pertb.vars{i}{2};

% varValue = inputsMap.values(varName);
varValue = myGetValue(params.pertb.vars{i}{1},Input);

amount = params.pertb.vars{i}{5};

    if abs(amount)<1000
        amount_type = 'multiplier';
    elseif abs(amount) >= 1000
        amount_type = 'amount';
    else error('Lomagundi:myFinterp','invalid amount specified')

    end

pert_mean = 0;%mean( [params.t.pert_start(i),...
%         params.t.pert_end(i) ] );

pert_std = 1;%pert_mean/10;%/log10(pert_mean);

X = linspace(-4,4,n);
% linspace(params.t.pert_start(i),...
%             params.t.pert_end(i),n);




switch amount_type
    
    case 'multiplier'
    
    switch pertShape
        
        case 'Gaussian'

            Finterp{i} = [...
                        varValue{1} ... 
                        varValue{1} ... 
                        varValue{1} *...
                        (1+ amount *...
                        normpdf(linspace(-4,4,n-1),...
                        pert_mean, pert_std)/...
                        max(...
                            normpdf(linspace(-4,4,n-1),...
                            pert_mean, pert_std))...
                            )...
                        varValue{1}...
                        ];

            
        case 'Sigmoidal'
            Finterp{i} =  [ varValue{1}, varValue{1}, ... 
                        [varValue{1} + ...
                        (varValue{1}* amount *...
                        normcdf(linspace(-4,4,n),0,1))...
                        ]];

%             Finterp{i} = [Finterp{i} Finterp{i}(end)];
        
        case 'Flat'
            Finterp{i} =  varValue{1} *...
                          ones(1,n+2 );
                      
        case 'Step'
            Finterp{i} =  [ varValue{1} ... 
                        varValue{1} ...
                        varValue{1} * amount *...
                        ones(1,n) ];     
        

    end
    
    
    
    case 'amount'  
            
    switch pertShape
            
        case 'Gaussian'

            Finterp{i} = [...
                        varValue{1} ... 
                        varValue{1} ...
                        varValue{1} + ...
                        (amount *...
                        normpdf(linspace(-4,4,n-2),...
                        pert_mean, pert_std)/...
                        max(...
                            normpdf(linspace(-4,4,n-2),...
                            pert_mean, pert_std))...
                            )...
                        varValue{1}...
                        varValue{1}...
                        ];
            
                     
         case 'Sigmoidal'
            Finterp{i} =  [ varValue{1} ... 
                      varValue{1} (varValue{1} + ...
                        amount *...
                        normcdf(linspace(-4,4,n),0,1) )...
                        ];
                    
                    
                    

%             Finterp{i} = [Finterp{i} Finterp{i}(end)];
        
        case 'Flat'
            Finterp{i} =  varValue{1} *...
                          ones(1,n+2 );
        case 'Step'
            Finterp{i} =  [ varValue{1} ... 
                        varValue{1} ...
                        varValue{1} + amount *...
                        ones(1,n) ];
                                
                      
                      
    end


end
    
    
            
end


end

function [value] = myGetValue(name,input)
%extracts value from cell array or struct
% acording to variable name or number

if iscell(input) == 1;

    if ischar(name) == 1; %variable name is string

        %if the string is characters
        value = input(strcmp(name,input(:,1)),2);


    elseif isnumeric(name) ==1; %variable name is numeric
        value = input(name,2);


    elseif strcpm(char(58),name)
        value = input(:,2);
    end

elseif isstruct(input)

%     if ischar(name) == 1; %variable name is string
%     
%     %if the string is characters
%     value = cell(strcmp(name,input(:,1)),2);
%     
% 
% elseif isnumeric(name) ==1; %variable name is numeric
%     value = input(name,2);


if  strcmp(char(58),name) == 1
    value = struct2cell(input);
    value = [value{:}]';
end
    
end


if isempty(input) == 1
 cprintf('-comment' , 'CODE ERROR:\n'  )
    
    error('Lomagundi:myGetValue',...
        'Invalid variable name or number.\n Must be in list')
end
 

end

function [logical_ind] = myStrCmp(cellA,cellB)
% finds all occurrences of elements in string array A within string array B

logical_ind = zeros(size(cellB));

for i = 1:length(cellA)
logical_ind_0 = strcmp(cellA{i},cellB);
logical_ind = logical_ind + logical_ind_0;
end




end

function [x] = non_neg(x)
%if x is negative returns zero
%else returns x

 
    x(x<0) = 0;

    
end

function ha = tight_subplot(Nh, Nw, gap, marg_h, marg_w)

% tight_subplot creates "subplot" axes with adjustable gaps and margins
%
% ha = tight_subplot(Nh, Nw, gap, marg_h, marg_w)
%
%   in:  Nh      number of axes in hight (vertical direction)
%        Nw      number of axes in width (horizontaldirection)
%        gap     gaps between the axes in normalized units (0...1)
%                   or [gap_h gap_w] for different gaps in height and width 
%        marg_h  margins in height in normalized units (0...1)
%                   or [lower upper] for different lower and upper margins 
%        marg_w  margins in width in normalized units (0...1)
%                   or [left right] for different left and right margins 
%
%  out:  ha     array of handles of the axes objects
%                   starting from upper left corner, going row-wise as in
%                   going row-wise as in
%
%  Example: ha = tight_subplot(3,2,[.01 .03],[.1 .01],[.01 .01])
%           for ii = 1:6; axes(ha(ii)); plot(randn(10,ii)); end
%           set(ha(1:4),'XTickLabel',''); set(ha,'YTickLabel','')

%downloaded from Matlab Central on April 1st. 
% Pekka Kumpulainen 20.6.2010   @tut.fi
% Tampere University of Technology / Automation Science and Engineering


if nargin<3; gap = .02; end
if nargin<4 || isempty(marg_h); marg_h = .05; end
if nargin<5; marg_w = .05; end

if numel(gap)==1; 
    gap = [gap gap];
end
if numel(marg_w)==1; 
    marg_w = [marg_w marg_w];
end
if numel(marg_h)==1; 
    marg_h = [marg_h marg_h];
end

axh = (1-sum(marg_h)-(Nh-1)*gap(1))/Nh; 
axw = (1-sum(marg_w)-(Nw-1)*gap(2))/Nw;

py = 1-marg_h(2)-axh; 

ha = zeros(Nh*Nw,1);
ii = 0;
for ih = 1:Nh
    px = marg_w(1);
    
    for ix = 1:Nw
        ii = ii+1;
        ha(ii) = axes('Units','normalized', ...
            'Position',[px py axw axh], ...
            'XTickLabel','', ...
            'YTickLabel','');
        px = px+axw+gap(2);
    end
    py = py-axh-gap(1);
end

end








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%~~~~~~~~~~~~~~~~~~~~~~~~~~~Code detritus~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%
% function [pco2, pH, omega] = CO3eq_plus_D(TA,TS)
% %CO3eq calculates carbonate system parameters from alkalinity total concentrations of dissolved species (TC,TS,TNH3,TP,TNO3,TNO2,TSi,Ca). 
% %Modified from Soetart et al 2007, with additional help from Chemical Oceanography and the Marine Carbon Cycle by Emerson
% %and Hedges p129 and CO2 in seawater: equilibrium, kinetics, isotopes by Zeebe
% %and Wolf - Gladrow. 
% %
% %inputs 
% %alk in meq/kg 
% %dic in mmol/kg
% % 
% %outputs co3 mmol/kg
% %and pCO2 in ppmv 
% 
% %%
% % TA = TA *1e-3; %mM to M
% % TS = TS *1e-3;
% 
% 
% TA = 2300e-6;
% Ca = 10.3e-3; %[mol/kg] %for Omega
% TP = 2e-6;
% TNO3 = 31e-6;
% TNO2 = 0.1e-6;
% TNH3 = 1.0e-6;
% TSi = 4.0e-6;
% TS = 0.1e-6;
% TC = 2.0e-3;
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% temp = 25; %[C] Celsius
% z = 0;
% s=1.035;   %[kg/L]
% 
% 
% %Assuming constant ratio to salinity 
% TB = 0.000416*s/1.035;
% TF = 68e-6*s/1.035;
% TSO4 = 28235e-6*s/1.035;
% 
% %%% Conversions 
% s=s*1e3-1e3;
% t=temp+273.15; 
% Pr=z/10;     
% R=83.131;
% 
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %Equilibrium constants Millero 1995
% 
% %Hydrogen
% U1=-60.2409+93.4517*(100/t)+23.3585*log(t/100);
% U2=s*(0.023517-0.023656*(t/100)+0.0047036*(t/100)^2);
% KH=exp(U1+U2);
% 
% %Water
% KW1=148.96502-13847.26/t-23.65218*log(t);
% KW2=(118.67/t-5.977+1.0495*log(t))*s^0.5-0.01615*s;
% KW=exp(KW1+KW2);
% 
% %Borate
% KB=exp((-8966.9-2890.53*s^0.5-77.942*s+1.728*s^1.5-0.0996*s^2)/t...
%     +148.0248+137.1942*s^0.5+1.62142*s-(24.4344+25.085*s^0.5+...
%     0.2474*s)*log(t)+0.053105*s^0.5*t);
% dvB= -29.48+0.1622*temp-0.002608*(temp)^2;
% dkB=-0.00284;
% KB=(exp(-(dvB/(R*t))*Pr+(0.5*dkB/(R*t))*Pr^2))*KB;
% 
% %Carbonate
% K1=10^(-(3633.86/t-61.2172+9.67770*log(t)-0.011555*s+0.0001152*s^2));
% K2=10^(-(471.78/t+25.9290-3.16967*log(t)-0.01781*s+0.0001122*s^2));
% dv1=-25.20+0.1271*temp;
% dv2=-15.82-0.0219*temp;
% dk1=-0.00308+0.0000877*temp;
% dk2=0.00113-0.0001475*temp;
% KC1=(exp(-(dv1/(R*t))*Pr+(0.5*dk1/(R*t))*Pr^2))*K1;
% KC2=(exp(-(dv2/(R*t))*Pr+(0.5*dk2/(R*t))*Pr^2))*K2;
% 
% %Calcite
% Kcal = 10.^(-171.9065-0.077993*t+2839.319/t+71.595*log10(t)+...
%     (-0.77712+0.0028426*t +178.34/t)*realsqrt(s)...
%     - 0.07711*s+0.0041249*s^1.5);
% dvcal=-48.76+0.5304*temp;
% dkcal=0.001176+0.0003692*temp;
% Kcal=(exp(-(dvcal/(R*t))*Pr+(0.5*dkcal/(R*t))*Pr^2))*Kcal;
% 
% %Sulfide
% KS1 = exp(225.838 - 13275.3/t - 34.6435*log(t) + 0.3449*s^0.5 - 0.0274*s );
% dvs1 = -14.8+0.0020*temp - 1e-3*0.4*(temp)^2;
% dks1= 2.89e-3 +0.054e-3*temp;
% KS1=(exp(-(dvs1/(R*t))*Pr+(0.5*dks1/(R*t))*Pr^2))*KS1;
% KS2 = 1.0e-18;
% 
% %Ammonia
% KN = exp( -6285.33/t + 0.0001635*t - 0.25444 +(0.46532 -123.7184/t)*s^0.5 +...
% (-0.01992 + 3.17556/t)*s);
% dvN = -23.43+0.0889*temp - 1e-3*0.905*(temp)^2;
% dkN= 5.03e-3 +0.0814e-3*temp;
% KN=(exp(-(dvN/(R*t))*Pr+(0.5*dkN/(R*t))*Pr^2))*KN;
% 
% 
% %Note no temp/pressure dependence on these constants. 
% %Phosphate
% KP1 = 0.19e-1;
% KP2 = 0.85e-6;
% KP3 = 0.13e-8;
% 
% %Silicate
% KSi1 = 0.31e-9;
% KSi2 = 0.12e12;
% 
% %Sulfate
% KSO4 = 0.1;
% 
% %Fluoride
% KF = 0.24e-2;
% 
% %Nitrate
% KNO3 = 0.23e2;
% 
% %Nitrite
% KNO2 = 0.12e-4;
% 
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HCO3    = @(H) TC  .* KC1.*H           ./ (H.^2 + H*KC1 + KC1*KC2);
% CO3     = @(H) TC  .* KC1*KC2          ./ (H.^2 + H*KC1 + KC1*KC2);
% CO2     = @(H) TC  .* H.^2             ./ (H.^2 + H*KC1 + KC1*KC2);
% BOH4    = @(H) TB  .* KB               ./ (H + KB);
% H3PO4   = @(H) TP  .* H.^3             ./ (H.^3 + H.^2*KP1 + H*KP1*KP2 + KP1*KP2*KP3 );
% H2PO4   = @(H) TP  .* KP1*H.^2         ./ (H.^3 + H.^2*KP1 + H*KP1*KP2 + KP1*KP2*KP3 );
% HPO4    = @(H) TP  .* KP1*KP2*H        ./ (H.^3 + H.^2*KP1 + H*KP1*KP2 + KP1*KP2*KP3 );
% PO4     = @(H) TP  .* KP1*KP2*KP3      ./ (H.^3 + H.^2*KP1 + H*KP1*KP2 + KP1*KP2*KP3 );
% H3SiO4  = @(H) TSi .* KSi1*H           ./ (H.^2 + H*KSi1 + KSi1*KSi2);
% H2SiO4  = @(H) TSi .* KSi1*KSi2        ./ (H.^2 + H*KSi1 + KSi1*KSi2);
% NH3     = @(H) TNH3.* KN               ./ (H + KN);
% SO4     = @(H) TSO4.* KSO4             ./ (H + KSO4);
% HSO4    = @(H) TSO4.* H                ./ (H + KSO4);              
% F       = @(H) TF  .* KF               ./ (H + KF);
% HF      = @(H) TF  .* H                ./ (H + KF);
% HNO3    = @(H) TNO3.* H                ./ (H + KNO3);
% HNO2    = @(H) TNO2.* H                ./ (H + KNO2);
% HS      = @(H) TS  .* KS1.*H           ./ (H.^2 + KS1.*H + KS1.*KS2);
% S2      = @(H) TS  .* H.^2             ./ (H.^2 + KS1.*H + KS1.*KS2);
% OH      = @(H) KW/H;
% 
% %equate total alkalinity to the sum of its constituents
% Talkfun = @(H) HCO3(H) + 2.*CO3(H) + OH(H) + BOH4(H) +HPO4(H) + 2.*PO4(H)...
%     +H3SiO4(H) +2.*H2SiO4(H) + NH3(H) + HS(H) - 2.*S2(H)...
%  - H -H3PO4(H) - HSO4(H) - HF(H) - HNO3(H) - HNO2(H)  - TA ;
% 
% %find the roots of the function (the pH at which TA equals the sum of species)
% H = fzero(Talkfun,[10^-14 10^0]);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %calculate speciations
% 
% 
% pH=-log10(H);
% pco2=1e6.*CO2(H)./KH;
% omega = (CO3(H).*Ca)./Kcal;
% 
% % TC == CO2(H)+HCO3(H)+CO3(H)
% HNO3(H)
% HNO2(H)
% HSO4(H)
% S2(H)
% end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%         case 0 %steady state burial fluxes
                    
            
%         case 1
%             F_extra = 0;
%             del_extra=0;
%             Fborg = interp1(tinterp,F_extra_interp,t,'pchip');
%             CP = fi.CP;
%             
%         case 2
%             F_extra = 0;
%             del_extra=0;
%             CP = fi.CP * (Fbp/Fbi.PO4).^params.p.CP_bP;
%             Fborg = Fbp*CP; %[mol/y]
%         
%         case 3.0
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP;
%                              
%         case 3.1
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             Fborg = Fbi.Corg * RCO2; %[mol/y]
%         case 3.2
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP;
%             Fborg = CP*Fbp; %[mol/y]
%         case 3.3
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP * (RCO2)^params.p.CP_RCO2;
%             Fborg = CP*Fbp; %[mol/y]
%        case 3.4 
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP;
%             Fborg = Fbi.Corg; %[mol/y]
%        case 3.6
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP * (Fbp/Fbi.PO4).^params.p.CP_bP;
%             Fborg = Fbp*CP; %[mol/y]
%        case 3.7
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP * exp(Fbp / Fbi.PO4 -1 );
%             Fborg = Fbp*CP; %[mol/y]
%        case 3.8
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP;
%             Fborg = Fwp.*CP; %[mol/y]
%        case 3.9
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             del_extra = interp1(tinterp, del_extra_interp,t,'pchip');
%             CP =  fi.CP * (Fbp/Fbi.PO4).^params.p.CP_bP;
%             Fborg = Fbp*CP; %[mol/y]

       
        
            
%     end
    
    
    %carbonate burial
%     switch flags.Fbcarb
%         case 0
%           Fbcarb = Fbi.CaCO3;
%         case 1
%           Fbcarb = Fhyd_Ca + Fw_Ca_sil  + Fw_CaCO3 ;
%         case 2
%           Fbcarb = Fw_CaCO3 + Fworg + Fvolc + F_extra - Fborg;
%         case 3
%           Fbcarb = Fb_CaCO3 * y(3)/M.Cai; %[mol/y]  
%         case 4
%           Fbcarb = Fb_CaCO3*(omega/Ci.Omega).^params.p.FbCaCO3;
%     end
    
    
    %more perturbation options
%     switch flags.pertb 
% %         case 2
% %             Fbcarb = interp1(tinterp,F_extra_interp,t,'pchip');
% %             Fborg = Fw_CaCO3 + Fworg + Fvolc + F_extra - Fbcarb;
%         case 3.0
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             Fborg = Fw_CaCO3 + Fworg + Fvolc + F_extra - Fbcarb; %[mol/y] 
%         case 3.5 
%            F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP;
%             Fborg = fi.borg/(1-fi.borg)*Fbcarb; %[mol/y]
 

% output.values = vertcat(...
%                   struct2cell(Fb),...
%                   struct2cell(Fw),...
%                   struct2cell(M),...
%                   struct2cell(C),...
%                   struct2cell(del),...
%                   struct2cell(f)...
%                   );


% output = struct('t', t, 'DIC',DIC*1e3, 'delbcarb', delbcarb, 'Ca', Ca*1e3,...
%     'Fborg', Fborg, 'Fbcarb', Fbcarb, 'forg', forg,...
%     'pco2', pco2, 'pH', pH,  'omega', omega, 'epsb',  epsb,...
%     'hco3', hco3, 'co3', co3, 'ALK', ALK*1e3, ...
%     'delbC', delbC, 'delborg', delborg,'PO4',PO4,...
%     'delCa',delCa,'Fextra',F_extra,'CP',CP,'Fw_Ca_sil',Fw_Ca_sil,'delwC',delwC,...
%     'O2', O2,'O2_prod',O2_prod,'O2_consm',O2_consm,'temp',temp,...
%     'delCa',delCa,'delb_sulf',delb_sulf);



%         case 1
%             F_extra = zeros(length(t),1);
%             del_extra=zeros(length(t),1);
%             Fborg = interp1(tinterp,F_extra_interp,t,'pchip');
%             CP = fi.CP * ones(length(t),1);
%         case 2
%             F_extra = zeros(length(t),1);
%             del_extra=zeros(length(t),1);
%             CP = fi.CP .* (Fbp./Fbi.PO4).^params.p.CP_bP;
%             Fborg = Fbp.*CP; %[mol/y]
%             
%         case 3.0
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP * ones(length(t),1);
%         case 3.1
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             Fborg = Fbi.Corg * MC / M.Ci; %[mol/y]
%             CP = fi.CP * ones(length(t),1);    
%         case 3.2
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP * ones(length(t),1);
%             Fborg = CP.*Fbp; %[mol/y]
%             
%         case 3.3
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP * (RCO2).^params.p.CP_RCO2;
%             Fborg = CP.*Fbp; %[mol/y]     
%         case 3.4 
%            F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%            CP = fi.CP * ones(length(t),1);
%            Fborg = Fbi.Corg * ones(length(t),1); %[mol/y]
%         case 3.6
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP .* (Fbp./Fbi.PO4).^params.p.CP_bP;
%             Fborg = Fbp.*CP; %[mol/y]
%         case 3.7
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP .* exp(Fbp ./ Fbi.PO4 -1 );
%             Fborg = Fbp.*CP; %[mol/y]
%             
%         case 3.8
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP * ones(length(t),1);
%             Fborg = Fwp.*CP; %[mol/y]
%         
%         case 3.9
%             F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             del_extra = interp1(tinterp, del_extra_interp,t,'pchip');
%             CP = fi.CP * (Fbp/Fbi.PO4).^params.p.CP_bP;
%             Fborg = Fbp.*CP; %[mol/y]


%     case 1
%         n=5000;     %number of points in the interpolation
%         tinterp=[params.t.run_start linspace(params.t_perturbation_start_1,params.t_perturbation_end_1,n) params.t.run_end];
% 
%         F_extra_interp=[Fbi.Corg Fbi.Corg*(1 + params.f_extra*normpdf(linspace(-4,4,n),0,1)/...
%         max(normpdf(linspace(-4,4,n),0,1))) Fbi.Corg];    % gaussian shaped excursion
%      case 2
%          F_extra_interp=[1 (1 + params.f_extra*normpdf(linspace(-4,4,n),0,1)/...
%          max(normpdf(linspace(-4,4,n),0,1))) 1];    % gaussian shaped excursion
%         
%     case {3.0,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8}
%         F_extra_interp = [0 M_extra*normpdf(linspace(-4,4,n),0,1)*8/n/...  
%         ((t_perturbation_end - t_perturbation_start)/(n-1)) 0]; 

%   for sigmoidal perturbation
%         ncdf = normcdf(linspace(-4,4,n),0,1)*8/n/((t_perturbation_end - t_perturbation_start)/(n-1));
%         F_extra_interp = [0 M_extra*ncdf max(ncdf*M_extra)];

%   sinosoidal perturbation

%         F_extra_interp = sin(1e5*t_interp); 

% F_extra_interp = 1e13+2*M_extra/1e5*sin(4*pi*tinterp/(t_perturbation_end-t_perturbation_start)); 



%     case 3.9
%     
%     
%     
%     events = [params.t_perturbation_start_1, params.t_perturbation_start_2,params.t_perturbation_end_1,params.t_perturbation_end_2];
%     
%     tinterp = linspace(min(events),max(events),n);
% 
%     
%     tinterp_1 = tinterp(tinterp>=params.t_perturbation_start_1 & tinterp<=params.t_perturbation_end_1);
%     tinterp_2 = tinterp(tinterp>=params.t_perturbation_start_2 & tinterp<=params.t_perturbation_end_2);
%     
%     n1 = length(tinterp_1);
%     n2 = length(tinterp_2); 
%     
%     F_extra_interp_1 = [ 0 params.M_extra_1*normpdf(linspace(-4,4,n1),0,1)*8/n1/((params.t_perturbation_end_1 - params.t_perturbation_start_1)/(n1-1)) 0];
%     F_extra_interp_2 = [ 0 params.M_extra_2*normpdf(linspace(-4,4,n2),0,1)*8/n2/((params.t_perturbation_end_2 - params.t_perturbation_start_2)/(n2-1)) 0];
%     
% 
%     [tinterp_intersect, ind_t1_intersect, ind_t2_intersect] = intersect(tinterp_1, tinterp_2);
%     [tinterp_setxor, ind_t1_setxor, ind_t2_setxor] = setxor(tinterp_1, tinterp_2);
%     t_interp_combined=[tinterp_1(ind_t1_intersect) tinterp_1(ind_t1_setxor) tinterp_2(ind_t2_setxor)];
%     [tinterp,ind_sort] = sort(t_interp_combined);
%   
% 
%     tinterp = [params.t.run_start tinterp params.t.run_end];
%     
%    
%     
%     F_extra_interp_intersect = F_extra_interp_1(ind_t1_intersect) + F_extra_interp_2(ind_t2_intersect);
%     
%     F_extra_interp_setxor = [F_extra_interp_1(ind_t1_setxor), F_extra_interp_2(ind_t2_setxor)];
%     
%     F_extra_interp_combined = [F_extra_interp_intersect, F_extra_interp_setxor]; 
%     
%     F_extra_interp = F_extra_interp_combined(ind_sort);
%      
%     F_extra_interp = [0 F_extra_interp 0];
%     
%     del_extra_interp_1 = params.del_extra_1*ones(1,length(F_extra_interp_1));
%     del_extra_interp_2 = params.del_extra_2*ones(1,length(F_extra_interp_2));
% 
%     del_extra_interp_intersect = (del_extra_interp_1(ind_t1_intersect) .* F_extra_interp_2(ind_t1_intersect) + ...
%     del_extra_interp_2(ind_t2_intersect) .* F_extra_interp_2(ind_t2_intersect) ) ./ ...
%     (F_extra_interp_2(ind_t1_intersect) + F_extra_interp_2(ind_t2_intersect))      ;
% 
%     del_extra_interp_setxor = [del_extra_interp_1(ind_t1_setxor),...
%     del_extra_interp_2(ind_t2_setxor)];
% 
%     del_extra_interp_combined = [del_extra_interp_intersect,...
%     del_extra_interp_setxor]; 
% 
%     del_extra_interp = del_extra_interp_combined(ind_sort);  
% 
%     del_extra_interp = [del_extra_interp(1) del_extra_interp del_extra_interp(end)];
  

%                      switch flags.plot
%                         case {0}                 
%                         annotation('textbox',get(gca,'Position')-[0.01 -.03 0 0],'String',['(',char(ii+64),')']...
%                         ,'LineStyle','none', 'FitBoxToText','on');
%                      end   
%                      if flags.pertb~=3.9 && flags.plot~=4 && tcrit>0.2
%                       line([params.t_perturbation_start_1 params.t_perturbation_start_1],ylim,'Color','r','LineStyle','--')
%                       line([tforcemax tforcemax],ylim,'Color','g','LineStyle','-.')
%                       line([params.t_perturbation_end_1 params.t_perturbation_end_1],ylim,'Color','r','LineStyle','--')
%                      end
%                     axis tight 



        % tcrit = (params.t_perturbation_end_1 -
        % params.t_perturbation_start_1)/(output.t(end) - output.t(1));
        

%     case 6 
%         yl1 = plot(x,y(:,2));
%         a1 = gca;
%         box off
%         ylabel(a1,'\delta^{13}C_{carb}')
%         xlabel(a1,'time (yrs)')
% %         ylm1 = get(a1,'YLim');
%         a2 = axes('Position',get(a1,'Position'),...
%            'YAxisLocation','right','XAxisLocation','top','XTickLabel',...
%            '','Color','none');
%         yl2 = line(x,y(:,15),'Parent',a2,'LineStyle','--','Color','k'); 
% %         ylm2 = get(a2,'YLim');
%         grid on 
%         hl = legend([yl1 yl2],'\delta^{13}C_{carb}','\delta^{13}C_{org}');
%         set(hl,'Box','off')
%         ylabel(a2,'\delta^{13}C_{org}')
%         axis([a1 a2],'square')
%                 set(a2,'YLim',[-.75+min(ylm2) , -.75+min(ylm2)+ylm1dis])
%         dist = max([ abs(ylm1 - y(1,2)); abs(ylm2 - y(1,15))]);
%         y1 = y(1,2); y2 = y(1,15);
    
%         ylim(a1,[0 7 ])
%         ylim(a2,[-30 -23])
        
%         line([params.t_perturbation_start_1 params.t_perturbation_start_1],ylim,'Color','r','LineStyle','--')
%         line([tforcemax tforcemax],ylim,'Color','g','LineStyle','-.')
%         line([params.t_perturbation_end_1 params.t_perturbation_end_1],ylim,'Color','r','LineStyle','--')



%     case 7
%       hold on
%       scatter(output.DIC, output.ALK,[],output.t)   

% end



% %lines denoting perturbation max (changes according to perturbation chosen)    
% switch flags.pertb
%    case 0
%         tforcemax=0;
%    case 1
%        tforcemax=output.t(output.Fborg==max(output.Fborg));
%    case 2
%        tforcemax=output.t(output.Fw_Ca_sil==max(output.Fborg));
%    case {3.0,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8}
%        tforcemax=output.t(output.Fextra==max(output.Fextra));
% end  




%     
% 
%     
%     %carbonate burial
%     switch flags.Fbcarb
%         case 0
%           Fbcarb = Fbi.CaCO3* ones(length(t),1);
%         case 1
%           Fbcarb = Fhyd_Ca + Fw_Ca_sil  + Fw_CaCO3 ;
%         case 2
%           Fbcarb = Fw_CaCO3 + Fworg + Fvolc + F_extra - Fborg;
%         case 3
%           Fbcarb = Fb_CaCO3 * MCa/M.Cai; %[mol/y]   
%         case 4
%           Fbcarb = Fb_CaCO3.*(omega./Ci.Omega).^params.p.FbCaCO3;
%     end
%     
%     
%     switch flags.pertb
% %         case 2
% %             Fbcarb = interp1(tinterp,F_extra_interp,t,'pchip');
% %             Fborg = Fw_CaCO3 + Fworg + Fvolc + F_extra - Fbcarb;
%         case 3.0
%             Fborg = Fw_CaCO3 + Fworg + Fvolc + F_extra - Fbcarb; %[mol/y]
%         case 3.5 
%            F_extra = interp1(tinterp, F_extra_interp,t,'pchip');
%             CP = fi.CP* ones(length(t),1);
%             Fborg = fi.borg./(1-fi.borg).*Fbcarb; %[mol/y]
%     end
%     
%     
%     %Oxygen fluxes
%     O2_prod = Fborg;
%     O2_consm = Fworg;
%     


%         Fborg = interp1(tinterp,F_extra_interp,t,'pchip');




%  %redox sensitive weathering fluxes (pyrite and Corg) 
%            Fw.FeS2 = Fwi.FeS2 * R.SO4* R.O2 * (M.sed_FeS2/Mi.sed_FeS2)...
%                 .*(R.CO2).^(params.berner.G.*params.berner.Z)...
%                 .*(1+params.berner.G...
%                 .*params.berner.Z.*log(R.CO2)).^0.65;
%             
%             Fw.Corg = Fwi.Corg *R.SO4 *R.O2 * (M.sed_Corg/Mi.sed_Corg) ...
%                 .*(R.CO2).^(params.berner.G.*params.berner.Z)...
%                 .*(1+params.berner.G...
%                 .*params.berner.Z.*log(R.CO2)).^0.65;






% function mapObj = myMapMakerFun(varargin)
% 
% names = cell(0);
% values = cell(0);
% 
% for i = 1:nargin
% 
%     field_names = fieldnames(varargin{i});
%     struct_name = inputname(i);
% 
%     names1 = strcat(struct_name,'.',field_names);
%     values1 = struct2cell(varargin{i});
% 
%     names = [names ; names1];
%     values = [values ; values1];
%     
%     
% end
% 
% mapObj = containers.Map(names,values); 
% 
% 
% end



% switch flags.w  
%         case 0 %(flags.w OUTPUT RESTRUCT)
%             %equal to initial steady state value
%             Fw = Fwi;
%             
%             
%         case 1 %(flags.w OUTPUT RESTRUCT)
%             %set proportional to pCO2
%             
%             ind = [2 3 6:17]; 
% 
%             for i = ind
%                   Fw.( Names.Fwi{i} ) = ...
%                   Fwi.( Names.Fwi{i} ).*(R.CO2.^params.p.w);  
%             end
%         
%             
%         case 2 %(flags.w OUTPUT RESTRUCT)
%             %set to Berner parameterization
%             
%             %carbonates and evaporites
%             
%             ind = [2 6 9 10 13 14 16 17]; 
%             
%             for i = ind
%                     Fw.( Names.Fwi{i} ) = ...
%                     Fwi.( Names.Fwi{i} ) ...
%                     .*(R.CO2).^(params.berner.G.*params.berner.Z).*...
%                     (1+params.berner.G.*params.berner.Zc.*log(R.CO2)) ;
%             end
%             
%             
%             %silicates
%             
%             ind = [3 7 8 11 12 15]; 
%             
%             for i = ind
%                     Fw.( Names.Fwi{i} ) = ...
%                     Fwi.( Names.Fwi{i} )...
%                     .*(R.CO2).^(params.berner.G.*params.berner.Z)...
%                     .*(1+params.berner.G...
%                     .*params.berner.Z.*log(R.CO2)).^0.65;
%             end
%             
%            
%         case 3 %(flags.w OUTPUT RESTRUCT)
%                %set proportional to pCO2 and redox
%            
% %            f.redoxC = M.sed_Corg ./ (M.sed_Corg + M.sed_CaCO3);  
%                
%            ind = {'Ca_sil','PO4', 'Mg_sil', 'K_sil', 'KCl',...
%                    'NaCl','Na_sil','Fw.Corg'};
%             Fw = myStructFun( @(X) X.*(R.CO2.^params.p.w), Fwi, ind);
% %             Fw = myStructFun( @(X) X, Fwi, ind);
%             
% 
% 
%             ind = {'CaSO4','MgCO3','MgSO4'};
%             Fw = myStructFun(...
%             @(X) X .* M.sed_CaSO4 ./ Mi.sed_CaSO4 .* R.CO2,...
%                 Fw, ind);
% 
% 
%             Fw.FeS2 = Fwi.FeS2 .* R.O2 .* (M.sed_FeS2./Mi.sed_FeS2);
%             
%             Fw.Corg = Fwi.Corg .*R.CO2  .*(M.sed_Corg./Mi.sed_Corg);
%             
%             Fw.CaCO3 = Fwi.CaCO3 .*R.CO2 .* (M.sed_CaCO3./Mi.sed_CaCO3);
%             
% 
% 
%         case 4 %(flags.w OUTPUT RESTRUCT)
%           %Like 5 but with cation and organic carbon weathering 
%             
%           
% %            ind = {'Ca_sil','PO4', 'Mg_sil', 'K_sil', 'KCl',...
% %                    'NaCl','Na_sil'};
% %             
% %             Fw = myStructFun( @(X) X.*(R.CO2.^params.p.w), Fwi, ind);
% % %             Fw = myStructFun( @(X) X, Fwi, ind);
% %             
% % 
% % 
% %             ind = {'CaSO4','MgCO3','MgSO4'};
% % 
% % 
% %             Fw = myStructFun(...
% %             @(X) X .* R.CO2,... % .* M.sed_CaSO4 ./ Mi.sed_CaSO4 ,...
% %                 Fw, ind);
% 
% 
%             Fw.FeS2 = Fwi.FeS2 .*R.CO2 .* R.O2;% .* (M.sed_FeS2./Mi.sed_FeS2);
%             
% %             Fw.Sulf = Fw.CaSO4 + Fw.MgSO4; 
% %             
% %             Fw.Corg = Fwi.Corg .*R.CO2;%  .*(M.sed_Corg./Mi.sed_Corg);
% %             
% %             Fw.CaCO3 = Fwi.CaCO3 .*R.CO2;% .* (M.sed_CaCO3./Mi.sed_CaCO3);
%             
%             
%           
% 
%          case 5 %(flags.w OUTPUT RESTRUCT)
%                %no cation weathering. Only O2 dependent weathering of
%                %pyrite 
% 
% 
%             Fw.FeS2 = Fwi.FeS2 .* R.O2 ;%.* (M.sed_FeS2./Mi.sed_FeS2);
%             
%     end

% switch flags.b
%         case 0 %(flags.b OUTPUT RESTRUCT)
%             %all fluxes equal to their initial values
%                
%                Fb = structfun(@(X) X.*ones(length(t),1), ...
%                     Fbi,'UniformOutput', false);
%         
%     case 1 %(flags.b OUTPUT RESTRUCT)
%             %standard burial flux dependencies
%             
%             %reverse weathering dependence on pH
%             Fb.Na_RW = Fbi.Na_RW .* R.pH;
%             Fb.K_RW  = Fbi.K_RW  .* R.pH;
%             
%             %phosphate burial 1st Order Mp
%             Fb.PO4 = Fbi.PO4 * (M.PO4 / Mi.PO4).^params.p.bp_Mp;
%             
%             %evaporite burial fluxes proportional total the change in 
%             %ion concentration product (ICP) to initial ICP ratio
%             Fb.MgSO4 = Fbi.MgSO4 .* ICP.MgSO4 / Ci.ICP_MgSO4; 
%             Fb.KCl   = Fbi.KCl   .* ICP.KCl   / Ci.ICP_KCl;
%             Fb.NaCl  = Fbi.NaCl  .* ICP.NaCl  / Ci.ICP_NaCl;
%             Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
%             
%             %same for dolomite burial
%             Fb.MgCO3 = Fbi.MgCO3 .* ICP.MgCO3 / Ci.ICP_MgCO3;
%             
%             %hydrothermal exchange of Mg by Ca at Mid Ocean Ridges
%             Fb.Mg_hyd = Fw.Ca_hyd;
%             
%             %burial of carbonate carbon proportional to change in Omega
%             Fb.CaCO3 = Fbi.CaCO3.*(C.Omega/Ci.Omega).^params.p.FbCaCO3;
%             
%             %organic carbon burial
%             f.CP = fi.CP .* (Fb.PO4./Fbi.PO4)...
%                 .*(R.SO4./R.O2).^params.p.CP_bP;
%             Fb.Corg = f.CP.*Fb.PO4; %[mol/y]
%             
%             %burial of sulfate and pyrite
%             Fb.Sulf = Fb.CaSO4 + Fb.MgSO4;
%             
%             f.CS = fi.CS.*(Fb.PO4/Fbi.PO4).^(-1);
%             Fb.Pyr  = Fb.Corg./f.CS; 
%         
%     case 3  %(flags.b OUTPUT RESTRUCT)
%          %set these fluxes to initial value
%             ind2 = {'Mg_hyd'}; 
%             
%             Fb = myStructFun( @(X) X , Fbi, ind2);
%             
%             %reverse weathering dependence on pH
%             Fb.Na_RW = Fbi.Na_RW .* R.pH;
%             Fb.K_RW  = Fbi.K_RW  .* R.pH;
%             
%             Fb.MgSO4 = Fbi.MgSO4 .* ICP.MgSO4 / Ci.ICP_MgSO4; 
%             Fb.KCl   = Fbi.KCl   .* ICP.KCl   / Ci.ICP_KCl;
%             Fb.NaCl  = Fbi.NaCl  .* ICP.NaCl  / Ci.ICP_NaCl;
%             Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
%             
%             Fb.CaCO3 = Fbi.CaCO3 * (C.Omega/Ci.Omega).^params.p.FbCaCO3;
%             
%             %same for dolomite burial
%             Fb.MgCO3 = Fbi.MgCO3 .* ICP.MgCO3 / Ci.ICP_MgCO3;
%             
%             Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4).*params.p.bp_Mp;
% 
%             f.CP = fi.CP .* (Fb.PO4./Fbi.PO4)...
%                  .^params.p.CP_bP;
%             
% %             Fb.Corg = Fbi.Corg;
%             Fb.Corg = f.CP.*Fb.PO4;
%             Fb.Sulf = Fb.CaSO4 + Fb.MgSO4;
%             
%             f.CS = fi.CS.*(Fb.PO4./Fbi.PO4).^(-1);
%             Fb.Pyr  = Fb.Corg./f.CS;
%             
% %             Fb.subd_CaCO3 = Fb.subd_CaCO3.*M.sed_CaCO3./Mi.sed_CaCO3;
% %             Fb.subd_Corg = Fb.subd_Corg.*M.sed_Corg./Mi.sed_Corg;
%             
% %             Fw_Cvolc = Fb.subd_CaCO3 + Fb.subd_Corg;
%             
%     case 4  %(flags.b OUTPUT RESTRUCT)
%          %set these fluxes to initial value
%             ind2 = {'Mg_hyd' 'Fb.subd_Corg' 'Fb.subd_CaCO3'}; 
%             
%             Fb = myStructFun( @(X) X , Fbi, ind2);
%             
%             %reverse weathering dependence on pH
% %             Fb.Na_RW = Fbi.Na_RW ;%.* R.pH;
% %             Fb.K_RW  = Fbi.K_RW  ;%.* R.pH;
% %             
% %             Fb.MgSO4 = Fbi.MgSO4 .* ICP.MgSO4 / Ci.ICP_MgSO4; 
% %             Fb.KCl   = Fbi.KCl   ;%.* ICP.KCl   / Ci.ICP_KCl;
% %             Fb.NaCl  = Fbi.NaCl  ;%.* ICP.NaCl  / Ci.ICP_NaCl;
% %             Fb.CaSO4 = Fbi.CaSO4 .* ICP.CaSO4 / Ci.ICP_CaSO4;
%             
% %             Fb.CaCO3 = Fbi.CaCO3 * (C.Omega/Ci.Omega).^params.p.FbCaCO3;
%             
%             %same for dolomite burial
% %             Fb.MgCO3 = Fbi.MgCO3 .* ICP.MgCO3 / Ci.ICP_MgCO3;
%             
%             Fb.PO4 = Fbi.PO4 .* (M.PO4 ./ Mi.PO4).*params.p.bp_Mp;
% 
%             f.CP = fi.CP .* (Fb.PO4./Fbi.PO4)...
%                  .^params.p.CP_bP;
%             
% %             Fb.Corg = Fbi.Corg;
%             Fb.Corg = f.CP.*Fb.PO4;
% %             Fb.Sulf = Fb.CaSO4 + Fb.MgSO4;
%             
% %             f.CS = fi.CS.*(Fb.PO4./Fbi.PO4).^(-1);
% %             Fb.Pyr  = Fb.Corg./f.CS;
%             
%     end
% 
%          Fw.PO4 = Fwi.PO4 .*R.CO2;
% 
%         Fw.FeS2 = Fwi.FeS2 .* R.O2 .*R.CO2 .* (M.sed_FeS2./Mi.sed_FeS2);
%              
%         Fw.Corg = Fwi.Corg .*R.CO2 .*(M.sed_Corg./Mi.sed_Corg);
%             
%         Fw.CaCO3 = Fwi.CaCO3 .* R.CO2 .* (M.sed_CaCO3./Mi.sed_CaCO3);
% 
%         Fw.CaSO4 = Fwi.CaSO4 .* R.CO2 .* (M.sed_CaSO4./Mi.sed_CaSO4);
%         
%         Fw.MgSO4 = Fwi.MgSO4 .* R.CO2;
%         
%         Fw.Sulf = Fw.CaSO4 + Fw.MgSO4;


%         
%         Fw.C_volc_ox = Fb.subd_CaCO3 .* (1 - fi.mantle_volc);
%         Fw.C_volc_red = Fb.subd_Corg .* (1 - fi.mantle_volc);
%         Fw.C_volc = Fw.C_volc_ox + Fw.C_volc_red;
    
%         Fw.C_mantle_red  = f.redox_mantle_C     .* Fwi.C_mantle;
%         Fw.C_mantle_ox = (1 - f.redox_mantle_C) .* Fwi.C_mantle;
%         Fw.C_mantle     = Fw.C_volc_ox + Fw.C_volc_red;

% Fb.Na_RW = Fbi.Na_RW .* R.pH;
%             Fb.K_RW  = Fbi.K_RW  .* R.pH;


% case custom
%         
%         %first perturbation
%     t_interp_1_pertb = ...
%     linspace(params.t_perturbation_start_1, ...
%              params.t_perturbation_end_1,n);
% 
%     t_interp_1 = [params.t.run_start t_interp_1_pertb(1) ...
%     t_interp_1_pertb(2:(end -1)) t_interp_1_pertb(end)...
%     params.t.run_end];
% 
%     
%     sigma_1 = (params.t_perturbation_end_1 - params.t_perturbation_start_1)/10;
%     %ten standard deviations out in each direction
% 
%     mu_1 = (params.t_perturbation_end_1 + params.t_perturbation_start_1)/2;
% 
%     F_extra_interp_1 = [0 0 params.M_extra_1*...
%     normpdf(t_interp_1_pertb(2:(end -1)), mu_1, sigma_1) 0 0]; 
%         
% 
% 
%     %second perturbation
%     t_interp_2_pertb = ...
%     linspace(params.t_perturbation_start_2,params.t_perturbation_end_2,n);
% 
%     t_interp_2 = [params.t_run_start t_interp_2_pertb(1) ...
%     t_interp_2_pertb(2:(end -1)) t_interp_2_pertb(end)...
%     params.t_run_end];
% 
%     sigma_2 = (params.t_perturbation_end_2 - params.t_perturbation_start_2)/10; 
% %ten standard deviations out in each direction
% 
%     mu_2 = (params.t_perturbation_start_2 + params.t_perturbation_end_2)/2;
% %             
%     F_extra_interp_2 = ...
%     [0 0 params.M_extra_2*normpdf(t_interp_2_pertb(2:(end -1)), mu_2, sigma_2) 0 0]; 












% function Sid_ox_Pyr_ox_no_pco2_drop 
% %% Initial OCEANIC AND ATMOSPHERIC CONCENTRATIONS 
% 
% % 0 option corresponds to modern value
% 
% %pco2 baseline 
% flags.pCO2 =2;    
%                     %0 502 ppm (with Ca = 10.3, alk=2.2, dic=2.0)
%                     %1 2000 ppm (with Ca = 10.3, alk=5.0, dic=5.22)
%                     %2 10,500 ppm (with Ca = 0.13; alk=58.5, dic=54)
%                     %3 5000 ppm (with Ca = 0.13, alk=, dic=)
%                     
% %Ca Baseline 
% flags.Ca  = 1;           
%                    %0 10.3 mM
%                    %1 0.13 mM
%                    %2 50.0 
%                    %3 1.03 mM
%                                      
% %O2 Baseline
% flags.O2 = 3;    
%                     %0 20.95 percent
%                     %1 0.1 PAL  
%                     %2 0.01 PAL 
%                     %3 1e-5 PAL
%                     
%                     
% %SO4 Baseline
% flags.SO4 = 3;     %0 28.2 mM (PL)
%                    %1 0.1  PL 
%                    %2 0.01 PL 
%                    %3 50 micro M
%                    
% %P concentrations                   
% flags.PO4  = 0;    %0 25e-6 [mol/kg]                
%                     
% 
% 
% %%%%%%% Sedimentary reservoirs
% 
% %Ratio of Pyr to Sulf sedimentary reservoirs
% flags.Pyr_Sed = 2;
%                    %0 as modern 153e18 : 192e18 pyr:sulf
%                    %1 0.95 Pyr : 0.05 sulfate  
%                    %2 0.99 Pyr : 0.01 sulfate  
%                    %3 0.999 Pyr : 0.001 Sulfate 
%                    
%                    
%                    
%                     
%                     
% 
% %differences between delccarb and delcorg:
% % flags.deltaB = 0;      
% %                     %0 - off
% %                     %1 - extrabasinal Corg. 
% %                         %amount: 
% %                         params.fexternal = .5; 
% %                         %composition:
% %                         params.delexternal = -28.0;
% %                     %2 - pco2 depd. fractionation with const PO4
% %                     %3-pco2 depd. fractionation with variable PO4
% 
% 
% %run length [yrs] 
%  params.t.run_start = -50e6;
%  params.t.run_end = 300e6;
% 
% % params.t.run_end = 1e6;
%             
% 
% %% RATE CONSTANTS
% 
% %Use modern rate constants calculated from modern oceanic concentrations
% %and estimated sedimentary reservoir sizes. 
% 
% flags.k_mod = 0;   %0 recalculate constants so model starts at steady state
%                       %according to values set below.
%                       
%                    %1 use rate constants calibrated to modern values
%                       %Model will evolve to modern steady state if initial
%                       %conditions set to values other than modern.
% 
% 
% 
% %% WEATHERING AND BURIAL FEEDBACKS
% 
% %For weathering and buiral fluxes type of dependence paramaterization. See
% %weathering_func and burial_func
% flags.w = 1.3;     
%         
% %burial fluxes             
% flags.b = 1.3;      
%                     
%                     
% 
% %% perturbation. 
% 
% % To turn perturbation off, set to zero.
% 
% flags.pertb = 1; % 0 - no perturbation (good for testing for steady state)
%                  % 1 - perturb the fluxes as specified in params.pertb.vars   
%                  % 'custom' make a custom defined funtion
% 
% %% Define perturnation parameters. 
% 
% %Format for input: 
% % {'variable_name','perturbaton shape', t start, t end, amount}
% 
% % Choose flux name from the sketch above. (eg 'Fw.volc')
% % perturbation shape: 'Gaussian' 'Sigmoidal' 'Step'  'Flat' or 'Custom'
% % Specify the start and stop times of the perturbation. 
% % These cannot exceed run times!
% % Amount is interpreted in two ways. 
% % If the factor is up to +-1000 the program interperets it as 
% % specifying a multiplier of the original amount (10x, 100x,...) 
% % to be added to it
% % Above +-1000 the program assumes you are
% % referring to an absolute amount in mols/yr (1e12, 1e18...)
% % which will be added to the baseline amount
% 
% % example: flags.pertb = {'Fw.volc', 'Gaussian',1e5 ,6e5 ,10}
% 
% 
% %for small pco2 drop [2,0.5,1]
% % kFesilox = 2;
% % kPyrox = 0.5;
% % kextra = 1;
% 
% %for no pco2 drop [3,0.5,2]
% kFesilox = 3;
% kPyrox = 0.5;
% kextra = 2;
% 
% 
% 
% params.pertb.vars = ...
%      {...
%     {'Fb.Corg', 'Gaussian', 0e6,  130e6,  10e12*kFesilox + 13e12*kPyrox}, ...   
%    {'Fw.FeCO3', 'Gaussian', 0e6, 130e6, 10e12*kFesilox + 7e12*kPyrox + 1e12*kextra}, ...  
%    {'Fw.FeO', 'Gaussian', 0e6, 130e6,  30e12*kFesilox }, ...   
%      };
%  
%  
%  
%  
% %      {'Fw.CaCO3', 'Gaussian', 0e6,  150e6,  6e12*kPyrox}, ...
%  %      {'Fw.FeS2', 'Gaussian', 0e6,  150e6,  6e12*kPyrox}, ...
% %      {'Fb.CaSO4', 'Gaussian', 0e6, 150e6, 6e12*kPyrox}
%  
% %      {'Fb.Corg', 'Gaussian', 0e6, 200e6,  2}, ...
% %      {'Fb.Corg', 'Gaussian', 200e6, 220e6,  -0.5}, ...
% 
% %     {'Fw.O_extra', 'Step', 50e6, 60e6, 1e12},...
% %    {'Fw.O_extra', 'Sigmoidal', 0, 2e6, 1e11},...
% %      {'f.CP', 'Gaussian', 0e6, 200e6,  2},...
% %      {'Fb.Corg', 'Gaussian', 0e6, 200e6,  0.5},...
% %      {'Fb.Corg', 'Gaussian', 0e6, 200e6,  0},...
% %      {'Fw.FeCO3', 'Gaussian', 0e6, 200e6,  1e13},...
% %      {'Fw.FeO', 'Gaussian', 0e6, 200e6,  .2},...
% 
% 
% %UNUSED BOXES: any boxes that you want unchanged. Zeroes the value of the 
% %particular reservoir at every timestep                    
% params.pertb.zeroing = {'Mg','K','Na','Cl'};
% % params.pertb.zeroing = {'Mg','K','Na','Cl','sed_FeS2'};
% % params.pertb.zeroing = {'Mg','K','Na','Cl','Ca','delCa'};
% % params.pertb.zeroing = {'Na','Mg','K','Cl'...
% %     'sed_Spyr', 'sed_Ssulf','sed_CaCO3','sed_Corg'};
% 
% % params.pertb.zeroing = {'Na','K','Cl'...
% %     'sed_Spyr', 'sed_Ssulf','sed_CaCO3','sed_Corg'};
% 
% % params.pertb.zeroing = {'sed_Spyr', 'sed_Ssulf','sed_CaCO3','sed_Corg'};
% 
% % params.pertb.zeroing = {'C','Ca'};
% 
% % params.pertb.zeroing = {};
% 
% 
% 
% %% Plotting control
% flags.plot = 1; 
%     %0 don't plot a figure
%     %1 plot a figure
%     
% flags.plotMidRun = 1;
%     %0 no mid run plots
%     %1 plot a component of the solution mid run every x seconds. 
%     
% params.plotting.n_subplots = [4 5];
% %number of subplots row and column
% 
% % comma seperated list of variable by number or name that  you would like to 
% % plot. Each cell corresponds to one subplot and you can plot either
% % one or two variables on a single plot
% params.plotting.vars_2_plot =...
%                      { ...
%                      {'C.C'       ,'del.C'        };... 
%                      {'C.Ca'      ,'del.Ca'       };...
%                      {'C.SO4'       ,'del.S'        };...
%                      {'C.O2'      ,'C.pCO2'       };...
%                      {'M.sed_FeS2','M.sed_CaSO4'  };...
%                      {'M.sed_Corg','M.sed_CaCO3'  };...
%                      {'del.sed_Corg','del.sed_CaCO3'};...
%                      {'M.sed_FeO', 'Fw.FeO'};...
%                      {'Fw.C_volc' , 'del.C_volc'  };...
%                      {'f.redox_volc_C','f.redox_volc_S'};...
%                      {'Fw.FeS2'    ,'Fb.FeS2'       };...
%                      {'Fw.CaCO3'  ,'Fb.CaCO3'     };...
%                      {'Fw.Corg'   ,'Fb.Corg'      };...
%                      {'Fw.CaSO4'  ,'Fb.CaSO4'     };...
%                      {'Fw.PO4'    ,'Fb.PO4'       };...
%                      {'C.pH'      ,'C.Omega'      };...
%                      {'f.CP'      ,'f.CS'         };...
%                      {'C.CO3'     ,'C.Alk'        };...
%                      {'M.sed_FeCO3','Fw.FeCO3'    };...
%                      {'Fw.O_extra' ,'R.SO'   };...
%                      };
%  
% 
% % params.plotting.n_subplots = [1 2];
% % params.plotting.vars_2_plot =...
% %                      { ...
% %                      {'del.C' ,'Fw.O_extra'    };... 
% %                      {'M.sed_FeO','M.sed_FeCO3'};...
% %                      };
% 
% 
% 
% 
% 
% %                     {'Fw.Mg_sil' ,'Fb.MgCO3'     };...
% %                      {'Fw.NaCl'   ,'M.Cl'         };...
% %                      {'Fw.KCl'    ,'M.K'          };...
% %                      {'Fw.MgSO4'  ,'Fb.MgSO4'     };...
% 
% % Fancy: for multiple monitors
% % in which monitor should a new figure open in? (1 -primary, 2-
% % secondary, etc...)
% flags.monitorNumber = 1;
% 
% %make plot window fill screen
% flags.plottingFullScreen = 1;    
% 
% 
% 
% %for Lee: color definition - dark or light background figure
% flags.FigBgColor = 'light';
% % flags.FigBgColor = 'dark';
%                  
%     
% flags.plot_save = 0;
%                 %0- don't save a plot
% 
%                 %1- save a copy as an eps file. If putting file in
%                 %directory other than the current one then add the full
%                 %path to the filename. 
%                     
% 
%       params.plotting.file_name  = 'myfile';
% 
%       params.plotting.file_path  = '/some/very/long/path';               
%                         
%       
% %Holds figure between consecutive model runs. Useful for comparing results      
% flags.plot_hold = 'hold';   %hold - do not clear plot window
% % flags.plot_hold = 'replace';   %replace - clear window
%   
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                       
%                         
%     
% 
%     
%     %call the model
%     [t,output,params] = Model(params,flags);
%  
%     %call plotting function
%     Plotting(t,output,params,flags);
% 
%     toc
%     
% %%export model data to base workspace as one structure 'output'. 
%     assignin('base', 'output', output)
%     assignin('base', 'params', params)
%     assignin('base','flags',flags)
%     assignin('base', 't', t)
%    
% 
% %If you want a sound to let you know that the simulation is done
% % load chirp
% % sound(y,Fs)
% 
% 
% %%
% 
% figure(2)
% 
% set(gcf,'PaperPositionMode','auto')
% % set(gcf,'InvertHardcopy','off')
% 
% AX1 = subplot(1,2,1);
% 
% mylinewidth = 1.5;
% myfontsize = 12;
% 
% plot(t/1e6,del.C,'k','LineWidth',mylinewidth)
% 
% xlabel('Time (Ma)','FontSize',myfontsize)
% ylabel('\delta^{13}C','FontSize',myfontsize)
% 
% set(AX1,'FontSize',myfontsize)
% axis square
% xlim([-50 300])
% ylim([-1 11])
% grid on
% 
% subplot 122
% 
% [AX2,H1,H2] = plotyy(t/1e6,C.O2,t/1e6,C.pCO2/1e3);
% 
% set(get(AX2(1),'Ylabel'),'String','pO_2  [atm]','FontSize',myfontsize) 
% set(get(AX2(2),'Ylabel'),'String','pCO_2 [10^3 ppmv]','FontSize',myfontsize, ...
%     'Position',[370 26.3937 0]) 
% 
% set(AX2(1),'FontSize',myfontsize)
% set(AX2(2),'FontSize',myfontsize)
% 
% set(H1,'LineStyle','-','LineWidth',mylinewidth)
% set(H2,'LineStyle','--','LineWidth',mylinewidth)
% 
% xlabel('Time (Ma)')
% 
% set(AX2(1),'YLIM',[-0.05 0.5],'YTickMode','auto', 'XLIM', [-50 300] )
% set(AX2(2),'YLIM',[0 55],'YTickMode','auto', 'XLIM', [-50 300] )
% set(AX2(1), 'box', 'off')
% 
% set(AX2(1),'Xgrid','on','Ygrid','on')
% % set(AX(2),'Xgrid','on','Ygrid','on')
% 
% 
% set(AX2(2), 'XAxisLocation', 'top','XTickLabel','')
% 
% axis(AX2(:),'square')
% 
% %  CurrentDir = cd;
% 
% % cd('/Users/avivbachan/Documents/Research/Postdoc/Lomagundi_Modeling/Manuscript/Nature_submission/Figures/')
%  
% %  print -f2 -depsc -painters -loose 'Sid_Pyr_Ox_no_pCO2_drop'
% 
% %  cd(CurrentDir)
%  
% %%
% 
% % figure(3)
% % clf
% % 
% % 
% % set(gcf,'PaperPositionMode','auto')
% % set(gcf,'InvertHardcopy','off')
% % set(gcf,'Color','none')
% % 
% % % [left bottom width height]
% % 
% % AX(3) = axes('Position',[0.12 0.48 0.815 0.42]);
% % 
% % plot(t/1e6,del.S)
% % 
% % xlabel('Time (Ma)')
% % 
% % xlim([0 190])
% % ylim([-3.5 35])
% % set(gca,'XDir','reverse','Color','none')
% % 
% % 
% % % box off
% % 
% % % set(gca,'Color','none', 'YTickLabels','')
% % % set(gca,'visible','off')
% % 
% % AX(4) = axes('Position',[0.12 0.14 0.815 0.255]);
% % 
% % plot(t/1e6,del.C)
% % 
% % 
% % xlabel('Time (Ma)')
% % 
% % xlim([0 190])
% % ylim([-1 16])
% % set(gca,'XDir','reverse','Color','none')
% % 
% % 
% % % set(gca,'visible','off')
% % % set(gca,'Color','none', 'YTickLabels','','visible','off')
% % 
% % % box off
% % % 
% %  CurrentDir = cd;
% % % 
% % cd('/Users/avivbachan/Documents/Research/Postdoc/Lomagundi_Modeling/Manuscript/Nature_submission/Figures/')
% % % 
% % print -f3 -depsc -painters -loose 'Model_d34S.eps'
% % % 
% %  cd(CurrentDir)
% 
% 
% 
%  
% end



