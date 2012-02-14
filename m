From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 14 Feb 2012 05:51:35 +0000
Subject: [PATCH 1/4] viafb: set correct polarity for second adapter
Message-Id: <e0e12a9282a879577ba8e35c73ff5d94ae1f50b9.1329194838.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1329194838.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1329194838.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

This patch sets the correct polarity for the second adapter when
viafb_SAMM_ON is set and viafb_dual_fb is not set. Just one step to
make this mode useful.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/hw.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index d5aaca9..08c1036 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -1758,13 +1758,13 @@ static void set_display_channel(void)
 	}
 }
 
-static u8 get_sync(struct fb_info *info)
+static u8 get_sync(struct fb_var_screeninfo *var)
 {
 	u8 polarity = 0;
 
-	if (!(info->var.sync & FB_SYNC_HOR_HIGH_ACT))
+	if (!(var->sync & FB_SYNC_HOR_HIGH_ACT))
 		polarity |= VIA_HSYNC_NEGATIVE;
-	if (!(info->var.sync & FB_SYNC_VERT_HIGH_ACT))
+	if (!(var->sync & FB_SYNC_VERT_HIGH_ACT))
 		polarity |= VIA_VSYNC_NEGATIVE;
 	return polarity;
 }
@@ -1976,13 +1976,13 @@ int viafb_setmode(int video_bpp, int video_bpp1)
 			viafb_DeviceStatus = CRT_Device;
 	}
 	device_on();
-	if (!viafb_dual_fb)
-		via_set_sync_polarity(devices, get_sync(viafbinfo));
+	if (!viafb_SAMM_ON)
+		via_set_sync_polarity(devices, get_sync(&viafbinfo->var));
 	else {
 		via_set_sync_polarity(viaparinfo->shared->iga1_devices,
-			get_sync(viafbinfo));
+			get_sync(&viafbinfo->var));
 		via_set_sync_polarity(viaparinfo->shared->iga2_devices,
-			get_sync(viafbinfo1));
+			get_sync(&var2));
 	}
 
 	clock.set_engine_pll_state(VIA_STATE_ON);
-- 
1.7.9

