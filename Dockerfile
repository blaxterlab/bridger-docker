FROM ubuntu:14.04
LABEL maintainer "sujaikumar@gmail.com"

RUN apt-get update && apt-get upgrade -y -q

RUN apt-get install -y -q \
    libboost-iostreams-dev libboost-system-dev libboost-filesystem-dev \
    zlibc gcc-multilib apt-utils zlib1g-dev \
    cmake build-essential g++ git wget gzip unzip

RUN apt-get install -y -q libboost-serialization-dev

RUN wget https://downloads.sourceforge.net/project/rnaseqassembly/Bridger_r2014-12-01.tar.gz

RUN tar -xzf Bridger_r2014-12-01.tar.gz

WORKDIR /Bridger_r2014-12-01

#RUN sed -i 's/CFLAGS =/CFLAGS = -I\/usr\/include\/ncurses/' /Bridger_r2014-12-01/Makefile
#RUN sed -i 's/#CFLAGS_EXTRA= -L\/usr\/include\/ncurses/CFLAGS_EXTRA= -I\/usr\/include\/ncurses/' /Bridger_r2014-12-01/plugins/rsem/sam/Makefile

RUN apt-get install nano

RUN ./configure; exit 0
RUN make; exit 0
RUN make; exit 0

RUN adduser --disabled-password --gecos '' dockeruser
RUN mkdir /data
RUN chown -R dockeruser /data
USER dockeruser
WORKDIR /data

ENV PATH $PATH:/Bridger_r2014-12-01
