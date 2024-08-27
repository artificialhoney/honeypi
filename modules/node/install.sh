#!/bin/bash
HONEYPI_NODE_VERSION=${HONEYPI_NODE_VERSION:-20.9.0}
DIST=node-v${HONEYPI_NODE_VERSION}-linux-armv6l
curl -O https://unofficial-builds.nodejs.org/download/release/v${HONEYPI_NODE_VERSION}/$DIST.tar.xz
tar -xf $DIST.tar.xz -d $HOME/$DIST
rm $HOME/$DIST.tar.xz

echo "[[ -d $HOME/$DIST ]] && export PATH=$HOME/$DIST/bin:$PATH" >> ~/.bashrc