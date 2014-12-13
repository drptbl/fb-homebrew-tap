require "formula"

class FollyMinimal < Formula
  homepage "https://github.com/facebook/folly"
  url "https://github.com/facebook/folly/archive/61e26ae9a52ae2c66f752191cff76613feca5bbc.tar.gz"
  version "18.0"
  sha1 "7c22815cf82b05391b897e0dafe35fe3e7bdc1a5"

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

  patch :p1, :DATA

  def install
    cd "folly"

    system "rm", "-rf",
            "wangle", "experimental/wangle", "io/async"

    system "autoreconf", "-i"

    system "./configure",
        "--disable-dependency-tracking",
        "--with-boost-thread=boost_thread-mt",
        "--with-boost-regex=boost_regex-mt",
        "--with-boost-system=boost_system-mt",
        "--with-boost-filesystem=boost_filesystem-mt",
        "--prefix=#{prefix}"

    system "make", "install"
  end
end

__END__
diff -ru orig/folly/Makefile.am mod/folly/Makefile.am
--- orig/folly/Makefile.am	2014-12-11 08:02:41.000000000 -0800
+++ mod/folly/Makefile.am	2014-12-12 16:44:49.000000000 -0800
@@ -42,7 +42,6 @@
 	detail/BitsDetail.h \
 	detail/CacheLocality.h \
 	detail/ChecksumDetail.h \
-	detail/Clock.h \
 	detail/DiscriminatedPtrDetail.h \
 	detail/ExceptionWrapper.h \
 	detail/FileUtilDetail.h \
@@ -72,47 +71,6 @@
 	experimental/io/FsUtil.h \
 	experimental/Singleton.h \
 	experimental/TestUtil.h \
-	experimental/wangle/channel/AsyncSocketHandler.h \
-	experimental/wangle/channel/ChannelHandler.h \
-	experimental/wangle/channel/ChannelHandlerContext.h \
-	experimental/wangle/channel/ChannelPipeline.h \
-	experimental/wangle/channel/OutputBufferingHandler.h \
-	experimental/wangle/concurrent/BlockingQueue.h \
-	experimental/wangle/concurrent/Codel.h \
-	experimental/wangle/concurrent/CPUThreadPoolExecutor.h \
-	experimental/wangle/concurrent/FutureExecutor.h \
-	experimental/wangle/concurrent/IOThreadPoolExecutor.h \
-	experimental/wangle/concurrent/LifoSemMPMCQueue.h \
-	experimental/wangle/concurrent/NamedThreadFactory.h \
-	experimental/wangle/concurrent/ThreadFactory.h \
-	experimental/wangle/concurrent/ThreadPoolExecutor.h \
-	experimental/wangle/rx/Observable.h \
-	experimental/wangle/rx/Observer.h \
-	experimental/wangle/rx/Subject.h \
-	experimental/wangle/rx/Subscription.h \
-	experimental/wangle/rx/types.h \
-	experimental/wangle/ConnectionManager.h \
-	experimental/wangle/ManagedConnection.h \
-	experimental/wangle/acceptor/Acceptor.h \
-	experimental/wangle/acceptor/ConnectionCounter.h \
-	experimental/wangle/acceptor/SocketOptions.h \
-	experimental/wangle/acceptor/DomainNameMisc.h \
-	experimental/wangle/acceptor/LoadShedConfiguration.h \
-	experimental/wangle/acceptor/NetworkAddress.h \
-	experimental/wangle/acceptor/ServerSocketConfig.h \
-	experimental/wangle/acceptor/TransportInfo.h \
-	experimental/wangle/ssl/ClientHelloExtStats.h \
-	experimental/wangle/ssl/DHParam.h \
-	experimental/wangle/ssl/PasswordInFile.h \
-	experimental/wangle/ssl/SSLCacheOptions.h \
-	experimental/wangle/ssl/SSLCacheProvider.h \
-	experimental/wangle/ssl/SSLContextConfig.h \
-	experimental/wangle/ssl/SSLContextManager.h \
-	experimental/wangle/ssl/SSLSessionCacheManager.h \
-	experimental/wangle/ssl/SSLStats.h \
-	experimental/wangle/ssl/SSLUtil.h \
-	experimental/wangle/ssl/TLSTicketKeyManager.h \
-	experimental/wangle/ssl/TLSTicketKeySeeds.h \
 	FBString.h \
 	FBVector.h \
 	File.h \
@@ -154,27 +112,6 @@
 	io/RecordIO-inl.h \
 	io/TypedIOBuf.h \
 	io/ShutdownSocketSet.h \
-	io/async/AsyncTimeout.h \
-	io/async/AsyncTransport.h \
-	io/async/AsyncServerSocket.h \
-	io/async/AsyncSSLServerSocket.h \
-	io/async/AsyncSocket.h \
-	io/async/AsyncSSLSocket.h \
-	io/async/AsyncSocketException.h \
-	io/async/DelayedDestruction.h \
-	io/async/EventBase.h \
-	io/async/EventBaseManager.h \
-	io/async/EventFDWrapper.h \
-	io/async/EventHandler.h \
-	io/async/EventUtil.h \
-	io/async/NotificationQueue.h \
-	io/async/HHWheelTimer.h \
-	io/async/Request.h \
-	io/async/SSLContext.h \
-	io/async/TimeoutManager.h \
-	io/async/test/TimeUtil.h \
-	io/async/test/UndelayedDestruction.h \
-	io/async/test/Util.h \
 	json.h \
 	Lazy.h \
 	LifoSem.h \
@@ -231,23 +168,7 @@
 	Uri.h \
 	Uri-inl.h \
 	Varint.h \
-	VersionCheck.h \
-	wangle/Deprecated.h \
-	wangle/Executor.h \
-	wangle/Future-inl.h \
-	wangle/Future.h \
-	wangle/InlineExecutor.h \
-	wangle/ManualExecutor.h \
-	wangle/OpaqueCallbackShunt.h \
-	wangle/Promise-inl.h \
-	wangle/Promise.h \
-	wangle/QueuedImmediateExecutor.h \
-	wangle/ScheduledExecutor.h \
-	wangle/Try-inl.h \
-	wangle/Try.h \
-	wangle/WangleException.h \
-	wangle/detail/Core.h \
-	wangle/detail/FSM.h
+	VersionCheck.h
 
 FormatTables.cpp: build/generate_format_tables.py
 	build/generate_format_tables.py
@@ -291,18 +212,6 @@
 	io/IOBufQueue.cpp \
 	io/RecordIO.cpp \
 	io/ShutdownSocketSet.cpp \
-	io/async/AsyncTimeout.cpp \
-	io/async/AsyncServerSocket.cpp \
-	io/async/AsyncSSLServerSocket.cpp \
-	io/async/AsyncSocket.cpp \
-	io/async/AsyncSSLSocket.cpp \
-	io/async/EventBase.cpp \
-	io/async/EventBaseManager.cpp \
-	io/async/EventHandler.cpp \
-	io/async/Request.cpp \
-	io/async/SSLContext.cpp \
-	io/async/HHWheelTimer.cpp \
-	io/async/test/TimeUtil.cpp \
 	json.cpp \
 	detail/MemoryIdler.cpp \
 	MacAddress.cpp \
@@ -318,26 +227,9 @@
 	TimeoutQueue.cpp \
 	Uri.cpp \
 	Version.cpp \
-	wangle/InlineExecutor.cpp \
-	wangle/ManualExecutor.cpp \
 	experimental/io/FsUtil.cpp \
 	experimental/Singleton.cpp \
-	experimental/TestUtil.cpp \
-	experimental/wangle/concurrent/CPUThreadPoolExecutor.cpp \
-	experimental/wangle/concurrent/Codel.cpp \
-	experimental/wangle/concurrent/IOThreadPoolExecutor.cpp \
-	experimental/wangle/concurrent/ThreadPoolExecutor.cpp \
-	experimental/wangle/ConnectionManager.cpp \
-	experimental/wangle/ManagedConnection.cpp \
-	experimental/wangle/acceptor/Acceptor.cpp \
-	experimental/wangle/acceptor/SocketOptions.cpp \
-	experimental/wangle/acceptor/LoadShedConfiguration.cpp \
-	experimental/wangle/acceptor/TransportInfo.cpp \
-	experimental/wangle/ssl/PasswordInFile.cpp \
-	experimental/wangle/ssl/SSLContextManager.cpp \
-	experimental/wangle/ssl/SSLSessionCacheManager.cpp \
-	experimental/wangle/ssl/SSLUtil.cpp \
-	experimental/wangle/ssl/TLSTicketKeyManager.cpp
+	experimental/TestUtil.cpp
 
 if HAVE_LINUX
 nobase_follyinclude_HEADERS += \
@@ -346,7 +238,7 @@
 	experimental/io/HugePages.cpp
 endif
 
-if !HAVE_LINUX
+if !HAVE_CLOCK_GETTIME
 nobase_follyinclude_HEADERS += detail/Clock.h
 libfollybase_la_SOURCES += detail/Clock.cpp
 endif
diff -ru orig/folly/configure.ac mod/folly/configure.ac
--- orig/folly/configure.ac	2014-12-11 08:02:41.000000000 -0800
+++ mod/folly/configure.ac	2014-12-12 16:54:55.000000000 -0800
@@ -260,11 +260,16 @@
 # Check for clock_gettime(2). This is not in an AC_CHECK_FUNCS() because we
 # want to link with librt if necessary.
 AC_SEARCH_LIBS([clock_gettime], [rt],
-  AC_DEFINE(
-    [HAVE_CLOCK_GETTIME],
-    [1],
-    [Define to 1 if we support clock_gettime(2).]),
-  [])
+  [
+    AC_DEFINE(
+      [HAVE_CLOCK_GETTIME],
+      [1],
+      [Define to 1 if we support clock_gettime(2).]),
+    AM_CONDITIONAL([HAVE_CLOCK_GETTIME], [true])
+  ],
+  [
+    AM_CONDITIONAL([HAVE_CLOCK_GETTIME], [false])
+  ])
 
 # Checks for library functions.
 AC_CHECK_FUNCS([getdelim \
