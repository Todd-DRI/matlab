function T = func_parse_irrigation(filePath, writeCSV)
% v1.0, 12/8/25, Co-pilot wrote this script! 
% PARSE_IRRIGATION Extracts Beginning/End times and Amount from Irrig.txt.
% Usage:
%   T = parse_irrigation('Irrig.txt');            % returns table
%   T = parse_irrigation('Irrig.txt', true);      % also writes CSV
%
% Output table columns:
%   Event, Begin_T, End_T, Amount_L
%
% Notes:
% - Parses line-by-line using regex to match the target labels.
% - Handles normal and scientific notation numbers.
% - Tolerates minor spacing variations.

dir_cur = pwd; 

cd(filePath)

fileName = "Irrig.out";

if nargin < 2, writeCSV = false; end
assert(isfile(fileName), 'File not found: %s', fileName);

% Open file
fid = fopen(fileName, 'r');
assert(fid ~= -1, 'Cannot open file: %s', fileName);

% Preallocate (unknown count initially)
eventNum = [];   % numeric event counter when present
beginT   = [];   % Beginning of irrigation [T]
endT     = [];   % End of irrigation [T]
amtL     = [];   % Irrigation amount [L]

% Keep a running event index if explicit "Irrigation event N" appears
currentEvent = NaN;

% Regex patterns (robust to spaces, tabs, and formats like 0.15200E+02)
numPat = '([-+]?\d+(\.\d+)?([eE][-+]?\d+)?)';
reEvent   = ['^\s*Irrigation\s+event\s+(\d+)\s*$'];
reBeginT  = ['^\s*Beginning\s+of\s+irrigation\s*\[T\]\s*:\s*' numPat '\s*$'];
reEndT    = ['^\s*End\s+of\s+irrigation\s*\[T\]\s*:\s*' numPat '\s*$'];
reAmountL = ['^\s*Irrigation\s+amount\s*\[L\]\s*:\s*' numPat '\s*$'];

% Temporary holders for a block
tmpBegin = NaN; tmpEnd = NaN; tmpAmt = NaN;

% Read line-by-line
while true
    line = fgetl(fid);
    if ~ischar(line), break; end

    % Match "Irrigation event N"
    tok = regexp(line, reEvent, 'tokens', 'once');
    if ~isempty(tok)
        % If we were in the middle of an event, flush it before starting a new one
        if ~isnan(currentEvent) && ~isnan(tmpBegin) && ~isnan(tmpEnd) && ~isnan(tmpAmt)
            eventNum(end+1,1) = currentEvent;
            beginT(end+1,1)   = tmpBegin;
            endT(end+1,1)     = tmpEnd;
            amtL(end+1,1)     = tmpAmt;
        end
        % Start a new event
        currentEvent = str2double(tok{1});
        tmpBegin = NaN; tmpEnd = NaN; tmpAmt = NaN;
        continue;
    end

    % Match "Beginning of irrigation [T]:"
    tok = regexp(line, reBeginT, 'tokens', 'once');
    if ~isempty(tok)
        tmpBegin = str2double(tok{1});
        continue;
    end

    % Match "End of irrigation [T]:"
    tok = regexp(line, reEndT, 'tokens', 'once');
    if ~isempty(tok)
        tmpEnd = str2double(tok{1});
        continue;
    end

    % Match "Irrigation amount [L]:"
    tok = regexp(line, reAmountL, 'tokens', 'once');
    if ~isempty(tok)
        tmpAmt = str2double(tok{1});
        % If we already have an event number, we can finalize this block
        if ~isnan(currentEvent)
            eventNum(end+1,1) = currentEvent;
        else
            % If no explicit event header, number sequentially
            eventNum(end+1,1) = numel(eventNum)+1;
        end
        beginT(end+1,1) = tmpBegin;
        endT(end+1,1)   = tmpEnd;
        amtL(end+1,1)   = tmpAmt;
        % Reset block holders (optional)
        tmpBegin = NaN; tmpEnd = NaN; tmpAmt = NaN;
    end
end

fclose(fid);

% Build output table
T = table(eventNum, beginT, endT, amtL, ...
    'VariableNames', {'Event','Begin_T','End_T','Amount_L'});

% Optional: write CSV alongside the input file
if writeCSV
    [p,f] = fileparts(filePath);
    outCSV = fullfile(p, [f '_parsed.csv']);
    writetable(T, outCSV);
    fprintf('Wrote: %s\n', outCSV);
end

cd(dir_cur)

end
