From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 11 Aug 2010 23:49:32 +0000
Subject: [PATCH 03/11] viafb: remove stub
Message-Id: <1281570580-8253-4-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1281570580-8253-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1281570580-8253-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>

viafb: remove stub

This is a nop so removing it is safe.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
---
 drivers/video/via/hw.c |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index 53b0651..63b6722 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -720,7 +720,6 @@ static struct rgbLUT palLUT_table[] = {
 
 static void set_crt_output_path(int set_iga);
 static void dvi_patch_skew_dvp0(void);
-static void dvi_patch_skew_dvp1(void);
 static void dvi_patch_skew_dvp_low(void);
 static void set_dvi_output_path(int set_iga, int output_interface);
 static void set_lcd_output_path(int set_iga, int output_interface);
@@ -910,21 +909,6 @@ static void dvi_patch_skew_dvp0(void)
 	}
 }
 
-static void dvi_patch_skew_dvp1(void)
-{
-	switch (viaparinfo->chip_info->gfx_chip_name) {
-	case UNICHROME_CX700:
-		{
-			break;
-		}
-
-	default:
-		{
-			break;
-		}
-	}
-}
-
 static void dvi_patch_skew_dvp_low(void)
 {
 	switch (viaparinfo->chip_info->gfx_chip_name) {
@@ -992,7 +976,6 @@ static void set_dvi_output_path(int set_iga, int output_interface)
 		}
 
 		viafb_write_reg_mask(SR1E, VIASR, 0x30, BIT4 + BIT5);
-		dvi_patch_skew_dvp1();
 		break;
 	case INTERFACE_DFP_HIGH:
 		if (viaparinfo->chip_info->gfx_chip_name != UNICHROME_CLE266) {
-- 
1.6.3.2

