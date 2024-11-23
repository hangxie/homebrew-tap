class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.25.3.tar.gz"
  sha256 "af9cc335b9f30873495de4cb4ff2ca7c87b8f731315895963e8c9d28a89f16bb"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.25.3/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=46cb6cf -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.25.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "6c321933d7486046700a01220413d60338089be20a9d48db86d0f6a266defed5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6c321933d7486046700a01220413d60338089be20a9d48db86d0f6a266defed5"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6c321933d7486046700a01220413d60338089be20a9d48db86d0f6a266defed5"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6c321933d7486046700a01220413d60338089be20a9d48db86d0f6a266defed5"
    sha256 cellar: :any_skip_relocation, sequoia:        "5eb791464a9314cdf39a2a63f10fd47e1d2913927d19dd0caf3c2365a227615d"
    sha256 cellar: :any_skip_relocation, sonoma:         "5eb791464a9314cdf39a2a63f10fd47e1d2913927d19dd0caf3c2365a227615d"
    sha256 cellar: :any_skip_relocation, ventura:        "5eb791464a9314cdf39a2a63f10fd47e1d2913927d19dd0caf3c2365a227615d"
    sha256 cellar: :any_skip_relocation, monterey:       "5eb791464a9314cdf39a2a63f10fd47e1d2913927d19dd0caf3c2365a227615d"
  end
end
