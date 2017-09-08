From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 08 Sep 2017 11:54:42 +0000
Subject: [PATCH 1/3] video: fb: Make fbcon dmi quirks usuable for drm drivers too
Message-Id: <20170908115444.19122-2-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170908115444.19122-1-hdegoede@redhat.com>
In-Reply-To: <20170908115444.19122-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>

Some x86 clamshell design devices use portrait tablet LCD panels and a
display engine which cannot (transparently) rotate in hardware, so we
need to rotate things in software / let user space deal with this.

The fbcon code has a set of DMI based quirks to automatically detect
such tablet LCD panels and rotate the fbcon to compensate.

The plan was for userspace (e.g. a Wayland compositor) to simply read
/sys/class/graphics/fbcon/rotate and apply the rotation from there to
the LCD panel to compensate.

However this will not work when an external monitor gets plugged in,
since with fbcon rotation is not per output, so the fbcon quirk code
disables the rotation when an external monitor is present.

Using /sys/class/graphics/fbcon/rotate will not help in that case
since it will indicate no rotation is in use. So instead we are going
to need a drm connecter property for this.

This commit is a preparation patch for adding the drm-connecter
property, by making the fbcon quirk code generally usable so that
the drm code can use it to check for rotation quirks.

Note this commit re-uses the FB_CMDLINE Kconfig option for selecting
if the quirk code should be build, since that is already selected by
both the drm and fbcon code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/console/Makefile                     |  3 ---
 drivers/video/console/fbcon.c                      | 22 ++++++++++++++--------
 drivers/video/console/fbcon.h                      |  6 ------
 drivers/video/fbdev/core/Makefile                  |  3 +++
 .../core/fb_dmi_quirks.c}                          | 15 +++++++++------
 include/linux/fb.h                                 |  6 ++++++
 6 files changed, 32 insertions(+), 23 deletions(-)
 rename drivers/video/{console/fbcon_dmi_quirks.c => fbdev/core/fb_dmi_quirks.c} (91%)

diff --git a/drivers/video/console/Makefile b/drivers/video/console/Makefile
index 32ee2ad37369..43bfa485db96 100644
--- a/drivers/video/console/Makefile
+++ b/drivers/video/console/Makefile
@@ -15,8 +15,5 @@ ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION),y)
 obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
                                          fbcon_ccw.o
 endif
-ifeq ($(CONFIG_DMI),y)
-obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += fbcon_dmi_quirks.o
-endif
 
 obj-$(CONFIG_FB_STI)              += sticore.o
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 3db5ac2bfbb7..f33f5a61405c 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -954,10 +954,13 @@ static const char *fbcon_startup(void)
 	ops->cur_rotate = -1;
 	ops->cur_blink_jiffies = HZ / 5;
 	info->fbcon_par = ops;
-	if (initial_rotation != -1)
-		p->con_rotate = initial_rotation;
-	else
-		p->con_rotate = fbcon_platform_get_rotate(info);
+	p->con_rotate = initial_rotation;
+	if (p->con_rotate = -1)
+		p->con_rotate = fb_get_panel_rotate_quirk(info->var.xres,
+							  info->var.yres);
+	if (p->con_rotate = -1)
+		p->con_rotate = FB_ROTATE_UR;
+
 	set_blitting_type(vc, info);
 
 	if (info->fix.type != FB_TYPE_TEXT) {
@@ -1094,10 +1097,13 @@ static void fbcon_init(struct vc_data *vc, int init)
 
 	ops = info->fbcon_par;
 	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
-	if (initial_rotation != -1)
-		p->con_rotate = initial_rotation;
-	else
-		p->con_rotate = fbcon_platform_get_rotate(info);
+	p->con_rotate = initial_rotation;
+	if (p->con_rotate = -1)
+		p->con_rotate = fb_get_panel_rotate_quirk(info->var.xres,
+							  info->var.yres);
+	if (p->con_rotate = -1)
+		p->con_rotate = FB_ROTATE_UR;
+
 	set_blitting_type(vc, info);
 
 	cols = vc->vc_cols;
diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
index 60e25e173fdb..73add376790c 100644
--- a/drivers/video/console/fbcon.h
+++ b/drivers/video/console/fbcon.h
@@ -261,10 +261,4 @@ extern void fbcon_set_rotate(struct fbcon_ops *ops);
 #define fbcon_set_rotate(x) do {} while(0)
 #endif /* CONFIG_FRAMEBUFFER_CONSOLE_ROTATION */
 
-#ifdef CONFIG_DMI
-int fbcon_platform_get_rotate(struct fb_info *info);
-#else
-#define fbcon_platform_get_rotate(i) FB_ROTATE_UR
-#endif /* CONFIG_DMI */
-
 #endif /* _VIDEO_FBCON_H */
diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
index 9e3ddf225393..b9162a2b6e88 100644
--- a/drivers/video/fbdev/core/Makefile
+++ b/drivers/video/fbdev/core/Makefile
@@ -1,4 +1,7 @@
 obj-$(CONFIG_FB_CMDLINE)          += fb_cmdline.o
+ifeq ($(CONFIG_DMI),y)
+obj-$(CONFIG_FB_CMDLINE)          += fb_dmi_quirks.o
+endif
 obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
 obj-$(CONFIG_FB)                  += fb.o
 fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o \
diff --git a/drivers/video/console/fbcon_dmi_quirks.c b/drivers/video/fbdev/core/fb_dmi_quirks.c
similarity index 91%
rename from drivers/video/console/fbcon_dmi_quirks.c
rename to drivers/video/fbdev/core/fb_dmi_quirks.c
index 6904e47d1e51..d5fdf3245f83 100644
--- a/drivers/video/console/fbcon_dmi_quirks.c
+++ b/drivers/video/fbdev/core/fb_dmi_quirks.c
@@ -1,5 +1,5 @@
 /*
- *  fbcon_dmi_quirks.c -- DMI based quirk detection for fbcon
+ *  fb_dmi_quirks.c -- DMI based LCD panel rotation quirk detection
  *
  *	Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
  *
@@ -11,7 +11,6 @@
 #include <linux/dmi.h>
 #include <linux/fb.h>
 #include <linux/kernel.h>
-#include "fbcon.h"
 
 /*
  * Some x86 clamshell design devices use portrait tablet screens and a display
@@ -112,7 +111,11 @@ static const struct dmi_system_id rotate_data[] = {
 	{}
 };
 
-int fbcon_platform_get_rotate(struct fb_info *info)
+/*
+ * Note this function returns the rotation necessary to put the display
+ * the right way up, or -1 if there is no quirk.
+ */
+int fb_get_panel_rotate_quirk(int width, int height)
 {
 	const struct dmi_system_id *match;
 	const struct fbcon_dmi_rotate_data *data;
@@ -124,8 +127,7 @@ int fbcon_platform_get_rotate(struct fb_info *info)
 	     match = dmi_first_match(match + 1)) {
 		data = match->driver_data;
 
-		if (data->width != info->var.xres ||
-		    data->height != info->var.yres)
+		if (data->width != width || data->height != height)
 			continue;
 
 		if (!data->bios_dates)
@@ -141,5 +143,6 @@ int fbcon_platform_get_rotate(struct fb_info *info)
 		}
 	}
 
-	return FB_ROTATE_UR;
+	return -1;
 }
+EXPORT_SYMBOL_GPL(fb_get_panel_rotate_quirk);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index a964d076b4dc..197e07681427 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -822,6 +822,12 @@ extern int fb_find_mode(struct fb_var_screeninfo *var,
 			const struct fb_videomode *default_mode,
 			unsigned int default_bpp);
 
+#ifdef CONFIG_DMI
+int fb_get_panel_rotate_quirk(int width, int height);
+#else
+#define fb_get_panel_rotate_quirk(width, height) (-1)
+#endif /* CONFIG_DMI */
+
 /* Convenience logging macros */
 #define fb_err(fb_info, fmt, ...)					\
 	pr_err("fb%d: " fmt, (fb_info)->node, ##__VA_ARGS__)
-- 
2.13.4

