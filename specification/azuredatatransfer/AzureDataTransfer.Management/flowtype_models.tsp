import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./common_models.tsp";
import "./versions.tsp";

using Azure.Core;

namespace Microsoft.AzureDataTransfer;

model FlowTypeResource {
  useCase?: string;
  description?: string;
  allowedLocations?: azureLocation;
  policy?: Policy;
}

union EnablementStatusEnum {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
}

model Policy {
  antivirus: {
    clam?: {
      status?: EnablementStatusEnum;
      customSignatures?: url;
    };
    defender?: {
      status?: EnablementStatusEnum;
      customSignatures?: url;
    };
  };
  machineLearning?: {
    credentials?: EnablementStatusEnum;
    personalIdentification?: EnablementStatusEnum;
  };
  archives?: {
    status?: EnablementStatusEnum;
    maximumExpansionSizeBytes?: uint64;
    maximumDepth?: uint64;
    maximumCompressionRatio?: float64;
  };
  size?: {
    maximum?: uint64;
    minimum?: uint64;
  };
  type?: {
    status?: EnablementStatusEnum;
    filterLocation?: url;
  };
  xsd?: {
    defaultNamespace?: string;
    location?: url;
  };
  keywords?: {
    allow?: {
      ...StaticKeyword;
    }[];
    deny?: {
      ...StaticKeyword;
    }[];
  };
}

model StaticKeyword {
  word: string;
}
