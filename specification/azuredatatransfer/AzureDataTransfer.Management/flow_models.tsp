import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./common_models.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AzureDataTransfer;

/**
 * Properties of flow
 */
model FlowProperties {
  /**
   * The connection associated with this flow
   */
  connection?: SelectedResource;

  /**
   * Dataflow GUID associated with this flow
   */
  @visibility(Lifecycle.Read)
  flowId?: string;

  /**
   * AME, PME, or TORUS only! AKV Chain Containing SAS Token
   */
  keyVaultUri?: string;

  /**
   * Link status of the current flow
   */
  @visibility(Lifecycle.Read)
  linkStatus?: LinkStatus;

  /**
   * Resource ID of the linked flow
   */
  @visibility(Lifecycle.Read)
  linkedFlowId?: string;

  /**
   * Status of the current flow
   */
  status?: FlowStatus;

  /**
   * Storage Account
   */
  storageAccountName?: string;

  /**
   * Storage Account ID
   */
  storageAccountId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * Storage Container Name
   */
  storageContainerName?: string;

  /**
   * Service Bus Queue ID
   */
  serviceBusQueueId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ServiceBus/namespaces/queues";
    }
  ]>;

  /**
   * The flow type for this flow
   */
  flowType?: FlowType;

  /**
   * Transfer Storage Blobs or Tables
   */
  dataType?: DataType;

  /**
   * Provisioning state of the flow
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The policies for this flow
   */
  policies?: string[];

  /**
   * The selected schema for this flow
   */
  schema?: Schema;

  /**
   * The messaging options for this flow
   */
  messagingOptions?: MessagingOptions;

  /**
   * The URI to the customer managed key for this flow
   */
  customerManagedKeyVaultUri?: url;

  /**
   * The flow stream identifier
   */
  streamId?: string;

  /**
   * The protocol of the stream
   */
  streamProtocol?: StreamProtocol;

  /**
   * The latency of the stream in milliseconds
   */
  streamLatency?: int64;

  /**
   * The passphrase used for SRT streams
   */
  passphrase?: string;

  /**
   * The source IP address and CIDR ranges of the stream
   */
  sourceAddresses?: StreamSourceAddresses;

  /**
   * The destination endpoints of the stream
   */
  destinationEndpoints?: string[];

  /**
   * The destination endpoint ports of the stream
   */
  destinationEndpointPorts?: int64[];
}

/**
 * Status of the current flow.
 */
union FlowStatus {
  string,

  /**
   * The flow is currently enabled and able to send or receive data.
   */
  Enabled: "Enabled",

  /**
   * The flow is currently disabled and cannot send or receive data.
   */
  Disabled: "Disabled",
}

/**
 * The flows resource patch definition.
 */
model FlowsPatch {
  ...ManagedServiceIdentityProperty;
  ...ArmTagsProperty;
}

/**
 * The source IP address and CIDR ranges of the stream
 */
model StreamSourceAddresses {
  /**
   * A source IP address or CIDR range
   */
  sourceAddresses?: string[];
}

/**
 * The protocol of the stream
 */
union StreamProtocol {
  string,

  /**
   * This Flow is using User Datagram Protocol for the video stream.
   */
  UDP: "UDP",

  /**
   * This Flow is using Secure Reliable Transfer for the video stream.
   */
  SRT: "SRT",

  /**
   * This Flow is using Real-time Transport Protocol for the video stream.
   */
  RTP: "RTP",
}

/**
 * Billing tier for this messaging flow.
 */
union FlowBillingTier {
  string,

  /**
   * Billing tier for messaging processing that charges based on how much data is transferred.
   */
  BlobTransport: "BlobTransport",

  /**
   * Billing tier for standard messaging processing that charges based on having the messaging resource allocated.
   */
  Standard: "Standard",

  /**
   * Billing tier for premium messaging processing that charges based on having the messaging resource allocated.
   */
  Premium: "Premium",
}

/**
 * The option associated with messaging flows.
 */
model MessagingOptions {
  /**
   * Billing tier for this messaging flow
   */
  billingTier?: FlowBillingTier;
}

/**
 * Transfer Storage Blobs or Tables
 */
union DataType {
  string,

  /**
   * The flow uses Azure Storage blobs to send or receive data.
   */
  Blob: "Blob",

  /**
   * The flow uses Azure Storage tables to send or receive data.
   */
  Table: "Table",
}

/**
 * Pending flow object
 */
model PendingFlow {
  ...FlowProperties;
  ...Azure.ResourceManager.TrackedResource<Flow>;

  /**
   * Subscription ID of the pending flow.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * Connection ID of the pending flow.
   */
  @visibility(Lifecycle.Read)
  connectionId?: string;
}

/**
 * A resource selected from ARM
 */
model SelectedResource {
  /**
   * Name of the connection
   */
  name?: string;

  /**
   * Id of the connection
   */
  id: string;

  /**
   * Location of the connection
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Name of the subscription with the connection
   */
  subscriptionName?: string;
}

/**
 * List of destination endpoint ports for the flow stream
 */
model GetDestinationEndpointPortsResult {
  /**
   * The destination endpoint port for the flow stream
   */
  ports?: int64[];
}

/**
 * Set the destination endpoint ports for the specified stream ID
 */
model SetDestinationEndpointPorts {
  /**
   * The specified stream ID destination endpoint ports
   */
  ports?: int64[];
}

/**
 * List of destination endpoints for the flow stream
 */
model GetDestinationEndpointsResult {
  /**
   * The destination endpoints for the flow stream
   */
  endpoints?: string[];
}

/**
 * Set the destination endpoints for the specified stream ID
 */
model SetDestinationEndpoints {
  /**
   * The specified stream ID destination endpoints
   */
  endpoints?: string[];
}

/**
 * The connection string for the specified streaming flow
 */
model GetStreamConnectionStringResult {
  /**
   * The connection string for the specified streaming flow
   */
  connectionString?: string;
}

/**
 * Set the passphrase used for SRT streams
 */
model SetStreamPassphrase {
  /**
   * The passphrase used for SRT streams
   */
  value?: string;
}

/**
 * Set the source addresses for the specified stream ID
 */
model SetSourceAddresses {
  /**
   * Source addresses
   */
  values?: string[];
}
