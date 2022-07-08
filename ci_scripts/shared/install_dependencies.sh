#!/bin/sh

echo "## Installing dependencies..."

echo "### load ruby/gem paths to PATH"
cat << EOF >> ~/.zshrc
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="\$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:\$PATH"
fi
EOF
source ~/.zshrc


echo "### Install bunder"
gem install --user-install bundler:2.3.17

bundle config set --local deployment 'true'

echo "### Install bundle"
bundle install

echo "## End of installing dependencies"
