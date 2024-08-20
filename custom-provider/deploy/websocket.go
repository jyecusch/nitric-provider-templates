package deploy

import (
	deploymentspb "github.com/nitrictech/nitric/core/pkg/proto/deployments/v1"
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (a *NitricCustomPulumiProvider) Websocket(ctx *pulumi.Context, parent pulumi.Resource, name string, config *deploymentspb.Websocket) error {
	// TODO: Implement Websocket deployment for the custom provider
	return status.Error(codes.Unimplemented, "Websocket deployment is not implemented for the custom provider")
}
