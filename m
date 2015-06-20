From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 18:36:45 +0000
Subject: [PATCH 11/19] staging: sm750fb: consistent spacing around operators
Message-Id: <1434825413-4994-11-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
In-Reply-To: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

fixes checkpatch.pl error:
ERROR: need consistent spacing around ''

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c    | 4 ++--
 drivers/staging/sm750fb/ddk750_display.h | 4 ++--
 drivers/staging/sm750fb/sm750.h          | 2 +-
 drivers/staging/sm750fb/sm750_hw.c       | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index fb1c533..633201e 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -464,7 +464,7 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 		RN = N * request;
 		quo = RN / input;
 		rem = RN % input;/* rem always small than 14318181 */
-		fl_quo = (rem * 10000 /input);
+		fl_quo = (rem * 10000 / input);
 
 		for (d = xcnt - 1; d >= 0; d--) {
 			X = xparm[d].value;
@@ -474,7 +474,7 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 			M += (fl_quo*X % 10000)>5000?1:0;
 			if (M < 256 && M > 0) {
 				unsigned int diff;
-				tmpClock = pll->inputFreq *M / N / X;
+				tmpClock = pll->inputFreq * M / N / X;
 				diff = absDiff(tmpClock, request_orig);
 				if (diff < miniDiff) {
 					pll->M = M;
diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index a7f50cc..afdf201 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -46,7 +46,7 @@
 	0: both off
 */
 #define SEC_TP_OFFSET 5
-#define SEC_TP_MASK (1<< SEC_TP_OFFSET)
+#define SEC_TP_MASK (1 << SEC_TP_OFFSET)
 #define SEC_TP_USAGE (SEC_TP_MASK << 16)
 #define SEC_TP_ON  ((0x1 << SEC_TP_OFFSET)|SEC_TP_USAGE)
 #define SEC_TP_OFF ((0x0 << SEC_TP_OFFSET)|SEC_TP_USAGE)
@@ -67,7 +67,7 @@
 #define DAC_OFFSET 7
 #define DAC_MASK (1 << DAC_OFFSET)
 #define DAC_USAGE (DAC_MASK << 16)
-#define DAC_ON ((0x0<< DAC_OFFSET)|DAC_USAGE)
+#define DAC_ON ((0x0 << DAC_OFFSET)|DAC_USAGE)
 #define DAC_OFF ((0x1 << DAC_OFFSET)|DAC_USAGE)
 
 /* DPMS only affect D-SUB head
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 320908bc..b0ff0b5 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -10,7 +10,7 @@
 #define MB(x) ((x)<<20)
 #define MHZ(x) ((x) * 1000000)
 /* align should be 2,4,8,16 */
-#define PADDING(align, data) (((data)+(align)-1)&(~((align) -1)))
+#define PADDING(align, data) (((data)+(align)-1)&(~((align) - 1)))
 extern int smi_indent;
 
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index a43f936..7a5d522 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -330,7 +330,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 	modparm.pixel_clock = ps_to_hz(var->pixclock);
 	modparm.vertical_sync_polarity = (var->sync & FB_SYNC_HOR_HIGH_ACT) ? POS:NEG;
 	modparm.horizontal_sync_polarity = (var->sync & FB_SYNC_VERT_HIGH_ACT) ? POS:NEG;
-	modparm.clock_phase_polarity = (var->sync& FB_SYNC_COMP_HIGH_ACT) ? POS:NEG;
+	modparm.clock_phase_polarity = (var->sync & FB_SYNC_COMP_HIGH_ACT) ? POS:NEG;
 	modparm.horizontal_display_end = var->xres;
 	modparm.horizontal_sync_width = var->hsync_len;
 	modparm.horizontal_sync_start = var->xres + var->right_margin;
@@ -369,7 +369,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 			FIELD_VALUE(0, PANEL_FB_WIDTH, OFFSET, fix->line_length));
 
 		POKE32(PANEL_WINDOW_WIDTH,
-			FIELD_VALUE(0, PANEL_WINDOW_WIDTH, WIDTH, var->xres -1)|
+			FIELD_VALUE(0, PANEL_WINDOW_WIDTH, WIDTH, var->xres - 1)|
 			FIELD_VALUE(0, PANEL_WINDOW_WIDTH, X, var->xoffset));
 
 		POKE32(PANEL_WINDOW_HEIGHT,
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
