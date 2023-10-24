 function mag0_plot(mag,varargin)
%----------------------------------------------------------------------
% Process inputs (varargin)
A.fig = 1;	% (1) new figure; (0) current figure
A.mode = 1;	% (1) simple plot: Nf, Hp, Structural biomass
                % (2) adds B_per_m
                % (3) adds envt
A.nsteps = 10;  % to plot profiles at "N" steps
A.print = 0;    % 0 to print figures as jpeg
A.fname = 'fig_mag0'; % Default file name (will append 'Nf' and 'Bm') 
A = parse_pv_pairs(A, varargin);
%----------------------------------------------------------------------
addpath additional_functions
%----------------------------------------------------------------------
 
 if A.fig==1
    figure;
 end

 out = mag.out;
 time = mag.time;

 % time step for plotting  profiles
 nsteps = A.nsteps;
 dtplot = max(1,floor(time.ndt/nsteps));

 % Vertical and time grids
 tday = [time.dt_Gr:time.dt_Gr:time.duration]/24;
 tz = mag.farm.z_arr;

 % Total nitrogen
 % Nf : fixed
 % Ns : stored
%Nall = mag.out.Nf + mag.out.Ns; 
 Nall = mag.out.Nf;
 Nall(Nall<=0) = nan;
 Nall_end = Nall(:,end);

 % Update # of plotting timesteps to actual value
 nsteps = size(Nall(:,1:dtplot:end),2);

 tt = tiledlayout(3,3);

 ax1 = nexttile([1 2]);
 yyaxis left
 pp1 = plot(tday,out.kelp_b,'-','linewidth',4,'color',[0.3 0.6 0.3]);
 ylabel('biomass (kg m^-^2)','fontsize',18)
 yyaxis right
 pp2 = plot(tday,out.kelp_h,'-','linewidth',4,'color',[0.3 0.3 0.8]);
 ylabel('height (m)','fontsize',18)
 xlabel('day','fontsize',18)
 ax1.YAxis(1).Color = [0.3 0.6 0.3];
 ax1.YAxis(2).Color = [0.3 0.3 0.8];
 xlim([tday(1) tday(end)]);
 title('plant biomass and height','fontsize',18)

 ax2 = nexttile([2 2]);
 pp2 = pcolor(tday,tz,Nall);
 hold on
 shading flat;
 colormap(ax2,parula);
 cb = colorbar;
 xlabel('day','fontsize',18)
 ylabel('depth (m)','fontsize',18)
 title('Nf','fontsize',18)

 ax3 = nexttile(6,[2 1]);
 pp3 = plot(Nall(:,1:dtplot:end),tz,'-','linewidth',4);
 cmap = parula(nsteps+2);
%cmap = cmocean('thermal',ceil(nsteps*1.2));
 cmap = cmap(2:nsteps+1,:);
 colormap(ax3,cmap);
 colororder(ax3,cmap);
 cb = colorbar;
 cb.TickLabels = {};
 cb.Label.String = 'time';
 cb.Label.FontSize = 15;
 title('Nf profile','fontsize',18)
 xlabel('N units','fontsize',18)
 ylabel('depth (m)','fontsize',18)

 % Print figure (needs to expand this part for flexibility)
 if A.print==1
    mprint_fig('name',[A.fname '_Nf.jpeg'],'for','jpeg','sty','nor1');
 end

 %------------------------------------------------------------
 % Additional plots if needed
 if A.mode == 2
    Bm = mag.out.Bm;
    Bm(Bm<=0) = nan;

    % Plots b_per_m plant "shape"
    figure
    tt = tiledlayout(1,3);
    ax4 = nexttile(1,[1 2]);
    pp2 = pcolor(tday,tz,Bm);
    hold on
    shading flat;
    cb = colorbar;
    xlabel('day','fontsize',18)
    ylabel('depth (m)','fontsize',18)
    title('Bm shape function','fontsize',18)

    % Plots Timeseries of profiles
    ax5 = nexttile(3);
    pp4 = plot(Bm(:,1:dtplot:end),tz,'-','linewidth',4);
    cmap = parula(nsteps+2);
   %cmap = cmocean('thermal',ceil(nsteps*1.2));
    cmap = cmap(2:nsteps+1,:);
    colormap(ax5,cmap);
    colororder(ax5,cmap);
    cb = colorbar;
    cb.TickLabels = {};
    cb.Label.String = 'time';
    cb.Label.FontSize = 15;

    title('Bm shape profile','fontsize',18)
    xlabel('1/m','fontsize',18)
    ylabel('depth (m)','fontsize',18)

    % Print figure (needs to expand this part for flexibility)
    if A.print==1
       mprint_fig('name',[A.fname '_Bm.jpeg'],'for','jpeg','sty','nor1b2');
    end
    
 end



  
