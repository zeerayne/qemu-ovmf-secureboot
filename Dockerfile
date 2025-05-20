ARG FEDORA_VERSION="36"

FROM fedora:${FEDORA_VERSION}
RUN dnf install -y openssl \
	edk2-ovmf qemu-system-x86 \
	python3 python3-requests

ARG FEDORA_VERSION
ARG USER=1000
ARG GROUP=1000

USER ${USER}:${GROUP}

WORKDIR /app
ADD --chown=${USER}:${GROUP} https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/${FEDORA_VERSION}/Everything/x86_64/os/images/pxeboot/vmlinuz .
COPY --chown=${USER}:${GROUP} --chmod=755 ovmf-vars-generator entrypoint.sh .

ENTRYPOINT [ "/app/entrypoint.sh" ]
CMD [ "ovmf-vars-generator" ]
