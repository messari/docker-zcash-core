build:
	cd 2.0.0 && docker build -t messari/zcash-core:2.0.0 .
	docker tag messari/zcash-core:2.0.0 messari/zcash-core:latest

push:
	docker push messari/dogecoin-core:1.10.0
	docker push messari/dogecoin-core:latest
