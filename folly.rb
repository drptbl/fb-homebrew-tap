require "formula"

class Folly < Formula
  homepage "https://github.com/facebook/folly"
  url "https://github.com/facebook/folly/archive/77f37d5ddc4c75d5a760cacce02e1ec5e9d242f2.tar.gz"
  version "47.0"
  sha1 "e02039f1bdc4fcc203e341cecc6dbe77f260f1c5"

  head "https://github.com/facebook/folly.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  depends_on "gflags"
  depends_on "glog"
  depends_on "boost"
  depends_on "libevent"
  depends_on "lz4"
  depends_on "snappy"
  depends_on "jemalloc"
  depends_on "double-conversion"

  def install
    cd "folly"

    system "autoreconf", "-i"

    system "./configure",
        "--disable-dependency-tracking",
        "--with-boost-thread=boost_thread-mt",
        "--with-boost-regex=boost_regex-mt",
        "--with-boost-system=boost_system-mt",
        "--with-boost-filesystem=boost_filesystem-mt",
        "--with-boost-context=boost_context-mt",
        "--prefix=#{prefix}"

    system "make", "install"
  end
end

