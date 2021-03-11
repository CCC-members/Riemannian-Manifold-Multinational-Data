function hdl = mysubplot(nx, ny, frame, top, bottom, left, right, gapx, gapy)
if ~exist('gapx','var') || isempty(gapx), gapx = 0.03; end
if ~exist('gapy','var') || isempty(gapy), gapy = 0.03; end
if ~exist('top','var') || isempty(top), top = 0.06; end
xinit = top;
if ~exist('left','var') || isempty(left), left = 0.06; end
yinit = left;
if ~exist('right','var') || isempty(right), right = 0.06; end
margeny = yinit+right;
if ~exist('bottom','var') || isempty(bottom), bottom = 0.06; end
margenx = xinit+bottom;
% if margenx < 0.06, margenx = 0.06; end
% if margeny < 0.06, margeny = 0.06; end
sx = (1 - margenx - gapx*(nx-1)) / nx;
sy = (1 - margeny - gapy*(ny-1)) / ny;

fy = rem(frame,ny);
fx = floor(frame/ny)+1;
if fy == 0, fy = ny; fx = fx-1; end
px = 1 - (xinit + fx*sx + (fx-1)*gapx);
py = yinit + (fy-1)*(sy + gapy);
hdl = subplot('position', [py px sy sx]);
    