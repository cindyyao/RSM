% writeDigPort.m
%
%        $Id: writeDigPort.m 669 2009-12-23 13:18:50Z justin $
%      usage: retval = writeDigPort(portNum,val);
%         by: justin gardner
%       date: 09/21/06
%    purpose: write an ouput to the National Instruments board
%  copyright: (c) 2006 Justin Gardner (GPL see mgl/COPYING)
%             portNum defaults to 2, to write from Dev1/port2.
%             The first time you read it needs to open the port to 
%             the NI device which can take some time. Subsequent calls
%             will be faster. Note that you can only open one port at
%             a time, so if you need to read from two different ports
%             it will always be closing and reopening the ports which 
%             will cause a performance hit (consider rewriting the code
%             to keep multiple ports open if you need this). Also,
%             if you want to switch between reading and writing on
%             a single port, you will need to manually close the port
%             in between read/write calls by setting portNum = -1 (see below).
%
%             portNum can also be set to:
%               -1 : closes any open port
%               -2 : displays which port (if any) is open.
%
%             Note that
%             in the distribution, writeDigPort is not compiled.
%             It always returns 0. To use it to read your NI card, you
%             will need to mex readDigPort.c, this requires
%             you to install the NI-DAQmx Base Frameworks from:
%             http://sine.ni.com/nips/cds/view/p/lang/en/nid/14480
function retval = writeDigPort(portNum,val)

retval = 0;

