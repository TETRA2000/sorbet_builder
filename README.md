# Sorbet builder

## AVX related issues on x86 Docker containers on Apple Silicon Mac

The official Sorbet binaries for x86 Linux are built with AVX.
However, certain environments, like Docker, which utilize Rosetta 2 for binary translation, are unable to run AVX instructions.
Therefore, you'll need to build it yourself while disabling AVX during compilation.

This problem is reported in this issue.
https://github.com/sorbet/sorbet/issues/1487

https://developer.apple.com/documentation/apple-silicon/about-the-rosetta-translation-environment#What-Cant-Be-Translated
> Rosetta translates all x86_64 instructions, but it doesn’t support the execution of some newer instruction sets and processor features, such as AVX, AVX2, and AVX512 vector instructions.


## Usage

Based on https://github.com/sorbet/sorbet-build-image

You can build a binary like this.
```bash
git submodule init
git submodule update
docker build --platform=linux/amd64 -t sorbet_builder .
docker run --rm --platform=linux/amd64 -it -v $PWD:/opt/app -w /opt/app sorbet_builder /opt/app/build.sh
# A binary will be placed on `out/sorbet`.
```

You can use the binary like this.
```bash
SRB_SORBET_EXE=/path/to/sorbet bundle exec srb tc
```
