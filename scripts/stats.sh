cdk-stats() {
    cd $PROJECT_DIR/cdk

    # 270M crazy size !
    CDK_DIR_SIZE=$(du --summarize --human-readable | cut --fields 1)
    log CDK_DIR_SIZE $CDK_DIR_SIZE

    # 15286 crazy files count !
    CDK_FILES_COUNT=$(find . -type f | wc -l)
    log CDK_FILES_COUNT $CDK_FILES_COUNT
}

cdk-stats
