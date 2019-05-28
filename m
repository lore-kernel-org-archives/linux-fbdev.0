From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:58 +0000
Subject: [PATCH 27/33] fb: Flatten control flow in fb_set_var
Message-Id: <20190528090304.9388-28-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Peter Rosin <peda@axentia.se>, Hans de Goede <hdegoede@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>

Instead of wiring almost everything down to the very last line using
goto soup (but not consistently, where would the fun be otherwise)
drop out early when checks fail. This allows us to flatten the huge
indent levels to just 1.

Aside: If a driver doesn't set ->fb_check_var, then FB_ACTIVATE_NOW
does nothing. This bug exists ever since this code was extracted as a
common helper in 2002, hence I decided against fixing it. Everyone
just better have a fb_check_var to make sure things work correctly.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/video/fbdev/core/fbmem.c | 126 +++++++++++++++----------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 25ae466ba593..96805fe85332 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -954,6 +954,9 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 {
 	int flags = info->flags;
 	int ret = 0;
+	u32 activate;
+	struct fb_var_screeninfo old_var;
+	struct fb_videomode mode;
 
 	if (var->activate & FB_ACTIVATE_INV_MODE) {
 		struct fb_videomode mode1, mode2;
@@ -970,87 +973,84 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 			fb_delete_videomode(&mode1, &info->modelist);
 
 
-		ret = (ret) ? -EINVAL : 0;
-		goto done;
+		return ret ? -EINVAL : 0;
 	}
 
-	if ((var->activate & FB_ACTIVATE_FORCE) ||
-	    memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
-		u32 activate = var->activate;
+	if (!(var->activate & FB_ACTIVATE_FORCE) &&
+	    !memcmp(&info->var, var, sizeof(struct fb_var_screeninfo)))
+		return 0;
 
-		/* When using FOURCC mode, make sure the red, green, blue and
-		 * transp fields are set to 0.
-		 */
-		if ((info->fix.capabilities & FB_CAP_FOURCC) &&
-		    var->grayscale > 1) {
-			if (var->red.offset     || var->green.offset    ||
-			    var->blue.offset    || var->transp.offset   ||
-			    var->red.length     || var->green.length    ||
-			    var->blue.length    || var->transp.length   ||
-			    var->red.msb_right  || var->green.msb_right ||
-			    var->blue.msb_right || var->transp.msb_right)
-				return -EINVAL;
-		}
+	activate = var->activate;
 
-		if (!info->fbops->fb_check_var) {
-			*var = info->var;
-			goto done;
-		}
+	/* When using FOURCC mode, make sure the red, green, blue and
+	 * transp fields are set to 0.
+	 */
+	if ((info->fix.capabilities & FB_CAP_FOURCC) &&
+	    var->grayscale > 1) {
+		if (var->red.offset     || var->green.offset    ||
+		    var->blue.offset    || var->transp.offset   ||
+		    var->red.length     || var->green.length    ||
+		    var->blue.length    || var->transp.length   ||
+		    var->red.msb_right  || var->green.msb_right ||
+		    var->blue.msb_right || var->transp.msb_right)
+			return -EINVAL;
+	}
 
-		ret = info->fbops->fb_check_var(var, info);
+	if (!info->fbops->fb_check_var) {
+		*var = info->var;
+		return 0;
+	}
 
-		if (ret)
-			goto done;
+	ret = info->fbops->fb_check_var(var, info);
 
-		if ((var->activate & FB_ACTIVATE_MASK) = FB_ACTIVATE_NOW) {
-			struct fb_var_screeninfo old_var;
-			struct fb_videomode mode;
+	if (ret)
+		return ret;
 
-			if (info->fbops->fb_get_caps) {
-				ret = fb_check_caps(info, var, activate);
+	if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
+		return 0;
 
-				if (ret)
-					goto done;
-			}
+	if (info->fbops->fb_get_caps) {
+		ret = fb_check_caps(info, var, activate);
 
-			old_var = info->var;
-			info->var = *var;
+		if (ret)
+			return ret;
+	}
 
-			if (info->fbops->fb_set_par) {
-				ret = info->fbops->fb_set_par(info);
+	old_var = info->var;
+	info->var = *var;
 
-				if (ret) {
-					info->var = old_var;
-					printk(KERN_WARNING "detected "
-						"fb_set_par error, "
-						"error code: %d\n", ret);
-					goto done;
-				}
-			}
+	if (info->fbops->fb_set_par) {
+		ret = info->fbops->fb_set_par(info);
+
+		if (ret) {
+			info->var = old_var;
+			printk(KERN_WARNING "detected "
+				"fb_set_par error, "
+				"error code: %d\n", ret);
+			return ret;
+		}
+	}
 
-			fb_pan_display(info, &info->var);
-			fb_set_cmap(&info->cmap, info);
-			fb_var_to_videomode(&mode, &info->var);
+	fb_pan_display(info, &info->var);
+	fb_set_cmap(&info->cmap, info);
+	fb_var_to_videomode(&mode, &info->var);
 
-			if (info->modelist.prev && info->modelist.next &&
-			    !list_empty(&info->modelist))
-				ret = fb_add_videomode(&mode, &info->modelist);
+	if (info->modelist.prev && info->modelist.next &&
+	    !list_empty(&info->modelist))
+		ret = fb_add_videomode(&mode, &info->modelist);
 
-			if (!ret && (flags & FBINFO_MISC_USEREVENT)) {
-				struct fb_event event;
-				int evnt = (activate & FB_ACTIVATE_ALL) ?
-					FB_EVENT_MODE_CHANGE_ALL :
-					FB_EVENT_MODE_CHANGE;
+	if (!ret && (flags & FBINFO_MISC_USEREVENT)) {
+		struct fb_event event;
+		int evnt = (activate & FB_ACTIVATE_ALL) ?
+			FB_EVENT_MODE_CHANGE_ALL :
+			FB_EVENT_MODE_CHANGE;
 
-				info->flags &= ~FBINFO_MISC_USEREVENT;
-				event.info = info;
-				event.data = &mode;
-				fb_notifier_call_chain(evnt, &event);
-			}
-		}
+		info->flags &= ~FBINFO_MISC_USEREVENT;
+		event.info = info;
+		event.data = &mode;
+		fb_notifier_call_chain(evnt, &event);
 	}
 
- done:
 	return ret;
 }
 EXPORT_SYMBOL(fb_set_var);
-- 
2.20.1
