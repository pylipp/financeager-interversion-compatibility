#!/usr/bin/env bash

set -e

# Check out appropriate backend version
( cd backend && git checkout "$FINANCEAGER_BACKEND" )
source backend/.venv/bin/activate

# Start webservice
python/print_financeager_version
python/start_webservice &
WEBSERVICE_PID=$!
sleep 2
deactivate

# Check out appropriate frontend version
(cd frontend && git checkout "$FINANCEAGER_FRONTEND")
source frontend/.venv/bin/activate

# Run test
python/print_financeager_version
python/run_test
deactivate

# Terminate webservice
kill $WEBSERVICE_PID
