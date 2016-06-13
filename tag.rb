require 'formula'

HOMEBREW_TAG_VERSION='1.0.0'
class Tag < Formula
  homepage 'https://github.com/aykamko/tag'
  url 'https://github.com/aykamko/tag.git', :tag => "v#{HOMEBREW_TAG_VERSION}"
  version HOMEBREW_TAG_VERSION
  head 'https://github.com/aykamko/tag.git', :branch => 'master'

  depends_on 'ag' => :build
  depends_on 'hg' => :build
  depends_on 'go' => :build

  def install
    ENV['GOPATH'] = buildpath
    system 'go', 'get', 'github.com/fatih/color'
    mkdir_p buildpath/'src/github.com/aykamko'
    ln_s buildpath, buildpath/'src/github.com/aykamko/tag'
    system 'go', 'build', '-o', 'tag'
    bin.install 'tag'
  end
end
