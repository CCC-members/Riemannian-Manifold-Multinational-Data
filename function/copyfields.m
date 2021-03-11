function b = copyfields(a, b, fields)

% COPYFIELDS copies a selection of the fields from one structure to another
%
% Use as
%   b = copyfields(a, b, fields);
% which copies the specified fields over from structure a to structure b. Fields that
% are specified but not present will be silently ignored.
%
% See also KEEPFIELDS, REMOVEFIELDS, RENAMEFIELDS

% Copyright (C) 2014, Robert Oostenveld
%
% This file is part of FieldTrip, see http://www.fieldtriptoolbox.org
% for the documentation and details.
%
%    FieldTrip is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    FieldTrip is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with FieldTrip. If not, see <http://www.gnu.org/licenses/>.
%
% $Id$

if isempty(a)
  % this prevents problems if a is an empty double, i.e. []
  return
end

if isempty(b)
  % this prevents problems if a is an empty double, i.e. []
  b = keepfields(a, fields);
  return
end

if ischar(fields)
  fields = {fields};
elseif ~iscell(fields)
  error('fields input argument must be a cell-array of strings or a single string');
end

existfields = intersect(fieldnames(a), fields);
nonexistfields=setdiff(existfields, fields);
for i=1:numel(existfields)
  b.(existfields{i}) = a.(existfields{i});
end
for i=1:numel(nonexistfields)
  b.(nonexistfields{i}) = [];
end

end