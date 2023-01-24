HOMEBREW_TAG_VERSION="v1.4.0".freeze
class TagAg < Formula
  desc "Instantly jump to your ag or ripgrep matches."
  homepage "https://github.com/christopherthielen/tag"
  url "https://github.com/christopherthielen/tag/archive/refs/tags/#{HOMEBREW_TAG_VERSION}-christopherthielen.tar.gz"
  sha256 "c1891349f7cbc4ebacfdf36387de2234f3424e19f9a7ef25da85ecbf9d8f0ac3"

  version HOMEBREW_TAG_VERSION
  head "https://github.com/aykamko/tag.git", :branch => "master"

  depends_on "the_silver_searcher" => :build
  depends_on "hg" => :build
  depends_on "go" => :build

  def install
    go_build
    bin.install "tag"
  end

  def go_build
    system "go", "mod", "init", "main"
    system "go", "mod", "tidy"
    mkdir_p buildpath/"src/github.com/aykamko"
    ln_s buildpath, buildpath/"src/github.com/aykamko/tag"
    system "go", "build", "-o", "tag"
  end

  test do
  end
end
