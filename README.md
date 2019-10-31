[![Build Status](https://travis-ci.org/pylipp/financeager-interversion-compatibility.svg?branch=master)](https://travis-ci.org/pylipp/financeager-interversion-compatibility)

## `financeager-interversion-compatibility`

This repository holds scripts for running Travis CI to check the compatibility of [`financeager`](https://github.com/pylipp/financeager) frontend and backend across different versions.

The backend (i.e. a local Flask webservice) is started using the `create_app()` function of the `financeager.fflask` module.
A slightly modified version of the `test_cli` module of the financeager test-suite is then run (it does not launch a Flask webservice itself since the webservice was just started separately). This procedure simulates CLI interaction triggering HTTP requests to the webservice.

The results of testing several combinations of frontend and backend versions are stored in a file.

## Compatibility matrix

backend `V` - frontend `>` | `v0.22` | `v0.21`
:--- | :---: | :---:
`v0.22` | yes | -
`v0.21` | -   | yes
