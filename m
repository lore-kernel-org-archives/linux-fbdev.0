From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/9] fbdev: Fix return code of fb_read and fb_write
Date: Tue, 20 Dec 2005 20:48:13 +0800
Message-ID: <43A7FD8D.7050207@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoyEI-0002A9-PZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:17:42 -0800
Received: from zproxy.gmail.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EoyEI-0005Kv-F1
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:17:42 -0800
Received: by zproxy.gmail.com with SMTP id z3so76970nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Dec 2005 23:17:42 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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

Make fb_read() and fb_write() return 0 (EOF) instead of -ENOSPC if reading
at or past the end of the framebuffer. This fixes user space apps hanging
if info->fix.smem_len == 0.

Whitespace changes.
    
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbmem.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 10dfdf0..83e2594 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -589,17 +589,19 @@ fb_read(struct file *file, char __user *
 		return info->fbops->fb_read(file, buf, count, ppos);
 	
 	total_size = info->screen_size;
+
 	if (total_size == 0)
 		total_size = info->fix.smem_len;
 
 	if (p >= total_size)
-	    return 0;
+		return 0;
+
 	if (count >= total_size)
-	    count = total_size;
+		count = total_size;
+
 	if (count + p > total_size)
 		count = total_size - p;
 
-	cnt = 0;
 	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
 			 GFP_KERNEL);
 	if (!buffer)
@@ -636,6 +638,7 @@ fb_read(struct file *file, char __user *
 	}
 
 	kfree(buffer);
+
 	return (err) ? err : cnt;
 }
 
@@ -648,7 +651,7 @@ fb_write(struct file *file, const char _
 	struct fb_info *info = registered_fb[fbidx];
 	u32 *buffer, *src;
 	u32 __iomem *dst;
-	int c, i, cnt = 0, err;
+	int c, i, cnt = 0, err = 0;
 	unsigned long total_size;
 
 	if (!info || !info->screen_base)
@@ -661,19 +664,19 @@ fb_write(struct file *file, const char _
 		return info->fbops->fb_write(file, buf, count, ppos);
 	
 	total_size = info->screen_size;
+
 	if (total_size == 0)
 		total_size = info->fix.smem_len;
 
 	if (p > total_size)
-	    return -ENOSPC;
+		return 0;
+
 	if (count >= total_size)
-	    count = total_size;
-	err = 0;
-	if (count + p > total_size) {
-	    count = total_size - p;
-	    err = -ENOSPC;
-	}
-	cnt = 0;
+		count = total_size;
+
+	if (count + p > total_size)
+		count = total_size - p;
+
 	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
 			 GFP_KERNEL);
 	if (!buffer)
@@ -687,12 +690,15 @@ fb_write(struct file *file, const char _
 	while (count) {
 		c = (count > PAGE_SIZE) ? PAGE_SIZE : count;
 		src = buffer;
+
 		if (copy_from_user(src, buf, c)) {
 			err = -EFAULT;
 			break;
 		}
+
 		for (i = c >> 2; i--; )
 			fb_writel(*src++, dst++);
+
 		if (c & 3) {
 			u8 *src8 = (u8 *) src;
 			u8 __iomem *dst8 = (u8 __iomem *) dst;
@@ -702,11 +708,13 @@ fb_write(struct file *file, const char _
 
 			dst = (u32 __iomem *) dst8;
 		}
+
 		*ppos += c;
 		buf += c;
 		cnt += c;
 		count -= c;
 	}
+
 	kfree(buffer);
 
 	return (err) ? err : cnt;




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
