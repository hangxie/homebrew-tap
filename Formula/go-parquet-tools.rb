class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.24.0.tar.gz"
  sha256 "82a57d51e825ff365e7c329041eef56efc44012097289c913278696ac2e90679"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.24.0/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=9b1bf9a -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.24.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "ba44edaa0b8db32da9f8f86d4ed755d8686aa4021851ba6e7462c5c1c1845d50"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ba44edaa0b8db32da9f8f86d4ed755d8686aa4021851ba6e7462c5c1c1845d50"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ba44edaa0b8db32da9f8f86d4ed755d8686aa4021851ba6e7462c5c1c1845d50"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ba44edaa0b8db32da9f8f86d4ed755d8686aa4021851ba6e7462c5c1c1845d50"
    sha256 cellar: :any_skip_relocation, sequoia:        "5a9127a58d0c06f44d19db93ade1758a3ca0a82af2c4642f543eb753f574ca40"
    sha256 cellar: :any_skip_relocation, sonoma:         "5a9127a58d0c06f44d19db93ade1758a3ca0a82af2c4642f543eb753f574ca40"
    sha256 cellar: :any_skip_relocation, ventura:        "5a9127a58d0c06f44d19db93ade1758a3ca0a82af2c4642f543eb753f574ca40"
    sha256 cellar: :any_skip_relocation, monterey:       "5a9127a58d0c06f44d19db93ade1758a3ca0a82af2c4642f543eb753f574ca40"
  end
end
