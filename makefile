binaries: deploybin

# build runtime binary directly into the deploy director so it can be embedded directly into the deployment engine binary
runtimebin:
	@echo Building Extension Runtime Server
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o bin/runtime-extension-aws -ldflags="-s -w -extldflags=-static" ./cmd/runtime

predeploybin: runtimebin
	@cp bin/runtime-extension-aws cmd/deploy/runtime-extension-aws

deploybin: predeploybin
	@echo Building Extension Deployment Server
	@CGO_ENABLED=0 go build -o bin/deploy-extension -ldflags="-s -w -extldflags=-static" -ldflags="-X google.golang.org/protobuf/reflect/protoregistry.conflictPolicy=ignore" ./cmd/deploy
	@rm cmd/deploy/runtime-extension-aws

.PHONY: install
install: deploybin
	@echo installing extension deployment server to ${HOME}/.nitric/providers/custom/extension-0.0.1
	@mkdir -p ${HOME}/.nitric/providers/custom/
	@rm -f ${HOME}/.nitric/providers/custom/extension-0.0.1
	@cp bin/deploy-extension ${HOME}/.nitric/providers/custom/extension-0.0.1