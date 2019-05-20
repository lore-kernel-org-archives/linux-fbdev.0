From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 20 May 2019 08:21:59 +0000
Subject: [PATCH 16/33] fbdev: lock_fb_info cannot fail
Message-Id: <20190520082216.26273-17-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, Peter Rosin <peda@axentia.se>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Mikulas Patocka <mpatocka@redhat.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-fbdev@vger.kernel.org

Ever since

commit c47747fde931c02455683bd00ea43eaa62f35b0e
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed May 11 14:58:34 2011 -0700

    fbmem: make read/write/ioctl use the frame buffer at open time

fbdev has gained proper refcounting for the fbinfo attached to any
open files, which means that the backing driver (stored in
fb_info->fbops) cannot untimely disappear anymore.

The only thing that can happen is that the entire device just outright
disappears and gets unregistered, but file_fb_info does check for
that. Except that it's racy - it only checks once at the start of a
file_ops, there's no guarantee that the underlying fbdev won't
untimely disappear. Aside: A proper way to fix that race is probably
to replicate the srcu trickery we've rolled out in drm.

But given that this race has existed since forever it's probably not
one we need to fix right away. do_unregister_framebuffer also nowhere
clears fb_info->fbops, hence the check in lock_fb_info can't possible
catch a disappearing fbdev later on.

Long story short: Ever since the above commit the fb_info->fbops
checks have essentially become dead code. Remove this all.

Aside from the file_ops callbacks, and stuff called from there
there's only register/unregister code left. If that goes wrong a driver
managed to register/unregister a device instance twice or in the wrong
order.  That's just a driver bug.

v2:
- fb_mmap had an open-coded version of the fbinfo->fops check, because
  it doesn't need the fbinfo->lock. Delete that too.
- Use the wrapper function in fb_open/release now, since no difference
  anymore.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: "Noralf Trønnes" <noralf@tronnes.org>
Cc: Peter Rosin <peda@axentia.se>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbcmap.c |  6 +--
 drivers/video/fbdev/core/fbcon.c  |  3 +-
 drivers/video/fbdev/core/fbmem.c  | 73 +++++++------------------------
 include/linux/fb.h                |  5 ++-
 4 files changed, 23 insertions(+), 64 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcmap.c b/drivers/video/fbdev/core/fbcmap.c
index 68a113594808..aac710b2f95f 100644
--- a/drivers/video/fbdev/core/fbcmap.c
+++ b/drivers/video/fbdev/core/fbcmap.c
@@ -283,11 +283,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
 		goto out;
 	}
 	umap.start = cmap->start;
-	if (!lock_fb_info(info)) {
-		rc = -ENODEV;
-		goto out;
-	}
-
+	lock_fb_info(info);
 	rc = fb_set_cmap(&umap, info);
 	unlock_fb_info(info);
 out:
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 95af6bd783e8..35443add7f7e 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2360,8 +2360,7 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 	}
 
 
-	if (!lock_fb_info(info))
-		return;
+	lock_fb_info(info);
 	event.info = info;
 	event.data = &blank;
 	fb_notifier_call_chain(FB_EVENT_CONBLANK, &event);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index ae2db31eeba7..1987aba4f5a2 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -80,17 +80,6 @@ static void put_fb_info(struct fb_info *fb_info)
 		fb_info->fbops->fb_destroy(fb_info);
 }
 
-int lock_fb_info(struct fb_info *info)
-{
-	mutex_lock(&info->lock);
-	if (!info->fbops) {
-		mutex_unlock(&info->lock);
-		return 0;
-	}
-	return 1;
-}
-EXPORT_SYMBOL(lock_fb_info);
-
 /*
  * Helpers
  */
@@ -1121,8 +1110,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 
 	switch (cmd) {
 	case FBIOGET_VSCREENINFO:
-		if (!lock_fb_info(info))
-			return -ENODEV;
+		lock_fb_info(info);
 		var = info->var;
 		unlock_fb_info(info);
 
@@ -1132,10 +1120,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		if (copy_from_user(&var, argp, sizeof(var)))
 			return -EFAULT;
 		console_lock();
-		if (!lock_fb_info(info)) {
-			console_unlock();
-			return -ENODEV;
-		}
+		lock_fb_info(info);
 		info->flags |= FBINFO_MISC_USEREVENT;
 		ret = fb_set_var(info, &var);
 		info->flags &= ~FBINFO_MISC_USEREVENT;
@@ -1145,8 +1130,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			ret = -EFAULT;
 		break;
 	case FBIOGET_FSCREENINFO:
-		if (!lock_fb_info(info))
-			return -ENODEV;
+		lock_fb_info(info);
 		fix = info->fix;
 		if (info->flags & FBINFO_HIDE_SMEM_START)
 			fix.smem_start = 0;
@@ -1162,8 +1146,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOGETCMAP:
 		if (copy_from_user(&cmap, argp, sizeof(cmap)))
 			return -EFAULT;
-		if (!lock_fb_info(info))
-			return -ENODEV;
+		lock_fb_info(info);
 		cmap_from = info->cmap;
 		unlock_fb_info(info);
 		ret = fb_cmap_to_user(&cmap_from, &cmap);
@@ -1172,10 +1155,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		if (copy_from_user(&var, argp, sizeof(var)))
 			return -EFAULT;
 		console_lock();
-		if (!lock_fb_info(info)) {
-			console_unlock();
-			return -ENODEV;
-		}
+		lock_fb_info(info);
 		ret = fb_pan_display(info, &var);
 		unlock_fb_info(info);
 		console_unlock();
@@ -1192,8 +1172,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			return -EINVAL;
 		con2fb.framebuffer = -1;
 		event.data = &con2fb;
-		if (!lock_fb_info(info))
-			return -ENODEV;
+		lock_fb_info(info);
 		event.info = info;
 		fb_notifier_call_chain(FB_EVENT_GET_CONSOLE_MAP, &event);
 		unlock_fb_info(info);
@@ -1214,10 +1193,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		}
 		event.data = &con2fb;
 		console_lock();
-		if (!lock_fb_info(info)) {
-			console_unlock();
-			return -ENODEV;
-		}
+		lock_fb_info(info);
 		event.info = info;
 		ret = fb_notifier_call_chain(FB_EVENT_SET_CONSOLE_MAP, &event);
 		unlock_fb_info(info);
@@ -1225,10 +1201,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		break;
 	case FBIOBLANK:
 		console_lock();
-		if (!lock_fb_info(info)) {
-			console_unlock();
-			return -ENODEV;
-		}
+		lock_fb_info(info);
 		info->flags |= FBINFO_MISC_USEREVENT;
 		ret = fb_blank(info, arg);
 		info->flags &= ~FBINFO_MISC_USEREVENT;
@@ -1236,8 +1209,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		console_unlock();
 		break;
 	default:
-		if (!lock_fb_info(info))
-			return -ENODEV;
+		lock_fb_info(info);
 		fb = info->fbops;
 		if (fb->fb_ioctl)
 			ret = fb->fb_ioctl(info, cmd, arg);
@@ -1357,8 +1329,7 @@ static int fb_get_fscreeninfo(struct fb_info *info, unsigned int cmd,
 {
 	struct fb_fix_screeninfo fix;
 
-	if (!lock_fb_info(info))
-		return -ENODEV;
+	lock_fb_info(info);
 	fix = info->fix;
 	if (info->flags & FBINFO_HIDE_SMEM_START)
 		fix.smem_start = 0;
@@ -1418,8 +1389,6 @@ fb_mmap(struct file *file, struct vm_area_struct * vma)
 	if (!info)
 		return -ENODEV;
 	fb = info->fbops;
-	if (!fb)
-		return -ENODEV;
 	mutex_lock(&info->mm_lock);
 	if (fb->fb_mmap) {
 		int res;
@@ -1483,7 +1452,7 @@ __releases(&info->lock)
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
-	mutex_lock(&info->lock);
+	lock_fb_info(info);
 	if (!try_module_get(info->fbops->owner)) {
 		res = -ENODEV;
 		goto out;
@@ -1499,7 +1468,7 @@ __releases(&info->lock)
 		fb_deferred_io_open(info, inode, file);
 #endif
 out:
-	mutex_unlock(&info->lock);
+	unlock_fb_info(info);
 	if (res)
 		put_fb_info(info);
 	return res;
@@ -1512,11 +1481,11 @@ __releases(&info->lock)
 {
 	struct fb_info * const info = file->private_data;
 
-	mutex_lock(&info->lock);
+	lock_fb_info(info);
 	if (info->fbops->fb_release)
 		info->fbops->fb_release(info,1);
 	module_put(info->fbops->owner);
-	mutex_unlock(&info->lock);
+	unlock_fb_info(info);
 	put_fb_info(info);
 	return 0;
 }
@@ -1726,14 +1695,10 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 		console_lock();
 	else
 		atomic_inc(&ignore_console_lock_warning);
-	if (!lock_fb_info(fb_info)) {
-		ret = -ENODEV;
-		goto unlock_console;
-	}
-
+	lock_fb_info(fb_info);
 	ret = fbcon_fb_registered(fb_info);
 	unlock_fb_info(fb_info);
-unlock_console:
+
 	if (!lockless_register_fb)
 		console_unlock();
 	else
@@ -1751,11 +1716,7 @@ static int unbind_console(struct fb_info *fb_info)
 		return -EINVAL;
 
 	console_lock();
-	if (!lock_fb_info(fb_info)) {
-		console_unlock();
-		return -ENODEV;
-	}
-
+	lock_fb_info(fb_info);
 	event.info = fb_info;
 	ret = fb_notifier_call_chain(FB_EVENT_FB_UNBIND, &event);
 	unlock_fb_info(fb_info);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 701abaf79c87..fd60207c0685 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -656,7 +656,10 @@ extern struct class *fb_class;
 	for (i = 0; i < FB_MAX; i++)		\
 		if (!registered_fb[i]) {} else
 
-extern int lock_fb_info(struct fb_info *info);
+static inline void lock_fb_info(struct fb_info *info)
+{
+	mutex_lock(&info->lock);
+}
 
 static inline void unlock_fb_info(struct fb_info *info)
 {
-- 
2.20.1
