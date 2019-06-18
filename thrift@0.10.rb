class ThriftAT010 < Formula
  desc "Framework for scalable cross-language services development"
  homepage "https://thrift.apache.org/"
  url "https://archive.apache.org/dist/thrift/0.10.0/thrift-0.10.0.tar.gz"
  sha256 "2289d02de6e8db04cbbabb921aeb62bfe3098c4c83f36eec6c31194301efa10b"

  bottle do
    cellar :any
  end

  keg_only :versioned_formula

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "bison" => :build
    depends_on "libtool" => :build
    depends_on "pkg-config" => :build
    depends_on "boost"
    depends_on "openssl"

  def install
    args = %W[
      --disable-debug
      --prefix=#{prefix}
      --libdir=#{lib}
      --with-openssl=#{Formula["openssl"].opt_prefix}
      --without-erlang
      --without-haskell
      --without-java
      --without-perl
      --without-php
      --without-php_extension
      --without-python
      --without-ruby
      --without-tests
    ]

    ENV.cxx11 if ENV.compiler == :clang

    # Don't install extensions to /usr:
    ENV["PY_PREFIX"] = prefix
    ENV["PHP_PREFIX"] = prefix
    ENV["JAVA_PREFIX"] = buildpath

    system "./configure", *args
    ENV.deparallelize
    system "make", "install"
  end

  test do
    system "#{bin}/thrift", "--version"
  end
end
