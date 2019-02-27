build:
	cd 2.0.3 && docker build -t messari/zcash-core:2.0.3 .
	docker tag messari/zcash-core:2.0.3 messari/zcash-core:latest

push:
	docker push messari/zcash-core:2.0.3
	docker push messari/zcash-core:latest
