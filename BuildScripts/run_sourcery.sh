#!/bin/bash

set -e

AUTO_MOCKABLE_IMPORTS="
import CoreLocation
import Foundation
import Shared
"
sourcery                                                \
  --sources "$PROJECT_DIR/Shared"                       \
  --templates "$PROJECT_DIR/Shared/Sourcery/Templates"  \
  --args imports="$AUTO_MOCKABLE_IMPORTS"               \
  --output "$PROJECT_DIR/Shared/Sourcery/Output"
