FROM dockerfile/ubuntu

RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update && \
  apt-get install -y google-chrome-stable && \
  rm -rf /var/lib/apt/lists/*

# Create a user
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/chrome && \
    echo "chrome:x:${uid}:${gid}:Chrome,,,:/home/chrome:/bin/bash" >> /etc/passwd && \
    echo "chrome:x:${uid}:" >> /etc/group && \
    echo "chrome ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/chrome && \
    chmod 0440 /etc/sudoers.d/chrome && \
    chown ${uid}:${gid} -R /home/chrome

USER chrome
ENV HOME /home/chrome

CMD []
ENTRYPOINT ["/usr/bin/google-chrome", "--no-sandbox"]
