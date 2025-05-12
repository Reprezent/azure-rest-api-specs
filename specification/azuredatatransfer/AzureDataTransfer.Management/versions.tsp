import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;

/**
 * Azure Data Transfer service resource provider
 */
@versioned(Versions)
namespace Microsoft.AzureDataTransfer;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2025-03-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2025_03_01_preview: "2025-03-01-preview",
}
