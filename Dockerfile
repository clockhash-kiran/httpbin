FROM ubuntu:18.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt update -y && apt install python3-pip git -y && pip3 install --no-cache-dir pipenv

WORKDIR /httpbin
COPY Pipfile Pipfile.lock /httpbin/

RUN pipenv lock -r > requirements.txt && pip3 install --no-cache-dir -r requirements.txt

COPY . /httpbin
RUN pip3 install --no-cache-dir .

EXPOSE 80

CMD ["gunicorn", "-b", "0.0.0.0:80", "httpbin:app", "-k", "gevent"]
