# docker run --rm -it \
    # -v $HOME/.local/share/castero:/home/user/.local/share/castero \
    # -v /dev/shm:/dev/shm \
    # --device /dev/snd \
    # --user $(id -u):$(id -g) \
    # kyokley/castero

FROM python:3.8-slim as base

ENV HOME=/home/user
WORKDIR /home/user

RUN apt update \
        && apt upgrade -y \
        && apt install -y vlc --no-install-recommends \
        && rm -rf /var/lib/apt/lists/*

RUN pip install -U pip castero pdbpp

# Add non-privileged user
RUN groupadd -r user \
        && useradd -r -g user -G audio user \
        && mkdir -p /home/user/.config /home/user/.local/share/castero \
        && chown -R user:user /home/user \
        && chmod -R 777 /home/user


FROM base as dev
COPY . /home/user/castero
RUN cd /home/user/castero \
        && python setup.py install
USER user

ENTRYPOINT ["castero"]


FROM base as prod
USER user

ENTRYPOINT ["castero"]
