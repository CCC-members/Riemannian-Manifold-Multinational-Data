function frames = plotsignals(ejex, leg, hlines, vlines, putmarks, fillout, Spec1, Spec2, Spec3, Spec4, Spec5, Spec6)
%plotsignals(ejex, Spec1, Spec2, Spec3, Spec4, Spec5)

nspec=nargin-6;
if nspec > 6,
  error( 'Limitado a 6 espectros' );
end
 
[nfreq,nd,~]=size(Spec1);
TSpec=[];
for i=1:nspec
  eval(['Sp=Spec',int2str(i) ';']);
  Sp = reshape(Sp, nfreq*nd, numel(Sp)./(nfreq*nd));
  TSpec= [TSpec Sp];
end

nspec = size(TSpec,2);

global mycolors
if isempty(mycolors)
    % colors=[ 'b' 'r' 'k' 'g' 'm' 'c' 'y'];
    % lw = [3 1 1 1 1 1 1];
    colors=[ 'b' 'r' 'y' 'k' 'g' 'm' 'c'];
else
    colors = mycolors;
end
if size(colors,2) > size(colors,1)
    colors = colors';
end
ncolors = size(colors,1);
lw = ones(ncolors, 1);

if ~isempty(hlines)
    if iscell(hlines)
        hlM = -Inf; hlm = Inf;
        for k=1:length(hlines)
            hlM = max(hlM, max(hlines{k}));
            hlm = min(hlm, min(hlines{k}));
        end
    else
        hlM = max(hlines);
        hlm = min(hlines);
    end
    mx = max(max(TSpec(:)), hlM);
    mn = min(min(TSpec(:)), hlm);
else
    mx = max(TSpec(:));
    mn = min(TSpec(:));
end
% maxv=min([20 mx]);
% minv=max([-20 mn]);
maxv = mx;
minv = mn;
gap = (maxv - minv) *0.1;
maxv = maxv + gap;
minv = minv - gap;

Spec=zeros(size(Spec1));

if nd == 19
    [frames, deriv, titles] = frames_s1020(nd);
    frametit = find(frames(3,:) == 22);
    frameleg = find(frames(3,:) == 24);
elseif nd == 18
    [frames, deriv, titles] = frames_s18(nd);
    frametit = 15; frameleg = 15;
elseif nd == 17 %This is for the 17 ROIS del paper de connectividad DD Vs NSRD
    [frames, deriv, titles] = frames_s17(nd);
    frametit = find(frames(3,:) == 22);
    frameleg = find(frames(3,:) == 7);
elseif nd == 22
    [frames, deriv, titles] = frames_s1022(nd);
    frametit = find(frames(3,:) == 22);
    frameleg = find(frames(3,:) == 24);
end

%Crear los handles de los frames
handfr=zeros(size(frames,2),1);
for i=1:size(frames,2)
  handfr(i)=mysubplot(frames(1,i), frames(2,i), frames(3,i), 0.03, 0.08, 0.06, 0.03, 0.05, 0.01); axis off
end
frames=handfr; clear handfr

xtit=ejex(1);
ytit=maxv+0.7;

xticks = unique([0:-500:ejex(1) 0:500:ejex(end)]);
x0 = 0;
if ejex(1)*ejex(end) < 0 %hay negativos y positivos
    xticks = sort([xticks 0]);
    x0 = 1;
end
xticks = unique(round(xticks));

if ~isempty(hlines) && ~iscell(hlines)
    yticks = hlines(:);
else
    yticks = linspace(minv,maxv, 4);
    y0 = 0;
    if minv*maxv < 0 %hay negativos y positivos
        [aa, bb] = min(abs(yticks));
        if aa < 3
            yticks(bb) = [];
        end
        yticks = sort([yticks 0]);
        y0 = 1;
    end
    yticks = unique(round(yticks));
end
yticks = round(yticks*10)./10;

ss=[ejex(1) ejex(end)];
for k=1:nd
    subplot(frames(k)); hold on; axis on
    for i=1:nspec
        Spec = reshape(TSpec(:, i), nfreq, nd);
        ix = mod(i, ncolors); if ix == 0, ix = ncolors; end
        plot(ejex, Spec(:,deriv(k)), 'color', colors(ix,:), 'linewidth', lw(ix)); hold on
    end
    axis([ejex(1) ejex(nfreq) minv maxv]);
    set(gca, 'xtick', xticks, 'ytick', yticks, 'fontsize', 12);
    if k ~= frametit
        set(gca, 'xticklabel', ''); set(gca,'yticklabel', '')
    else
        xlabel('Frequency (Hz)');
    end
    
    if k == frameleg && ~isempty(leg)
        xx = get(gca, 'position');
        hh=legend(leg, 'location', 'eastoutside', 'fontsize', 12);
        yy = get(hh, 'position');
        xx(1) = xx(1)+xx(3);
        yy(1) = xx(1) + xx(1)*0.03;
        set(hh, 'position', yy);
    end
    if i == nspec
        for hh =1:length(xticks)
            xx=line([xticks(hh) xticks(hh)], [minv maxv], 'color', [0.5 0.5 0.5]);
            set(xx, 'linestyle', ':');
        end
        if ~isempty(hlines)
            if iscell(hlines)
                Spec(:) = TSpec(:, i);
                try
                    markM = Spec(:, deriv(k)) > hlines{1};
                catch
                    markM = 0;
                end
                try
                    markm = Spec(:, deriv(k)) < hlines{2};
                catch
                    markm = 0;
                end
                ghl = [];
                ii = find(markM > 0);
                if ~isempty(ii)
                    ghl(1) = min(hlines{1}(ii));
                end
                ii = find(markm > 0);
                if ~isempty(ii)
                    ghl(2) = max(hlines{2}(ii));
                end
                for h=1:size(Spec,1)
                    if markM(h)
                        hh = plot(ejex(h), Spec(h,deriv(k)), 'ro', 'markersize', 6, 'MarkerFaceColor', 'r');
                    end
                    if markm(h)
                        hh = plot(ejex(h), Spec(h,deriv(k)), 'bo', 'markersize', 6, 'MarkerFaceColor', 'b');
                    end
                end
            else
                ghl = hlines;
                for jj=1:length(ghl)
                    line([ejex(1) ejex(end)], [ghl(jj) ghl(jj)], 'color', [0.5 0.5 0.5]);
                end
                if fillout
                    fillsig(ejex, Spec(:,deriv(k)), ghl);
                end
            end
        end
    end

%     htext=text(xtit, ytit, titles(k,:)); set(htext,'FontSize', 12);
    title(titles(k,:), 'FontSize', 12);
    if ~isempty(vlines)
        set(gca, 'xtick', vlines)
        for hh=1:length(vlines)
            line([vlines(hh) vlines(hh)], [minv maxv], 'color', [0.5 0.5 0.5]);
        end
    end
    yy = ylim; ym = yy(1) + diff(yy)*0.05; f = 8;
    ylim([yy(1)-diff(yy)*0.05, yy(2)]);
    text(2, ym, '\delta', 'fontsize',f); text(6, ym, '\theta', 'fontsize',f); text(9.5, ym, '\alpha', 'fontsize',f);
    text(15, ym, '\beta', 'fontsize',f); %text(34, ym, '\gamma', 'fontsize',f);

end

% gg = subplot(frames(16));
% xx = get(gca, 'position');
% hh=legend(leg, 'location', 'eastoutside', 'fontsize', 10);
% yy = get(hh, 'position');
% xx(1) = xx(1)+xx(3);
% yy(1) = xx(1) + xx(1)*0.03;
% set(hh, 'position', yy);
% 
if putmarks
    xx=ginput;
    
    if ~isempty(xx)
        xx = sort(round(xx(:,1)));
        for k=17:19
            subplot(frames(k));
            for h=1:length(xx)
                line([xx(h) xx(h)], [minv maxv], 'color', [0.5 0.5 0.5]);
            end
            set(gca, 'xtick', xx, 'xticklabel', xx, 'fontsize',14)
        end
    end
end
