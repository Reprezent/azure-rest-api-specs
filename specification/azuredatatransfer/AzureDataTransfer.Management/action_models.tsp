import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./common_models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AzureDataTransfer;

/**
 * The request used to list approved schemas within the resource provider.
 */
model ListApprovedSchemasRequest {
  /**
   * The name of the pipeline to filter approved schemas.
   */
  pipeline?: string;

  /**
   * The direction pipeline to filter approved schemas.
   */
  direction?: ListApprovedSchemasDirection;
}

/**
 * The direction pipeline to filter approved schemas.
 */
union ListApprovedSchemasDirection {
  Direction,
}

/**
 * The schemas list result.
 */
model SchemasListResult {
  /**
   * Schemas array.
   */
  value?: Schema[];
}


/**
 * The schema object.
 */
model Schema {
  /**
   * ID associated with this schema
   */
  id?: string;

  /**
   * Connection ID associated with this schema
   */
  connectionId?: string;

  /**
   * Status of the schema
   */
  status?: SchemaStatus;

  /**
   * Name of the schema
   */
  name?: string;

  /**
   * Content of the schema
   */
  content?: string;

  /**
   * The direction of the schema.
   */
  direction?: SchemaDirection;

  /**
   * Uri containing SAS token for the zipped schema
   */
  schemaUri?: url;

  /**
   * The Schema Type
   */
  schemaType?: SchemaType;
}

/**
 * Result of the schema validation.
 */
model ValidateSchemaResult {
  /**
   * Validation status of the schema
   */
  status?: ValidateSchemaStatus;

  /**
   * Message describing the schema validation
   */
  message?: string;
}


/**
 * Validation status of the schema
 */
union ValidateSchemaStatus {
  string,

  /**
   * Validation of the schema was successful.
   */
  Succeeded: "Succeeded",

  /**
   * Validation of the was unsuccessful.
   */
  Failed: "Failed",
}

/**
 * The Schema Type
 */
union SchemaType {
  string,

  /**
   * The schema represents a single XML schema definition file.
   */
  Xsd: "Xsd",

  /**
   * The schema represents a ZIP file with multiple XML schema definition files within it.
   */
  Zip: "Zip",
}

/**
 * Status of the schema
 */
union SchemaStatus {
  string,

  /**
   * A schema that has not been approved and is awaiting review.
   */
  New: "New",

  /**
   * A schema that has been approved and is ready for use.
   */
  Approved: "Approved",
}

/**
 * The direction of the schema.
 */
union SchemaDirection {
  Direction,
}