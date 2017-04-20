# ipms
Image processing microservice

## Examples

For the following examples [HTTPie](https://httpie.org/) is used to manage HTTP connections.

### Quality

* Quality set to 95%

```bash
http localhost:8000/v1/imagemagick/quality quality==95 < source.jpg > target.jpg
```

### Rotate

* Rotate the image to 90° (clockwise)

```bash
http localhost:8000/v1/imagemagick/rotate degrees==90 < source.jpg > target.jpg
```

### Thumb

* Crop to 500 by 300 at position 10,20

```bash
http localhost:8000/v1/imagemagick/thumb size==500x300+10+20 < source.jpg > target.jpg
```
