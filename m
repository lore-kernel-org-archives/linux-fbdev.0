From: Thiago Galesi <thiagogalesi@gmail.com>
Subject: [PATCH] fb: Remove use of lock_kernel / unlock_kernel in fbmem
Date: Sun, 13 Apr 2008 11:50:07 -0300
Message-ID: <200804131150.07601.thiagogalesi@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759242AbYDMOu1@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Hello

This patch removes lock_kernel(), unlock_kernel() usage in fbmem.c and replaces it with a mutex

Signed-off-by: Thiago Galesi <thiagogalesi@gmail.com>

---

Index: linux-2.6.23.1/drivers/video/fbmem.c
===================================================================
--- linux-2.6.23.1.orig/drivers/video/fbmem.c	2007-10-12 13:43:44.000000000 -0300
+++ linux-2.6.23.1/drivers/video/fbmem.c	2008-04-12 15:08:04.000000000 -0300
@@ -1208,7 +1208,7 @@
 	struct fb_ops *fb = info->fbops;
 	long ret = -ENOIOCTLCMD;
 
-	lock_kernel();
+	mutex_lock(&info->hwlock);
 	switch(cmd) {
 	case FBIOGET_VSCREENINFO:
 	case FBIOPUT_VSCREENINFO:
@@ -1234,7 +1234,7 @@
 			ret = fb->fb_compat_ioctl(info, cmd, arg);
 		break;
 	}
-	unlock_kernel();
+	mutex_unlock(&info->hwlock);
 	return ret;
 }
 #endif
@@ -1256,13 +1256,13 @@
 		return -ENODEV;
 	if (fb->fb_mmap) {
 		int res;
-		lock_kernel();
+		mutex_lock(&info->hwlock);
 		res = fb->fb_mmap(info, vma);
-		unlock_kernel();
+		mutex_unlock(&info->hwlock);
 		return res;
 	}
 
-	lock_kernel();
+	mutex_lock(&info->hwlock);
 
 	/* frame buffer memory */
 	start = info->fix.smem_start;
@@ -1271,13 +1271,13 @@
 		/* memory mapped io */
 		off -= len;
 		if (info->var.accel_flags) {
-			unlock_kernel();
+			mutex_unlock(&info->hwlock);
 			return -EINVAL;
 		}
 		start = info->fix.mmio_start;
 		len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.mmio_len);
 	}
-	unlock_kernel();
+	mutex_unlock(&info->hwlock);
 	start &= PAGE_MASK;
 	if ((vma->vm_end - vma->vm_start + off) > len)
 		return -EINVAL;
@@ -1323,11 +1323,11 @@
 {
 	struct fb_info * const info = file->private_data;
 
-	lock_kernel();
+	mutex_lock(&info->hwlock);
 	if (info->fbops->fb_release)
 		info->fbops->fb_release(info,1);
 	module_put(info->fbops->owner);
-	unlock_kernel();
+	mutex_unlock(&info->hwlock);
 	return 0;
 }
 
@@ -1413,6 +1413,8 @@
 
 	event.info = fb_info;
 	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
+
+	mutex_init(&fb_info->hwlock);
 	return 0;
 }
 
@@ -1464,6 +1466,7 @@
 	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 	event.info = fb_info;
 	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
+	mutex_destroy(&fb_info.hwlock);
 done:
 	return ret;
 }
Index: linux-2.6.23.1/include/linux/fb.h
===================================================================
--- linux-2.6.23.1.orig/include/linux/fb.h	2007-10-12 13:43:44.000000000 -0300
+++ linux-2.6.23.1/include/linux/fb.h	2008-04-12 15:06:41.000000000 -0300
@@ -802,6 +802,7 @@
 	struct list_head modelist;      /* mode list */
 	struct fb_videomode *mode;	/* current mode */
 
+	struct mutex hwlock;		/* mutex for protecting hw ops */
 #ifdef CONFIG_FB_BACKLIGHT
 	/* assigned backlight device */
 	/* set before framebuffer registration, 
