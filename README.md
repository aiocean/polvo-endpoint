# Endpoint service

Proxy giúp grpc-web có thể kết nối với các grpc service.

## Config

Cần phải chuẩn bị các file sau đây:

1. api_descriptor.pb
1. api_config.yaml

## Step #1: Generate api_descriptor.pb

Clone repo proto về thư mục ngang hàng với thư mục hiện tại (../)

```
protoc \
    --include_imports \
    --include_source_info \
    --proto_path=../proto/proto \
    --descriptor_set_out=api_descriptor.pb \
    ../proto/proto/aiocean/polvo/v1/polvo.proto \
    ../proto/proto/aiocean/polvo/v1/polvo_service.proto
```

## Step #2: Create Cloud Endpoint

Tạo file api_config.yaml với nội dung như sau:

```yaml
type: google.api.Service
config_version: 3
name: polvo-endpoint.endpoints.aio-shopify-services.cloud.goog
title: Polvo API Endpoint

authentication:
  providers:
    - id: google_service_account
      issuer: polvo-endpoint-client
      jwks_uri: https://www.googleapis.com/robot/v1/metadata/x509/polvo-endpoint-client
  rules:
    - selector: "*"
      requirements:
        - provider_id: google_service_account
endpoints:
  - name: polvo-endpoint.aiocean.services
    allow_cors: true
apis:
  - name: aiocean.polvo.v1.PolvoService

usage:
  rules:
    - selector: aiocean.polvo.v1.PolvoService.*
      allow_unregistered_calls: true

backend:
  rules:
    - selector: "aiocean.polvo.v1.PolvoService.*"
      address: grpcs://polvo.aiocean.services
```

```
gcloud endpoints services deploy api_descriptor.pb api_config.yaml
```

## Step #3: Build ESP Image

```
./gcloud_build_image -s polvo-endpoint.endpoints.trueprofit-frontend.cloud.goog -p trueprofit-frontend -c 2021-06-21r0
```

## Step #4: Deploy to cloud run

```
aiocli apply
```
