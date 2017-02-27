FROM debian:8.6

ENV NODE_DOWNLOAD_URL=https://nodejs.org/dist/v6.10.0/node-v6.10.0-linux-x64.tar.xz
ENV PHANTOMJS_DOWNLOAD_URL=https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
ENV CASPERJS_DOWNLOAD_URL=https://github.com/casperjs/casperjs/tarball/1.1.0

RUN     apt-get update && apt-get install -y --force-yes curl xz-utils python && rm -rf /var/lib/apt/lists/* && find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true && find /usr/share/doc -empty|xargs rmdir || true && rm -rf /usr/share/man/* /usr/share/groff/* /usr/share/info/* && rm -rf /usr/share/lintian/* /usr/share/linda/* /var/cache/man/*

RUN     cd  /opt && \
        curl -SL "$NODE_DOWNLOAD_URL" -o node.tar.xz && \
        xz -d node.tar.xz && \
        tar -xf node.tar && \
        rm -f node.tar && \
        ln -s * node && \
        ln -s /opt/node/bin/node /usr/local/bin && \
        ln -s /opt/node/bin/npm /usr/local/bin

RUN     cd /opt && \
        curl -SL "$PHANTOMJS_DOWNLOAD_URL" -o phantomjs.tbz && \
        tar -xjf phantomjs.tbz && \
        rm -f phantomjs.tbz && \
        ln -s phantomjs* phantomjs && \
        ln -s /opt/phantomjs/bin/phantomjs /usr/local/bin
        
RUN     cd /opt && \
        curl -SL "$CASPERJS_DOWNLOAD_URL" -o casperjs.tgz && \
        tar -xzf casperjs.tgz && \
        rm -f casperjs.tgz && \
        mv casperjs* casperjs && \
        rm -f casperjs/bin/casperjs.exe && \
        ln -s /opt/casperjs/bin/bootstrap.js /usr/local/bin && \
        ln -s /opt/casperjs/bin/casperjs /usr/local/bin

COPY startTests.sh /startTests.sh

VOLUME ["/opt/myTests"]

ENTRYPOINT ["/startTests.sh"]






