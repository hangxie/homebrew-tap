class GoParquetTools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://github.com/hangxie/parquet-tools"
  url "https://github.com/hangxie/parquet-tools/archive/v1.23.2.tar.gz"
  sha256 "d241e5d3b36906e8687e3ed8cbced673a5b1c9f1b7c5df2cb236b91dea12eca3"
  license "BSD-3-Clause"

  depends_on "go" => :build

  resource("test-parquet") do
    url "https://github.com/hangxie/parquet-tools/raw/v1.23.2/testdata/good.parquet"
    sha256 "daf5090fbc5523cf06df8896cf298dd5e53c058457e34766407cb6bff7522ba5"
  end

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X github.com/hangxie/parquet-tools/cmd.version=v#{version} -X github.com/hangxie/parquet-tools/cmd.build=#{Time.now.iso8601} -X github.com/hangxie/parquet-tools/cmd.gitHash=126c0c1 -X github.com/hangxie/parquet-tools/cmd.source=source", *std_go_args, "-o", "#{bin}/parquet-tools"
  end

  test do
    resource("test-parquet").stage testpath

    output = shell_output("#{bin}/parquet-tools schema #{testpath}/good.parquet")
    assert_match "name=Parquet_go_root", output
  end

  bottle do
    root_url "https://github.com/hangxie/parquet-tools/releases/download/v1.23.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "508d41e229fa7696330d87da831276aa936cccc1a62b3244ada29e2e93297e25"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "508d41e229fa7696330d87da831276aa936cccc1a62b3244ada29e2e93297e25"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "508d41e229fa7696330d87da831276aa936cccc1a62b3244ada29e2e93297e25"
    sha256 cellar: :any_skip_relocation, sonoma:         "0b9636ec7ebea5ea0bf6c2e7fcd82e8a4733e08d732f7b985e1062e9ab56567e"
    sha256 cellar: :any_skip_relocation, ventura:        "0b9636ec7ebea5ea0bf6c2e7fcd82e8a4733e08d732f7b985e1062e9ab56567e"
    sha256 cellar: :any_skip_relocation, monterey:       "0b9636ec7ebea5ea0bf6c2e7fcd82e8a4733e08d732f7b985e1062e9ab56567e"
  end
end
