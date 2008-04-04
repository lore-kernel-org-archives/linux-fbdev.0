From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [PATCH 2/4 2.6.24] fbdev: hecubafb bugfix v4
Date: Fri, 04 Apr 2008 08:24:29 -0400
Message-ID: <20080404122429.6404.76840.sendpatchset@hit-nxdomain.opendns.com>
References: <20080404122358.6404.54652.sendpatchset@hit-nxdomain.opendns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhlsR-00046V-E1 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 06:22:43 -0700
Received: from yw-out-1718.google.com ([74.125.46.154])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JhlsQ-0007kF-3p
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 06:22:43 -0700
Received: by yw-out-1718.google.com with SMTP id 4so7401ywq.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 04 Apr 2008 06:22:41 -0700 (PDT)
In-Reply-To: <20080404122358.6404.54652.sendpatchset@hit-nxdomain.opendns.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Jaya Kumar <jayakumar.lkml@gmail.com>

This patch is a bugfix for hecubafb_write which would return an incorrect
error value for the bytecount from framebuffer writes.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>

---
 hecubafb.c |   52 +++++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 25 deletions(-)


diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index 94e0df8..b77d033 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -270,41 +270,43 @@ static void hecubafb_imageblit(struct fb_info *info,
 static ssize_t hecubafb_write(struct fb_info *info, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	unsigned long p;
-	int err=-EINVAL;
-	struct hecubafb_par *par;
-	unsigned int xres;
-	unsigned int fbmemlength;
+	struct hecubafb_par *par = info->par;
+	unsigned long p = *ppos;
+	void *dst;
+	int err = 0;
+	unsigned long total_size;
 
-	p = *ppos;
-	par = info->par;
-	xres = info->var.xres;
-	fbmemlength = (xres * info->var.yres)/8;
+	if (info->state != FBINFO_STATE_RUNNING)
+		return -EPERM;
 
-	if (p > fbmemlength)
-		return -ENOSPC;
+	total_size = info->fix.smem_len;
 
-	err = 0;
-	if ((count + p) > fbmemlength) {
-		count = fbmemlength - p;
-		err = -ENOSPC;
+	if (p > total_size)
+		return -EFBIG;
+
+	if (count > total_size) {
+		err = -EFBIG;
+		count = total_size;
 	}
 
-	if (count) {
-		char *base_addr;
+	if (count + p > total_size) {
+		if (!err)
+			err = -ENOSPC;
 
-		base_addr = (char __force *)info->screen_base;
-		count -= copy_from_user(base_addr + p, buf, count);
-		*ppos += count;
-		err = -EFAULT;
+		count = total_size - p;
 	}
 
-	hecubafb_dpy_update(par);
+	dst = (void __force *) (info->screen_base + p);
+
+	if (copy_from_user(dst, buf, count))
+		err = -EFAULT;
 
-	if (count)
-		return count;
+	if  (!err)
+		*ppos += count;
+
+	hecubafb_dpy_update(par);
 
-	return err;
+	return (err) ? err : count;
 }
 
 static struct fb_ops hecubafb_ops = {

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
