HOMEBREW_TAG_VERSION="v1.4.0".freeze
class TagAg < Formula
  desc "Instantly jump to your ag or ripgrep matches."
  homepage "https://github.com/aykamko/tag"
  url "https://github.com/aykamko/tag/archive/refs/tags/#{HOMEBREW_TAG_VERSION}.tar.gz"
  sha256 "d3a02466e600634cf0ffff9ad8c5f70eba97e44758edf35cc4efbda9cbfdff9a"

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
