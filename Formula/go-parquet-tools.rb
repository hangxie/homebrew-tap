class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.25.7.tar.gz"
  sha256 "7038abd746ef72d1ed20f45a973253f3c80fe68afbb7de44c2a779f5185fa69f"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.25.7/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=c3443a5 -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.25.7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "17d94797a1286f4fdf45bc226dece0a6f53580bf62cd17ac32f2751db40e6f04"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "17d94797a1286f4fdf45bc226dece0a6f53580bf62cd17ac32f2751db40e6f04"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "17d94797a1286f4fdf45bc226dece0a6f53580bf62cd17ac32f2751db40e6f04"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "17d94797a1286f4fdf45bc226dece0a6f53580bf62cd17ac32f2751db40e6f04"
    sha256 cellar: :any_skip_relocation, sequoia:        "1f966139d9d767df327d228233ac234fea52afe7098e6617ac7508fb3e03c2c9"
    sha256 cellar: :any_skip_relocation, sonoma:         "1f966139d9d767df327d228233ac234fea52afe7098e6617ac7508fb3e03c2c9"
    sha256 cellar: :any_skip_relocation, ventura:        "1f966139d9d767df327d228233ac234fea52afe7098e6617ac7508fb3e03c2c9"
    sha256 cellar: :any_skip_relocation, monterey:       "1f966139d9d767df327d228233ac234fea52afe7098e6617ac7508fb3e03c2c9"
  end
end
