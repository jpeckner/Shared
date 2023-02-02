#!/bin/bash

set -e

sourcery                                                \
  --sources "Shared"                       \
  --templates "Shared/Sourcery/Templates"  \
  --output "Shared/Sourcery/Output"
  
AUTO_MOCKABLE_IMPORTS="
import CoreLocation
import Foundation
import Shared
"
sourcery                                                                \
  --sources "Shared"                                       \
  --templates "SharedTestComponents/Sourcery/Templates"    \
  --args autoMockableImports="CoreLocation",autoMockableImports="Shared"                               \
  --output "SharedTestComponents/Sourcery/Output"
