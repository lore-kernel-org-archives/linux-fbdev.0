From: Anatoly Stepanov <drivengroove@gmail.com>
Date: Sun, 28 Jun 2015 23:44:04 +0000
Subject: [PATCH 11/11] staging: sm750fb: add required spaces around C operators
Message-Id: <1435535044-22042-12-git-send-email-drivengroove@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



Add spaces according to checkpatch.pl messages:
"ERROR: spaces required around that '=' (ctx:VxV)"
"ERROR: need consistent spacing around '-' (ctx:WxV)"
"ERROR: spaces required around that '?' (ctx:VxE)"
"ERROR: need consistent spacing around '&' (ctx:VxW)"

Signed-off-by: Anatoly Stepanov <drivengroove@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index a4f0cd0..359165d 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -107,7 +107,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	spec_share = container_of(share, struct sm750_share, share);
 	parm = &spec_share->state.initParm;
 	if (parm->chip_clk = 0)
-		parm->chip_clk = (getChipType() = SM750LE)?
+		parm->chip_clk = (getChipType() = SM750LE) ?
 						DEFAULT_SM750LE_CHIP_CLOCK :
 						DEFAULT_SM750_CHIP_CLOCK;
 
@@ -327,7 +327,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 	modparm.pixel_clock = ps_to_hz(var->pixclock);
 	modparm.vertical_sync_polarity = (var->sync & FB_SYNC_HOR_HIGH_ACT) ? POS:NEG;
 	modparm.horizontal_sync_polarity = (var->sync & FB_SYNC_VERT_HIGH_ACT) ? POS:NEG;
-	modparm.clock_phase_polarity = (var->sync& FB_SYNC_COMP_HIGH_ACT) ? POS:NEG;
+	modparm.clock_phase_polarity = (var->sync & FB_SYNC_COMP_HIGH_ACT) ? POS:NEG;
 	modparm.horizontal_display_end = var->xres;
 	modparm.horizontal_sync_width = var->hsync_len;
 	modparm.horizontal_sync_start = var->xres + var->right_margin;
@@ -366,7 +366,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 			FIELD_VALUE(0, PANEL_FB_WIDTH, OFFSET, fix->line_length));
 
 		POKE32(PANEL_WINDOW_WIDTH,
-			FIELD_VALUE(0, PANEL_WINDOW_WIDTH, WIDTH, var->xres -1)|
+			FIELD_VALUE(0, PANEL_WINDOW_WIDTH, WIDTH, var->xres - 1)|
 			FIELD_VALUE(0, PANEL_WINDOW_WIDTH, X, var->xoffset));
 
 		POKE32(PANEL_WINDOW_HEIGHT,
@@ -418,7 +418,7 @@ void hw_sm750_crtc_clear(struct lynxfb_crtc *crtc)
 int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
 								ushort red, ushort green, ushort blue)
 {
-	static unsigned int add[]={PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
+	static unsigned int add[] = {PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
 	POKE32(add[crtc->channel] + index*4, (red<<16)|(green<<8)|blue);
 	return 0;
 }
@@ -576,7 +576,7 @@ void hw_sm750_initAccel(struct lynx_share *share)
 
 int hw_sm750le_deWait(void)
 {
-	int i=0x10000000;
+	int i = 0x10000000;
 	while (i--) {
 		unsigned int dwVal = PEEK32(DE_STATE2);
 		if ((FIELD_GET(dwVal, DE_STATE2, DE_STATUS) = DE_STATE2_DE_STATUS_IDLE) &&
@@ -592,7 +592,7 @@ int hw_sm750le_deWait(void)
 
 int hw_sm750_deWait(void)
 {
-	int i=0x10000000;
+	int i = 0x10000000;
 	while (i--) {
 		unsigned int dwVal = PEEK32(SYSTEM_CTRL);
 		if ((FIELD_GET(dwVal, SYSTEM_CTRL, DE_STATUS) = SYSTEM_CTRL_DE_STATUS_IDLE) &&
-- 
2.1.0

