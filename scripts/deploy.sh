deploy() {
    log START $(date "+%Y-%d-%m %H:%M:%S")
    START=$SECONDS

    cd $PROJECT_DIR/cdk
    cdk deploy --all --require-approval never --outputs-file cdk-outputs.json
    
    log END $(date "+%Y-%d-%m %H:%M:%S")
    # 234 seconds (creation)
    #  23 seconds (no modification, just after creation)
    #  53 seconds (update lambda, uncomment `return buildResponse(200, event)`)
    #  67 seconds (update lambda,   comment `return buildResponse(200, event)`)
    info DURATION $(($SECONDS - $START)) seconds
}

deploy
