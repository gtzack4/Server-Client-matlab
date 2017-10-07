classdef ServerClass < handle
    %ServerClass This class sets up a sever socket conection from matlab to
    %anther instance of matlab.
    
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
        function obj = ServerClass
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            %             import java.net.*; %only need once
            %             import java.io.*;  %only need once
            obj.sockNum = 4444; % can use can number of unused socket
            obj.serverSocket = java.net.ServerSocket(obj.sockNum); % defins socket
            
            obj.serverSocket.close; %this will close the socket
            obj.serverSocket = java.net.ServerSocket(obj.sockNum); % redefine socket
            
            obj.clientSocket = obj.serverSocket.accept(); % waits for link
            obj.in = java.io.BufferedReader(java.io.InputStreamReader(getInputStream(obj.clientSocket)));
            obj.out = java.io.PrintWriter(getOutputStream(obj.clientSocket),true);
            
        end
        %% destructor
        function delete(obj)
            
            obj.in.close;
            obj.out.close
            obj.serverSocket.close
        end
        %% send data
        function sendData(obj,data)
            %sendData sends data to the client
            obj.out.println(data)
        end
        %% read data
        function data = readData(obj)
            %readData reads data sent from client
            if ready(obj.in)
                data = obj.in.readLine;
                data = chr(data);
                
            else
                data = -1;
            end
        end
    end
end

