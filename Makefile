.PHONY: api_descriptor.pb
api_descriptor.pb:
	protoc \
		--include_imports \
		--include_source_info \
		--proto_path=../proto/proto \
		--descriptor_set_out=api_descriptor.pb \
		../proto/proto/aiocean/polvo/v1/polvo.proto \
		../proto/proto/aiocean/polvo/v1/polvo_service.proto

.PHONY: endpoint
endpoint: api_descriptor.pb
	gcloud endpoints services deploy api_descriptor.pb api_config.yaml

build:
	./gcloud_build_image -s polvo-endpoint.endpoints.aio-shopify-services.cloud.goog -p aio-shopify-services -c 2021-06-09r2

apply:
	aiocli apply
