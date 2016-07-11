#! /usr/bin/env bash
## Inspired by https://gist.github.com/domenic/ec8b0fc8ab45f39403dd
## Decrypt ssh deploy key so we can push to Github from Travis

set -ev

${ENC_LABEL:="enc"}
${DEPLOY_KEY_ENC:="deploy_key.enc"}

ENC_KEY="encrypted_${ENC_LABEL}_key"
ENC_IV="encrypted_${ENC_LABEL}_iv"
DEPLOY_KEY=${DEPLOY_KEY_ENC%.enc}

openssl aes-256-cbc -K ${!ENC_KEY} -iv ${!ENC_IV} -in $DEPLOY_KEY_ENC -out $DEPLOY_KEY_ENC -d
chmod 600 $DEPLOY_KEY
eval `ssh-agent -s`
ssh-add $DEPLOY_KEY

