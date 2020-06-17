# docker run --rm -it \
#     -v $HOME/.local/share/castero:/home/user/.local/share/castero
#     -v /dev/shm:/dev/shm \
#     --device /dev/snd \
#     kyokley/castero

FROM python:3.8-slim

RUN apt update \
        && apt upgrade -y \
        && apt install -y vlc --no-install-recommends \
        && rm -rf /var/lib/apt/lists/*

RUN pip install -U pip castero

# Add non-privileged user
RUN groupadd -r user \
        && useradd -r -g user -G audio user \
        && mkdir /home/user \
        && chown -R user:user /home/user

USER user

ENTRYPOINT ["castero"]
