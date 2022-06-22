#!/bin/sh

# Dispatch ci_post_xcodebuild script for specific workflow


echo "#### Dispatching CI script to ./$CI_WORKFLOW/"

./"$CI_WORKFLOW"/ci_post_xcodebuild.sh
