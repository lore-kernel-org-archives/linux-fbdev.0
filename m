From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 26 Aug 2017 12:26:38 +0000
Subject: [PATCH] video/console: Add new BIOS date for GPD pocket to dmi quirk table
Message-Id: <20170826122638.29936-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

GPD has released a new BIOS for the pocket, update the dmi data
accordingly.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/console/fbcon_dmi_quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/fbcon_dmi_quirks.c b/drivers/video/console/fbcon_dmi_quirks.c
index 7fbf7df765ea..9027f044a0e1 100644
--- a/drivers/video/console/fbcon_dmi_quirks.c
+++ b/drivers/video/console/fbcon_dmi_quirks.c
@@ -38,7 +38,7 @@ static const struct fbcon_dmi_rotate_data rotate_data_gpd_pocket = {
 	.width = 1200,
 	.height = 1920,
 	.bios_dates = (const char * const []){ "05/26/2017", "06/28/2017",
-		"07/05/2017", NULL },
+		"07/05/2017", "08/07/2017", NULL },
 	.rotate = FB_ROTATE_CW,
 };
 
-- 
2.13.4

