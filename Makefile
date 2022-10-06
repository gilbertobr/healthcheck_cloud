build-latest-version:
	@docker build --label "org.opencontainers.image.source=https://github.com/gilbertobr/healthcheck_cloud" -t ghcr.io/gilbertobr/healthcheck_cloud:latest .

push-latest-version:
	@docker push ghcr.io/gilbertobr/healthcheck_cloud:latest

start-latest-version:
	@docker run -d --name healthcheck_cloud -p 4000:4000 ghcr.io/gilbertobr/healthcheck_cloud:latest

stop-container:
	@docker stop healthcheck_cloud

remove-container:
	@docker rm healthcheck_cloud
