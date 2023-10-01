FROM nginx:1.24.0-alpine
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
RUN pip3 install awscli
RUN pip3 install boto3
# COPY py_test.py usr/py_test.py
# RUN python3 usr/py_test.py