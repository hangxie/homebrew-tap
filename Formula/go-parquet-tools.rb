class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.23.0.tar.gz"
  sha256 "7fbb5f1739c9661b77f91913ceef639d77d0645472199255b6f0c8ac0abdee99"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.23.0/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=95c38ef -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.23.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b7bd72f72e7ab6fc624700c3dd8f9b3c8b1102e9da1e5ff412c0d2ada1f362b2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b7bd72f72e7ab6fc624700c3dd8f9b3c8b1102e9da1e5ff412c0d2ada1f362b2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b7bd72f72e7ab6fc624700c3dd8f9b3c8b1102e9da1e5ff412c0d2ada1f362b2"
    sha256 cellar: :any_skip_relocation, sonoma:         "c37c2c4ac0ae4326851418eba71983becc29480f26740ea9177055d93890f94b"
    sha256 cellar: :any_skip_relocation, ventura:        "c37c2c4ac0ae4326851418eba71983becc29480f26740ea9177055d93890f94b"
    sha256 cellar: :any_skip_relocation, monterey:       "c37c2c4ac0ae4326851418eba71983becc29480f26740ea9177055d93890f94b"
  end
end
