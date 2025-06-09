# For arm64/aarch64 (native to your M1/M2/M3 Mac)
docker build \
  --build-arg BUILD_FROM="ghcr.io/home-assistant/aarch64-base:3.21" \
  -t fdaloisio/cloudflare-ddns-aarch64:1.0.0 .

docker build --platform linux/amd64 \
  --build-arg BUILD_FROM="ghcr.io/home-assistant/amd64-base:3.21" \
  -t dock .

docker build --platform linux/armv7 \
  --build-arg BUILD_FROM="ghcr.io/home-assistant/armv7-base:3.21" \
  -t fdaloisio/cloudflare-ddns-armv7:1.0.0 .

docker build --platform linux/armhf \
  --build-arg BUILD_FROM="ghcr.io/home-assistant/armhf-base:3.21" \
  -t fdaloisio/cloudflare-ddns-armhf:1.0.0 .

docker build --platform linux/386 \
  --build-arg BUILD_FROM="ghcr.io/home-assistant/i386-base:3.21" \
  -t fdaloisio/cloudflare-ddns-i386:1.0.0 .