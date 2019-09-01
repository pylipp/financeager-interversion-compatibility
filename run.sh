#!/usr/bin/env bash

set -e

# Check out appropriate backend version
cd backend
git checkout "$FINANCEAGER_BACKEND"

# Output version info
.venv/bin/python -c "
from financeager import __version__
print(__version__)"

# Start webservice
.venv/bin/python -c "
from financeager import fflask
fflask.create_app().run()" &
WEBSERVICE_PID=$!
sleep 2
cd ..

# Check out appropriate frontend version
cd frontend
git checkout "$FINANCEAGER_FRONTEND"

# Output version info
.venv/bin/python -c "
from financeager import __version__
print(__version__)"

# Run test
echo "Running test..."

# Terminate webservice
kill $WEBSERVICE_PID
