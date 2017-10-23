From: Hans de Goede <j.w.r.degoede@gmail.com>
Date: Mon, 23 Oct 2017 07:14:19 +0000
Subject: [PATCH v3 1/7] fbcon: Add fbcon_rotate_hint to struct fb_info
Message-Id: <20171023071425.5090-2-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171023071425.5090-1-hdegoede@redhat.com>
In-Reply-To: <20171023071425.5090-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>, Bastien Nocera <hadess@hadess.net>

On some hardware the LCD panel is not mounted upright in the casing,
but upside-down or rotated 90 degrees. In this case we want the console
to automatically be rotated to compensate.

The fbdev-driver may know about the need to rotate. Add a new
fbcon_rotate_hint field to struct fb_info, which gets initialized to -1.
If the fbdev-driver knows that some sort of rotation is necessary then
it can set this field to a FB_ROTATE_* value to tell the fbcon console
driver to rotate the console.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/fbdev/core/fbcon.c   | 18 ++++++++++++------
 drivers/video/fbdev/core/fbsysfs.c |  1 +
 include/linux/fb.h                 |  5 +++++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 04612f938bab..fb317ed76b45 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -963,10 +963,13 @@ static const char *fbcon_startup(void)
 	ops->cur_rotate = -1;
 	ops->cur_blink_jiffies = HZ / 5;
 	info->fbcon_par = ops;
-	if (initial_rotation != -1)
-		p->con_rotate = initial_rotation;
-	else
+
+	p->con_rotate = initial_rotation;
+	if (p->con_rotate = -1)
+		p->con_rotate = info->fbcon_rotate_hint;
+	if (p->con_rotate = -1)
 		p->con_rotate = fbcon_platform_get_rotate(info);
+
 	set_blitting_type(vc, info);
 
 	if (info->fix.type != FB_TYPE_TEXT) {
@@ -1103,10 +1106,13 @@ static void fbcon_init(struct vc_data *vc, int init)
 
 	ops = info->fbcon_par;
 	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
-	if (initial_rotation != -1)
-		p->con_rotate = initial_rotation;
-	else
+
+	p->con_rotate = initial_rotation;
+	if (p->con_rotate = -1)
+		p->con_rotate = info->fbcon_rotate_hint;
+	if (p->con_rotate = -1)
 		p->con_rotate = fbcon_platform_get_rotate(info);
+
 	set_blitting_type(vc, info);
 
 	cols = vc->vc_cols;
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 15755ce1d26c..e31a182b42bf 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -58,6 +58,7 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 		info->par = p + fb_info_size;
 
 	info->device = dev;
+	info->fbcon_rotate_hint = -1;
 
 #ifdef CONFIG_FB_BACKLIGHT
 	mutex_init(&info->bl_curve_mutex);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f4386b0ccf40..10cf71cc5d13 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -464,6 +464,11 @@ struct fb_info {
 	atomic_t count;
 	int node;
 	int flags;
+	/*
+	 * -1 by default, set to a FB_ROTATE_* value by the driver, if it knows
+	 * a lcd is not mounted upright and fbcon should rotate to compensate.
+	 */
+	int fbcon_rotate_hint;
 	struct mutex lock;		/* Lock for open/release/ioctl funcs */
 	struct mutex mm_lock;		/* Lock for fb_mmap and smem_* fields */
 	struct fb_var_screeninfo var;	/* Current var */
-- 
2.14.2

