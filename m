From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/05] video: deferred io sys helpers - core
Date: Mon, 22 Dec 2008 14:52:41 +0900
Message-ID: <20081222055241.27821.12610.sendpatchset@rx1.opensource.se>
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

Add shared sys helpers to the deferred io code. Instead of duplicating
the code in each driver we can keep it in one place. This saves a
few lines. This patch also adds "sysdelay" which allows the driver to
select timeout for sys helper functions. While at it, keep track of
the dirty area to allow partial screen update.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/Kconfig    |    4 ++
 drivers/video/fb_defio.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fb.h       |   14 +++++++++
 3 files changed, 89 insertions(+)

--- 0006/drivers/video/Kconfig
+++ work/drivers/video/Kconfig	2008-12-22 13:50:17.000000000 +0900
@@ -179,6 +179,10 @@ config FB_SYS_FOPS
 config FB_DEFERRED_IO
 	bool
 	depends on FB
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
 
 config FB_HECUBA
 	tristate
--- 0005/drivers/video/fb_defio.c
+++ work/drivers/video/fb_defio.c	2008-12-22 14:03:35.000000000 +0900
@@ -83,6 +83,32 @@ int fb_deferred_io_fsync(struct file *fi
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
 
+static void fb_deferred_io_touch(struct fb_info *info,
+				 int dx, int dy, int width, int height)
+{
+	struct fb_deferred_io *fbdefio = info->fbdefio;
+
+	/* Skip if deferred io is complied-in but disabled on this fbdev */
+	if (!fbdefio)
+		return;
+
+	/* Remember area to redraw and expand if necessary */
+	if (fbdefio->dx == -1) {
+		fbdefio->dx = dx;
+		fbdefio->dy = dy;
+		fbdefio->width = width;
+		fbdefio->height = height;
+	} else {
+		fbdefio->dx = min_t(int, dx, fbdefio->dx);
+		fbdefio->dy = min_t(int, dx, fbdefio->dy);
+		fbdefio->width = max_t(int, width, fbdefio->width);
+		fbdefio->height = max_t(int, height, fbdefio->height);
+	}
+
+	/* come back after sysdelay to process the deferred IO */
+	schedule_delayed_work(&info->deferred_work, fbdefio->sysdelay);
+}
+
 /* vm_ops->page_mkwrite handler */
 static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
 				  struct page *page)
@@ -172,9 +198,53 @@ static void fb_deferred_io_work(struct w
 	list_for_each_safe(node, next, &fbdefio->pagelist) {
 		list_del(node);
 	}
+
+	/* reset sys operations state */
+	fbdefio->dx = -1;
+
 	mutex_unlock(&fbdefio->lock);
 }
 
+ssize_t fb_deferred_io_read(struct fb_info *info, char __user *buf,
+			    size_t count, loff_t *ppos)
+{
+	return fb_sys_read(info, buf, count, ppos);
+}
+EXPORT_SYMBOL_GPL(fb_deferred_io_read);
+
+ssize_t fb_deferred_io_write(struct fb_info *info, const char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	int ret = fb_sys_write(info, buf, count, ppos);
+
+	if (ret > 0)
+		fb_deferred_io_touch(info, 0, 0, INT_MAX, INT_MAX);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fb_deferred_io_write);
+
+void fb_deferred_io_fillrect(struct fb_info *info, const struct fb_fillrect *r)
+{
+	sys_fillrect(info, r);
+	fb_deferred_io_touch(info, r->dx, r->dy, r->width, r->height);
+}
+EXPORT_SYMBOL_GPL(fb_deferred_io_fillrect);
+
+void fb_deferred_io_copyarea(struct fb_info *info, const struct fb_copyarea *a)
+{
+	sys_copyarea(info, a);
+	fb_deferred_io_touch(info, a->dx, a->dy, a->width, a->height);
+}
+EXPORT_SYMBOL_GPL(fb_deferred_io_copyarea);
+
+void fb_deferred_io_imageblit(struct fb_info *info, const struct fb_image *i)
+{
+	sys_imageblit(info, i);
+	fb_deferred_io_touch(info, i->dx, i->dy, i->width, i->height);
+}
+EXPORT_SYMBOL_GPL(fb_deferred_io_imageblit);
+
 void fb_deferred_io_init(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
@@ -184,6 +254,7 @@ void fb_deferred_io_init(struct fb_info 
 	info->fbops->fb_mmap = fb_deferred_io_mmap;
 	INIT_DELAYED_WORK(&info->deferred_work, fb_deferred_io_work);
 	INIT_LIST_HEAD(&fbdefio->pagelist);
+	fbdefio->dx = -1;
 	if (fbdefio->delay == 0) /* set a default of 1 s */
 		fbdefio->delay = HZ;
 }
--- 0001/include/linux/fb.h
+++ work/include/linux/fb.h	2008-12-22 13:50:17.000000000 +0900
@@ -587,8 +587,11 @@ struct fb_pixmap {
 struct fb_deferred_io {
 	/* delay between mkwrite and deferred handler */
 	unsigned long delay;
+	/* delay between write/fillrect/copyarea/imageblit and handler */
+	unsigned long sysdelay;
 	struct mutex lock; /* mutex that protects the page list */
 	struct list_head pagelist; /* list of touched pages */
+	int dx, dy, width, height; /* modified area */
 	/* callback */
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
 };
@@ -983,6 +986,17 @@ extern void fb_deferred_io_open(struct f
 extern void fb_deferred_io_cleanup(struct fb_info *info);
 extern int fb_deferred_io_fsync(struct file *file, struct dentry *dentry,
 				int datasync);
+extern ssize_t fb_deferred_io_read(struct fb_info *info, char __user *buf,
+				   size_t count, loff_t *ppos);
+extern ssize_t fb_deferred_io_write(struct fb_info *info,
+				    const char __user *buf,
+				    size_t count, loff_t *ppos);
+extern void fb_deferred_io_fillrect(struct fb_info *info,
+				    const struct fb_fillrect *rect);
+extern void fb_deferred_io_copyarea(struct fb_info *info,
+				    const struct fb_copyarea *area);
+extern void fb_deferred_io_imageblit(struct fb_info *info,
+				     const struct fb_image *image);
 
 static inline bool fb_be_math(struct fb_info *info)
 {
