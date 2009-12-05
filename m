From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 05 Dec 2009 23:24:48 +0000
Subject: [PATCH 2/2] viafb: cosmetic cleanup of function integrated_lvds_enable()
Message-Id: <1260055488-10833-2-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1260055488-10833-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1260055488-10833-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Harald Welte <laforge@gnumonks.org>, Harald Welte <HaraldWelte@viatech.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

From: Harald Welte <laforge@gnumonks.org>

viafb: cosmetic cleanup of function integrated_lvds_enable()

A humble attempt to simplify the coding style to improve readability

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/lcd.c |   40 ++++++++++++++--------------------------
 1 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/video/via/lcd.c b/drivers/video/via/lcd.c
index e3e597f..09353e2 100644
--- a/drivers/video/via/lcd.c
+++ b/drivers/video/via/lcd.c
@@ -1134,45 +1134,33 @@ static void integrated_lvds_enable(struct lvds_setting_information
 			    *plvds_setting_info,
 			    struct lvds_chip_information *plvds_chip_info)
 {
-	bool turn_on_first_powersequence = false;
-	bool turn_on_second_powersequence = false;
-
 	DEBUG_MSG(KERN_INFO "integrated_lvds_enable, out_interface:%d\n",
 		  plvds_chip_info->output_interface);
 	if (plvds_setting_info->lcd_mode = LCD_SPWG)
 		viafb_write_reg_mask(CRD2, VIACR, 0x00, BIT0 + BIT1);
-	 else
+	else
 		viafb_write_reg_mask(CRD2, VIACR, 0x03, BIT0 + BIT1);
-	if (INTERFACE_LVDS0LVDS1 = plvds_chip_info->output_interface)
-		turn_on_first_powersequence = true;
-	if (INTERFACE_LVDS0 = plvds_chip_info->output_interface)
-		turn_on_first_powersequence = true;
-	if (INTERFACE_LVDS1 = plvds_chip_info->output_interface)
-		turn_on_second_powersequence = true;
-
-	if (turn_on_second_powersequence) {
-		/* Use second power sequence control: */
-
-		/* Use hardware control power sequence. */
-		viafb_write_reg_mask(CRD3, VIACR, 0, BIT0);
-
-		/* Turn on back light. */
-		viafb_write_reg_mask(CRD3, VIACR, 0, BIT6 + BIT7);
 
-		/* Turn on hardware power sequence. */
-		viafb_write_reg_mask(CRD4, VIACR, 0x02, BIT1);
-	}
-	if (turn_on_first_powersequence) {
+	switch (plvds_chip_info->output_interface) {
+	case INTERFACE_LVDS0LVDS1:
+	case INTERFACE_LVDS0:
 		/* Use first power sequence control: */
-
 		/* Use hardware control power sequence. */
 		viafb_write_reg_mask(CR91, VIACR, 0, BIT0);
-
 		/* Turn on back light. */
 		viafb_write_reg_mask(CR91, VIACR, 0, BIT6 + BIT7);
-
 		/* Turn on hardware power sequence. */
 		viafb_write_reg_mask(CR6A, VIACR, 0x08, BIT3);
+		break;
+	case INTERFACE_LVDS1:
+		/* Use second power sequence control: */
+		/* Use hardware control power sequence. */
+		viafb_write_reg_mask(CRD3, VIACR, 0, BIT0);
+		/* Turn on back light. */
+		viafb_write_reg_mask(CRD3, VIACR, 0, BIT6 + BIT7);
+		/* Turn on hardware power sequence. */
+		viafb_write_reg_mask(CRD4, VIACR, 0x02, BIT1);
+		break;
 	}
 
 	/* Turn DFP High/Low pad on. */
-- 
1.6.3.2

