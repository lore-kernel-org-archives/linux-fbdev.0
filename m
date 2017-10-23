From: Hans de Goede <j.w.r.degoede@gmail.com>
Date: Mon, 23 Oct 2017 07:14:25 +0000
Subject: [PATCH v3 7/7] fbcon: Remove dmi quirk table
Message-Id: <20171023071425.5090-8-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171023071425.5090-1-hdegoede@redhat.com>
In-Reply-To: <20171023071425.5090-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>, Bastien Nocera <hadess@hadess.net>

This is now all handled in the drivers and communicated through
fb_info.fbcon_rotate_hint.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/fbdev/core/Makefile           |   3 -
 drivers/video/fbdev/core/fbcon.c            |   4 +-
 drivers/video/fbdev/core/fbcon.h            |   6 --
 drivers/video/fbdev/core/fbcon_dmi_quirks.c | 145 ----------------------------
 4 files changed, 2 insertions(+), 156 deletions(-)
 delete mode 100644 drivers/video/fbdev/core/fbcon_dmi_quirks.c

diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
index 73493bbd7a15..0214b863ac3f 100644
--- a/drivers/video/fbdev/core/Makefile
+++ b/drivers/video/fbdev/core/Makefile
@@ -14,9 +14,6 @@ ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION),y)
 fb-y				  += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
 				     fbcon_ccw.o
 endif
-ifeq ($(CONFIG_DMI),y)
-fb-y				  += fbcon_dmi_quirks.o
-endif
 endif
 fb-objs                           := $(fb-y)
 
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index fb317ed76b45..157a40670a47 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -968,7 +968,7 @@ static const char *fbcon_startup(void)
 	if (p->con_rotate = -1)
 		p->con_rotate = info->fbcon_rotate_hint;
 	if (p->con_rotate = -1)
-		p->con_rotate = fbcon_platform_get_rotate(info);
+		p->con_rotate = FB_ROTATE_UR;
 
 	set_blitting_type(vc, info);
 
@@ -1111,7 +1111,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 	if (p->con_rotate = -1)
 		p->con_rotate = info->fbcon_rotate_hint;
 	if (p->con_rotate = -1)
-		p->con_rotate = fbcon_platform_get_rotate(info);
+		p->con_rotate = FB_ROTATE_UR;
 
 	set_blitting_type(vc, info);
 
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 18f3ac144237..3746828356ed 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
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
diff --git a/drivers/video/fbdev/core/fbcon_dmi_quirks.c b/drivers/video/fbdev/core/fbcon_dmi_quirks.c
deleted file mode 100644
index 6904e47d1e51..000000000000
--- a/drivers/video/fbdev/core/fbcon_dmi_quirks.c
+++ /dev/null
@@ -1,145 +0,0 @@
-/*
- *  fbcon_dmi_quirks.c -- DMI based quirk detection for fbcon
- *
- *	Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file COPYING in the main directory of this archive for
- *  more details.
- */
-
-#include <linux/dmi.h>
-#include <linux/fb.h>
-#include <linux/kernel.h>
-#include "fbcon.h"
-
-/*
- * Some x86 clamshell design devices use portrait tablet screens and a display
- * engine which cannot rotate in hardware, so we need to rotate the fbcon to
- * compensate. Unfortunately these (cheap) devices also typically have quite
- * generic DMI data, so we match on a combination of DMI data, screen resolution
- * and a list of known BIOS dates to avoid false positives.
- */
-
-struct fbcon_dmi_rotate_data {
-	int width;
-	int height;
-	const char * const *bios_dates;
-	int rotate;
-};
-
-static const struct fbcon_dmi_rotate_data rotate_data_asus_t100ha = {
-	.width = 800,
-	.height = 1280,
-	.rotate = FB_ROTATE_CCW,
-};
-
-static const struct fbcon_dmi_rotate_data rotate_data_gpd_pocket = {
-	.width = 1200,
-	.height = 1920,
-	.bios_dates = (const char * const []){ "05/26/2017", "06/28/2017",
-		"07/05/2017", "08/07/2017", NULL },
-	.rotate = FB_ROTATE_CW,
-};
-
-static const struct fbcon_dmi_rotate_data rotate_data_gpd_win = {
-	.width = 720,
-	.height = 1280,
-	.bios_dates = (const char * const []){
-		"10/25/2016", "11/18/2016", "12/23/2016", "12/26/2016",
-		"02/21/2017", "03/20/2017", "05/25/2017", NULL },
-	.rotate = FB_ROTATE_CW,
-};
-
-static const struct fbcon_dmi_rotate_data rotate_data_itworks_tw891 = {
-	.width = 800,
-	.height = 1280,
-	.bios_dates = (const char * const []){ "10/16/2015", NULL },
-	.rotate = FB_ROTATE_CW,
-};
-
-static const struct fbcon_dmi_rotate_data rotate_data_vios_lth17 = {
-	.width = 800,
-	.height = 1280,
-	.rotate = FB_ROTATE_CW,
-};
-
-static const struct dmi_system_id rotate_data[] = {
-	{	/* Asus T100HA */
-		.matches = {
-		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100HAN"),
-		},
-		.driver_data = (void *)&rotate_data_asus_t100ha,
-	}, {	/*
-		 * GPD Pocket, note that the the DMI data is less generic then
-		 * it seems, devices with a board-vendor of "AMI Corporation"
-		 * are quite rare, as are devices which have both board- *and*
-		 * product-id set to "Default String"
-		 */
-		.matches = {
-		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
-		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
-		  DMI_EXACT_MATCH(DMI_BOARD_SERIAL, "Default string"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
-		},
-		.driver_data = (void *)&rotate_data_gpd_pocket,
-	}, {	/* GPD Win (same note on DMI match as GPD Pocket) */
-		.matches = {
-		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
-		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
-		  DMI_EXACT_MATCH(DMI_BOARD_SERIAL, "Default string"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
-		},
-		.driver_data = (void *)&rotate_data_gpd_win,
-	}, {	/* I.T.Works TW891 */
-		.matches = {
-		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "TW891"),
-		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
-		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "TW891"),
-		},
-		.driver_data = (void *)&rotate_data_itworks_tw891,
-	}, {	/* VIOS LTH17 */
-		.matches = {
-		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "VIOS"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "LTH17"),
-		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "VIOS"),
-		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "LTH17"),
-		},
-		.driver_data = (void *)&rotate_data_vios_lth17,
-	},
-	{}
-};
-
-int fbcon_platform_get_rotate(struct fb_info *info)
-{
-	const struct dmi_system_id *match;
-	const struct fbcon_dmi_rotate_data *data;
-	const char *bios_date;
-	int i;
-
-	for (match = dmi_first_match(rotate_data);
-	     match;
-	     match = dmi_first_match(match + 1)) {
-		data = match->driver_data;
-
-		if (data->width != info->var.xres ||
-		    data->height != info->var.yres)
-			continue;
-
-		if (!data->bios_dates)
-			return data->rotate;
-
-		bios_date = dmi_get_system_info(DMI_BIOS_DATE);
-		if (!bios_date)
-			continue;
-
-		for (i = 0; data->bios_dates[i]; i++) {
-			if (!strcmp(data->bios_dates[i], bios_date))
-				return data->rotate;
-		}
-	}
-
-	return FB_ROTATE_UR;
-}
-- 
2.14.2

