#! /usr/bin/env bash
readonly BRANCH=$(git rev-parse --abbrev-ref HEAD)
if test "$BRANCH" != master; then
  echo "Can only release into production from master branch" 1>&2
  exit 1
fi
set -eux
# Build it
gradle clean buildDebian

# Check everything is checked in and pushed
git diff --exit-code
git diff --cached --exit-code
readonly VERSION=$(grep version gradle.properties | cut -d= -f2)
git tag --sign --annotate v${VERSION}

FILE=$(find build -type f -name '*.deb')
PKG=$(basename $FILE .deb)
scp $FILE prditsubpkg01:/var/www/html/packages/its/dev/ubuntu/

mailx -s "$PKG" "Troy.D.Smith@BrisBane.qld.gov.au" <<EOF
Hi Troy,

A new $PKG is ready for release on http://prditsubpkg01/packages/its/dev/ubuntu/.
Please review the Change Log on [BitBucket](https://bitbucket.org/bccits/hateoas-scats) and release the package.

Kind Regards,
Veit
EOF

git push --all
