.PHONY: build run shell

build:
	docker build -t kyokley/castero .

run:
	docker run --rm -it \
	    -v $$HOME/.local/share/castero:/home/user/.local/share/castero \
	    -v /dev/shm:/dev/shm \
	    --device /dev/snd \
	    kyokley/castero

shell:
	docker run --rm -it \
	    -v $$HOME/.local/share/castero:/home/user/.local/share/castero \
	    -v /dev/shm:/dev/shm \
	    --device /dev/snd \
	    --entrypoint /bin/bash \
	    kyokley/castero
