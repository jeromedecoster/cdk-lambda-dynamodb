curl-add() {
    [[ ! -f $PROJECT_DIR/cdk/cdk-outputs.json ]] && error abort ./cdk/cdk-outputs.json not found && exit
    
    APIGATEWAY_URL=$(jq --raw-output '.ApiGateway.Url' < $PROJECT_DIR/cdk/cdk-outputs.json)
    log APIGATEWAY_URL $APIGATEWAY_URL

    # random sha like c74e84eb1cc4
    # head -n 1 /dev/urandom | md5sum | head -c 12

    # random integer like 0573145346 (can start my one or more 0)
    # head /dev/urandom | tr -dc '0-9' | head -c 10

    VALUE=$(echo $RANDOM | md5sum | head -c 10)
    log VALUE $VALUE
    
    curl "${APIGATEWAY_URL}add" \
        --header "Content-Type: application/json" \
        --data '{"value":"'${VALUE}'"}' \
        --silent \
        | jq
}

curl-add
