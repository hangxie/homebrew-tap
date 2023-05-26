class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.19.2.tar.gz"
  sha256 "b3960c13e3d7dce19e1cebc69c857c942f1a706e3788cc84bb06c00677274c47"
  license "BSD-3-Clause"

  depends_on "go" => :build

  conflicts_with "parquet-tools", because: "both install `parquet-tools` executables"

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.19.2/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=02eefa6", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end
end
