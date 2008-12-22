From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/05] video: deferred io sys helpers - hecuba / n411
Date: Mon, 22 Dec 2008 14:53:01 +0900
Message-ID: <20081222055301.27821.25166.sendpatchset@rx1.opensource.se>
References: <20081222055233.27821.68008.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20081222055233.27821.68008.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: aliguori@us.ibm.com, adaplas@gmail.com, linux-sh@vger.kernel.org, armbru@redhat.com, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, jayakumar.lkml@gmail.com

From: Magnus Damm <damm@igel.co.jp>

Change the hecubafb driver and the n411 code to use the new shared sys
helpers. This allows us to remove some duplicated code. In the future
this driver can setup the "sysdelay" value to delay flushing.

While at it, convert space to tabs for the n411 kconfig entry.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/Kconfig    |   17 +++------
 drivers/video/hecubafb.c |   86 ++--------------------------------------------
 2 files changed, 11 insertions(+), 92 deletions(-)

--- 0050/drivers/video/Kconfig
+++ work/drivers/video/Kconfig	2008-12-22 14:06:31.000000000 +0900
@@ -712,17 +712,12 @@ config FB_EFI
 	  using the EFI framebuffer as your console.
 
 config FB_N411
-       tristate "N411 Apollo/Hecuba devkit support"
-       depends on FB && X86 && MMU
-       select FB_SYS_FILLRECT
-       select FB_SYS_COPYAREA
-       select FB_SYS_IMAGEBLIT
-       select FB_SYS_FOPS
-       select FB_DEFERRED_IO
-       select FB_HECUBA
-       help
-         This enables support for the Apollo display controller in its
-         Hecuba form using the n411 devkit.
+	tristate "N411 Apollo/Hecuba devkit support"
+	depends on FB && X86 && MMU
+	select FB_HECUBA
+	help
+	  This enables support for the Apollo display controller in its
+	  Hecuba form using the n411 devkit.
 
 config FB_HGA
 	tristate "Hercules mono graphics support"
--- 0001/drivers/video/hecubafb.c
+++ work/drivers/video/hecubafb.c	2008-12-22 14:06:31.000000000 +0900
@@ -122,89 +122,13 @@ static void hecubafb_dpy_deferred_io(str
 	hecubafb_dpy_update(info->par);
 }
 
-static void hecubafb_fillrect(struct fb_info *info,
-				   const struct fb_fillrect *rect)
-{
-	struct hecubafb_par *par = info->par;
-
-	sys_fillrect(info, rect);
-
-	hecubafb_dpy_update(par);
-}
-
-static void hecubafb_copyarea(struct fb_info *info,
-				   const struct fb_copyarea *area)
-{
-	struct hecubafb_par *par = info->par;
-
-	sys_copyarea(info, area);
-
-	hecubafb_dpy_update(par);
-}
-
-static void hecubafb_imageblit(struct fb_info *info,
-				const struct fb_image *image)
-{
-	struct hecubafb_par *par = info->par;
-
-	sys_imageblit(info, image);
-
-	hecubafb_dpy_update(par);
-}
-
-/*
- * this is the slow path from userspace. they can seek and write to
- * the fb. it's inefficient to do anything less than a full screen draw
- */
-static ssize_t hecubafb_write(struct fb_info *info, const char __user *buf,
-				size_t count, loff_t *ppos)
-{
-	struct hecubafb_par *par = info->par;
-	unsigned long p = *ppos;
-	void *dst;
-	int err = 0;
-	unsigned long total_size;
-
-	if (info->state != FBINFO_STATE_RUNNING)
-		return -EPERM;
-
-	total_size = info->fix.smem_len;
-
-	if (p > total_size)
-		return -EFBIG;
-
-	if (count > total_size) {
-		err = -EFBIG;
-		count = total_size;
-	}
-
-	if (count + p > total_size) {
-		if (!err)
-			err = -ENOSPC;
-
-		count = total_size - p;
-	}
-
-	dst = (void __force *) (info->screen_base + p);
-
-	if (copy_from_user(dst, buf, count))
-		err = -EFAULT;
-
-	if  (!err)
-		*ppos += count;
-
-	hecubafb_dpy_update(par);
-
-	return (err) ? err : count;
-}
-
 static struct fb_ops hecubafb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_read        = fb_sys_read,
-	.fb_write	= hecubafb_write,
-	.fb_fillrect	= hecubafb_fillrect,
-	.fb_copyarea	= hecubafb_copyarea,
-	.fb_imageblit	= hecubafb_imageblit,
+	.fb_read        = fb_deferred_io_read,
+	.fb_write	= fb_deferred_io_write,
+	.fb_fillrect	= fb_deferred_io_fillrect,
+	.fb_copyarea	= fb_deferred_io_copyarea,
+	.fb_imageblit	= fb_deferred_io_imageblit,
 };
 
 static struct fb_deferred_io hecubafb_defio = {
