#!/usr/bin/env bash

set -e

# Check out appropriate backend version
cd backend
git checkout "$FINANCEAGER_BACKEND"
source .venv/bin/activate

# Output version info
python -c "
from financeager import __version__
print(__version__)"

# Start webservice
python -c "
from financeager import fflask
fflask.create_app().run()" &
WEBSERVICE_PID=$!
sleep 2
deactivate
cd ..

# Check out appropriate frontend version
cd frontend
git checkout "$FINANCEAGER_FRONTEND"
source .venv/bin/activate

# Output version info
python -c "
from financeager import __version__
print(__version__)"

# Run test
cd test
python -c "
import unittest
import sys
from test_cli import CliFlaskTestCase, suite

CliFlaskTestCase.launch_server = lambda: 0

test_runner = unittest.TextTestRunner(verbosity=2)
result = test_runner.run(suite())
sys.exit(0 if result.wasSuccessful() else 1)
"
deactivate

# Terminate webservice
kill $WEBSERVICE_PID
