graph
=====
it's a graphic service, with the "graphic command" received, it plot on the screen.
the available command now is:

#line:
 draw a line from (fx,fy) to (tx,ty), with spec color and alpha
 command: "#line fx fy tx ty [color] [alpha] [thickness]"
 
#rect
 draw a rect on a given localtion (x,y) with spec with and height.
 command: "#rect x y width height [color] [fill]"
 
 ...
 
usage:
 the service run on port 9001, you can use the socket of any other language to connect to this port 
 and just send the command string to it.
 
 you can telnet it to try the command
 
 
