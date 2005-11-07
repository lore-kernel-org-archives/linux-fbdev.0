From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/7] fbdev: move ioctl32 code to fbmem.c
Date: Mon, 07 Nov 2005 19:21:08 +0800
Message-ID: <436F38A4.4060803@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZ5Bo-0004W4-53
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:29:28 -0800
Received: from xproxy.gmail.com ([66.249.82.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZ5Bn-0006Hq-J6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:29:28 -0800
Received: by xproxy.gmail.com with SMTP id i28so364656wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 03:29:27 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>

From: Arnd Bergmann <arnd@arndb.de>

The frame buffer layer already had some code dealing with
compat ioctls, this patch moves over the remaining code
from fs/compat_ioctl.c

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
Andrew,

If you haven't picked this up yet.

 drivers/video/fbmem.c        |  147 +++++++++++++++++++++++++++++++++++++++++--
 fs/compat_ioctl.c            |  143 -----------------------------------------
 include/linux/compat_ioctl.h |    7 --
 3 files changed, 142 insertions(+), 155 deletions(-)


diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 81b6cd2..9f18009 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 
+#include <linux/compat.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
@@ -933,18 +934,154 @@ fb_ioctl(struct inode *inode, struct fil
 }
 
 #ifdef CONFIG_COMPAT
+struct fb_fix_screeninfo32 {
+	char			id[16];
+	compat_caddr_t		smem_start;
+	u32			smem_len;
+	u32			type;
+	u32			type_aux;
+	u32			visual;
+	u16			xpanstep;
+	u16			ypanstep;
+	u16			ywrapstep;
+	u32			line_length;
+	compat_caddr_t		mmio_start;
+	u32			mmio_len;
+	u32			accel;
+	u16			reserved[3];
+};
+
+struct fb_cmap32 {
+	u32			start;
+	u32			len;
+	compat_caddr_t	red;
+	compat_caddr_t	green;
+	compat_caddr_t	blue;
+	compat_caddr_t	transp;
+};
+
+static int fb_getput_cmap(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	struct fb_cmap_user __user *cmap;
+	struct fb_cmap32 __user *cmap32;
+	__u32 data;
+	int err;
+
+	cmap = compat_alloc_user_space(sizeof(*cmap));
+	cmap32 = compat_ptr(arg);
+
+	if (copy_in_user(&cmap->start, &cmap32->start, 2 * sizeof(__u32)))
+		return -EFAULT;
+
+	if (get_user(data, &cmap32->red) ||
+	    put_user(compat_ptr(data), &cmap->red) ||
+	    get_user(data, &cmap32->green) ||
+	    put_user(compat_ptr(data), &cmap->green) ||
+	    get_user(data, &cmap32->blue) ||
+	    put_user(compat_ptr(data), &cmap->blue) ||
+	    get_user(data, &cmap32->transp) ||
+	    put_user(compat_ptr(data), &cmap->transp))
+		return -EFAULT;
+
+	err = fb_ioctl(inode, file, cmd, (unsigned long) cmap);
+
+	if (!err) {
+		if (copy_in_user(&cmap32->start,
+				 &cmap->start,
+				 2 * sizeof(__u32)))
+			err = -EFAULT;
+	}
+	return err;
+}
+
+static int do_fscreeninfo_to_user(struct fb_fix_screeninfo *fix,
+				  struct fb_fix_screeninfo32 __user *fix32)
+{
+	__u32 data;
+	int err;
+
+	err = copy_to_user(&fix32->id, &fix->id, sizeof(fix32->id));
+
+	data = (__u32) (unsigned long) fix->smem_start;
+	err |= put_user(data, &fix32->smem_start);
+
+	err |= put_user(fix->smem_len, &fix32->smem_len);
+	err |= put_user(fix->type, &fix32->type);
+	err |= put_user(fix->type_aux, &fix32->type_aux);
+	err |= put_user(fix->visual, &fix32->visual);
+	err |= put_user(fix->xpanstep, &fix32->xpanstep);
+	err |= put_user(fix->ypanstep, &fix32->ypanstep);
+	err |= put_user(fix->ywrapstep, &fix32->ywrapstep);
+	err |= put_user(fix->line_length, &fix32->line_length);
+
+	data = (__u32) (unsigned long) fix->mmio_start;
+	err |= put_user(data, &fix32->mmio_start);
+
+	err |= put_user(fix->mmio_len, &fix32->mmio_len);
+	err |= put_user(fix->accel, &fix32->accel);
+	err |= copy_to_user(fix32->reserved, fix->reserved,
+			    sizeof(fix->reserved));
+
+	return err;
+}
+
+static int fb_get_fscreeninfo(struct inode *inode, struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs;
+	struct fb_fix_screeninfo fix;
+	struct fb_fix_screeninfo32 __user *fix32;
+	int err;
+
+	fix32 = compat_ptr(arg);
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	err = fb_ioctl(inode, file, cmd, (unsigned long) &fix);
+	set_fs(old_fs);
+
+	if (!err)
+		err = do_fscreeninfo_to_user(&fix, fix32);
+
+	return err;
+}
+
 static long
 fb_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	int fbidx = iminor(file->f_dentry->d_inode);
+	struct inode *inode = file->f_dentry->d_inode;
+	int fbidx = iminor(inode);
 	struct fb_info *info = registered_fb[fbidx];
 	struct fb_ops *fb = info->fbops;
-	long ret;
+	long ret = -ENOIOCTLCMD;
 
-	if (fb->fb_compat_ioctl == NULL)
-		return -ENOIOCTLCMD;
 	lock_kernel();
-	ret = fb->fb_compat_ioctl(file, cmd, arg, info);
+	switch(cmd) {
+	case FBIOGET_VSCREENINFO:
+	case FBIOPUT_VSCREENINFO:
+	case FBIOPAN_DISPLAY:
+	case FBIOGET_CON2FBMAP:
+	case FBIOPUT_CON2FBMAP:
+		arg = (unsigned long) compat_ptr(arg);
+	case FBIOBLANK:
+		ret = fb_ioctl(inode, file, cmd, arg);
+		break;
+
+	case FBIOGET_FSCREENINFO:
+		ret = fb_get_fscreeninfo(inode, file, cmd, arg);
+		break;
+
+	case FBIOGETCMAP:
+	case FBIOPUTCMAP:
+		ret = fb_getput_cmap(inode, file, cmd, arg);
+		break;
+
+	default:
+		if (fb->fb_compat_ioctl)
+			ret = fb->fb_compat_ioctl(file, cmd, arg, info);
+		break;
+	}
 	unlock_kernel();
 	return ret;
 }
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index baf19f9..0d4fbf1 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -838,146 +838,6 @@ static int hdio_getgeo(unsigned int fd, 
 	return err ? -EFAULT : 0;
 }
 
-struct fb_fix_screeninfo32 {
-	char			id[16];
-        compat_caddr_t	smem_start;
-	u32			smem_len;
-	u32			type;
-	u32			type_aux;
-	u32			visual;
-	u16			xpanstep;
-	u16			ypanstep;
-	u16			ywrapstep;
-	u32			line_length;
-        compat_caddr_t	mmio_start;
-	u32			mmio_len;
-	u32			accel;
-	u16			reserved[3];
-};
-
-struct fb_cmap32 {
-	u32			start;
-	u32			len;
-	compat_caddr_t	red;
-	compat_caddr_t	green;
-	compat_caddr_t	blue;
-	compat_caddr_t	transp;
-};
-
-static int fb_getput_cmap(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct fb_cmap_user __user *cmap;
-	struct fb_cmap32 __user *cmap32;
-	__u32 data;
-	int err;
-
-	cmap = compat_alloc_user_space(sizeof(*cmap));
-	cmap32 = compat_ptr(arg);
-
-	if (copy_in_user(&cmap->start, &cmap32->start, 2 * sizeof(__u32)))
-		return -EFAULT;
-
-	if (get_user(data, &cmap32->red) ||
-	    put_user(compat_ptr(data), &cmap->red) ||
-	    get_user(data, &cmap32->green) ||
-	    put_user(compat_ptr(data), &cmap->green) ||
-	    get_user(data, &cmap32->blue) ||
-	    put_user(compat_ptr(data), &cmap->blue) ||
-	    get_user(data, &cmap32->transp) ||
-	    put_user(compat_ptr(data), &cmap->transp))
-		return -EFAULT;
-
-	err = sys_ioctl(fd, cmd, (unsigned long) cmap);
-
-	if (!err) {
-		if (copy_in_user(&cmap32->start,
-				 &cmap->start,
-				 2 * sizeof(__u32)))
-			err = -EFAULT;
-	}
-	return err;
-}
-
-static int do_fscreeninfo_to_user(struct fb_fix_screeninfo *fix,
-				  struct fb_fix_screeninfo32 __user *fix32)
-{
-	__u32 data;
-	int err;
-
-	err = copy_to_user(&fix32->id, &fix->id, sizeof(fix32->id));
-
-	data = (__u32) (unsigned long) fix->smem_start;
-	err |= put_user(data, &fix32->smem_start);
-
-	err |= put_user(fix->smem_len, &fix32->smem_len);
-	err |= put_user(fix->type, &fix32->type);
-	err |= put_user(fix->type_aux, &fix32->type_aux);
-	err |= put_user(fix->visual, &fix32->visual);
-	err |= put_user(fix->xpanstep, &fix32->xpanstep);
-	err |= put_user(fix->ypanstep, &fix32->ypanstep);
-	err |= put_user(fix->ywrapstep, &fix32->ywrapstep);
-	err |= put_user(fix->line_length, &fix32->line_length);
-
-	data = (__u32) (unsigned long) fix->mmio_start;
-	err |= put_user(data, &fix32->mmio_start);
-
-	err |= put_user(fix->mmio_len, &fix32->mmio_len);
-	err |= put_user(fix->accel, &fix32->accel);
-	err |= copy_to_user(fix32->reserved, fix->reserved,
-			    sizeof(fix->reserved));
-
-	return err;
-}
-
-static int fb_get_fscreeninfo(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	mm_segment_t old_fs;
-	struct fb_fix_screeninfo fix;
-	struct fb_fix_screeninfo32 __user *fix32;
-	int err;
-
-	fix32 = compat_ptr(arg);
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_ioctl(fd, cmd, (unsigned long) &fix);
-	set_fs(old_fs);
-
-	if (!err)
-		err = do_fscreeninfo_to_user(&fix, fix32);
-
-	return err;
-}
-
-static int fb_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	int err;
-
-	switch (cmd) {
-	case FBIOGET_FSCREENINFO:
-		err = fb_get_fscreeninfo(fd,cmd, arg);
-		break;
-
-  	case FBIOGETCMAP:
-	case FBIOPUTCMAP:
-		err = fb_getput_cmap(fd, cmd, arg);
-		break;
-
-	default:
-		do {
-			static int count;
-			if (++count <= 20)
-				printk("%s: Unknown fb ioctl cmd fd(%d) "
-				       "cmd(%08x) arg(%08lx)\n",
-				       __FUNCTION__, fd, cmd, arg);
-		} while(0);
-		err = -ENOSYS;
-		break;
-	};
-
-	return err;
-}
-
 static int hdio_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	mm_segment_t old_fs = get_fs();
@@ -2951,10 +2811,7 @@ HANDLE_IOCTL(BLKGETSIZE, w_long)
 HANDLE_IOCTL(0x1260, broken_blkgetsize)
 HANDLE_IOCTL(BLKFRAGET, w_long)
 HANDLE_IOCTL(BLKSECTGET, w_long)
-HANDLE_IOCTL(FBIOGET_FSCREENINFO, fb_ioctl_trans)
 HANDLE_IOCTL(BLKPG, blkpg_ioctl_trans)
-HANDLE_IOCTL(FBIOGETCMAP, fb_ioctl_trans)
-HANDLE_IOCTL(FBIOPUTCMAP, fb_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_KEEPSETTINGS, hdio_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_UNMASKINTR, hdio_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_DMA, hdio_ioctl_trans)
diff --git a/include/linux/compat_ioctl.h b/include/linux/compat_ioctl.h
index 4c63c29..2209ad3 100644
--- a/include/linux/compat_ioctl.h
+++ b/include/linux/compat_ioctl.h
@@ -56,13 +56,6 @@ ULONG_IOCTL(TIOCSCTTY)
 COMPATIBLE_IOCTL(TIOCGPTN)
 COMPATIBLE_IOCTL(TIOCSPTLCK)
 COMPATIBLE_IOCTL(TIOCSERGETLSR)
-/* Big F */
-COMPATIBLE_IOCTL(FBIOBLANK)
-COMPATIBLE_IOCTL(FBIOGET_VSCREENINFO)
-COMPATIBLE_IOCTL(FBIOPUT_VSCREENINFO)
-COMPATIBLE_IOCTL(FBIOPAN_DISPLAY)
-COMPATIBLE_IOCTL(FBIOGET_CON2FBMAP)
-COMPATIBLE_IOCTL(FBIOPUT_CON2FBMAP)
 /* Little f */
 COMPATIBLE_IOCTL(FIOCLEX)
 COMPATIBLE_IOCTL(FIONCLEX)



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
