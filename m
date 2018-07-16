From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 16 Jul 2018 13:45:43 +0000
Subject: [PATCH] efifb: BGRT: Do not copy the boot graphics for non native resolutions
Message-Id: <20180716134543.26091-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On x86 some firmwares use a low non native resolution for the display when
they have shown some text messages. While keeping the bgrt filled with info
for the native resolution. If the bgrt image intended for the native
resolution still fits, it will be displayed very close to the right edge of
the display looking quite bad.

This commits adds a (heuristics based) checks for this and makes efifb
not show the boot graphics when this is the case.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/fbdev/efifb.c | 43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index fa01eecc0a55..52bf39f93888 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -111,6 +111,46 @@ static void efifb_copy_bmp(u8 *src, u32 *dst, int width, struct screen_info *si)
 	}
 }
 
+#ifdef CONFIG_X86
+/*
+ * On x86 some firmwares use a low non native resolution for the display when
+ * they have shown some text messages. While keeping the bgrt filled with info
+ * for the native resolution. If the bgrt image intended for the native
+ * resolution still fits, it will be displayed very close to the right edge of
+ * the display looking quite bad. This function checks for this.
+ */
+static bool efifb_bgrt_sanity_check(struct screen_info *si, u32 bmp_width)
+{
+	static const int default_resolutions[][2] = {
+		{  800,  600 },
+		{ 1024,  768 },
+		{ 1280, 1024 },
+	};
+	u32 i, right_margin;
+
+	for (i = 0; i < ARRAY_SIZE(default_resolutions); i++) {
+		if (default_resolutions[i][0] = si->lfb_width &&
+		    default_resolutions[i][1] = si->lfb_height)
+			break;
+	}
+	/* If not a default resolution used for textmode, this should be fine */
+	if (i >= ARRAY_SIZE(default_resolutions))
+		return true;
+
+	/* If the right margin is 5 times smaller then the left one, reject */
+	right_margin = si->lfb_width - (bgrt_tab.image_offset_x + bmp_width);
+	if (right_margin < (bgrt_tab.image_offset_x / 5))
+		return false;
+
+	return true;
+}
+#else
+static bool efifb_bgrt_sanity_check(struct screen_info *si, u32 bmp_width)
+{
+	return true;
+}
+#endif
+
 static void efifb_show_boot_graphics(struct fb_info *info)
 {
 	u32 bmp_width, bmp_height, bmp_pitch, screen_pitch, dst_x, y, src_y;
@@ -169,6 +209,9 @@ static void efifb_show_boot_graphics(struct fb_info *info)
 	    (bgrt_tab.image_offset_y + bmp_height) > si->lfb_height)
 		goto error;
 
+	if (!efifb_bgrt_sanity_check(si, bmp_width))
+		goto error;
+
 	pr_info("efifb: showing boot graphics\n");
 
 	for (y = 0; y < si->lfb_height; y++, dst += si->lfb_linelength) {
-- 
2.17.1

