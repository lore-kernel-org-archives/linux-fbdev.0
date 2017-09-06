From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 06 Sep 2017 12:40:05 +0000
Subject: [PATCH] video/console: Update BIOS dates list for GPD win console rotation DMI quirk
Message-Id: <20170906124005.11573-2-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Recently produced GPD win devices have a new BIOS, research into the
changes in this BIOS has found a ChangeLog which also lists 2 previously
unknown BIOS dates.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/console/fbcon_dmi_quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/fbcon_dmi_quirks.c b/drivers/video/console/fbcon_dmi_quirks.c
index 3fd40568070b..6904e47d1e51 100644
--- a/drivers/video/console/fbcon_dmi_quirks.c
+++ b/drivers/video/console/fbcon_dmi_quirks.c
@@ -46,8 +46,8 @@ static const struct fbcon_dmi_rotate_data rotate_data_gpd_win = {
 	.width = 720,
 	.height = 1280,
 	.bios_dates = (const char * const []){
-		"10/25/2016", "11/18/2016", "02/21/2017",
-		"03/20/2017", NULL },
+		"10/25/2016", "11/18/2016", "12/23/2016", "12/26/2016",
+		"02/21/2017", "03/20/2017", "05/25/2017", NULL },
 	.rotate = FB_ROTATE_CW,
 };
 
-- 
2.13.4

