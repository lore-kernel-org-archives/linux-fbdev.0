From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 20 May 2019 08:22:01 +0000
Subject: [PATCH 18/33] fbdev: make unregister/unlink functions not fail
Message-Id: <20190520082216.26273-19-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Mikulas Patocka <mpatocka@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Peter Rosin <peda@axentia.se>

Except for driver bugs (which we'll catch with a WARN_ON) this is only
to report failures of the new driver taking over the console. There's
nothing the outgoing driver can do about that, and no one ever
bothered to actually look at these return values. So remove them all.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbmem.c | 73 ++++++++++----------------------
 include/linux/fb.h               |  4 +-
 2 files changed, 25 insertions(+), 52 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 156523cc48bf..032506576aa0 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1590,13 +1590,13 @@ static bool fb_do_apertures_overlap(struct apertures_struct *gena,
 	return false;
 }
 
-static int do_unregister_framebuffer(struct fb_info *fb_info);
+static void do_unregister_framebuffer(struct fb_info *fb_info);
 
 #define VGA_FB_PHYS 0xA0000
-static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
-					      const char *name, bool primary)
+static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
+					       const char *name, bool primary)
 {
-	int i, ret;
+	int i;
 
 	/* check all firmware fbs and kick off if the base addr overlaps */
 	for_each_registered_fb(i) {
@@ -1612,13 +1612,9 @@ static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
 
 			printk(KERN_INFO "fb%d: switching to %s from %s\n",
 			       i, name, registered_fb[i]->fix.id);
-			ret = do_unregister_framebuffer(registered_fb[i]);
-			if (ret)
-				return ret;
+			do_unregister_framebuffer(registered_fb[i]);
 		}
 	}
-
-	return 0;
 }
 
 static bool lockless_register_fb;
@@ -1634,11 +1630,9 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	if (fb_check_foreignness(fb_info))
 		return -ENOSYS;
 
-	ret = do_remove_conflicting_framebuffers(fb_info->apertures,
-						 fb_info->fix.id,
-						 fb_is_primary_device(fb_info));
-	if (ret)
-		return ret;
+	do_remove_conflicting_framebuffers(fb_info->apertures,
+					   fb_info->fix.id,
+					   fb_is_primary_device(fb_info));
 
 	if (num_registered_fb = FB_MAX)
 		return -ENXIO;
@@ -1706,32 +1700,25 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	return ret;
 }
 
-static int unbind_console(struct fb_info *fb_info)
+static void unbind_console(struct fb_info *fb_info)
 {
 	int i = fb_info->node;
 
-	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
-		return -EINVAL;
+	if (WARN_ON(i < 0 || i >= FB_MAX || registered_fb[i] != fb_info))
+		return;
 
 	console_lock();
 	lock_fb_info(fb_info);
 	fbcon_fb_unbind(fb_info);
 	unlock_fb_info(fb_info);
 	console_unlock();
-
-	return 0;
 }
 
-static int __unlink_framebuffer(struct fb_info *fb_info);
+static void __unlink_framebuffer(struct fb_info *fb_info);
 
-static int do_unregister_framebuffer(struct fb_info *fb_info)
+static void do_unregister_framebuffer(struct fb_info *fb_info)
 {
-	int ret;
-
-	ret = unbind_console(fb_info);
-
-	if (ret)
-		return -EINVAL;
+	unbind_console(fb_info);
 
 	pm_vt_switch_unregister(fb_info->dev);
 
@@ -1749,36 +1736,27 @@ static int do_unregister_framebuffer(struct fb_info *fb_info)
 
 	/* this may free fb info */
 	put_fb_info(fb_info);
-	return 0;
 }
 
-static int __unlink_framebuffer(struct fb_info *fb_info)
+static void __unlink_framebuffer(struct fb_info *fb_info)
 {
 	int i;
 
 	i = fb_info->node;
-	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
-		return -EINVAL;
+	if (WARN_ON(i < 0 || i >= FB_MAX || registered_fb[i] != fb_info))
+		return;
 
 	if (fb_info->dev) {
 		device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 		fb_info->dev = NULL;
 	}
-
-	return 0;
 }
 
-int unlink_framebuffer(struct fb_info *fb_info)
+void unlink_framebuffer(struct fb_info *fb_info)
 {
-	int ret;
-
-	ret = __unlink_framebuffer(fb_info);
-	if (ret)
-		return ret;
+	__unlink_framebuffer(fb_info);
 
 	unbind_console(fb_info);
-
-	return 0;
 }
 EXPORT_SYMBOL(unlink_framebuffer);
 
@@ -1795,7 +1773,6 @@ EXPORT_SYMBOL(unlink_framebuffer);
 int remove_conflicting_framebuffers(struct apertures_struct *a,
 				    const char *name, bool primary)
 {
-	int ret;
 	bool do_free = false;
 
 	if (!a) {
@@ -1809,13 +1786,13 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
 	}
 
 	mutex_lock(&registration_lock);
-	ret = do_remove_conflicting_framebuffers(a, name, primary);
+	do_remove_conflicting_framebuffers(a, name, primary);
 	mutex_unlock(&registration_lock);
 
 	if (do_free)
 		kfree(a);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(remove_conflicting_framebuffers);
 
@@ -1891,16 +1868,12 @@ EXPORT_SYMBOL(register_framebuffer);
  *      that the driver implements fb_open() and fb_release() to
  *      check that no processes are using the device.
  */
-int
+void
 unregister_framebuffer(struct fb_info *fb_info)
 {
-	int ret;
-
 	mutex_lock(&registration_lock);
-	ret = do_unregister_framebuffer(fb_info);
+	do_unregister_framebuffer(fb_info);
 	mutex_unlock(&registration_lock);
-
-	return ret;
 }
 EXPORT_SYMBOL(unregister_framebuffer);
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 38fae1678939..44021e55b15c 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -627,8 +627,8 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
-extern int unregister_framebuffer(struct fb_info *fb_info);
-extern int unlink_framebuffer(struct fb_info *fb_info);
+extern void unregister_framebuffer(struct fb_info *fb_info);
+extern void unlink_framebuffer(struct fb_info *fb_info);
 extern int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id,
 					       const char *name);
 extern int remove_conflicting_framebuffers(struct apertures_struct *a,
-- 
2.20.1
