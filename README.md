# bgpmap

![](https://engasylum.files.wordpress.com/2016/07/screen-shot-2016-07-02-at-9-14-18-pm.png)

### About:
The following scripts create a list of edges from a routers BGP table. Right now the scripts only support MRT format BGP tables, but I'll add support for stripping the AS paths from CLI generated output. 

### Dependencies:
 - parallel
 - pigz
 - bgpdump
 - perl
 - gawk
 - sort
 - grep
 - sed
 
### Script Layout:
![](https://raw.githubusercontent.com/mattlfinn/bgpmap/master/images/layout.png)