FROM ubuntu:25.04
RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Asia/Tokyo apt-get install -y build-essential wget automake libtool bison flex lv vim gawk libgmp3-dev libmpc-dev libmpfr-dev texinfo
RUN mkdir /build && cd /build && \
     wget https://sourceware.org/pub/binutils/releases/binutils-2.43.tar.gz && \
     wget https://sourceware.org/pub/gcc/releases/gcc-10.5.0/gcc-10.5.0.tar.gz && \
     wget ftp://sourceware.org/pub/newlib/newlib-3.3.0.tar.gz && \
     tar zxf binutils-2.43.tar.gz && \
     tar zxf gcc-10.5.0.tar.gz && \
     tar zxf newlib-3.3.0.tar.gz
RUN cd /build/binutils-2.43 && \
    ./configure --target=mips-elf --prefix=/usr/local/cross --disable-nls --disable-werror && \
    make && make install 
RUN export PATH=$PATH:/usr/local/cross/bin && \
    mkdir -p /build/gcc_build/gcc && cd /build/gcc_build/gcc && \
    /build/gcc-10.5.0/configure --target=mips-elf --with-arch=mips1 --with-endian=little --prefix=/usr/local/cross --disable-libssp --disable-libquadmath --without-headers \
        --disable-nls --disable-threads --disable-shared --disable-target-libiberty \
        --enable-languages=c && \
    make all-gcc && make install-gcc 
RUN export PATH=$PATH:/usr/local/cross/bin && \
    mkdir -p /build/gcc_build/newlib && cd /build/gcc_build/newlib && \
    /build/newlib-3.3.0/configure --target=mips-elf --with-arch=mips1 --with-endian=little --prefix=/usr/local/cross \
        --disable-nls --disable-threads --disable-shared --disable-newlib-reent \
        --disable-newlib-supplied-syscalls --enable-newlib-nano-malloc --disable-newlib-unbuf-stream-opt --enable-lite-exit --enable-newlib-global-atexit --enable-target-optspace && \
    make && make install 
RUN export PATH=$PATH:/usr/local/cross/bin && \
    cd /build/gcc_build/gcc && make clean && \
    /build/gcc-10.5.0/configure --target=mips-elf --with-arch=mips1 --with-endian=little --prefix=/usr/local/cross --disable-libssp --disable-libquadmath --without-headers \
        --disable-nls --disable-threads --disable-shared --disable-target-libiberty \
        --enable-languages=c --with-newlib && \
    make && make install
RUN mkdir /src && echo PS1=\"\\h:\\w\\$ \" >> /etc/bash.bashrc
ENV PATH="/usr/local/cross/bin:${PATH}"
#RUN useradd -m build && apt-get install sudo
#USER build
ENTRYPOINT ["bash"]
