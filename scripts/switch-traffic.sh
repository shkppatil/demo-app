#!/bin/bash

VERSION=$1  # Accepts 'blue' or 'green'

if [[ "$VERSION" != "blue" && "$VERSION" != "green" ]]; then
  echo "Usage: $0 [blue|green]"
  exit 1
fi

kubectl patch service node-app-service -p \
  "{\"spec\": {\"selector\": {\"app\": \"node-app\", \"version\": \"$VERSION\"}}}"
