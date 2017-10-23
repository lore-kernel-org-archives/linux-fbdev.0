From: Hans de Goede <j.w.r.degoede@gmail.com>
Date: Mon, 23 Oct 2017 09:25:01 +0000
Subject: [PATCH v4 6/7] efifb: Set info->fbcon_rotate_hint based on drm_get_panel_orientation_quirk
Message-Id: <20171023092502.1095-7-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171023092502.1095-1-hdegoede@redhat.com>
In-Reply-To: <20171023092502.1095-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>, Bastien Nocera <hadess@hadess.net>

On some hardware the LCD panel is not mounted upright in the casing,
but rotated by 90 degrees. In this case we want the console to
automatically be rotated to compensate.

The drm subsys has a quirk table for this, use the
drm_get_panel_orientation_quirk function to get the panel orientation
and set info->fbcon_rotate_hint based on this, so that the fbcon console
on top of efifb gets automatically=C2=A0rotated to compensate for the panel
orientation.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/fbdev/Kconfig |  1 +
 drivers/video/fbdev/efifb.c | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 5e58f5ec0a28..c4a90c497839 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -772,6 +772,7 @@ config FB_VESA
 config FB_EFI
 	bool "EFI-based Framebuffer Support"
 	depends on (FB =3D y) && !IA64 && EFI
+	select DRM_PANEL_ORIENTATION_QUIRKS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 3a010641f630..8c7f6aeee205 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -15,6 +15,8 @@
 #include <linux/screen_info.h>
 #include <video/vga.h>
 #include <asm/efi.h>
+#include <drm/drm_utils.h> /* For drm_get_panel_orientation_quirk */
+#include <drm/drm_mode.h>  /* For DRM_MODE_PANEL_ORIENTATION_* */
=20
 static bool request_mem_succeeded =3D false;
 static bool nowc =3D false;
@@ -156,7 +158,7 @@ static u64 bar_offset;
 static int efifb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
-	int err;
+	int err, orientation;
 	unsigned int size_vmode;
 	unsigned int size_remap;
 	unsigned int size_total;
@@ -328,6 +330,23 @@ static int efifb_probe(struct platform_device *dev)
 	info->fix =3D efifb_fix;
 	info->flags =3D FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE;
=20
+	orientation =3D drm_get_panel_orientation_quirk(efifb_defined.xres,
+						      efifb_defined.yres);
+	switch (orientation) {
+	default:
+		info->fbcon_rotate_hint =3D FB_ROTATE_UR;
+		break;
+	case DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP:
+		info->fbcon_rotate_hint =3D FB_ROTATE_UD;
+		break;
+	case DRM_MODE_PANEL_ORIENTATION_LEFT_UP:
+		info->fbcon_rotate_hint =3D FB_ROTATE_CCW;
+		break;
+	case DRM_MODE_PANEL_ORIENTATION_RIGHT_UP:
+		info->fbcon_rotate_hint =3D FB_ROTATE_CW;
+		break;
+	}
+
 	err =3D sysfs_create_groups(&dev->dev.kobj, efifb_groups);
 	if (err) {
 		pr_err("efifb: cannot add sysfs attrs\n");
--=20
2.14.2

