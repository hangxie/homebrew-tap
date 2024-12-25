class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.25.6.tar.gz"
  sha256 "457e1cb11257f473f6363074b20b663f9805ceaba79ccb25382be3c588feee87"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.25.6/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=853f114 -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.25.6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "6922de63d3c1524f7681db14d6c90b52079309ac325ceed20ba136645df43738"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6922de63d3c1524f7681db14d6c90b52079309ac325ceed20ba136645df43738"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6922de63d3c1524f7681db14d6c90b52079309ac325ceed20ba136645df43738"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6922de63d3c1524f7681db14d6c90b52079309ac325ceed20ba136645df43738"
    sha256 cellar: :any_skip_relocation, sequoia:        "a35a3bdb781b034156aa4148c9319c7b2a4292aa188e1dda435e7e2b5fa6ee4d"
    sha256 cellar: :any_skip_relocation, sonoma:         "a35a3bdb781b034156aa4148c9319c7b2a4292aa188e1dda435e7e2b5fa6ee4d"
    sha256 cellar: :any_skip_relocation, ventura:        "a35a3bdb781b034156aa4148c9319c7b2a4292aa188e1dda435e7e2b5fa6ee4d"
    sha256 cellar: :any_skip_relocation, monterey:       "a35a3bdb781b034156aa4148c9319c7b2a4292aa188e1dda435e7e2b5fa6ee4d"
  end
end
