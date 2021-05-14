# Endpoint service

Proxy giúp grpc-web có thể kết nối với các grpc service.

## Config

Cần phải chuẩn bị các file sau đây:
 
1. api_descriptor.pb
1. api_config.yaml

## Step #1: Generate api_descriptor.pb

Clone repo proto về thư mục ngang hàng với thư mục hiện tại (../)

```
make api_descriptor.pb
```

## Step #2: Create Cloud Endpoint

```
make endpoint
```

## Step #3: Build ESP Image

```
make build
```

## Step #4: Deploy to cloud run

```
aiocli apply
```
