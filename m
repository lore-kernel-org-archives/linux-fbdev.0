From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] fbdev/radeonfb: Remove bugus radeonfb_read/write
Date: Mon, 13 Sep 2004 14:30:02 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1095049802.24290.260.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6iWT-0006Un-5J
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Sep 2004 21:33:01 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1C6iWS-00048j-6S
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Sep 2004 21:33:01 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linus Torvalds <torvalds@osdl.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

This patch kills the bogus radeonfb_read/write routines. In order to do so,
it adds a new member to fb_info, along with screen_base, which is screen_size,
indicating the mapped area. The default fb_read/write will now use that instead
of fix->smem_len if it is non-0, and radeonfb now sets it to the mapped size
of the framebuffer.

Ben.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== drivers/video/fbmem.c 1.127 vs edited =====
--- 1.127/drivers/video/fbmem.c	2004-09-08 16:33:07 +10:00
+++ edited/drivers/video/fbmem.c	2004-09-13 14:03:44 +10:00
@@ -506,6 +506,7 @@
 	struct fb_info *info = registered_fb[fbidx];
 	u32 *buffer, *dst, *src;
 	int c, i, cnt = 0, err = 0;
+	unsigned long total_size;
 
 	if (!info || ! info->screen_base)
 		return -ENODEV;
@@ -516,12 +517,16 @@
 	if (info->fbops->fb_read)
 		return info->fbops->fb_read(file, buf, count, ppos);
 	
-	if (p >= info->fix.smem_len)
+	total_size = info->screen_size;
+	if (total_size == 0)
+		total_size = info->fix.smem_len;
+
+	if (p >= total_size)
 	    return 0;
-	if (count >= info->fix.smem_len)
-	    count = info->fix.smem_len;
-	if (count + p > info->fix.smem_len)
-		count = info->fix.smem_len - p;
+	if (count >= total_size)
+	    count = total_size;
+	if (count + p > total_size)
+		count = total_size - p;
 
 	cnt = 0;
 	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
@@ -572,6 +577,7 @@
 	struct fb_info *info = registered_fb[fbidx];
 	u32 *buffer, *dst, *src;
 	int c, i, cnt = 0, err;
+	unsigned long total_size;
 
 	if (!info || !info->screen_base)
 		return -ENODEV;
@@ -582,13 +588,17 @@
 	if (info->fbops->fb_write)
 		return info->fbops->fb_write(file, buf, count, ppos);
 	
-	if (p > info->fix.smem_len)
+	total_size = info->screen_size;
+	if (total_size == 0)
+		total_size = info->fix.smem_len;
+
+	if (p > total_size)
 	    return -ENOSPC;
-	if (count >= info->fix.smem_len)
-	    count = info->fix.smem_len;
+	if (count >= total_size)
+	    count = total_size;
 	err = 0;
-	if (count + p > info->fix.smem_len) {
-	    count = info->fix.smem_len - p;
+	if (count + p > total_size) {
+	    count = total_size - p;
 	    err = -ENOSPC;
 	}
 	cnt = 0;
===== drivers/video/aty/radeon_base.c 1.27 vs edited =====
--- 1.27/drivers/video/aty/radeon_base.c	2004-09-11 12:08:04 +10:00
+++ edited/drivers/video/aty/radeon_base.c	2004-09-13 14:05:55 +10:00
@@ -1702,68 +1702,6 @@
 }
 
 
-
-static ssize_t radeonfb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
-{
-	unsigned long p = *ppos;
-	struct inode *inode = file->f_dentry->d_inode;
-	int fbidx = iminor(inode);
-	struct fb_info *info = registered_fb[fbidx];
-	struct radeonfb_info *rinfo = info->par;
-	
-	if (p >= rinfo->mapped_vram)
-	    return 0;
-	if (count >= rinfo->mapped_vram)
-	    count = rinfo->mapped_vram;
-	if (count + p > rinfo->mapped_vram)
-		count = rinfo->mapped_vram - p;
-	radeonfb_sync(info);
-	if (count) {
-	    void __iomem *base_addr;
-
-	    base_addr = info->screen_base;
-	    count -= copy_to_user(buf, base_addr+p, count);	/* Ayee!! */
-	    if (!count)
-		return -EFAULT;
-	    *ppos += count;
-	}
-	return count;
-}
-
-static ssize_t radeonfb_write(struct file *file, const char __user *buf, size_t count,
-			      loff_t *ppos)
-{
-	unsigned long p = *ppos;
-	struct inode *inode = file->f_dentry->d_inode;
-	int fbidx = iminor(inode);
-	struct fb_info *info = registered_fb[fbidx];
-	struct radeonfb_info *rinfo = info->par;
-	int err;
-
-	if (p > rinfo->mapped_vram)
-	    return -ENOSPC;
-	if (count >= rinfo->mapped_vram)
-	    count = rinfo->mapped_vram;
-	err = 0;
-	if (count + p > rinfo->mapped_vram) {
-	    count = rinfo->mapped_vram - p;
-	    err = -ENOSPC;
-	}
-	radeonfb_sync(info);
-	if (count) {
-	    void __iomem *base_addr;
-
-	    base_addr = info->screen_base;
-	    count -= copy_from_user(base_addr+p, buf, count);	/* Ayee!! */
-	    *ppos += count;
-	    err = -EFAULT;
-	}
-	if (count)
-		return count;
-	return err;
-}
-
-
 static struct fb_ops radeonfb_ops = {
 	.owner			= THIS_MODULE,
 	.fb_check_var		= radeonfb_check_var,
@@ -1776,8 +1714,6 @@
 	.fb_fillrect		= radeonfb_fillrect,
 	.fb_copyarea		= radeonfb_copyarea,
 	.fb_imageblit		= radeonfb_imageblit,
-	.fb_read		= radeonfb_read,
-	.fb_write		= radeonfb_write,
 	.fb_cursor		= soft_cursor,
 };
 
@@ -1796,7 +1732,7 @@
 		    | FBINFO_HWACCEL_YPAN;
 	info->fbops = &radeonfb_ops;
 	info->screen_base = rinfo->fb_base;
-
+	info->screen_size = rinfo->mapped_vram;
 	/* Fill fix common fields */
 	strlcpy(info->fix.id, rinfo->name, sizeof(info->fix.id));
         info->fix.smem_start = rinfo->fb_base_phys;
@@ -2242,12 +2178,6 @@
 	}
 
 	RTRACE("radeonfb: mapped %ldk videoram\n", rinfo->mapped_vram/1024);
-
-
-	/* Argh. Scary arch !!! */
-#ifdef CONFIG_PPC64
-	rinfo->fb_base = IO_TOKEN_TO_ADDR(rinfo->fb_base);
-#endif
 
 	/*
 	 * Check for required workaround for PLL accesses
===== include/linux/fb.h 1.82 vs edited =====
--- 1.82/include/linux/fb.h	2004-09-11 12:08:04 +10:00
+++ edited/include/linux/fb.h	2004-09-13 14:01:45 +10:00
@@ -603,6 +603,7 @@
 	struct fb_cmap cmap;		/* Current cmap */
 	struct fb_ops *fbops;
 	char __iomem *screen_base;	/* Virtual address */
+	unsigned long screen_size;	/* Amount of ioremapped VRAM or 0 */ 
 	int currcon;			/* Current VC. */
 	void *pseudo_palette;		/* Fake palette of 16 colors */ 
 #define FBINFO_STATE_RUNNING	0




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
