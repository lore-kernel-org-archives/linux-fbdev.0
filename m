From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 05/05] video: deferred io sys helpers - xen
Date: Mon, 22 Dec 2008 14:53:17 +0900
Message-ID: <20081222055317.27821.25927.sendpatchset@rx1.opensource.se>
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

Change the xen driver to use the new shared sys helpers. This allows
us to remove some duplicated code. In the future this driver can
setup the "sysdelay" value to delay flushing.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/Kconfig       |    4 ---
 drivers/video/xen-fbfront.c |   52 +++++++++----------------------------------
 2 files changed, 12 insertions(+), 44 deletions(-)

--- 0052/drivers/video/Kconfig
+++ work/drivers/video/Kconfig	2008-12-22 14:08:03.000000000 +0900
@@ -2057,10 +2057,6 @@ config FB_VIRTUAL
 config XEN_FBDEV_FRONTEND
 	tristate "Xen virtual frame buffer support"
 	depends on FB && XEN
-	select FB_SYS_FILLRECT
-	select FB_SYS_COPYAREA
-	select FB_SYS_IMAGEBLIT
-	select FB_SYS_FOPS
 	select FB_DEFERRED_IO
 	default y
 	help
--- 0001/drivers/video/xen-fbfront.c
+++ work/drivers/video/xen-fbfront.c	2008-12-22 14:08:03.000000000 +0900
@@ -177,11 +177,18 @@ static void xenfb_refresh(struct xenfb_i
 static void xenfb_deferred_io(struct fb_info *fb_info,
 			      struct list_head *pagelist)
 {
+	struct fb_deferred_io *fbdefio = fb_info->fbdefio;
 	struct xenfb_info *info = fb_info->par;
 	struct page *page;
 	unsigned long beg, end;
 	int y1, y2, miny, maxy;
 
+	if (fbdefio->dx != -1) {
+		xenfb_refresh(info, fbdefio->dx, fbdefio->dy,
+			      min_t(int, info->page->width, fbdefio->width),
+			      min_t(int, info->page->height, fbdefio->height));
+	}
+
 	miny = INT_MAX;
 	maxy = 0;
 	list_for_each_entry(page, pagelist, lru) {
@@ -235,41 +242,6 @@ static int xenfb_setcolreg(unsigned regn
 	return 0;
 }
 
-static void xenfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
-{
-	struct xenfb_info *info = p->par;
-
-	sys_fillrect(p, rect);
-	xenfb_refresh(info, rect->dx, rect->dy, rect->width, rect->height);
-}
-
-static void xenfb_imageblit(struct fb_info *p, const struct fb_image *image)
-{
-	struct xenfb_info *info = p->par;
-
-	sys_imageblit(p, image);
-	xenfb_refresh(info, image->dx, image->dy, image->width, image->height);
-}
-
-static void xenfb_copyarea(struct fb_info *p, const struct fb_copyarea *area)
-{
-	struct xenfb_info *info = p->par;
-
-	sys_copyarea(p, area);
-	xenfb_refresh(info, area->dx, area->dy, area->width, area->height);
-}
-
-static ssize_t xenfb_write(struct fb_info *p, const char __user *buf,
-			size_t count, loff_t *ppos)
-{
-	struct xenfb_info *info = p->par;
-	ssize_t res;
-
-	res = fb_sys_write(p, buf, count, ppos);
-	xenfb_refresh(info, 0, 0, info->page->width, info->page->height);
-	return res;
-}
-
 static int
 xenfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
@@ -323,12 +295,12 @@ static int xenfb_set_par(struct fb_info 
 
 static struct fb_ops xenfb_fb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_read	= fb_sys_read,
-	.fb_write	= xenfb_write,
+	.fb_read        = fb_deferred_io_read,
+	.fb_write	= fb_deferred_io_write,
+	.fb_fillrect	= fb_deferred_io_fillrect,
+	.fb_copyarea	= fb_deferred_io_copyarea,
+	.fb_imageblit	= fb_deferred_io_imageblit,
 	.fb_setcolreg	= xenfb_setcolreg,
-	.fb_fillrect	= xenfb_fillrect,
-	.fb_copyarea	= xenfb_copyarea,
-	.fb_imageblit	= xenfb_imageblit,
 	.fb_check_var	= xenfb_check_var,
 	.fb_set_par     = xenfb_set_par,
 };
