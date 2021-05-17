# clamav-docker-lambda-layer

A container image with [ClamAV](https://www.clamav.net) (open-source antivirus engine) binaries and linked libraries, for use with AWS Lambda container images.

The base image used is `public.ecr.aws/lambda/provided:al2`, running Amazon Linux 2.

The binaries are located under `/opt/bin/` and the linked libraries under `/opt/lib/`.


## Usage

Copy the Lambda layer in a Dockerfile:

```Dockerfile
FROM public.ecr.aws/lambda/provided:al2
COPY --from=andreswebs/clamav-lambda /opt/ /opt
```

Or use it directly as a base image:

```Dockerfile
FROM andreswebs/clamav-lambda
```

## Authors

**Andre Silva** [@andreswebs](https://github.com/andreswebs)


## License

This project is licensed under the [Unlicense](UNLICENSE.md).


## Acknowledgments

Based on:

<https://github.com/upsidetravel/bucket-antivirus-function>

<https://github.com/truework/lambda-s3-antivirus>


## References

<https://aws.amazon.com/blogs/compute/working-with-lambda-layers-and-extensions-in-container-images/>
