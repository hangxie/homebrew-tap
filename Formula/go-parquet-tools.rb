class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.25.2.tar.gz"
  sha256 "a31a31d6bd8a785e5825a94dbb7a5f92036fd5392e41cc4b532016b35a07fa69"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.25.2/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=92f5712 -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.25.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "bf0c2c893b0be2f4877255eafdb8fc6283b00d11f0be9ae8f563ed9700a54727"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "bf0c2c893b0be2f4877255eafdb8fc6283b00d11f0be9ae8f563ed9700a54727"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "bf0c2c893b0be2f4877255eafdb8fc6283b00d11f0be9ae8f563ed9700a54727"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bf0c2c893b0be2f4877255eafdb8fc6283b00d11f0be9ae8f563ed9700a54727"
    sha256 cellar: :any_skip_relocation, sequoia:        "c241494d1b6efd1fd88ac3036a0bf70f326e86c1ffec52dbba11c9cbf48e4d61"
    sha256 cellar: :any_skip_relocation, sonoma:         "c241494d1b6efd1fd88ac3036a0bf70f326e86c1ffec52dbba11c9cbf48e4d61"
    sha256 cellar: :any_skip_relocation, ventura:        "c241494d1b6efd1fd88ac3036a0bf70f326e86c1ffec52dbba11c9cbf48e4d61"
    sha256 cellar: :any_skip_relocation, monterey:       "c241494d1b6efd1fd88ac3036a0bf70f326e86c1ffec52dbba11c9cbf48e4d61"
  end
end
