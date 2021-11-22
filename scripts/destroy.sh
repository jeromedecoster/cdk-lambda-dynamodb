destroy() {
    log START $(date "+%Y-%d-%m %H:%M:%S")
    START=$SECONDS

    cd $PROJECT_DIR/cdk
    cdk destroy --all --force
    
    log END $(date "+%Y-%d-%m %H:%M:%S")
    # 102 seconds (destruction)
    #  15 seconds (no modification, just after destruction)
    info DURATION $(($SECONDS - $START)) seconds
}

destroy
