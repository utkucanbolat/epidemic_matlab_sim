% randomWalk function returns x and y values of the next timestep
% for example, if random number gives 1 then particle goes x direction
% or, if random number gives 4 then particle goes -y direction.
% o | 3 | o
% ---------
% 2 |   | 1
% ---------
% o | 4 | o

function [x, y] = randomWalk(x, y, dim, biasx, biasy)

bc = @(x,die)(mod(x,dim)~=0)*(-1)^(die+1) + (x==dim)*(-1) + (x==1);

die = randsample([1 2 3 4], 1, true, [0.25+biasx 0.25-biasx 0.25+biasy 0.25-biasy]);
if die == 1 || die == 2
    x = x + bc(x,die);
elseif die == 3 ||  die == 4
    y = y + bc(y,die);
end
