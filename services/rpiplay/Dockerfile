FROM dtcooper/raspberrypi-os:bookworm

RUN apt-get update && apt-get install -y cmake libavahi-compat-libdnssd-dev libplist-dev libssl-dev git build-essential

WORKDIR /app

RUN git clone https://github.com/FD-/RPiPlay.git rpiplay

WORKDIR /app/rpiplay

RUN mkdir build && cd build && cmake .. && make -j && make install

COPY start.sh ./

RUN chmod +x ./start.sh

CMD ["sh", "./start.sh"]