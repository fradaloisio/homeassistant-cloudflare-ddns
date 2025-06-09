ARG BUILD_FROM
FROM $BUILD_FROM

# Install Python 3 and pip
RUN apk add --no-cache python3 py3-requests

WORKDIR /

# Install the one Python dependency

# Copy the DDNS script and our launcher
ADD https://raw.githubusercontent.com/timothymiller/cloudflare-ddns/f0d9510fffb026012b68b27b2d35ab742b255696/cloudflare-ddns.py /cloudflare-ddns.py
COPY run.sh /run.sh
RUN chmod a+x /run.sh /cloudflare-ddns.py

# This is what Supervisor will run
CMD [ "/run.sh" ]