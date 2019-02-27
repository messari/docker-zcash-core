# messari/zcash-core

A Zcash Core docker image.

[![messari/zcash-core][docker-pulls-image]][docker-hub-url] [![messari/zcash-core][docker-stars-image]][docker-hub-url] [![messari/zcash-core][docker-size-image]][docker-hub-url] [![messari/zcash-core][docker-layers-image]][docker-hub-url]

## Tags

- `2.0.3`, `latest` ([2.0.3/Dockerfile](https://github.com/messari/docker-zcash-core/blob/master/2.0.3/Dockerfile))

**Picking the right tag**

- `messari/zcash-core:latest`: points to the latest stable release available of Zcash Core. Use this only if you know what you're doing as upgrading Zcash Core blindly is a risky procedure.
- `messari/zcash-core:<version>`: based on a slim Debian image, points to a specific version branch or release of Zcash Core. Uses the pre-compiled binaries which are fully tested by the Zcash Core team.

## What is Zcash?

Zcash is a cryptocurrency like Bitcoin, but with full privacy using zero-knowledge cryptography. Learn more about [Zcash](https://z.cash/).

## What is Zcash Core?

Zcash Core is the Zcash reference client and contains all the protocol rules required for the Zcash network to function. Learn more about [Zcash Core](https://github.com/zcash/zcash).

## Usage

### How to use this image

This image contains the main binaries from the Zcash Core project - `zcashd`, `zcash-cli`. It behaves like a binary, so you can pass any arguments to the image and they will be forwarded to the `zcashd` binary:

```sh
❯ docker run --rm messari/zcash-core \
  -printtoconsole \
  -regtest=1 \
  -rpcallowip=172.17.0.0/16 \
  -rpcauth='foo:YmFy' \
  -server \
  -rest
```

By default, `zcashd` will run as user `zcash` for security reasons and with its default data dir (`~/.zcash`). If you'd like to customize where `zcashd` stores its data, you must use the `ZCASH_DATA` environment variable. The directory will be automatically created with the correct permissions for the `zcash` user and `zcashd` automatically configured to use it.

```sh
❯ docker run -e ZCASH_DATA=/var/lib/zcashd --rm messari/zcash-core \
  -printtoconsole \
  -regtest=1
```

You can also mount a directory in a volume under `/home/zcash/.zcash` in case you want to access it on the host:

```sh
❯ docker run -v ${PWD}/data:/home/zcash/.zcash --rm messari/zcash-core \
  -printtoconsole \
  -regtest=1
```


### Exposing Ports

Depending on the network (mode) the Zcash Core daemon is running as well as the chosen runtime flags, several default ports may be available for mapping.

Ports can be exposed by mapping all of the available ones (using `-P` and based on what `EXPOSE` documents) or individually by adding `-p`. This mode allows assigning a dynamic port on the host (`-p <port>`) or assigning a fixed port `-p <hostPort>:<containerPort>`.

Example for running a node in `regtest` mode mapping JSON-RPC/REST and P2P ports:

```sh
docker run --rm -it \
  -p 8232:8232 \
  -p 8233:8233 \
  messari/zcash-core \
  -printtoconsole \
  -regtest=1 \
  -rpcallowip=172.17.0.0/16 \
  -rpcauth='foo:YmFy'
```

To test that mapping worked, you can send a JSON-RPC curl request to the host port:

```
curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getnetworkinfo","params":[]}' http://foo:YmFy=@127.0.0.1:8232/
```

#### Mainnet

- JSON-RPC/REST: 8232
- P2P: 8233

#### Testnet

- JSON-RPC: 18232
- P2P: 18233


## License

The [messari/zcash-core][docker-hub-url] docker project is under MIT license.

[docker-hub-url]: https://hub.docker.com/r/messari/zcash-core
[docker-layers-image]: https://img.shields.io/imagelayers/layers/messari/zcash-core/latest.svg?style=flat-square
[docker-pulls-image]: https://img.shields.io/docker/pulls/messari/zcash-core.svg?style=flat-square
[docker-size-image]: https://img.shields.io/imagelayers/image-size/messari/zcash-core/latest.svg?style=flat-square
[docker-stars-image]: https://img.shields.io/docker/stars/messari/zcash-core.svg?style=flat-square
