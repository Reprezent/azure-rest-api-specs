// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./action_models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureDataTransfer;

@armResourceOperations
interface AzureDataTransferOperationGroup {
  /**
   * Lists approved schemas for Azure Data Transfer.
   */
  @autoRoute
  listApprovedSchemas is ArmProviderActionSync<
    Request = ListApprovedSchemasRequest,
    Response = SchemasListResult
  >;
  /**
   * Validates a schema for Azure Data Transfer.
   */
  @autoRoute
  validateSchema is ArmProviderActionSync<
    Request = Schema,
    Response = ValidateSchemaResult
  >;
}
