#!/bin/bash

set -e

sourcery                                    \
  --sources "Shared"                        \
  --templates "Shared/Sourcery/Templates"   \
  --output "Shared/Sourcery/Output"
  
sourcery                                                                    \
  --sources "Shared"                                                        \
  --templates "SharedTestComponents/Sourcery/Templates"                     \
  --args autoMockableImports="CoreLocation",autoMockableImports="Shared"    \
  --output "SharedTestComponents/Sourcery/Output"
