#/bin/bash

sudo apt-get install --no-install-recommends build-essential git autoconf automake libtool \
    libpopt-dev libconfig-dev libasound2-dev avahi-daemon libavahi-client-dev libssl-dev libsoxr-dev \
    libplist-dev libsodium-dev libavutil-dev libavcodec-dev libavformat-dev uuid-dev libgcrypt-dev xxd -y

git clone https://github.com/mikebrady/shairport-sync.git ./tmp/shairport-sync
cd ./tmp/shairport-sync
autoreconf -fi
./configure --sysconfdir=/etc --with-alsa \
    --with-soxr --with-avahi --with-ssl=openssl --with-systemd --with-airplay-2
make
sudo make install
cd -

git clone https://github.com/mikebrady/nqptp.git ./tmp/nqptp
cd ./tmp/nqptp
autoreconf -fi
./configure --with-systemd-startup
make
sudo make install
cd -

sudo systemctl enable nqptp
sudo service nqptp start

sudo systemctl enable shairport-sync
sudo service shairport-sync start