FROM dtcooper/raspberrypi-os:bookworm AS builder

RUN apt-get update && apt-get install -y cmake libavahi-compat-libdnssd-dev libplist-dev libssl-dev git build-essential

WORKDIR /app

RUN git clone https://github.com/FD-/RPiPlay.git rpiplay

WORKDIR /app/rpiplay

RUN mkdir build && cd build && cmake .. && make -j

FROM dtcooper/raspberrypi-os:bookworm

COPY --from=builder /app /app

WORKDIR /app/rpiplay/build

COPY start.sh ./

RUN chmod +x ./start.sh

CMD ["sh", "./start.sh"]