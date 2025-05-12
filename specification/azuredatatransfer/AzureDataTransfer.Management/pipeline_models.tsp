import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AzureDataTransfer;

/**
 * Properties of pipeline
 */
model PipelineProperties {
  /**
   * Remote cloud of the data to be transferred or received
   */
  remoteCloud: string;

  /**
   * Display name of this pipeline
   */
  displayName?: string;

  /**
   * Connections associated with pipeline
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["id"])
  connections?: PipelineConnection[];

  /**
   * Subscribers of this resource
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  subscribers?: Subscriber[];

  /**
   * Provisioning state of the pipeline
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The policies for this pipeline
   */
  policies?: string[];

  /**
   * The flow types allowed for this pipeline
   */
  flowTypes?: FlowType[];
}

/**
 * The pipelines resource patch definition.
 */
model PipelinesPatch {
  /**
   * Properties of pipelines patch body.
   */
  properties?: PipelinesPatchProperties;

  ...ManagedServiceIdentityProperty;
  ...ArmTagsProperty;
}

/**
 * Properties of pipelines patch body.
 */
model PipelinesPatchProperties {
  /**
   * Connections associated with pipeline
   */
  @OpenAPI.extension("x-ms-identifiers", #["id"])
  connections?: PipelineConnection[];

  /**
   * The flow types allowed for this pipeline
   */
  flowTypes?: FlowType[];
}

/**
 * Connection body inside a pipeline
 */
model PipelineConnection {
  ...Record<unknown>;

  /**
   * Connection id inside pipeline
   */
  id: string;

  /**
   * Connection name inside pipeline
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Connection type inside pipeline
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Connection location inside pipeline
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Connection etag inside pipeline
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  /**
   * Connection properties inside pipeline
   */
  properties?: PipelineConnectionProperties;
}

/**
 * Connection properties inside pipeline
 */
model PipelineConnectionProperties {
  ...Record<unknown>;

  /**
   * Internal metadata of the connection inside pipeline.
   */
  internalMetadata?: InternalMetadataProperties;
}

/**
 * An individual that would like to subscribe to events that occur on a pipeline.
 */
model Subscriber {
  /**
   * Email of the subscriber
   */
  email?: string;

  /**
   * Number specifying what notifications to receive
   */
  notifications?: int64;
}

/**
 * Internal metadata of the connection inside pipeline.
 */
model InternalMetadataProperties {
  ...Record<unknown>;

  /**
   * Operation status associated with the last patch request
   */
  operationStatus?: OperationStatusProperties;

  /**
   * User that last set the approved status for this connection
   */
  @visibility(Lifecycle.Read)
  statusSetBy?: string;
}

/**
 * Operation status associated with the last patch request
 */
model OperationStatusProperties {
  /**
   * Operation status for the last patch request for this connection.
   */
  @visibility(Lifecycle.Read)
  status?: OperationStatusEnum;

  /**
   * Operation status ID of the last patch request for this connection.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Message for the operation for the last patch request for this connection.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Operation status for the last patch request for this connection.
 */
union OperationStatusEnum {
  string,

  /**
   * The last patch request for this connection completed with an error.
   */
  Failed: "Failed",

  /**
   * The last patch request for this connection completed.
   */
  Succeeded: "Succeeded",
}
