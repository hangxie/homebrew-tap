class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.23.1.tar.gz"
  sha256 "b42f563168ee58fd872793caed21f635b0912ae50ec6791b401c3bd832f9ba01"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.23.1/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=a7da203 -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.23.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "75277f9ecdfd9f35eec6ed921b06551db1237e8f7dbd63fbf98d954fffdc672f"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "75277f9ecdfd9f35eec6ed921b06551db1237e8f7dbd63fbf98d954fffdc672f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "75277f9ecdfd9f35eec6ed921b06551db1237e8f7dbd63fbf98d954fffdc672f"
    sha256 cellar: :any_skip_relocation, sonoma:         "704b0741dc8b53c7586d5813c0c9d6ce962c98381e893cd56b42bc13493894f9"
    sha256 cellar: :any_skip_relocation, ventura:        "704b0741dc8b53c7586d5813c0c9d6ce962c98381e893cd56b42bc13493894f9"
    sha256 cellar: :any_skip_relocation, monterey:       "704b0741dc8b53c7586d5813c0c9d6ce962c98381e893cd56b42bc13493894f9"
  end
end
