class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.20.4.tar.gz"
  sha256 "902b45697ddcc6294fd4add77c1d64cdfacec11bb1e02e7ec09984588ad98ab8"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.20.4/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=ce432a3", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end
end
