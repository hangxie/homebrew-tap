class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.25.1.tar.gz"
  sha256 "248728c47c9e9ad2b49f7f6c7193d51537905eb901775676b51908ca29ea8418"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.25.1/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=69d1ac9 -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.25.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "4cf37c28b4c20ec0d8eba2295fe47fb607651fc99b00bc3cd7f93c740beaf356"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4cf37c28b4c20ec0d8eba2295fe47fb607651fc99b00bc3cd7f93c740beaf356"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4cf37c28b4c20ec0d8eba2295fe47fb607651fc99b00bc3cd7f93c740beaf356"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4cf37c28b4c20ec0d8eba2295fe47fb607651fc99b00bc3cd7f93c740beaf356"
    sha256 cellar: :any_skip_relocation, sequoia:        "0ca6a0ebdec9adb2cc80e106aa9f946180354cdb02c46cadc65f045bba057052"
    sha256 cellar: :any_skip_relocation, sonoma:         "0ca6a0ebdec9adb2cc80e106aa9f946180354cdb02c46cadc65f045bba057052"
    sha256 cellar: :any_skip_relocation, ventura:        "0ca6a0ebdec9adb2cc80e106aa9f946180354cdb02c46cadc65f045bba057052"
    sha256 cellar: :any_skip_relocation, monterey:       "0ca6a0ebdec9adb2cc80e106aa9f946180354cdb02c46cadc65f045bba057052"
  end
end
