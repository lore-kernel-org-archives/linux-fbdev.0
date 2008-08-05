From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] fb: convert lock/unlock_kernel() into
	local fb mutex
Date: Tue, 5 Aug 2008 07:37:55 +0200
Message-ID: <20080805073755.bb8d5c8c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQFcd-0002pq-B5 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 23:02:15 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KQFca-0008Oi-0l
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 23:02:13 -0700
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Change lock_kernel()/unlock_kernel() to local fb mutex.
Each frame buffer instance has its own mutex.

The one line try_to_load() function is unrolled to
request_module() in two places for readability.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

The only caveat is that I had to put request_module()
call outside this new mutex while it was inside the 
lock_kernel() (inside fb_open()). 
If the request_module() should be called only inside this mutex
please drop the patch.

Regards,
Krzysztof

diff -urp linux-old/drivers/video/fbmem.c linux-mm/drivers/video/fbmem.c
--- linux-old/drivers/video/fbmem.c	2008-08-04 18:06:28.000000000 +0200
+++ linux-mm/drivers/video/fbmem.c	2008-08-04 19:01:32.601978814 +0200
@@ -837,13 +837,6 @@ fb_write(struct file *file, const char _
 	return (cnt) ? cnt : err;
 }
 
-#ifdef CONFIG_KMOD
-static void try_to_load(int fb)
-{
-	request_module("fb%d", fb);
-}
-#endif /* CONFIG_KMOD */
-
 int
 fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
 {
@@ -1026,12 +1019,12 @@ fb_ioctl(struct file *file, unsigned int
 	void __user *argp = (void __user *)arg;
 	long ret = 0;
 
-	lock_kernel();
 	info = registered_fb[fbidx];
+	mutex_lock(&info->lock);
 	fb = info->fbops;
 
 	if (!fb) {
-		unlock_kernel();
+		mutex_unlock(&info->lock);
 		return -ENODEV;
 	}
 	switch (cmd) {
@@ -1112,7 +1105,7 @@ fb_ioctl(struct file *file, unsigned int
 		}
 #ifdef CONFIG_KMOD
 		if (!registered_fb[con2fb.framebuffer])
-			try_to_load(con2fb.framebuffer);
+			request_module("fb%d", con2fb.framebuffer);
 #endif /* CONFIG_KMOD */
 		if (!registered_fb[con2fb.framebuffer]) {
 			ret = -EINVAL;
@@ -1136,7 +1129,7 @@ fb_ioctl(struct file *file, unsigned int
 		else
 			ret = fb->fb_ioctl(info, cmd, arg);
 	}
-	unlock_kernel();
+	mutex_unlock(&info->lock);
 	return ret;
 }
 
@@ -1263,7 +1256,7 @@ fb_compat_ioctl(struct file *file, unsig
 	struct fb_ops *fb = info->fbops;
 	long ret = -ENOIOCTLCMD;
 
-	lock_kernel();
+	mutex_lock(&info->lock);
 	switch(cmd) {
 	case FBIOGET_VSCREENINFO:
 	case FBIOPUT_VSCREENINFO:
@@ -1289,7 +1282,7 @@ fb_compat_ioctl(struct file *file, unsig
 			ret = fb->fb_compat_ioctl(info, cmd, arg);
 		break;
 	}
-	unlock_kernel();
+	mutex_unlock(&info->lock);
 	return ret;
 }
 #endif
@@ -1311,13 +1304,13 @@ fb_mmap(struct file *file, struct vm_are
 		return -ENODEV;
 	if (fb->fb_mmap) {
 		int res;
-		lock_kernel();
+		mutex_lock(&info->lock);
 		res = fb->fb_mmap(info, vma);
-		unlock_kernel();
+		mutex_unlock(&info->lock);
 		return res;
 	}
 
-	lock_kernel();
+	mutex_lock(&info->lock);
 
 	/* frame buffer memory */
 	start = info->fix.smem_start;
@@ -1326,13 +1319,13 @@ fb_mmap(struct file *file, struct vm_are
 		/* memory mapped io */
 		off -= len;
 		if (info->var.accel_flags) {
-			unlock_kernel();
+			mutex_unlock(&info->lock);
 			return -EINVAL;
 		}
 		start = info->fix.mmio_start;
 		len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.mmio_len);
 	}
-	unlock_kernel();
+	mutex_unlock(&info->lock);
 	start &= PAGE_MASK;
 	if ((vma->vm_end - vma->vm_start + off) > len)
 		return -EINVAL;
@@ -1356,15 +1349,16 @@ fb_open(struct inode *inode, struct file
 
 	if (fbidx >= FB_MAX)
 		return -ENODEV;
-	lock_kernel();
+	info = registered_fb[fbidx];
 #ifdef CONFIG_KMOD
-	if (!(info = registered_fb[fbidx]))
-		try_to_load(fbidx);
+	if (!info)
+		request_module("fb%d", fbidx);
 #endif /* CONFIG_KMOD */
 	if (!(info = registered_fb[fbidx])) {
 		res = -ENODEV;
 		goto out;
 	}
+	mutex_lock(&info->lock);
 	if (!try_module_get(info->fbops->owner)) {
 		res = -ENODEV;
 		goto out;
@@ -1376,7 +1370,7 @@ fb_open(struct inode *inode, struct file
 			module_put(info->fbops->owner);
 	}
 out:
-	unlock_kernel();
+	mutex_unlock(&info->lock);
 	return res;
 }
 
@@ -1385,11 +1379,11 @@ fb_release(struct inode *inode, struct f
 {
 	struct fb_info * const info = file->private_data;
 
-	lock_kernel();
+	mutex_lock(&info->lock);
 	if (info->fbops->fb_release)
 		info->fbops->fb_release(info,1);
 	module_put(info->fbops->owner);
-	unlock_kernel();
+	mutex_unlock(&info->lock);
 	return 0;
 }
 
@@ -1468,6 +1462,7 @@ register_framebuffer(struct fb_info *fb_
 		if (!registered_fb[i])
 			break;
 	fb_info->node = i;
+	mutex_init(&fb_info->lock);
 
 	fb_info->dev = device_create(fb_class, fb_info->device,
 				     MKDEV(FB_MAJOR, i), NULL, "fb%d", i);
diff -urp linux-old/include/linux/fb.h linux-mm/include/linux/fb.h
--- linux-old/include/linux/fb.h	2008-08-04 17:57:10.000000000 +0200
+++ linux-mm/include/linux/fb.h	2008-08-04 18:12:52.553978289 +0200
@@ -808,6 +808,7 @@ struct fb_tile_ops {
 struct fb_info {
 	int node;
 	int flags;
+	struct mutex lock;		/* Lock for open/release/ioctl funcs */
 	struct fb_var_screeninfo var;	/* Current var */
 	struct fb_fix_screeninfo fix;	/* Current fix */
 	struct fb_monspecs monspecs;	/* Current Monitor specs */

----------------------------------------------------------------------
Te newsy nakreca Cie na caly dzien!
Sprawdz >>> http://link.interia.pl/f1e94


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
