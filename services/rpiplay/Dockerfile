FROM dtcooper/raspberrypi-os:bookworm AS builder

RUN apt-get update && apt-get install -y cmake \
                     libavahi-compat-libdnssd-dev libplist-dev libssl-dev \
                     build-essential\
                     git

RUN apt-get install -y libraspberrypi-dev libraspberrypi-doc

WORKDIR /usr/src/app/

RUN git clone https://github.com/FD-/RPiPlay.git

WORKDIR /usr/src/app/RPiPlay/build

RUN cmake -D CMAKE_CXX_FLAGS="-O3" -D CMAKE_C_FLAGS="-O3" .. &&\
    make -j &&\
    make install

RUN apt-get install -y python3-pip python3-setuptools rsync

WORKDIR /rootfs

WORKDIR /usr/src/app

RUN pip3 install git+https://github.com/larsks/dockerize --break-system-packages

RUN dockerize -n --verbose -g video -g audio -o /rootfs/ /usr/local/bin/rpiplay &&\
    rm /rootfs/Dockerfile

FROM --platform=linux/arm/v8 busybox:stable

COPY --from=builder /rootfs/ ./

WORKDIR /usr/src/app/

COPY start.sh ./

RUN chmod +x ./start.sh

CMD ["sh", "./start.sh"]