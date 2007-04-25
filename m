From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 21/41] fbdev: Pass struct fb_info to
	fb_read and fb_write
Date: Wed, 25 Apr 2007 14:47:24 +0800
Message-ID: <462EF97C.2050209@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcXB-0003za-7J for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 01:07:29 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc90-0002pB-UY
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:42:31 -0700
Received: by py-out-1112.google.com with SMTP id a29so116192pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:42:30 -0700 (PDT)
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
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Christopher Hoover <ch@hpl.hp.com>

It is unnecessary to pass struct file to fb_read() and fb_write() in struct
fb_ops. For consistency with the other methods, pass struct fb_info instead.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/arcfb.c       |   14 ++------------
 drivers/video/epson1355fb.c |   18 ++----------------
 drivers/video/fbmem.c       |    4 ++--
 drivers/video/hecubafb.c    |   12 +-----------
 drivers/video/pvr2fb.c      |    4 ++--
 include/linux/fb.h          |    6 ++++--
 6 files changed, 13 insertions(+), 45 deletions(-)

diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index 740b83b..c668e56 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -440,14 +440,11 @@ static int arcfb_ioctl(struct fb_info *i
  * the fb. it's inefficient for them to do anything less than 64*8
  * writes since we update the lcd in each write() anyway.
  */
-static ssize_t arcfb_write(struct file *file, const char __user *buf, size_t count,
-				loff_t *ppos)
+static ssize_t arcfb_write(struct fb_info *info, const char __user *buf,
+			   size_t count, loff_t *ppos)
 {
 	/* modded from epson 1355 */
 
-	struct inode *inode;
-	int fbidx;
-	struct fb_info *info;
 	unsigned long p;
 	int err=-EINVAL;
 	unsigned int fbmemlength,x,y,w,h, bitppos, startpos, endpos, bitcount;
@@ -455,13 +452,6 @@ static ssize_t arcfb_write(struct file *
 	unsigned int xres;
 
 	p = *ppos;
-	inode = file->f_path.dentry->d_inode;
-	fbidx = iminor(inode);
-	info = registered_fb[fbidx];
-
-	if (!info || !info->screen_base)
-		return -ENODEV;
-
 	par = info->par;
 	xres = info->var.xres;
 	fbmemlength = (xres * info->var.yres)/8;
diff --git a/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
index 37e297d..ca2c54c 100644
--- a/drivers/video/epson1355fb.c
+++ b/drivers/video/epson1355fb.c
@@ -403,17 +403,10 @@ static inline unsigned long copy_to_user
 
 
 static ssize_t
-epson1355fb_read(struct file *file, char *buf, size_t count, loff_t * ppos)
+epson1355fb_read(struct fb_info *info, char *buf, size_t count, loff_t * ppos)
 {
-	struct inode *inode = file->f_path.dentry->d_inode;
-	int fbidx = iminor(inode);
-	struct fb_info *info = registered_fb[fbidx];
 	unsigned long p = *ppos;
 
-	/* from fbmem.c except for our own copy_*_user */
-	if (!info || !info->screen_base)
-		return -ENODEV;
-
 	if (p >= info->fix.smem_len)
 		return 0;
 	if (count >= info->fix.smem_len)
@@ -434,20 +427,13 @@ epson1355fb_read(struct file *file, char
 }
 
 static ssize_t
-epson1355fb_write(struct file *file, const char *buf,
+epson1355fb_write(struct fb_info *info, const char *buf,
 		  size_t count, loff_t * ppos)
 {
-	struct inode *inode = file->f_path.dentry->d_inode;
-	int fbidx = iminor(inode);
-	struct fb_info *info = registered_fb[fbidx];
 	unsigned long p = *ppos;
 	int err;
 
 	/* from fbmem.c except for our own copy_*_user */
-	if (!info || !info->screen_base)
-		return -ENODEV;
-
-	/* from fbmem.c except for our own copy_*_user */
 	if (p > info->fix.smem_len)
 		return -ENOSPC;
 	if (count >= info->fix.smem_len)
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 08c292d..7b72841 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -588,7 +588,7 @@ fb_read(struct file *file, char __user *
 		return -EPERM;
 
 	if (info->fbops->fb_read)
-		return info->fbops->fb_read(file, buf, count, ppos);
+		return info->fbops->fb_read(info, buf, count, ppos);
 	
 	total_size = info->screen_size;
 
@@ -663,7 +663,7 @@ fb_write(struct file *file, const char _
 		return -EPERM;
 
 	if (info->fbops->fb_write)
-		return info->fbops->fb_write(file, buf, count, ppos);
+		return info->fbops->fb_write(info, buf, count, ppos);
 	
 	total_size = info->screen_size;
 
diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index 0ade725..3ec0e97 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -267,12 +267,9 @@ static void hecubafb_imageblit(struct fb
  * this is the slow path from userspace. they can seek and write to
  * the fb. it's inefficient to do anything less than a full screen draw
  */
-static ssize_t hecubafb_write(struct file *file, const char __user *buf,
+static ssize_t hecubafb_write(struct fb_info *info, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	struct inode *inode;
-	int fbidx;
-	struct fb_info *info;
 	unsigned long p;
 	int err=-EINVAL;
 	struct hecubafb_par *par;
@@ -280,13 +277,6 @@ static ssize_t hecubafb_write(struct fil
 	unsigned int fbmemlength;
 
 	p = *ppos;
-	inode = file->f_dentry->d_inode;
-	fbidx = iminor(inode);
-	info = registered_fb[fbidx];
-
-	if (!info || !info->screen_base)
-		return -ENODEV;
-
 	par = info->par;
 	xres = info->var.xres;
 	fbmemlength = (xres * info->var.yres)/8;
diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index a93618b..df2909a 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -214,7 +214,7 @@ static int pvr2_init_cable(void);
 static int pvr2_get_param(const struct pvr2_params *p, const char *s,
                             int val, int size);
 #ifdef CONFIG_SH_DMA
-static ssize_t pvr2fb_write(struct file *file, const char *buf,
+static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
 			    size_t count, loff_t *ppos);
 #endif
 
@@ -674,7 +674,7 @@ static int pvr2_init_cable(void)
 }
 
 #ifdef CONFIG_SH_DMA
-static ssize_t pvr2fb_write(struct file *file, const char *buf,
+static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
 			    size_t count, loff_t *ppos)
 {
 	unsigned long dst, start, end, len;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index c4e1b3d..acb6ddb 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -591,8 +591,10 @@ struct fb_ops {
 	/* For framebuffers with strange non linear layouts or that do not
 	 * work with normal memory mapped access
 	 */
-	ssize_t (*fb_read)(struct file *file, char __user *buf, size_t count, loff_t *ppos);
-	ssize_t (*fb_write)(struct file *file, const char __user *buf, size_t count, loff_t *ppos);
+	ssize_t (*fb_read)(struct fb_info *info, char __user *buf,
+			   size_t count, loff_t *ppos);
+	ssize_t (*fb_write)(struct fb_info *info, const char __user *buf,
+			    size_t count, loff_t *ppos);
 
 	/* checks var and eventually tweaks it to something supported,
 	 * DO NOT MODIFY PAR */


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
