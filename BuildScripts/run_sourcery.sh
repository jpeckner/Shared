#!/bin/bash

set -e
  
sourcery                                                                    \
  --sources "Shared"                                                        \
  --templates "SharedTestComponents/Sourcery/Templates"                     \
  --args autoMockableImports="CoreLocation",autoMockableImports="Shared"    \
  --output "SharedTestComponents/Sourcery/Output"
