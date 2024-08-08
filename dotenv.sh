export $HONEYPI_ENVIRONMENT=${HONEYPI_ENVIRONMENT:-"local"}
echo "Loading environment from '${HONEYPI_ENVIRONMENT}.env'"
[ -f $HONEYPI_ENVIRONMENT.env ] && export $(grep -v '^#' $HONEYPI_ENVIRONMENT.env | xargs)