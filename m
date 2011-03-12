From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 12 Mar 2011 21:22:58 +0000
Subject: [PATCH 3/4] viafb: strip some structures
Message-Id: <1299964979-3391-4-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1299964979-3391-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1299964979-3391-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

This patch removes some write-only variables from the device management
structures. Just a small cleanup.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/chip.h |    4 ----
 drivers/video/via/hw.c   |   11 -----------
 2 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/drivers/video/via/chip.h b/drivers/video/via/chip.h
index 3e8aacd..781f3aa 100644
--- a/drivers/video/via/chip.h
+++ b/drivers/video/via/chip.h
@@ -139,9 +139,6 @@ struct chip_information {
 
 struct crt_setting_information {
 	int iga_path;
-	int h_active;
-	int v_active;
-	int bpp;
 	int refresh_rate;
 };
 
@@ -159,7 +156,6 @@ struct lvds_setting_information {
 	int h_active;
 	int v_active;
 	int bpp;
-	int refresh_rate;
 	int lcd_panel_hres;
 	int lcd_panel_vres;
 	int display_method;
diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index 9ecf486..b0b0278 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -2117,9 +2117,6 @@ void viafb_update_device_setting(int hres, int vres,
 	int bpp, int vmode_refresh, int flag)
 {
 	if (flag = 0) {
-		viaparinfo->crt_setting_info->h_active = hres;
-		viaparinfo->crt_setting_info->v_active = vres;
-		viaparinfo->crt_setting_info->bpp = bpp;
 		viaparinfo->crt_setting_info->refresh_rate  			vmode_refresh;
 
@@ -2129,13 +2126,9 @@ void viafb_update_device_setting(int hres, int vres,
 		viaparinfo->lvds_setting_info->h_active = hres;
 		viaparinfo->lvds_setting_info->v_active = vres;
 		viaparinfo->lvds_setting_info->bpp = bpp;
-		viaparinfo->lvds_setting_info->refresh_rate -			vmode_refresh;
 		viaparinfo->lvds_setting_info2->h_active = hres;
 		viaparinfo->lvds_setting_info2->v_active = vres;
 		viaparinfo->lvds_setting_info2->bpp = bpp;
-		viaparinfo->lvds_setting_info2->refresh_rate -			vmode_refresh;
 	} else {
 
 		if (viaparinfo->tmds_setting_info->iga_path = IGA2) {
@@ -2147,15 +2140,11 @@ void viafb_update_device_setting(int hres, int vres,
 			viaparinfo->lvds_setting_info->h_active = hres;
 			viaparinfo->lvds_setting_info->v_active = vres;
 			viaparinfo->lvds_setting_info->bpp = bpp;
-			viaparinfo->lvds_setting_info->refresh_rate -				vmode_refresh;
 		}
 		if (IGA2 = viaparinfo->lvds_setting_info2->iga_path) {
 			viaparinfo->lvds_setting_info2->h_active = hres;
 			viaparinfo->lvds_setting_info2->v_active = vres;
 			viaparinfo->lvds_setting_info2->bpp = bpp;
-			viaparinfo->lvds_setting_info2->refresh_rate -				vmode_refresh;
 		}
 	}
 }
-- 
1.6.3.2

