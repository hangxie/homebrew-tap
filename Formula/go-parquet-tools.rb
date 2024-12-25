class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.25.5.tar.gz"
  sha256 "a9c322dc862c335a1943415e3b50a25c3be4eeeef1c32ffe00aab10bc7857393"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.25.5/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=f5ca2d9 -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.25.5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "db667e00cc6fd6312f2745231f09c31012caf66225ca81ef5da9364c3d8ab6a4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "db667e00cc6fd6312f2745231f09c31012caf66225ca81ef5da9364c3d8ab6a4"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "db667e00cc6fd6312f2745231f09c31012caf66225ca81ef5da9364c3d8ab6a4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "db667e00cc6fd6312f2745231f09c31012caf66225ca81ef5da9364c3d8ab6a4"
    sha256 cellar: :any_skip_relocation, sequoia:        "9fa960bca39c109b756d338a8666a7080e12894edec3699798d5145b36a7f4b8"
    sha256 cellar: :any_skip_relocation, sonoma:         "9fa960bca39c109b756d338a8666a7080e12894edec3699798d5145b36a7f4b8"
    sha256 cellar: :any_skip_relocation, ventura:        "9fa960bca39c109b756d338a8666a7080e12894edec3699798d5145b36a7f4b8"
    sha256 cellar: :any_skip_relocation, monterey:       "9fa960bca39c109b756d338a8666a7080e12894edec3699798d5145b36a7f4b8"
  end
end
