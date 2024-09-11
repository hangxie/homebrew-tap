class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.22.3.tar.gz"
  sha256 "9f133fba0da7e0a923fc48b2da6403f7223ad882d8c51e1bfde1451974ec8562"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.22.3/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=211ef9a -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.22.3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6f632981c71cacbd1faab019d1296272a02d8d77f633fad9a8c64d979e1ea08f"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6f632981c71cacbd1faab019d1296272a02d8d77f633fad9a8c64d979e1ea08f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6f632981c71cacbd1faab019d1296272a02d8d77f633fad9a8c64d979e1ea08f"
    sha256 cellar: :any_skip_relocation, sonoma:         "193ff0b743db9ff640801f7a9e659791ef08aa03f7fac317d91693647a1a49f9"
    sha256 cellar: :any_skip_relocation, ventura:        "193ff0b743db9ff640801f7a9e659791ef08aa03f7fac317d91693647a1a49f9"
    sha256 cellar: :any_skip_relocation, monterey:       "193ff0b743db9ff640801f7a9e659791ef08aa03f7fac317d91693647a1a49f9"
  end
end
