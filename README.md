# bishengjdk-docker

#1、If necessary, you need to set up a proxy, fill in the correct ip:port
#error info:
```
Cannot find a valid baseurl for repo: base/7/aarch64
The command '/bin/sh -c yum makecache && yum install -y tzdata openssl curl ca-certificates fontconfig gzip tar && yum update -y && yum clean all' returned a non-zero code: 1
```
> vim Dockerfile ---> ENV http_proxy='ip:port' https_proxy='pi:port'


#2、 Only the mirror image of 8u292 is made here, if necessary, it can be modified to the required version number

> build_latest.sh--->jdk_versions

$ bash build_latest.sh
> Successfully built b32b1efab579
> Successfully tagged dockerimages/bishengjdk:8u292

>$ sudo docker images
```
REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
dockerimages/bishengjdk   8u292               b32b1efab579        12 seconds ago      1.24GB
csmith                    latest              e0f1c69fe499        5 months ago        850MB
centos                    7                   e5df02c43685        9 months ago        301MB
```
#success
```
Successfully built b32b1efab579
Successfully tagged dockerimages/bishengjdk:8u292
```

$ sudo docker run -it dockerimages/bishengjdk:8u292 /bin/bash  
或者：  
$ sudo docker run -it b32b1efab579 /bin/bash 

```
[root@7b45fcc38acf /]# cd opt/java/openjdk/  
[root@7b45fcc38acf openjdk]# export JAVA_HOME=`pwd`  
[root@7b45fcc38acf openjdk]# export PATH=$JAVA_HOME/bin:$PATH  
[root@7b45fcc38acf openjdk]# export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar  
[root@7b45fcc38acf openjdk]# java -version  
openjdk version "1.8.0_292"
OpenJDK Runtime Environment Bisheng (build 1.8.0_292-b13)
OpenJDK 64-Bit Server VM Bisheng (build 25.292-b13, mixed mode)
```

[root@7b45fcc38acf openjdk]# exit 
