# bgpmap

### About
The following scripts create a list of edges from a routers BGP table. Right now the scripts only support MRT format bgp tables, but I'll add support for stripping the AS paths form CLI generated output. 

### Dependencies:
 - parallel
 - pigz
 - bgpdump
 - perl
 - gawk
 - sort
 - grep
 - sed
 
### Script Layout 
![](https://raw.githubusercontent.com/mattlfinn/bgpmap/master/images/layout.png)