curl-list() {
    [[ ! -f $PROJECT_DIR/cdk/cdk-outputs.json ]] && error abort ./cdk/cdk-outputs.json not found && exit

    APIGATEWAY_URL=$(jq --raw-output '.ApiGateway.Url' < $PROJECT_DIR/cdk/cdk-outputs.json)
    log APIGATEWAY_URL $APIGATEWAY_URL
    
    curl --silent "${APIGATEWAY_URL}" | jq
}

curl-list
