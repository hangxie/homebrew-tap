#!/bin/bash

set -euo pipefail

VERSION=$1

if [ -z "${VERSION}" ]; then
    echo Usage: $(basename $0) version
    exit 1
fi

if ! SHA256=$(curl -fsL https://github.com/hangxie/parquet-tools/archive/${VERSION}.tar.gz | shasum -a 256 | awk '{print $1}'); then
    echo failed to retrirve version ${VERSION}
    exit 1
fi

cat > $(dirname $0)/Formula/go-parquet-tools.rb <<EOF
class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/${VERSION}.tar.gz"
  sha256 "${SHA256}"
  license "BSD-3-Clause"

  depends_on "go" => :build

  conflicts_with "parquet-tools", because: "both install \`parquet-tools\` executables"

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/${VERSION}/cmd/testdata/good.parquet"
    sha256 "d6ab36ac8bd23da136b7f8bd2a6c188db6421ea4e85870e247e57ddf554584ed"
  end

  def install
    system "go", "build", "-ldflags", "-s -w -X main.version=v#{version} -X main.build=#{Time.now.iso8601}", *std_go_args, "-o", bin/"parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end
end
EOF
