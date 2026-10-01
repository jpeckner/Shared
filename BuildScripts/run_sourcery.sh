#!/bin/bash

set -e
  
mint run sourcery                                                                    \
  --sources "Shared"                                                        \
  --templates "SharedTestComponents/Sourcery/Templates"                     \
  --args autoMockableImports="CoreLocation",autoMockableImports="Shared"    \
  --output "SharedTestComponents/Sourcery/Output"
