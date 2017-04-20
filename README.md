# ipms
Image processing microservice

## Examples

For the following examples [HTTPie](https://httpie.org/) is used to manage HTTP connections.

### Basic commands

Ipms provides the following basic commands.

#### Format

* Format set to PNG

```bash
http localhost:8000/v1/imagemagick/format format==PNG < source.jpg > target.png
```

#### Quality

* Quality set to 95%

```bash
http localhost:8000/v1/imagemagick/quality quality==95 < source.jpg > target.jpg
```

#### Rotate

* Rotate the image to 90° (clockwise)

```bash
http localhost:8000/v1/imagemagick/rotate degrees==90 < source.jpg > target.jpg
```

#### Thumb

* Crop to 500 by 300 at position 10,20

```bash
http localhost:8000/v1/imagemagick/thumb size==500x300+10+20 < source.jpg > target.jpg
```

### Combine multiple commands

Commands will be executed from left to right. E.g. a request with the path `/thumb/rotate` translates to `rotate(thumb(<image>))`.

#### Thumb + Rotate

* Crop to 500 by 300 at position 10,20
* Rotate the image to 90° (clockwise)

```bash
http localhost:8000/v1/imagemagick/thumb/rotate size==500x300+10+20 degrees==90 < source.jpg > target.jpg
```
