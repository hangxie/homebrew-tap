class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.22.1.tar.gz"
  sha256 "dea032891ec43c07dc42520d84f378d160e37bf6f1f3e29293731608f1b8b8b5"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.22.1/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=2bb6993", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.22.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a219fcb30d398d55c880463ef7e816db2a778008bc2d1071924c7bb7ab545d03"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a219fcb30d398d55c880463ef7e816db2a778008bc2d1071924c7bb7ab545d03"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a219fcb30d398d55c880463ef7e816db2a778008bc2d1071924c7bb7ab545d03"
    sha256 cellar: :any_skip_relocation, sonoma:         "4e87965a65e7d9d4fa513077870a0d3dbcea45412cb0ed77d8addbe7e11b0bfd"
    sha256 cellar: :any_skip_relocation, ventura:        "4e87965a65e7d9d4fa513077870a0d3dbcea45412cb0ed77d8addbe7e11b0bfd"
    sha256 cellar: :any_skip_relocation, monterey:       "4e87965a65e7d9d4fa513077870a0d3dbcea45412cb0ed77d8addbe7e11b0bfd"
  end
end
