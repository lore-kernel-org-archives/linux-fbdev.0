From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH][RESUBMIT] fbdev: fix copy_to/from_user in fbmem.c:fb_read/write
Date: Mon, 30 Aug 2004 20:11:34 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408302011.34384.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1l2N-00074L-KS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 05:13:27 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C1l2M-0000c8-Uq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 05:13:27 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 4FF6410B234E
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 30 Aug 2004 12:13:21 +0000 (UTC)
Content-Disposition: inline
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This patch fixes a problem reported by David S. Miller <davem@redhat.com>

"I just noticed that fb_{read,write}() uses copy_*_user() with
the kernel buffer being the frame buffer.  It needs to use
the proper device address accessor functions."

The patch will do an intermediate copy of the contents to a page-sized,
kmalloc'ed buffer.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbmem.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 72 insertions(+), 18 deletions(-)

diff -uprN linux-2.6.9-rc1-mm1-orig/drivers/video/fbmem.c linux-2.6.9-rc1-mm1/drivers/video/fbmem.c
--- linux-2.6.9-rc1-mm1-orig/drivers/video/fbmem.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm1/drivers/video/fbmem.c	2004-08-30 19:40:16.581806584 +0800
@@ -878,6 +878,8 @@ fb_read(struct file *file, char __user *
 	struct inode *inode = file->f_dentry->d_inode;
 	int fbidx = iminor(inode);
 	struct fb_info *info = registered_fb[fbidx];
+	u32 *buffer, *dst, *src;
+	int c, i, cnt = 0, err = 0;
 
 	if (!info || ! info->screen_base)
 		return -ENODEV;
@@ -894,18 +896,45 @@ fb_read(struct file *file, char __user *
 	    count = info->fix.smem_len;
 	if (count + p > info->fix.smem_len)
 		count = info->fix.smem_len - p;
+
+	cnt = 0;
+	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
+			 GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	src = (u32 *) (info->screen_base + p);
+
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
-	if (count) {
-	    char *base_addr;
+
+	while (count) {
+		c  = (count > PAGE_SIZE) ? PAGE_SIZE : count;
+		dst = buffer;
+		for (i = c >> 2; i--; )
+			*dst++ = fb_readl(src++);
+		if (c & 3) {
+			u8 *dst8 = (u8 *) dst;
+			u8 *src8 = (u8 *) src;
 
-	    base_addr = info->screen_base;
-	    count -= copy_to_user(buf, base_addr+p, count);
-	    if (!count)
-		return -EFAULT;
-	    *ppos += count;
+			for (i = c & 3; i--;)
+				*dst8++ = fb_readb(src8++);
+
+			src = (u32 *) src8;
+		}
+
+		if (copy_to_user(buf, buffer, c)) {
+			err = -EFAULT;
+			break;
+		}
+		*ppos += c;
+		buf += c;
+		cnt += c;
+		count -= c;
 	}
-	return count;
+
+	kfree(buffer);
+	return (err) ? err : cnt;
 }
 
 static ssize_t
@@ -915,7 +944,8 @@ fb_write(struct file *file, const char _
 	struct inode *inode = file->f_dentry->d_inode;
 	int fbidx = iminor(inode);
 	struct fb_info *info = registered_fb[fbidx];
-	int err;
+	u32 *buffer, *dst, *src;
+	int c, i, cnt = 0, err;
 
 	if (!info || !info->screen_base)
 		return -ENODEV;
@@ -935,19 +965,43 @@ fb_write(struct file *file, const char _
 	    count = info->fix.smem_len - p;
 	    err = -ENOSPC;
 	}
+	cnt = 0;
+	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
+			 GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	dst = (u32 *) (info->screen_base + p);
+
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
-	if (count) {
-	    char *base_addr;
 
-	    base_addr = info->screen_base;
-	    count -= copy_from_user(base_addr+p, buf, count);
-	    *ppos += count;
-	    err = -EFAULT;
+	while (count) {
+		c = (count > PAGE_SIZE) ? PAGE_SIZE : count;
+		src = buffer;
+		if (copy_from_user(src, buf, c)) {
+			err = -EFAULT;
+			break;
+		}
+		for (i = c >> 2; i--; )
+			fb_writel(*src++, dst++);
+		if (c & 3) {
+			u8 *src8 = (u8 *) src;
+			u8 *dst8 = (u8 *) dst;
+
+			for (i = c & 3; i--; )
+				fb_writeb(*src8++, dst8++);
+
+			dst = (u32 *) dst8;
+		}
+		*ppos += c;
+		buf += c;
+		cnt += c;
+		count -= c;
 	}
-	if (count)
-		return count;
-	return err;
+	kfree(buffer);
+
+	return (err) ? err : cnt;
 }
 
 #ifdef CONFIG_KMOD




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
