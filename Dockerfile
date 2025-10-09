# Base image
FROM debian:bookworm

# ARG ile kullanıcı adı/UID/GID opsiyonel
ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=1000

# Non-interactive ve temel paketler
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    sudo nano vim git curl wget ca-certificates \
    build-essential flex bison bc kmod cpio rsync \
    libncurses5-dev libssl-dev libelf-dev \
    gcc g++ make pkg-config file unzip zip tar xz-utils \
    crossbuild-essential-arm64 qemu-user-static binfmt-support \
    python3 python3-pip python3-distutils \
    busybox fakeroot util-linux \
    openssh-client dialog fdisk \
    && apt-get clean

# Kullanıcı ve sudo ayarı
RUN groupadd -g ${USER_GID} ${USERNAME} || true && \
    useradd -m -u ${USER_UID} -g ${USER_GID} -s /bin/bash ${USERNAME} || true && \
    mkdir -p /etc/sudoers.d && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME} && \
    chown -R ${USER_UID}:${USER_GID} /home/${USERNAME}

# Çalışma dizini
WORKDIR /mnt/output

# Varsayılan user ve shell
USER ${USERNAME}
CMD ["/bin/bash"]
