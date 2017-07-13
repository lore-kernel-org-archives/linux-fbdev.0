From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Jul 2017 21:32:23 +0000
Subject: [PATCH v3 2/2] video/console: Add dmi quirk table for x86 systems which need fbcon rotation
Message-Id: <20170713213223.28503-2-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Some x86 clamshell design devices use portrait tablet screens and a
display engine which cannot rotate in hardware, so we need to rotate
the fbcon to compensate.

This commit adds a DMI based quirk table which is initially populated with
3 such devices: The GPD Win, the GPD Pocket and the I.T.Works TW891, so
that the console comes up in the right orientation on this devices OOTB.

Unfortunately these (cheap) devices also typically have quite generic DMI
data, so we match on a combination of DMI data, screen resolution and a
list of known BIOS dates to avoid false positives.

Since we are now not just checking dmi-strings but also other variables
we cannot use dmi_check_system. So this commit exports dmi_matches and
we use our own loop over the table entries using dmi_matches to match
the dmi strings.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Extend the commit message explaining why dmi_check_system does not work
 and this commit exports and uses dmi_matches instead

Changes in v3:
-The exporting of dmi_matches has been split out in a separate patch
-Use u32 for width/height in struct fbcon_dmi_rotate_data to match the
 type of fb_var_screeninfo.xres / .yres
---
 drivers/video/console/Makefile           |   3 +
 drivers/video/console/fbcon.c            |  12 +++-
 drivers/video/console/fbcon.h            |   7 ++-
 drivers/video/console/fbcon_dmi_quirks.c | 103 +++++++++++++++++++++++++++++++
 4 files changed, 121 insertions(+), 4 deletions(-)
 create mode 100644 drivers/video/console/fbcon_dmi_quirks.c

diff --git a/drivers/video/console/Makefile b/drivers/video/console/Makefile
index 43bfa485db96..32ee2ad37369 100644
--- a/drivers/video/console/Makefile
+++ b/drivers/video/console/Makefile
@@ -15,5 +15,8 @@ ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION),y)
 obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
                                          fbcon_ccw.o
 endif
+ifeq ($(CONFIG_DMI),y)
+obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += fbcon_dmi_quirks.o
+endif
 
 obj-$(CONFIG_FB_STI)              += sticore.o
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 12ded23f1aaf..3db5ac2bfbb7 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -135,7 +135,7 @@ static char fontname[40];
 static int info_idx = -1;
 
 /* console rotation */
-static int initial_rotation;
+static int initial_rotation = -1;
 static int fbcon_has_sysfs;
 
 static const struct consw fb_con;
@@ -954,7 +954,10 @@ static const char *fbcon_startup(void)
 	ops->cur_rotate = -1;
 	ops->cur_blink_jiffies = HZ / 5;
 	info->fbcon_par = ops;
-	p->con_rotate = initial_rotation;
+	if (initial_rotation != -1)
+		p->con_rotate = initial_rotation;
+	else
+		p->con_rotate = fbcon_platform_get_rotate(info);
 	set_blitting_type(vc, info);
 
 	if (info->fix.type != FB_TYPE_TEXT) {
@@ -1091,7 +1094,10 @@ static void fbcon_init(struct vc_data *vc, int init)
 
 	ops = info->fbcon_par;
 	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
-	p->con_rotate = initial_rotation;
+	if (initial_rotation != -1)
+		p->con_rotate = initial_rotation;
+	else
+		p->con_rotate = fbcon_platform_get_rotate(info);
 	set_blitting_type(vc, info);
 
 	cols = vc->vc_cols;
diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
index 7aaa4eabbba0..60e25e173fdb 100644
--- a/drivers/video/console/fbcon.h
+++ b/drivers/video/console/fbcon.h
@@ -261,5 +261,10 @@ extern void fbcon_set_rotate(struct fbcon_ops *ops);
 #define fbcon_set_rotate(x) do {} while(0)
 #endif /* CONFIG_FRAMEBUFFER_CONSOLE_ROTATION */
 
-#endif /* _VIDEO_FBCON_H */
+#ifdef CONFIG_DMI
+int fbcon_platform_get_rotate(struct fb_info *info);
+#else
+#define fbcon_platform_get_rotate(i) FB_ROTATE_UR
+#endif /* CONFIG_DMI */
 
+#endif /* _VIDEO_FBCON_H */
diff --git a/drivers/video/console/fbcon_dmi_quirks.c b/drivers/video/console/fbcon_dmi_quirks.c
new file mode 100644
index 000000000000..02feec1c28e0
--- /dev/null
+++ b/drivers/video/console/fbcon_dmi_quirks.c
@@ -0,0 +1,103 @@
+/*
+ *  fbcon_dmi_quirks.c -- DMI based quirk detection for fbcon
+ *
+ *	Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/dmi.h>
+#include <linux/fb.h>
+#include <linux/kernel.h>
+#include "fbcon.h"
+
+/*
+ * Some x86 clamshell design devices use portrait tablet screens and a display
+ * engine which cannot rotate in hardware, so we need to rotate the fbcon to
+ * compensate. Unfortunately these (cheap) devices also typically have quite
+ * generic DMI data, so we match on a combination of DMI data, screen resolution
+ * and a list of known BIOS dates to avoid false positives.
+ */
+
+struct fbcon_dmi_rotate_data {
+	struct dmi_system_id dmi_id;
+	u32 width;
+	u32 height;
+	const char * const *bios_dates;
+	int rotate;
+};
+
+static const struct fbcon_dmi_rotate_data rotate_data[] = {
+	{	/*
+		 * GPD Win, note that the the DMI data is less generic then it
+		 * seems, devices with a board_vendor of "AMI Corporation" are
+		 * quite rare, as are devices which have both board- *and*
+		 * product-id set to "Default String"
+		 */
+		.dmi_id = { .matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		} },
+		.width = 720,
+		.height = 1280,
+		.bios_dates = (const char * const []){
+			"10/25/2016", "11/18/2016", "02/21/2017",
+			"03/20/2017", NULL },
+		.rotate = FB_ROTATE_CW
+	}, {	/* GPD Pocket (same note on DMI match as GPD Win) */
+		.dmi_id = { .matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		} },
+		.width = 1200,
+		.height = 1920,
+		.bios_dates = (const char * const []){ "05/26/2017", NULL },
+		.rotate = FB_ROTATE_CW,
+	}, {	/* I.T.Works TW891 */
+		.dmi_id = { .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TW891"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_BOARD_NAME, "TW891"),
+		} },
+		.width = 800,
+		.height = 1280,
+		.bios_dates = (const char * const []){ "10/16/2015", NULL },
+		.rotate = FB_ROTATE_CW,
+	}
+};
+
+int fbcon_platform_get_rotate(struct fb_info *info)
+{
+	const char *bios_date;
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(rotate_data); i++) {
+		if (!dmi_system_id_match(&rotate_data[i].dmi_id))
+			continue;
+
+		if (rotate_data[i].width != info->var.xres ||
+		    rotate_data[i].height != info->var.yres)
+			continue;
+
+		if (!rotate_data[i].bios_dates)
+			return rotate_data->rotate;
+
+		bios_date = dmi_get_system_info(DMI_BIOS_DATE);
+		if (!bios_date)
+			continue;
+
+		for (j = 0; rotate_data[i].bios_dates[j]; j++) {
+			if (!strcmp(rotate_data[i].bios_dates[j], bios_date))
+				return rotate_data->rotate;
+		}
+	}
+
+	return FB_ROTATE_UR;
+}
-- 
2.13.0

