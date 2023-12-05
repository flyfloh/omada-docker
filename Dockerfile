FROM ubuntu:20.04

RUN apt-get update && apt-get -y install curl jsvc mongodb-server openjdk-8-jre-headless
RUN curl -o omada.deb https://static.tp-link.com/upload/software/2023/202309/20230920/Omada_SDN_Controller_v5.12.7_Linux_x64.deb
RUN dpkg -i omada.deb

WORKDIR /opt/tplink/EAPController/lib
EXPOSE 8088 8043 8843 29810/udp 29811 29812 29813 29814
VOLUME ["/opt/tplink/EAPController/data","/opt/tplink/EAPController/logs"]
CMD ["/usr/bin/java","-server","-Xms128m","-Xmx1024m","-XX:MaxHeapFreeRatio=60","-XX:MinHeapFreeRatio=30","-XX:+HeapDumpOnOutOfMemoryError","-XX:HeapDumpPath=/opt/tplink/EAPController/logs/java_heapdump.hprof","-Djava.awt.headless=true","-cp","/opt/tplink/EAPController/lib/*::/opt/tplink/EAPController/properties:","com.tplink.smb.omada.starter.OmadaLinuxMain"]
