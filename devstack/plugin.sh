# plugin.sh - DevStack plugin.sh dispatch script sahara-dashboard

SAHARA_DASH_DIR=$(cd $(dirname $BASH_SOURCE)/.. && pwd)

function install_sahara_dashboard {
    sudo pip install --upgrade ${SAHARA_DASH_DIR}

    cp -a ${SAHARA_DASH_DIR}/sahara_dashboard/enabled/* ${DEST}/horizon/openstack_dashboard/enabled/
    python ${DEST}/horizon/manage.py collectstatic --noinput
    python ${DEST}/horizon/manage.py compress --force
}

# check for service enabled
if is_service_enabled sahara-dashboard; then

    if [[ "$1" == "stack" && "$2" == "pre-install"  ]]; then
        # Set up system services
        # no-op
        :

    elif [[ "$1" == "stack" && "$2" == "install"  ]]; then
        # Perform installation of service source
        # no-op
        :

    elif [[ "$1" == "stack" && "$2" == "post-config"  ]]; then
        # Configure after the other layer 1 and 2 services have been configured
        echo_summary "Installing Sahara Dashboard"
        install_sahara_dashboard

    elif [[ "$1" == "stack" && "$2" == "extra"  ]]; then
        # Initialize and start the app-catalog-ui service
        # no-op
        :
    fi

    if [[ "$1" == "unstack"  ]]; then
        # Shut down app-catalog-ui services
        # no-op
        :
    fi

    if [[ "$1" == "clean"  ]]; then
        # Remove state and transient data
        # Remember clean.sh first calls unstack.sh
        # no-op
        :
    fi
fi