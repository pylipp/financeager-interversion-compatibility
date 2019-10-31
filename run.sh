#!/usr/bin/env bash

VERSIONS=( v0.22 c8568d9 )
EXIT_CODE=0

for FINANCEAGER_BACKEND in "${VERSIONS[@]}"; do
    for FINANCEAGER_FRONTEND in "${VERSIONS[@]}"; do
        [[ $FINANCEAGER_BACKEND = $FINANCEAGER_FRONTEND ]] && continue

        echo $FINANCEAGER_BACKEND $FINANCEAGER_FRONTEND
        echo $FINANCEAGER_BACKEND $FINANCEAGER_FRONTEND >> result.txt

        # Check out appropriate backend version
        ( cd backend && git checkout -q "$FINANCEAGER_BACKEND" )
        source backend/.venv/bin/activate
        pip install -qqq -U ./backend

        # Start webservice
        python/print_financeager_version
        python/start_webservice &
        WEBSERVICE_PID=$!
        sleep 2
        deactivate

        # Check out appropriate frontend version
        (cd frontend && git checkout -q "$FINANCEAGER_FRONTEND")
        source frontend/.venv/bin/activate
        pip install -qqq -U ./frontend

        # Run test
        python/print_financeager_version
        PYTHONPATH=frontend/test python/run_test &&\
            sed -i '$ s/$/ compatible/' result.txt || ((EXIT_CODE++))
        deactivate

        # Terminate webservice
        kill $WEBSERVICE_PID
    done
done

exit $EXIT_CODE
