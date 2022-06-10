#!/bin/sh

./shared/install_dependencies.sh

cd $CI_WORKSPACE

if [[ "$CI_PRODUCT_PLATFORM" == 'macOS' ]];
then
    export UPLOADING_ASSET_PATH="$CI_DEVELOPMENT_SIGNED_APP_PATH/$CI_XCODE_SCHEME.app"
elif [[ "$CI_PRODUCT_PLATFORM" == 'iOS' ]];
then
    export UPLOADING_ASSET_PATH="$CI_DEVELOPMENT_SIGNED_APP_PATH/$CI_XCODE_SCHEME.ipa"
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

bundle exec fastlane run set_github_release repository_name:"faberNovel/HLSAnalyzer" api_bearer:$GITHUB_PAT name:$CI_TAG tag_name:$CI_TAG description:"" upload_assets:$UPLOADING_ASSET_PATH
