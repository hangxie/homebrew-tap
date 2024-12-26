class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.25.8.tar.gz"
  sha256 "1fe15349296324b298c92c858fb2ee4c9994a32550206e885db10c318c76a537"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.25.8/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=3cf63fe -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.25.8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "cf5b803c159258ac3a66e080d44cfbb3ca8db2f33a3a2d7390f553f25edc4714"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "cf5b803c159258ac3a66e080d44cfbb3ca8db2f33a3a2d7390f553f25edc4714"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "cf5b803c159258ac3a66e080d44cfbb3ca8db2f33a3a2d7390f553f25edc4714"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cf5b803c159258ac3a66e080d44cfbb3ca8db2f33a3a2d7390f553f25edc4714"
    sha256 cellar: :any_skip_relocation, sequoia:        "d25bf9ab477dcf7c3bb14211d565bbf5e7ed98c63e9b34c524d6d2ba27e8f967"
    sha256 cellar: :any_skip_relocation, sonoma:         "d25bf9ab477dcf7c3bb14211d565bbf5e7ed98c63e9b34c524d6d2ba27e8f967"
    sha256 cellar: :any_skip_relocation, ventura:        "d25bf9ab477dcf7c3bb14211d565bbf5e7ed98c63e9b34c524d6d2ba27e8f967"
    sha256 cellar: :any_skip_relocation, monterey:       "d25bf9ab477dcf7c3bb14211d565bbf5e7ed98c63e9b34c524d6d2ba27e8f967"
  end
end
