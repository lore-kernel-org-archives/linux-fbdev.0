From: Matej Dujava <mdujava@kocurkovo.cz>
Date: Wed, 10 May 2017 21:55:57 +0000
Subject: [PATCH 7/9] staging: sm750fb: Remove typedef from "typedef enum _disp_output_t"
Message-Id: <1494453359-3722-8-git-send-email-mdujava@kocurkovo.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch removes typedefs from enum and renames it from "typedef enum
_disp_output_t" to "enum disp_output" as per kernel coding standards.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/ddk750_display.c | 2 +-
 drivers/staging/sm750fb/ddk750_display.h | 8 ++++----
 drivers/staging/sm750fb/sm750_hw.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 9b116ed6..13b91c3 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -110,7 +110,7 @@ static void swPanelPowerSequence(int disp, int delay)
 	primary_wait_vertical_sync(delay);
 }
 
-void ddk750_setLogicalDispOut(disp_output_t output)
+void ddk750_setLogicalDispOut(enum disp_output output)
 {
 	unsigned int reg;
 
diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index f9e1614..8b0830f 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -88,7 +88,7 @@
  * LCD1 means panel path TFT1  & panel path DVI (so enable DAC)
  * CRT means crt path DSUB
  */
-typedef enum _disp_output_t {
+enum disp_output {
 	do_LCD1_PRI = PNL_2_PRI | PRI_TP_ON | PNL_SEQ_ON | DAC_ON,
 	do_LCD1_SEC = PNL_2_SEC | SEC_TP_ON | PNL_SEQ_ON | DAC_ON,
 	do_LCD2_PRI = CRT_2_PRI | PRI_TP_ON | DUAL_TFT_ON,
@@ -99,9 +99,9 @@
 	 */
 	do_CRT_PRI = CRT_2_PRI | PRI_TP_ON | DPMS_ON | DAC_ON,
 	do_CRT_SEC = CRT_2_SEC | SEC_TP_ON | DPMS_ON | DAC_ON,
-}
-disp_output_t;
+};
 
-void ddk750_setLogicalDispOut(disp_output_t output);
+
+void ddk750_setLogicalDispOut(enum disp_output output);
 
 #endif
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 3cdc4ae..f7d1e67 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -184,7 +184,7 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 			    struct fb_fix_screeninfo *fix)
 {
 	int ret;
-	disp_output_t dispSet;
+	enum disp_output dispSet;
 	int channel;
 
 	ret = 0;
-- 
1.8.3.1

