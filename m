From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 22 Aug 2018 08:54:02 +0000
Subject: [PATCH 1/4] fbdev: Drop FBINFO_CAN_FORCE_OUTPUT flag
Message-Id: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Kapshuk <alexander.kapshuk@gmail.com>, Kees Cook <keescook@chromium.org>, Thierry Reding <treding@nvidia.com>, David Lechner <david@lechnology.com>, nouveau@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>

This was only added for the drm's fbdev emulation support, so that it
would try harder to show the Oops.

Unfortunately this never really worked reliably, and in practice ended
up pushing the real Oops off the screen due to plentyfull locking,
sleep-while-atomic and other issues. So we removed all that support
from the fbdev emulation a while back. Aside: We've also removed the
kgdb support, for similar reasons.

Since it's such a small patch I figured I don't split this up into the
usual 3-phase removal.

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: David Lechner <david@lechnology.com>
Cc: nouveau@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c | 1 -
 drivers/staging/vboxvideo/vbox_fb.c     | 3 +--
 drivers/video/fbdev/core/fbcon.c        | 1 -
 include/linux/fb.h                      | 4 ----
 4 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 844498c4267c..20a260887be3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -379,7 +379,6 @@ nouveau_fbcon_create(struct drm_fb_helper *helper,
 		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_COPYAREA |
 			      FBINFO_HWACCEL_FILLRECT |
 			      FBINFO_HWACCEL_IMAGEBLIT;
-	info->flags |= FBINFO_CAN_FORCE_OUTPUT;
 	info->fbops = &nouveau_fbcon_sw_ops;
 	info->fix.smem_start = fb->nvbo->bo.mem.bus.base +
 			       fb->nvbo->bo.mem.bus.offset;
diff --git a/drivers/staging/vboxvideo/vbox_fb.c b/drivers/staging/vboxvideo/vbox_fb.c
index 43c39eca4ae1..034f8ffa8f20 100644
--- a/drivers/staging/vboxvideo/vbox_fb.c
+++ b/drivers/staging/vboxvideo/vbox_fb.c
@@ -155,8 +155,7 @@ static int vboxfb_create(struct drm_fb_helper *helper,
 	 * The last flag forces a mode set on VT switches even if the kernel
 	 * does not think it is needed.
 	 */
-	info->flags = FBINFO_DEFAULT | FBINFO_CAN_FORCE_OUTPUT |
-		      FBINFO_MISC_ALWAYS_SETPAR;
+	info->flags = FBINFO_DEFAULT | FBINFO_MISC_ALWAYS_SETPAR;
 	info->fbops = &vboxfb_ops;
 
 	/*
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 5fb156bdcf4e..2b5bb52b1798 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1104,7 +1104,6 @@ static void fbcon_init(struct vc_data *vc, int init)
 	if (p->userfont)
 		charcnt = FNTCHARCNT(p->fontdata);
 
-	vc->vc_panic_force_write = !!(info->flags & FBINFO_CAN_FORCE_OUTPUT);
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (charcnt = 256) {
diff --git a/include/linux/fb.h b/include/linux/fb.h
index aa74a228bb92..fa8c6f9c9c3a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -457,10 +457,6 @@ struct fb_tile_ops {
  */
 #define FBINFO_BE_MATH  0x100000
 
-/* report to the VT layer that this fb driver can accept forced console
-   output like oopses */
-#define FBINFO_CAN_FORCE_OUTPUT     0x200000
-
 struct fb_info {
 	atomic_t count;
 	int node;
-- 
2.18.0
