class Nano < Formula
  desc "Free (GNU) replacement for the Pico text editor"
  homepage "http://www.nano-editor.org/"
  url "http://www.nano-editor.org/dist/v2.6/nano-2.6.0.tar.gz"
  mirror "ftp://ftp.gnu.org/pub/gnu/nano/nano-2.6.0.tar.gz"
  sha256 "d517a5fcaa9fa6ceda8a63e22be1d83dd7f4af13703c73b10a48e95a6e1178d3"

  bottle do
    sha256 "09fe43a25e24101ca96a590da2f345eac527f119907f5efcd3dd4f8b2d7e1286" => :el_capitan
    sha256 "4e7161874df661708027673a22c64585902b6d7385310f4eed5fb3dab970849c" => :yosemite
    sha256 "2bb06be10bca6030d3c6bb288ef6326cd7e4e03d9b3cf71a71c2b97bb695c79c" => :mavericks
  end

  head do
    url "http://git.savannah.gnu.org/r/nano.git"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "homebrew/dupes/ncurses"

  def install
    # Otherwise SIGWINCH will not be defined
    ENV.append_to_cflags "-U_XOPEN_SOURCE" if MacOS.version < :leopard

    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--enable-color",
                          "--enable-extra",
                          "--enable-multibuffer",
                          "--enable-nanorc",
                          "--enable-utf8"
    system "make", "install"
  end

  test do
    system "#{bin}/nano", "--version"
  end
end
