class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.24.1.tar.gz"
  sha256 "87f365d0a60e2620bd5b7fcafec4954f66ef061610676523ec69b4b7fabddd43"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.24.1/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=ce15f36 -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.24.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "1b7d75c29ceccaedeb5ef528ef59ebcbd2462dc20377d2958e75fe03cac6dfec"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1b7d75c29ceccaedeb5ef528ef59ebcbd2462dc20377d2958e75fe03cac6dfec"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1b7d75c29ceccaedeb5ef528ef59ebcbd2462dc20377d2958e75fe03cac6dfec"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1b7d75c29ceccaedeb5ef528ef59ebcbd2462dc20377d2958e75fe03cac6dfec"
    sha256 cellar: :any_skip_relocation, sequoia:        "8b0d212d49d1808b56497180ac376564455d006a962fb30c1f6bbacdebfeaf13"
    sha256 cellar: :any_skip_relocation, sonoma:         "8b0d212d49d1808b56497180ac376564455d006a962fb30c1f6bbacdebfeaf13"
    sha256 cellar: :any_skip_relocation, ventura:        "8b0d212d49d1808b56497180ac376564455d006a962fb30c1f6bbacdebfeaf13"
    sha256 cellar: :any_skip_relocation, monterey:       "8b0d212d49d1808b56497180ac376564455d006a962fb30c1f6bbacdebfeaf13"
  end
end
