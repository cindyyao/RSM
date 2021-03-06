% isfile.m
%
%      usage: isfile(filename)
%         by: justin gardner
%       date: 08/20/03
%       e.g.: isfile('filename')
%    purpose: function to check whether file exists
%             Note meta characters like "?", "*", or "~user" are not recognized but "~/" can be used for filename.

%
function [isit permission] = isfile(filename)

isit = 0;permission = [];
if (nargin ~= 1)
  help isfile;
  return
end
if isempty(filename),isit = 0;,return,end

% replace the tilde with a full path
filename = mglReplaceTilde(filename);

% open file
fid = fopen(filename,'r');

% check to see if there was an error
if (fid ~= -1)
  % check to see if this is the correct path (cause matlab can open
  % files anywhere in the path)
  if (length(filename)>=1) && ~isequal(filename(1),filesep)
    openname = fopen(fid);
    if ~strcmp(fullfile(pwd,filename),openname)
      %disp(sprintf('(isfile) Found file %s, but not in current path',openname));
      isit = false;
      fclose(fid);
      return;
    end
  end
  % close file and get permissions
  fclose(fid);
  [dummy permission] = fileattrib(filename);
  isit = true;
else
  isit = false;
end


% mglReplaceTilde.m
%
%        $Id:$ 
%      usage: filename =  mglReplaceTilde(filename)
%         by: justin gardner
%       date: 12/07/11
%    purpose: If filename starts with a tilde, will replace with
%             fully qualified path (e.g. ~/uhm will become /Users/justin/uhm)
%
function filename = mglReplaceTilde(filename)

% check arguments
if ~any(nargin == [1])
  help mglReplaceTilde
  return
end

if (length(filename) >= 1) && (filename(1) == '~')
  % get tilde dir
  if ispc
    tildeDir = [getenv('HOMEDRIVE') getenv('HOMEPATH')];
  else
    tildeDir = getenv('HOME');
  end

  % apend tildeDir
  filename = fullfile(tildeDir,filename(2:end));
end

