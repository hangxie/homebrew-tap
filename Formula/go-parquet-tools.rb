class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.22.2.tar.gz"
  sha256 "710172bccebfd81511788f451864a946fbf3696ac3ddf81c8ea77fbf62c1b683"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.22.2/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=2f24732 -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.22.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7e570ef52a1eb3f47ac2ba9e4ff805b6b8b0934cf7979a23d7a8220f1b061334"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7e570ef52a1eb3f47ac2ba9e4ff805b6b8b0934cf7979a23d7a8220f1b061334"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7e570ef52a1eb3f47ac2ba9e4ff805b6b8b0934cf7979a23d7a8220f1b061334"
    sha256 cellar: :any_skip_relocation, sonoma:         "71453e50f24c9a2303a69e3d94ded6d11bb54b596f2352e1908a6a817c864b38"
    sha256 cellar: :any_skip_relocation, ventura:        "71453e50f24c9a2303a69e3d94ded6d11bb54b596f2352e1908a6a817c864b38"
    sha256 cellar: :any_skip_relocation, monterey:       "71453e50f24c9a2303a69e3d94ded6d11bb54b596f2352e1908a6a817c864b38"
  end
end
