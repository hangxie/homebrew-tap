class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.22.4.tar.gz"
  sha256 "a6a51ba6a4974eb8d00d8a9edffa19c0e4c7456ab3e227cc836c4a3359d346de"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.22.4/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=5a96a21 -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.22.4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ff209d6cd563f644c67a79e8d4b56a3345054512d8af29182a3caf24a406d5f2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ff209d6cd563f644c67a79e8d4b56a3345054512d8af29182a3caf24a406d5f2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ff209d6cd563f644c67a79e8d4b56a3345054512d8af29182a3caf24a406d5f2"
    sha256 cellar: :any_skip_relocation, sonoma:         "1c56b9016829406c5c3ff3c5fef43fb7f983cd52b8adef3e5bcb27839cc1199e"
    sha256 cellar: :any_skip_relocation, ventura:        "1c56b9016829406c5c3ff3c5fef43fb7f983cd52b8adef3e5bcb27839cc1199e"
    sha256 cellar: :any_skip_relocation, monterey:       "1c56b9016829406c5c3ff3c5fef43fb7f983cd52b8adef3e5bcb27839cc1199e"
  end
end
