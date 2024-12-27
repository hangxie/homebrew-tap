class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.25.9.tar.gz"
  sha256 "61df81b68b58cfccd6b819bc3edf50e6ecf58e294195167517d71076fb047fd3"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.25.9/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=3d1f9fb -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.25.9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "a4cf04eb052c774bf3091a360ad579a19cc87434beb0765702106ca139839b97"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a4cf04eb052c774bf3091a360ad579a19cc87434beb0765702106ca139839b97"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a4cf04eb052c774bf3091a360ad579a19cc87434beb0765702106ca139839b97"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a4cf04eb052c774bf3091a360ad579a19cc87434beb0765702106ca139839b97"
    sha256 cellar: :any_skip_relocation, sequoia:        "a303324ed4bb0e8188609b1f1a1dcab9a7dca3b5d7c6b97d1defcb95986afa5f"
    sha256 cellar: :any_skip_relocation, sonoma:         "a303324ed4bb0e8188609b1f1a1dcab9a7dca3b5d7c6b97d1defcb95986afa5f"
    sha256 cellar: :any_skip_relocation, ventura:        "a303324ed4bb0e8188609b1f1a1dcab9a7dca3b5d7c6b97d1defcb95986afa5f"
    sha256 cellar: :any_skip_relocation, monterey:       "a303324ed4bb0e8188609b1f1a1dcab9a7dca3b5d7c6b97d1defcb95986afa5f"
  end
end
