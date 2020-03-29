#!/bin/bash

set -e

sourcery                                                \
  --sources "$PROJECT_DIR/Shared"                       \
  --templates "$PROJECT_DIR/Shared/Sourcery/Templates"  \
  --output "$PROJECT_DIR/Shared/Sourcery/Output"
  
AUTO_MOCKABLE_IMPORTS="
import CoreLocation
import Foundation
import Shared
"
sourcery                                                                \
  --sources "$PROJECT_DIR/Shared"                                       \
  --templates "$PROJECT_DIR/SharedTestComponents/Sourcery/Templates"    \
  --args imports="$AUTO_MOCKABLE_IMPORTS"                               \
  --output "$PROJECT_DIR/SharedTestComponents/Sourcery/Output"
