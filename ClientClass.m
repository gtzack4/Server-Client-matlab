classdef ClientClass < handle
    %ClientClass This class conects to a seversocket on the socket number
    %'sockNum'. U*se host = 'localhost' for a socket on the same computer.
    %Set the host equal to the servers IP adress for a conection over a network.  
    
    %   example use:
    %   %-matlab 1
    %   S = ServerClass; % this will wait until the client is conected
    %   %-matlab 2
    %   C = ClientClass;
    %   %-matlab 1
    %   S.sendData('hey matlab 2 this is matlab 2');
    %   %-matlab 2
    %   data = C.readData;
    %   disp(data)
    properties
        serverSocket
        clientSocket
        in
        out
        sockNum
        host
    end
    
    methods
        %% constructor
        function obj = ClientClass
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.host = 'localhost'; % use 'localhost' or the IP address of the sever.
            obj.sockNum = 4444; % can be any open socket usaly 4000-5000
            obj.clientSocket = java.net.Socket(obj.host,obj.sockNum);
            obj.in  = java.io.BufferedReader(java.io.InputStreamReader(getInputStream(obj.clientSocket)));
            obj.out = java.io.PrintWriter(getOutputStream(obj.clientSocket),true);
            
            
        end
        %% destructor
        function delete(obj)
            
            obj.in.close;
            obj.out.close
            obj.clientSocket.close
        end
        %% send data
        function sendData(obj,data)
            %sendData sends data to the sever
            obj.out.println(data)
        end
        %% read data
        function data = readData(obj)
            % readData reads data from the server
            if ready(obj.in)
                data = obj.in.readLine;
                data = chr(data);
                
            else
                data = -1;
            end
        end
    end
end

