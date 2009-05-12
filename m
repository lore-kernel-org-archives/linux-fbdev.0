From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] fbdev: move back to BKL solution
Date: Tue, 12 May 2009 22:48:00 +0200
Message-ID: <20090512224800.59b1c787.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M3yo1-0000rS-RO
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 May 2009 20:42:29 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M3ynn-0005S6-2S for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 May 2009 20:42:24 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

A conversion of the BLK to the fb_info->lock mutex brought some circular locking dependencies.
Despite extensive effort to fix these problems there are still some bugs left. The last effort unveiled
a problem described below. It is not fixable without rethinking how locking should be done inside
the fbdev layer. 

Short summary of the lock dep is:

1. sys_munmap() obtains [mm->mmap_sem] and calls indirectly
  :: fb_release() obtains [fb_info->lock]

2. fb_ioctl() obtains [fb_info->lock] and calls indirectly
  :: fb_notifier_call_chain() obtains [fb_notifier_list->rwsem]

3. driver_probe_device() calls indirectly
  :: register_framebuffer() calls indirectly
    :: fb_notifier_call_chain() obtains [fb_notifier_list->rwsem] and calls indirectly
      :: sysfs_create_dir() obtains [sysfs_mutex]

4. sysfs_readdir() obtains [sysfs_mutex] and calls indirectly
  :: copy_to_user() obtains [mm->mmap_sem]

Revert the BKL to mutex conversion patch (3e680aae4e53ab54cdbb0c29257dae0cbb158e1c) 
while keeping the patch which made the fb_ioctl and the fb_compat_ioctl using
a common function (a684e7d33096892093456dd56a582cfc3bfad648).

This patch requires reverting following commits before applying:
513adb58685615b0b1d47a3f0d40f5352beff189
6a7f2829b5f8be124e168265f176dbbbea8861a0
66c1ca019078220dc1bf968f2bb18421100ef147
1f5e31d7e55ac7fbd4ec5e5b20c8868b0e4564c9

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

The commits for reverting are given in correct order for reverting
(the newest is the first).


 drivers/video/fbmem.c |   47 ++++++++++++++++++-----------------------------
 include/linux/fb.h    |    1 -
 2 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 756efeb..fd65399 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1126,18 +1126,16 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 }
 
 static long fb_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-__acquires(&info->lock)
-__releases(&info->lock)
 {
 	struct inode *inode = file->f_path.dentry->d_inode;
 	int fbidx = iminor(inode);
 	struct fb_info *info;
 	long ret;
 
+	lock_kernel();
 	info = registered_fb[fbidx];
-	mutex_lock(&info->lock);
 	ret = do_fb_ioctl(info, cmd, arg);
-	mutex_unlock(&info->lock);
+	unlock_kernel();
 	return ret;
 }
 
@@ -1257,8 +1255,6 @@ static int fb_get_fscreeninfo(struct fb_info *info, unsigned int cmd,
 
 static long fb_compat_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
-__acquires(&info->lock)
-__releases(&info->lock)
 {
 	struct inode *inode = file->f_path.dentry->d_inode;
 	int fbidx = iminor(inode);
@@ -1266,7 +1262,7 @@ __releases(&info->lock)
 	struct fb_ops *fb = info->fbops;
 	long ret = -ENOIOCTLCMD;
 
-	mutex_lock(&info->lock);
+	lock_kernel();
 	switch(cmd) {
 	case FBIOGET_VSCREENINFO:
 	case FBIOPUT_VSCREENINFO:
@@ -1292,15 +1288,13 @@ __releases(&info->lock)
 			ret = fb->fb_compat_ioctl(info, cmd, arg);
 		break;
 	}
-	mutex_unlock(&info->lock);
+	unlock_kernel();
 	return ret;
 }
 #endif
 
 static int
 fb_mmap(struct file *file, struct vm_area_struct * vma)
-__acquires(&info->lock)
-__releases(&info->lock)
 {
 	int fbidx = iminor(file->f_path.dentry->d_inode);
 	struct fb_info *info = registered_fb[fbidx];
@@ -1316,13 +1310,13 @@ __releases(&info->lock)
 		return -ENODEV;
 	if (fb->fb_mmap) {
 		int res;
-		mutex_lock(&info->lock);
+		lock_kernel();
 		res = fb->fb_mmap(info, vma);
-		mutex_unlock(&info->lock);
+		unlock_kernel();
 		return res;
 	}
 
-	mutex_lock(&info->lock);
+	lock_kernel();
 
 	/* frame buffer memory */
 	start = info->fix.smem_start;
@@ -1331,13 +1325,13 @@ __releases(&info->lock)
 		/* memory mapped io */
 		off -= len;
 		if (info->var.accel_flags) {
-			mutex_unlock(&info->lock);
+			unlock_kernel();
 			return -EINVAL;
 		}
 		start = info->fix.mmio_start;
 		len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.mmio_len);
 	}
-	mutex_unlock(&info->lock);
+	unlock_kernel();
 	start &= PAGE_MASK;
 	if ((vma->vm_end - vma->vm_start + off) > len)
 		return -EINVAL;
@@ -1354,8 +1348,6 @@ __releases(&info->lock)
 
 static int
 fb_open(struct inode *inode, struct file *file)
-__acquires(&info->lock)
-__releases(&info->lock)
 {
 	int fbidx = iminor(inode);
 	struct fb_info *info;
@@ -1363,13 +1355,13 @@ __releases(&info->lock)
 
 	if (fbidx >= FB_MAX)
 		return -ENODEV;
-	info = registered_fb[fbidx];
-	if (!info)
+	lock_kernel();
+	if (!(info = registered_fb[fbidx]))
 		request_module("fb%d", fbidx);
-	info = registered_fb[fbidx];
-	if (!info)
-		return -ENODEV;
-	mutex_lock(&info->lock);
+	if (!(info = registered_fb[fbidx])) {
+		res = -ENODEV;
+		goto out;
+	}
 	if (!try_module_get(info->fbops->owner)) {
 		res = -ENODEV;
 		goto out;
@@ -1385,22 +1377,20 @@ __releases(&info->lock)
 		fb_deferred_io_open(info, inode, file);
 #endif
 out:
-	mutex_unlock(&info->lock);
+	unlock_kernel();
 	return res;
 }
 
 static int 
 fb_release(struct inode *inode, struct file *file)
-__acquires(&info->lock)
-__releases(&info->lock)
 {
 	struct fb_info * const info = file->private_data;
 
-	mutex_lock(&info->lock);
+	lock_kernel();
 	if (info->fbops->fb_release)
 		info->fbops->fb_release(info,1);
 	module_put(info->fbops->owner);
-	mutex_unlock(&info->lock);
+	unlock_kernel();
 	return 0;
 }
 
@@ -1479,7 +1469,6 @@ register_framebuffer(struct fb_info *fb_info)
 		if (!registered_fb[i])
 			break;
 	fb_info->node = i;
-	mutex_init(&fb_info->lock);
 
 	fb_info->dev = device_create(fb_class, fb_info->device,
 				     MKDEV(FB_MAJOR, i), NULL, "fb%d", i);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 3c98db3..0a5b462 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -813,7 +813,6 @@ struct fb_tile_ops {
 struct fb_info {
 	int node;
 	int flags;
-	struct mutex lock;		/* Lock for open/release/ioctl funcs */
 	struct fb_var_screeninfo var;	/* Current var */
 	struct fb_fix_screeninfo fix;	/* Current fix */
 	struct fb_monspecs monspecs;	/* Current Monitor specs */
-- 
1.6.0.3


----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>> http://link.interia.pl/f2162 


------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
