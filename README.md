# Description

Container to use the dwarf2json tool to generate Linux Profiles based on CentOS7 for Volatility3

# Building the docker container
```
 docker build --tag dwarf2json-centos7:0.0.1 .
```
## Note edit the Dockerfile to update the kernel version you require.

# Running the docker container
```
docker run --rm --user=$(id -u):$(id -g) -v "$(pwd)":/output:ro,Z -ti  dwarf2json-centos7:0.0.1
```

# Copy the dumped symbols with dwar2json
```
docker ps
docker cp <CONTAINER ID>:/tmp/output/<distro><version>.json.xz .
```

# Adding linux kernel profile to Volatility3
```
zip -a volatility3/volatility/symbols/linux.zip dizt.json.xz
```

# Running volatility example
```
python3 vol.py  -f collected_memory.lime  yarascan.YaraScan --yara-file <rules.yar>
```

# References
* [https://github.com/volatilityfoundation/dwarf2json](dwarf2json)
* [https://github.com/volatilityfoundation/volatility3](Volatility3)
