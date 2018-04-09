#! /usr/bin/env bash
set -eu
# Script to format all code to Google code conventions, which are actually quite good.
# TODO - this should be integrated into the build system (Maven or Gradle) but I do not yet know how.

# Best is to clone https://github.com/google/google-java-format.git and then to build and install it.
# Here we find the build JAR.
readonly JAR=$(find $HOME/.m2/repository -type f -name 'google-java-format*-all-deps.jar' | sort | tail -n1)
echo "# Using $JAR"

function recursively_format() {
  # shellcheck disable=SC2156
  find ${1:-.} -type f -name '*.java' -exec sh -c "echo '{}' ; java -jar $JAR --replace '{}'" \;
}

if test $# -eq 0; then
  recursively_format
else
  for A in "$@"; do
    if test -d $A; then
      recursively_format $A
    else
      echo $A
      java -jar $JAR --replace $A
    fi
  done
fi
