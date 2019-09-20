#!/usr/bin/env bash

# Frontend part
# Clone the financeager repository
git clone https://github.com/pylipp/financeager frontend

# Create venv
cd frontend
python3 -m venv .venv
source .venv/bin/activate
pip install -U pip
pip install .
deactivate
cd ..

# Backend part
cp -r frontend backend
