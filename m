From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 05 May 2020 14:03:52 +0000
Subject: [PATCH] omapfb: don't annotate dss_conv_list as __initdata
Message-Id: <20200505140407.373983-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marco Elver <elver@google.com>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, clang-built-linux@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Alexios Zavras <alexios.zavras@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Enrico Weigelt <info@metux.net>, Allison Randal <allison@lohutok.net>

With the kcsan changes, __read_once_size() is not inlined, but
clang can decide to emit a version that hardcodes the address, which
in turn triggers a warning for dss_conv_list being __initdata but
__read_once_size() not being __init:

WARNING: modpost: vmlinux.o(.text+0x6e4d7a): Section mismatch in
reference from the function __read_once_size() to the variable
.init.data:dss_conv_list
The function __read_once_size() references
the variable __initdata dss_conv_list.
This is often because __read_once_size lacks a __initdata
annotation or the annotation of dss_conv_list is wrong.

This is clearly a false positive warning, but it's hard to tell
who is to blame for it. Work around it by removing the __initdata
annotation, wasting the space of two pointers in return for getting
rid of the warning.

Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastructure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
index 0ae0cab252d3..29fdff9c95f6 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
@@ -19,7 +19,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 
-static struct list_head dss_conv_list __initdata;
+static struct list_head dss_conv_list;
 
 static const char prefix[] __initconst = "omapdss,";
 
-- 
2.26.0
