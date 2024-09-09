#!/bin/bash

set -euo pipefail

REPO=github.com/hangxie/parquet-tools
VERSION=$1

if [ -z "${VERSION}" ]; then
    echo Usage: $(basename $0) version
    exit 1
fi

if ! GIT_HASH=$(git ls-remote https://${REPO} ${VERSION} | cut -c 1-7); then
    echo failed to retrirve git hash of version ${VERSION}
    exit 1
fi

if ! SRC_SHA256=$(curl -fsL https://${REPO}/archive/${VERSION}.tar.gz | shasum -a 256 | awk '{print $1}'); then
    echo failed to retrirve source code of version ${VERSION}
    exit 1
fi

TEST_FILE=https://${REPO}/raw/${VERSION}/testdata/good.parquet
if ! TEST_FILE_SHA256=$(curl -fsL ${TEST_FILE} | shasum -a 256 | awk '{print $1}'); then
    echo failed to retrieve test file of version ${VERSION}
    exit 1
fi

ARM64_BOTTLE=https://github.com/hangxie/parquet-tools/releases/download/${VERSION}/go-parquet-tools-${VERSION:1}.arm64_sonoma.bottle.tar.gz
if ! ARM64_CHKSUM=$(curl -fsL ${ARM64_BOTTLE} | shasum -a 256 | awk '{print $1}'); then
    echo failed to retrieve arm64 bottle for version ${VERSION}
    exit 1
fi

AMD64_BOTTLE=https://github.com/hangxie/parquet-tools/releases/download/${VERSION}/go-parquet-tools-${VERSION:1}.sonoma.bottle.tar.gz
if ! AMD64_CHKSUM=$(curl -fsL ${AMD64_BOTTLE} | shasum -a 256 | awk '{print $1}'); then
    echo failed to retrieve amd64 bottle for version ${VERSION}
    exit 1
fi

cat > $(dirname $0)/Formula/go-parquet-tools.rb <<EOF
class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://${REPO}"
  url "https://${REPO}/archive/${VERSION}.tar.gz"
  sha256 "${SRC_SHA256}"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "${TEST_FILE}"
    sha256 "${TEST_FILE_SHA256}"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X ${REPO}/cmd.version=v#{version} -X ${REPO}/cmd.build=#{Time.now.iso8601} -X ${REPO}/cmd.gitHash=${GIT_HASH}", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/${VERSION}"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "${ARM64_CHKSUM}"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "${ARM64_CHKSUM}"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "${ARM64_CHKSUM}"
    sha256 cellar: :any_skip_relocation, sonoma:         "${AMD64_CHKSUM}"
    sha256 cellar: :any_skip_relocation, ventura:        "${AMD64_CHKSUM}"
    sha256 cellar: :any_skip_relocation, monterey:       "${AMD64_CHKSUM}"
  end
end
EOF
