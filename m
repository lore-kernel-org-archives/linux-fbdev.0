From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 22/41] fbdev: Add fb_read/fb_write
 functions for framebuffers in system RAM
Date: Wed, 25 Apr 2007 14:49:26 +0800
Message-ID: <462EF9F6.5030600@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc9D-0001G1-Ag for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:42:43 -0700
Received: from nz-out-0506.google.com ([64.233.162.234])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc9C-0003qY-Oe
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:42:43 -0700
Received: by nz-out-0506.google.com with SMTP id j2so171588nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:42:42 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The functions fb_read() and fb_write in fbmem.c assume that the framebuffer
is in IO memory.  However, we have 3 drivers (hecubafb, arcfb, and vfb)
where the framebuffer is allocated from system RAM (via vmalloc). Using
__raw_read/__raw_write (fb_readl/fb_writel) for these drivers is
illegal, especially in other platforms.

Create file read and write methods for these types of drivers.  These are
named fb_sys_read() and fb_sys_write().

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig       |    5 ++
 drivers/video/Makefile      |    1 
 drivers/video/fb_sys_fops.c |  104 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fb.h          |    4 ++
 4 files changed, 114 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 60e3ceb..5b6350d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -122,6 +122,11 @@ config FB_SYS_IMAGEBLIT
 	  blitting. This is used by drivers that don't provide their own
 	  (accelerated) version and the framebuffer is in system RAM.
 
+config FB_SYS_FOPS
+       tristate
+       depends on FB
+       default n
+
 config FB_DEFERRED_IO
 	bool
 	depends on FB
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index a245cc7..fb0f3ab 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_FB_CFB_IMAGEBLIT) += cfbimg
 obj-$(CONFIG_FB_SYS_FILLRECT)  += sysfillrect.o
 obj-$(CONFIG_FB_SYS_COPYAREA)  += syscopyarea.o
 obj-$(CONFIG_FB_SYS_IMAGEBLIT) += sysimgblt.o
+obj-$(CONFIG_FB_SYS_FOPS)      += fb_sys_fops.o
 obj-$(CONFIG_FB_SVGALIB)       += svgalib.o
 obj-$(CONFIG_FB_MACMODES)      += macmodes.o
 obj-$(CONFIG_FB_DDC)           += fb_ddc.o
diff --git a/drivers/video/fb_sys_fops.c b/drivers/video/fb_sys_fops.c
new file mode 100644
index 0000000..cf2538d
--- /dev/null
+++ b/drivers/video/fb_sys_fops.c
@@ -0,0 +1,104 @@
+/*
+ * linux/drivers/video/fb_sys_read.c - Generic file operations where
+ * framebuffer is in system RAM
+ *
+ * Copyright (C) 2007 Antonino Daplas <adaplas@pol.net>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ *
+ */
+#include <linux/fb.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+
+ssize_t fb_sys_read(struct fb_info *info, char __user *buf, size_t count,
+		    loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	void *src;
+	int err = 0;
+	unsigned long total_size;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return -EPERM;
+
+	total_size = info->screen_size;
+
+	if (total_size == 0)
+		total_size = info->fix.smem_len;
+
+	if (p >= total_size)
+		return 0;
+
+	if (count >= total_size)
+		count = total_size;
+
+	if (count + p > total_size)
+		count = total_size - p;
+
+	src = (void __force *)(info->screen_base + p);
+
+	if (info->fbops->fb_sync)
+		info->fbops->fb_sync(info);
+
+	if (copy_to_user(buf, src, count))
+		err = -EFAULT;
+
+	if  (!err)
+		*ppos += count;
+
+	return (err) ? err : count;
+}
+EXPORT_SYMBOL_GPL(fb_sys_read);
+
+ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
+		     size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	void *dst;
+	int err = 0;
+	unsigned long total_size;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return -EPERM;
+
+	total_size = info->screen_size;
+
+	if (total_size == 0)
+		total_size = info->fix.smem_len;
+
+	if (p > total_size)
+		return -EFBIG;
+
+	if (count > total_size) {
+		err = -EFBIG;
+		count = total_size;
+	}
+
+	if (count + p > total_size) {
+		if (!err)
+			err = -ENOSPC;
+
+		count = total_size - p;
+	}
+
+	dst = (void __force *) (info->screen_base + p);
+
+	if (info->fbops->fb_sync)
+		info->fbops->fb_sync(info);
+
+	if (copy_from_user(dst, buf, count))
+		err = -EFAULT;
+
+	if  (!err)
+		*ppos += count;
+
+	return (err) ? err : count;
+}
+EXPORT_SYMBOL_GPL(fb_sys_write);
+
+MODULE_AUTHOR("Antonino Daplas <adaplas@pol.net>");
+MODULE_DESCRIPTION("Generic file read (fb in system RAM)");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/fb.h b/include/linux/fb.h
index acb6ddb..70d154a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -903,6 +903,10 @@ extern void cfb_imageblit(struct fb_info
 extern void sys_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
 extern void sys_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 extern void sys_imageblit(struct fb_info *info, const struct fb_image *image);
+extern ssize_t fb_sys_read(struct fb_info *info, char __user *buf,
+			   size_t count, loff_t *ppos);
+extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
+			    size_t count, loff_t *ppos);
 
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
