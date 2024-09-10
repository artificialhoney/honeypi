# honeypi

My Raspberry Pi Server.

## Installation

```bash
./setup.sh
```

## Usage

### Docker Swarm

```
docker swarm init --advertise-addr <MANAGER-IP>
docker service create --name registry --publish published=5000,target=5000 registry:2
# docker swarm join --token SWMTKN-1-43j7mg5pelqtb5242ac6yplrddfpflq4ykzi28fi8bclex8omb-9fmatto8un4y2ky5sym9j0z5u 192.168.178.63:2377
docker compose --env-file stack.env up -d
```

## License

Honeypi is available under the
[MIT license](https://opensource.org/licenses/MIT). See
[LICENSE](https://github.com/artificialhoney/honeypi/blob/HEAD/LICENSE) for the full
license text.
