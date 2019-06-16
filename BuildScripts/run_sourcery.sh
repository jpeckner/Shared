#!/bin/bash

set -e

AUTO_MOCKABLE_IMPORTS="
import CoreLocation
import Foundation
import Shared
"
sourcery                                            \
  --sources "$SRCROOT/Shared"                       \
  --templates "$SRCROOT/Shared/Sourcery/Templates"  \
  --args imports="$AUTO_MOCKABLE_IMPORTS"           \
  --output "$SRCROOT/Shared/Sourcery/Output"
