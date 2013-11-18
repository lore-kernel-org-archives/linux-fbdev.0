From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 18 Nov 2013 10:57:11 +0000
Subject: [PATCH] RFC: framebuffer: provide generic get_fb_unmapped_area
Message-Id: <1384772231-20993-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

This patch makes mmapping the simple-framebuffer device work on a no-MMU
ARM target. The code is mostly taken from
arch/blackfin/kernel/sys_bfin.c.

Note this is only tested on this no-MMU machine and I don't know enough
about framebuffers and mm to decide if this patch is sane. Also I'm
unsure about the size check because it triggers if userspace page aligns
the len parameter. (I don't know how usual it is to do, I'd say it's
wrong, but my test program (fbtest by Geert Uytterhoeven) does it.)

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbmem.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index dacaf74..70b328c 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1483,6 +1483,24 @@ __releases(&info->lock)
 	return 0;
 }
=20
+#ifdef HAVE_ARCH_FB_UNMAPPED_AREA
+#define fb_get_unmapped_area get_fb_unmapped_area
+#else
+unsigned long fb_get_unmapped_area(struct file *filp, unsigned long orig_a=
ddr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct fb_info * const info =3D filp->private_data;
+	unsigned long screen_size =3D info->screen_size ?: info->fix.smem_len;
+
+	if (len > screen_size) {
+		pr_info("%lu > %lu (%lu, %lu)\n", len, screen_size, info->screen_size, i=
nfo->fix.smem_len);
+		return -EINVAL;
+	}
+
+	return (unsigned long)info->screen_base;
+}
+#endif
+
 static const struct file_operations fb_fops =3D {
 	.owner =3D	THIS_MODULE,
 	.read =3D		fb_read,
@@ -1494,9 +1512,7 @@ static const struct file_operations fb_fops =3D {
 	.mmap =3D		fb_mmap,
 	.open =3D		fb_open,
 	.release =3D	fb_release,
-#ifdef HAVE_ARCH_FB_UNMAPPED_AREA
-	.get_unmapped_area =3D get_fb_unmapped_area,
-#endif
+	.get_unmapped_area =3D fb_get_unmapped_area,
 #ifdef CONFIG_FB_DEFERRED_IO
 	.fsync =3D	fb_deferred_io_fsync,
 #endif
--=20
1.8.4.2

