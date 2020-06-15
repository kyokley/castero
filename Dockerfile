# docker run -it \
#     -v /etc/machine-id:/etc/machine-id \
#     -v /run/user/$(id -u)/pulse:/run/user/1000/pulse \
#     -v /var/lib/dbus:/var/lib/dbus \
#     -v /dev/shm:/dev/shm \
#     --device /dev/snd \
#     --name castero \
#     kyokley/castero

FROM python:3.8-slim

RUN apt update && \
        apt upgrade -y && \
        apt install -y vlc

RUN pip install -U pip castero
ENTRYPOINT ["castero"]
