From: Matej Dujava <mdujava@kocurkovo.cz>
Date: Wed, 10 May 2017 21:55:56 +0000
Subject: [PATCH 6/9] staging: sm750fb: Remove typedef from "typedef enum _clock_type"
Message-Id: <1494453359-3722-7-git-send-email-mdujava@kocurkovo.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch removes typedefs from enum and renames it from "typedef enum
_clock_type_t" to "enum clock_type" as per kernel coding standards.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/ddk750_chip.h | 8 ++++----
 drivers/staging/sm750fb/ddk750_mode.c | 2 +-
 drivers/staging/sm750fb/sm750_hw.c    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index f2eee2b..e5cb436 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -31,17 +31,17 @@ enum logical_chip_type {
 };
 
 
-typedef enum _clock_type_t {
+enum clock_type {
 	MXCLK_PLL,
 	PRIMARY_PLL,
 	SECONDARY_PLL,
 	VGA0_PLL,
 	VGA1_PLL,
-}
-clock_type_t;
+};
+
 
 struct pll_value {
-	clock_type_t clockType;
+	enum clock_type clockType;
 	unsigned long inputFreq; /* Input clock frequency to the PLL */
 
 	/* Use this when clockType = PANEL_PLL */
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index bb673e1..24d3447 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -205,7 +205,7 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
 	return ret;
 }
 
-int ddk750_setModeTiming(struct mode_parameter *parm, clock_type_t clock)
+int ddk750_setModeTiming(struct mode_parameter *parm, enum clock_type clock)
 {
 	struct pll_value pll;
 	unsigned int uiActualPixelClk;
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index baf1bbd..3cdc4ae 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -253,7 +253,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 	int ret, fmt;
 	u32 reg;
 	struct mode_parameter modparm;
-	clock_type_t clock;
+	enum clock_type clock;
 	struct sm750_dev *sm750_dev;
 	struct lynxfb_par *par;
 
-- 
1.8.3.1

