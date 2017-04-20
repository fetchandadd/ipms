# ipms
Image processing microservice

## Examples

For the following examples [HTTPie](https://httpie.org/) is used to manage HTTP connections.

### Quality

* Quality set to 95%
* Format set to PNG

```bash
http localhost:8000/v1/imagemagick/quality/95/png < source.jpg  > target.png
```

### Rotate

* Rotate the image to 90° (clockwise)
* Format set to JPG

```bash
http localhost:8000/v1/imagemagick/rotate/90/jpg < source.jpg  > target.jpg
```

### Thumb

* Crop to 500 by 300 at position 10,20
* Format set to JPG

```bash
http localhost:8000/v1/imagemagick/thumb/500x300+10+20/jpg < source.tiff > target.jpg
```
