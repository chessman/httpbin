FROM python:3

LABEL name="httpbin"
LABEL version="0.9.2"
LABEL description="A simple HTTP service."
LABEL org.kennethreitz.vendor="Kenneth Reitz"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN pip install --no-cache-dir pipenv

ADD Pipfile Pipfile.lock /httpbin/
WORKDIR /httpbin
RUN pipenv sync

ADD . /httpbin

RUN pipenv install /httpbin

EXPOSE 80

CMD ["pipenv", "run", "gunicorn", "-b", "0.0.0.0:80", "httpbin:app", "-k", "gevent", "--timeout", "600"]
