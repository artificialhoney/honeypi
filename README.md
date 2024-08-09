# honeypi

My Raspberry Pi Server.

## Installation

```bash
git clone https://github.com/artificialhoney/honeypi honeypi
cd honeypi
cp local.env hive.env # make changes etc.
```

## Usage

__Run__:

> `honeypi run -e hive portainer` installs __Portainer__

__Sync__:

> `honeypi sync -e hive` syncs local folder to $HONEYPI_HOST

## License

Honeypi is available under the
[MIT license](https://opensource.org/licenses/MIT). See
[LICENSE](https://github.com/artificialhoney/honeypi/blob/HEAD/LICENSE) for the full
license text.
