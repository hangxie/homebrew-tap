class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.25.0.tar.gz"
  sha256 "54f414e1dc998de7c704315c5ce4acfb14b1968bc48df05b3d9dd4455191470c"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.25.0/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=82e0c94 -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.25.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "a0f7c5c9acebee3401e8d6d41fb69ed69a3e4cbe8e8e08cf9ed2629825ff43d3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a0f7c5c9acebee3401e8d6d41fb69ed69a3e4cbe8e8e08cf9ed2629825ff43d3"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a0f7c5c9acebee3401e8d6d41fb69ed69a3e4cbe8e8e08cf9ed2629825ff43d3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a0f7c5c9acebee3401e8d6d41fb69ed69a3e4cbe8e8e08cf9ed2629825ff43d3"
    sha256 cellar: :any_skip_relocation, sequoia:        "26dc6b7e1b123ccb899513c28355d289612e68513017534496125fc2fc9c0b81"
    sha256 cellar: :any_skip_relocation, sonoma:         "26dc6b7e1b123ccb899513c28355d289612e68513017534496125fc2fc9c0b81"
    sha256 cellar: :any_skip_relocation, ventura:        "26dc6b7e1b123ccb899513c28355d289612e68513017534496125fc2fc9c0b81"
    sha256 cellar: :any_skip_relocation, monterey:       "26dc6b7e1b123ccb899513c28355d289612e68513017534496125fc2fc9c0b81"
  end
end
