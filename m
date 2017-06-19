From: Simran Singhal <singhalsimran0@gmail.com>
Date: Mon, 19 Jun 2017 17:33:21 +0000
Subject: [PATCH] staging: sm750fb: Remove typedefs from _logical_chip_type_t and _clock_type_t
Message-Id: <20170619172120.GA28772@singhal-Inspiron-5558>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This patch removes typedefs from enum _logical_chip_type_t and enum
_clock_type_t and rename them to logical_chip_type_t and clock_type_t
respectively.

Fix checkpatch warning:
WARNING: do not add new typedefs

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c |  4 ++--
 drivers/staging/sm750fb/ddk750_chip.h | 14 ++++++--------
 drivers/staging/sm750fb/ddk750_mode.c |  2 +-
 drivers/staging/sm750fb/ddk750_mode.h |  2 +-
 drivers/staging/sm750fb/sm750_hw.c    |  2 +-
 5 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 944dd25..db4d2fc 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -7,9 +7,9 @@
 
 #define MHz(x) ((x) * 1000000)
 
-static logical_chip_type_t chip;
+static enum logical_chip_type_t chip;
 
-logical_chip_type_t sm750_get_chip_type(void)
+enum logical_chip_type_t sm750_get_chip_type(void)
 {
 	return chip;
 }
diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index 2c7a9b9..df1f586 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -23,25 +23,23 @@ static inline void poke32(u32 data, u32 addr)
 }
 
 /* This is all the chips recognized by this library */
-typedef enum _logical_chip_type_t {
+enum logical_chip_type_t {
 	SM_UNKNOWN,
 	SM718,
 	SM750,
 	SM750LE,
-}
-logical_chip_type_t;
+};
 
-typedef enum _clock_type_t {
+enum clock_type_t {
 	MXCLK_PLL,
 	PRIMARY_PLL,
 	SECONDARY_PLL,
 	VGA0_PLL,
 	VGA1_PLL,
-}
-clock_type_t;
+};
 
 struct pll_value {
-	clock_type_t clockType;
+	enum clock_type_t clockType;
 	unsigned long inputFreq; /* Input clock frequency to the PLL */
 
 	/* Use this when clockType = PANEL_PLL */
@@ -93,7 +91,7 @@ struct initchip_param {
 	/* More initialization parameter can be added if needed */
 };
 
-logical_chip_type_t sm750_get_chip_type(void);
+enum logical_chip_type_t sm750_get_chip_type(void);
 void sm750_set_chip_type(unsigned short devId, u8 revId);
 unsigned int sm750_calc_pll_value(unsigned int request, struct  pll_value *pll);
 unsigned int sm750_format_pll_reg(struct pll_value *pPLL);
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index bb673e1..6242770 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -205,7 +205,7 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
 	return ret;
 }
 
-int ddk750_setModeTiming(struct mode_parameter *parm, clock_type_t clock)
+int ddk750_setModeTiming(struct mode_parameter *parm, enum clock_type_t clock)
 {
 	struct pll_value pll;
 	unsigned int uiActualPixelClk;
diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
index d5eae36..78a3cc7 100644
--- a/drivers/staging/sm750fb/ddk750_mode.h
+++ b/drivers/staging/sm750fb/ddk750_mode.h
@@ -32,5 +32,5 @@ struct mode_parameter {
 	enum spolarity clock_phase_polarity;
 };
 
-int ddk750_setModeTiming(struct mode_parameter *parm, clock_type_t clock);
+int ddk750_setModeTiming(struct mode_parameter *parm, enum clock_type_t clock);
 #endif
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index baf1bbd..8836e324 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -253,7 +253,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 	int ret, fmt;
 	u32 reg;
 	struct mode_parameter modparm;
-	clock_type_t clock;
+	enum clock_type_t clock;
 	struct sm750_dev *sm750_dev;
 	struct lynxfb_par *par;
 
-- 
2.7.4

