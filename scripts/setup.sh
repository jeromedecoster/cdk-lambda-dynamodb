install-aws-cdk() {
    log npm install --global aws-cdk
    npm i --global aws-cdk

    # https://stackoverflow.com/a/46749819/1503073
    # https://arve0.github.io/npm-download-size/#aws-cdk
    log npm install --global download-size
    npm i --global download-size

    info compute aws-cdk package size
    # important package size !
    # aws-cdk@1.129.0: 12.71 MiB
    # aws-cdk@1.132.0: 12.98 MiB
    download-size aws-cdk
}

create-cdk-project() {
    # an empty directory is required to create a project
    mkdir --parents $PROJECT_DIR/cdk
    cd $PROJECT_DIR/cdk

    log cdk init app
    # possible values [csharp|fsharp|java|javascript|python|typescript]
    cdk init app --language typescript

    info compute package size
    # empty project crazy size ! 
    # 247M    .
    # 236M    .
    du --summarize --human-readable

    info compute files count
    # empty project crazy files count !
    # 14467
    # 14353
    find . -type f | wc -l

    log npm install @aws-cdk/aws-lambda
    npm install @aws-cdk/aws-lambda

    info compute @aws-cdk/aws-lambda package size
    # package size
    # @aws-cdk/aws-lambda@1.129.0: 3.62 MiB
    # @aws-cdk/aws-lambda@1.132.0: 3.66 MiB
    download-size @aws-cdk/aws-lambda

    log npm install @aws-cdk/aws-apigateway
    npm install @aws-cdk/aws-apigateway

    info compute @aws-cdk/aws-apigateway package size
    # package size
    # @aws-cdk/aws-apigateway@1.129.0: 5.02 MiB
    # @aws-cdk/aws-apigateway@1.132.0: 5.14 MiB
    download-size @aws-cdk/aws-apigateway

    log npm install @aws-cdk/aws-dynamodb
    npm install @aws-cdk/aws-dynamodb

    info compute @aws-cdk/aws-dynamodb package size
    # package size
    # @aws-cdk/aws-dynamodb@1.129.0: 4.04 MiB
    # @aws-cdk/aws-dynamodb@1.132.0: 4.08 MiB
    download-size @aws-cdk/aws-dynamodb
}

copy-cdk-templates() {
    [[ -d $PROJECT_DIR/cdk/bin ]] && mv $PROJECT_DIR/cdk/bin $PROJECT_DIR/cdk/bin.bak || true
    [[ -d $PROJECT_DIR/cdk/lib ]] && mv $PROJECT_DIR/cdk/lib $PROJECT_DIR/cdk/lib.bak || true
    cp --recursive $PROJECT_DIR/cdk.tmpl/* $PROJECT_DIR/cdk
}

cdk-bootstrap() {
    log START $(date "+%Y-%d-%m %H:%M:%S")
    START=$SECONDS

    # root account id
    ACCOUNT_ID=$(aws sts get-caller-identity \
        --query Account \
        --output text)
    log ACCOUNT_ID $ACCOUNT_ID

    # https://docs.aws.amazon.com/cdk/latest/guide/bootstrapping.html
    cdk bootstrap aws://$ACCOUNT_ID/$AWS_REGION

    log END $(date "+%Y-%d-%m %H:%M:%S")
    # 41 seconds
    info DURATION $(($SECONDS - $START)) seconds
}

install-aws-cdk
create-cdk-project
copy-cdk-templates
cdk-bootstrap
