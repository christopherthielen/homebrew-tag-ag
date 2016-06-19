require 'formula'

HOMEBREW_TAG_VERSION='1.1.0'
class TagAg < Formula
  homepage 'https://github.com/aykamko/tag'
  url "https://github.com/aykamko/tag/releases/download/#{HOMEBREW_TAG_VERSION}/tag_darwin_amd64.zip"
  sha256 'bd9eb7b7e4ba7c7f295c9b396b6c3a824425bc5f71f65d2b0fa90356fcf8c9f1'

  version HOMEBREW_TAG_VERSION
  head 'https://github.com/aykamko/tag.git', :branch => 'master'

  depends_on 'ag' => :build
  if build.head?
    depends_on 'hg' => :build
    depends_on 'go' => :build
  end

  def install
    go_build if build.head?
    bin.install 'tag'
  end

  def go_build
    ENV['GOPATH'] = buildpath
    system 'go', 'get', 'github.com/fatih/color'
    mkdir_p buildpath/'src/github.com/aykamko'
    ln_s buildpath, buildpath/'src/github.com/aykamko/tag'
    system 'go', 'build', '-o', 'tag'
  end
end
