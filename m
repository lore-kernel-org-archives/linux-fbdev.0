From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 04 Sep 2017 14:26:01 +0000
Subject: [PATCH] video/console: Add rotated LCD-panel DMI quirk for the VIOS LTH17
Message-Id: <20170904142601.30641-2-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The VIOS LTH17 Cherry Trail bases netbook has its LCD panel mounted
rotated 90 degrees, add a DMI quirk for this.

Cc: Daniel Drake <drake@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/console/fbcon_dmi_quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/video/console/fbcon_dmi_quirks.c b/drivers/video/console/fbcon_dmi_quirks.c
index 9027f044a0e1..3fd40568070b 100644
--- a/drivers/video/console/fbcon_dmi_quirks.c
+++ b/drivers/video/console/fbcon_dmi_quirks.c
@@ -58,6 +58,12 @@ static const struct fbcon_dmi_rotate_data rotate_data_itworks_tw891 = {
 	.rotate = FB_ROTATE_CW,
 };
 
+static const struct fbcon_dmi_rotate_data rotate_data_vios_lth17 = {
+	.width = 800,
+	.height = 1280,
+	.rotate = FB_ROTATE_CW,
+};
+
 static const struct dmi_system_id rotate_data[] = {
 	{	/* Asus T100HA */
 		.matches = {
@@ -94,6 +100,14 @@ static const struct dmi_system_id rotate_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "TW891"),
 		},
 		.driver_data = (void *)&rotate_data_itworks_tw891,
+	}, {	/* VIOS LTH17 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "VIOS"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "LTH17"),
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "VIOS"),
+		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "LTH17"),
+		},
+		.driver_data = (void *)&rotate_data_vios_lth17,
 	},
 	{}
 };
-- 
2.13.4

