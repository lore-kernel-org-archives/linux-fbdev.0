From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Jul 2019 19:55:32 +0000
Subject: [PATCH v5 16/29] compat_ioctl: move ATYFB_CLK handling to atyfb driver
Message-Id: <20190730195819.901457-4-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730195819.901457-1-arnd@arndb.de>
In-Reply-To: <20190730195819.901457-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Mikulas Patocka <mpatocka@redhat.com>, linux-fsdevel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

These are two obscure ioctl commands, in a driver that only
has compatible commands, so just let the driver handle this
itself.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/aty/atyfb_base.c | 12 +++++++++++-
 fs/compat_ioctl.c                    |  2 --
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 72bcfbe42e49..63bc76a1b2f9 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -48,7 +48,7 @@
 
 ******************************************************************************/
 
-
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
@@ -235,6 +235,13 @@ static int atyfb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info);
 static int atyfb_blank(int blank, struct fb_info *info);
 static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg);
+#ifdef CONFIG_COMPAT
+static int atyfb_compat_ioctl(struct fb_info *info, u_int cmd, u_long arg)
+{
+	return atyfb_ioctl(info, cmd, (u_long)compat_ptr(arg));
+}
+#endif
+
 #ifdef __sparc__
 static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma);
 #endif
@@ -290,6 +297,9 @@ static struct fb_ops atyfb_ops = {
 	.fb_pan_display	= atyfb_pan_display,
 	.fb_blank	= atyfb_blank,
 	.fb_ioctl	= atyfb_ioctl,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl = atyfb_compat_ioctl,
+#endif
 	.fb_fillrect	= atyfb_fillrect,
 	.fb_copyarea	= atyfb_copyarea,
 	.fb_imageblit	= atyfb_imageblit,
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index b65eef3d4787..a4e8fb7da968 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -696,8 +696,6 @@ COMPATIBLE_IOCTL(CAPI_CLR_FLAGS)
 COMPATIBLE_IOCTL(CAPI_NCCI_OPENCOUNT)
 COMPATIBLE_IOCTL(CAPI_NCCI_GETUNIT)
 /* Misc. */
-COMPATIBLE_IOCTL(0x41545900)		/* ATYIO_CLKR */
-COMPATIBLE_IOCTL(0x41545901)		/* ATYIO_CLKW */
 COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
-- 
2.20.0
