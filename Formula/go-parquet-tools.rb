class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.25.4.tar.gz"
  sha256 "a3dc9995226625a1334705940f45b11febcd09ac8028f134f23beba7158d5a72"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.25.4/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=7238629 -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.25.4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "3884ec7dabf810cf92929ce743d03b12bec3f9ab18d9ef4fa17efbdb2006b053"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3884ec7dabf810cf92929ce743d03b12bec3f9ab18d9ef4fa17efbdb2006b053"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3884ec7dabf810cf92929ce743d03b12bec3f9ab18d9ef4fa17efbdb2006b053"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3884ec7dabf810cf92929ce743d03b12bec3f9ab18d9ef4fa17efbdb2006b053"
    sha256 cellar: :any_skip_relocation, sequoia:        "79613429959496026f47b8ffd29b1fb3b99310796c97170199ee1c661731f6cf"
    sha256 cellar: :any_skip_relocation, sonoma:         "79613429959496026f47b8ffd29b1fb3b99310796c97170199ee1c661731f6cf"
    sha256 cellar: :any_skip_relocation, ventura:        "79613429959496026f47b8ffd29b1fb3b99310796c97170199ee1c661731f6cf"
    sha256 cellar: :any_skip_relocation, monterey:       "79613429959496026f47b8ffd29b1fb3b99310796c97170199ee1c661731f6cf"
  end
end
