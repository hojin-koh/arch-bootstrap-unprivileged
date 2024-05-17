FROM alpine:3.13.11

RUN apk add --no-cache --update g++ gcc meson make cmake samurai perl m4 autoconf automake sed file bash curl libarchive-tools patch pkgconf gzip linux-headers \
  && export _prefix=/build \
  && export CFLAGS="-no-pie -g0 -O3 -pipe -w -fomit-frame-pointer -I$_prefix/include" \
  && export CXXFLAGS="-no-pie -g0 -O3 -pipe -w -fomit-frame-pointer -I$_prefix/include" \
  && export CPPFLAGS="-I$_prefix/include" \
  && export LDFLAGS="-s -Wl,-O3 -static-libgcc -static -Wl,-static -Wl,--no-dynamic-linker -L$_prefix/include" \
  && export PKG_CONFIG_PATH=$_prefix/lib/pkgconfig/ \
  && export _ver_libcap=2.69 \
  && export _ver_bubblewrap=0.9.0 \
  && curl -LJkO "https://kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-$_ver_libcap.tar.xz" \
  && curl -LJkO "https://github.com/containers/bubblewrap/releases/download/v$_ver_bubblewrap/bubblewrap-$_ver_bubblewrap.tar.xz" \
  && tar xf libcap-$_ver_libcap.tar.xz \
  && cd libcap-$_ver_libcap \
  && make SHARED=no lib=lib prefix=$_prefix install \
  && cd .. \
  && tar xf bubblewrap-$_ver_bubblewrap.tar.xz \
  && cd bubblewrap-$_ver_bubblewrap \
  && meson setup -Ddefault_library=static --buildtype=release build \
  && meson compile -C build \
  && mv build/bwrap /

# Now the static bubblewrap binary is in the container's /bwrap
