FROM dtcooper/raspberrypi-os:bookworm AS builder

RUN apt-get update && sudo apt-get install cmake libavahi-compat-libdnssd-dev libplist-dev libssl-dev \
libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev gstreamer1.0-libav \
gstreamer1.0-vaapi gstreamer1.0-plugins-bad git

WORKDIR /app

RUN git clone https://github.com/FD-/RPiPlay.git rpiplay

WORKDIR /app/rpiplay

RUN mkdir build && cd build && cmake .. && make -j

FROM dtcooper/raspberrypi-os:bookworm

COPY --from=builder /app /app

WORKDIR /app/rpiplay

COPY start.sh ./

RUN chmod +x ./start.sh

CMD ["sh", "./start.sh"]