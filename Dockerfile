ARG IMAGE_VARIANT=slim-buster
ARG OPENJDK_VERSION=8
ARG PYTHON_VERSION=3.9.4

FROM python:${PYTHON_VERSION}-${IMAGE_VARIANT} AS py3
FROM openjdk:${OPENJDK_VERSION}-${IMAGE_VARIANT}

COPY --from=py3 / /

ARG PYSPARK_VERSION=3.1.1
RUN pip --no-cache-dir install pyspark==${PYSPARK_VERSION}

ENTRYPOINT ["python"]
COPY requirements.txt ./
RUN pip install -r requirements.txt


RUN echo "***********Installing *************"


# SPARK
COPY . /main


WORKDIR /main
ENTRYPOINT [ "python" ]

CMD [ "main.py" ]
