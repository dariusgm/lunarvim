FROM dariusmurawski/lunarvim_base:latest
ARG version=5.0-1.1.2
RUN cd && curl -o bashdb.tar.gz https://altushost-swe.dl.sourceforge.net/project/bashdb/bashdb/${version}/bashdb-${version}.tar.bz2 && \
  tar xpf bashdb.tar.gz && \
  ln -s bashdb-${version} bashdb && \
  cd bashdb-${version} && \
  cat configure | sed "s/'5.0')/'5.1')/g" > configure_patch && \
  chmod +x ./configure_patch && \
  ./configure_patch --prefix=/usr && \
  make && \
  make install && \
  cat /usr/bin/bashdb | sed "s/print/echo/g" > /usr/bin/bashdb2 && \
  chmod +x /usr/bin/bashdb2 && \
  mv -f /usr/bin/bashdb2 /usr/bin/bashdb
