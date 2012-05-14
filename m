From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 14 May 2012 20:58:37 +0000
Subject: [patch] fb: handle NULL pointers in framebuffer release
Message-Id: <20120514205837.GE20836@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This function is called with a potential NULL pointer in
picolcd_init_framebuffer() and it causes a static checker warning.  This
used to handle NULL pointers when the picolcd code was written, but a
couple months later we added the "info->apertures" dereference.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index 67afa9c..a55e366 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -80,6 +80,8 @@ EXPORT_SYMBOL(framebuffer_alloc);
  */
 void framebuffer_release(struct fb_info *info)
 {
+	if (!info)
+		return;
 	kfree(info->apertures);
 	kfree(info);
 }
