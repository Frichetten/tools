FROM ubuntu

COPY * /root/tools/
WORKDIR /root/tools

RUN ./arsenal.sh container

ENTRYPOINT ["/bin/bash"]
