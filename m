From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 23 Jul 2010 15:39:18 +0000
Subject: [PATCH 03/11] viafb: improve lcd code readability
Message-Id: <1279899566-4359-4-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>

viafb: improve lcd code readability

This changes the code to better reflect that we can (currently) only
perform upscaling.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
---
 drivers/video/via/lcd.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/via/lcd.c b/drivers/video/via/lcd.c
index 438a106..55cb4ec 100644
--- a/drivers/video/via/lcd.c
+++ b/drivers/video/via/lcd.c
@@ -437,7 +437,7 @@ static void load_lcd_scaling(int set_hres, int set_vres, int panel_hres,
 	viafb_write_reg_mask(CR79, VIACR, 0x07, BIT0 + BIT1 + BIT2);
 
 	/* Check if expansion for horizontal */
-	if (set_hres != panel_hres) {
+	if (set_hres < panel_hres) {
 		/* Load Horizontal Scaling Factor */
 		switch (viaparinfo->chip_info->gfx_chip_name) {
 		case UNICHROME_CLE266:
@@ -477,7 +477,7 @@ static void load_lcd_scaling(int set_hres, int set_vres, int panel_hres,
 	}
 
 	/* Check if expansion for vertical */
-	if (set_vres != panel_vres) {
+	if (set_vres < panel_vres) {
 		/* Load Vertical Scaling Factor */
 		switch (viaparinfo->chip_info->gfx_chip_name) {
 		case UNICHROME_CLE266:
@@ -643,9 +643,8 @@ void viafb_lcd_set_mode(struct crt_mode_table *mode_crt_table,
 				 (mode_crt_reg, panel_crt_reg), IGA1);
 	} else {
 		/* Expansion */
-		if ((plvds_setting_info->display_method =
-		     LCD_EXPANDSION) & ((set_hres != panel_hres)
-					|| (set_vres != panel_vres))) {
+		if (plvds_setting_info->display_method = LCD_EXPANDSION
+			&& (set_hres < panel_hres || set_vres < panel_vres)) {
 			/* expansion timing IGA2 loaded panel set timing*/
 			viafb_load_crtc_timing(panel_crt_reg, IGA2);
 			DEBUG_MSG(KERN_INFO "viafb_load_crtc_timing!!\n");
-- 
1.6.3.2

