# ipms
Image processing microservice

## Examples

For the following examples [HTTPie](https://httpie.org/) is used to manage HTTP connections.

### Basic commands

Ipms provides the following basic commands. A command consist of a path fragment (e.g. `rotate`) and a GET parameter (e.g. `degrees`). The path fragment triggers the execution of the specific command and the GET parameter delivers the value. 

A request `/rotate?degrees=90` can be seen as a function call `rotate(<image>, degrees=90)`.

#### Blur

* Blur the image with sigma=20 and radius=50

```bash
http localhost:8000/v1/imagemagick/blur sigma==20 radius==50 < source.jpg > target.png
```

#### Format

* Format set to PNG

```bash
http localhost:8000/v1/imagemagick/format format==png < source.jpg > target.png
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

Commands will be executed from left to right. E.g. a request `/thumb/rotate?size=500x300+10+20&degrees=90` translates to `rotate(thumb(<image>, size=500x300+10+20), degrees=90)`.

#### Thumb + Rotate

* Crop to 500 by 300 at position 10,20
* Rotate the image to 90° (clockwise)

```bash
http localhost:8000/v1/imagemagick/thumb/rotate size==500x300+10+20 degrees==90 < source.jpg > target.jpg
```
