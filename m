From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Tue, 21 Mar 2017 11:38:38 +0000
Subject: [PATCH 1/2] staging: sm750fb: Remove typedefs from struct
Message-Id: <20170321112639.32495-2-arushisinghal19971997@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170321112639.32495-1-arushisinghal19971997@gmail.com>
In-Reply-To: <20170321112639.32495-1-arushisinghal19971997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: w.d.hubbs@gmail.com
Cc: linux-fbdev@vger.kernel.org, outreachy-kernel@googlegroups.com, teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, speakup@linux-speakup.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Arushi Singhal <arushisinghal19971997@gmail.com>

This patch removes typedefs from structure and renames them as
per kernel coding standards.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 8 +++++---
 drivers/staging/sm750fb/ddk750_mode.h | 8 +++-----
 drivers/staging/sm750fb/sm750_hw.c    | 2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 37b5d4850fb9..bb673e18999b 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -12,7 +12,8 @@
  * HW only supports 7 predefined pixel clocks, and clock select is
  * in bit 29:27 of Display Control register.
  */
-static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam, unsigned long dispControl)
+static unsigned long displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
+						  unsigned long dispControl)
 {
 	unsigned long x, y;
 
@@ -72,7 +73,8 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 }
 
 /* only timing related registers will be  programed */
-static int programModeRegisters(mode_parameter_t *pModeParam, struct pll_value *pll)
+static int programModeRegisters(struct mode_parameter *pModeParam,
+				struct pll_value *pll)
 {
 	int ret = 0;
 	int cnt = 0;
@@ -203,7 +205,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, struct pll_value *
 	return ret;
 }
 
-int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock)
+int ddk750_setModeTiming(struct mode_parameter *parm, clock_type_t clock)
 {
 	struct pll_value pll;
 	unsigned int uiActualPixelClk;
diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
index 6d204b8b4a01..9dc4d6c5a779 100644
--- a/drivers/staging/sm750fb/ddk750_mode.h
+++ b/drivers/staging/sm750fb/ddk750_mode.h
@@ -9,7 +9,7 @@ typedef enum _spolarity_t {
 }
 spolarity_t;
 
-typedef struct _mode_parameter_t {
+struct mode_parameter {
 	/* Horizontal timing. */
 	unsigned long horizontal_total;
 	unsigned long horizontal_display_end;
@@ -31,9 +31,7 @@ typedef struct _mode_parameter_t {
 
 	/* Clock Phase. This clock phase only applies to Panel. */
 	spolarity_t clock_phase_polarity;
-}
-mode_parameter_t;
-
-int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock);
+};
 
+int ddk750_setModeTiming(struct mode_parameter *parm, clock_type_t clock);
 #endif
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index fab3fc9c8330..baf1bbdc92ff 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -252,7 +252,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 {
 	int ret, fmt;
 	u32 reg;
-	mode_parameter_t modparm;
+	struct mode_parameter modparm;
 	clock_type_t clock;
 	struct sm750_dev *sm750_dev;
 	struct lynxfb_par *par;
-- 
2.11.0

