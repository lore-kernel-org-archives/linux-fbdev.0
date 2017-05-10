From: Matej Dujava <mdujava@kocurkovo.cz>
Date: Wed, 10 May 2017 21:55:52 +0000
Subject: [PATCH 2/9] staging: sm750fb: unifying macro definitions
Message-Id: <1494453359-3722-3-git-send-email-mdujava@kocurkovo.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds tabs into macro definitions so all rhs are on same column.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/ddk750_display.h | 74 ++++++++++++++++----------------
 drivers/staging/sm750fb/ddk750_hwi2c.c   |  4 +-
 drivers/staging/sm750fb/sm750.h          |  6 +--
 3 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index 609bf74..6f639d7 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -6,8 +6,8 @@
  *	80000[29:28]
  */
 
-#define PNL_2_OFFSET 0
-#define PNL_2_MASK (3 << PNL_2_OFFSET)
+#define PNL_2_OFFSET	0
+#define PNL_2_MASK	(3 << PNL_2_OFFSET)
 #define PNL_2_USAGE	(PNL_2_MASK << 16)
 #define PNL_2_PRI	((0 << PNL_2_OFFSET) | PNL_2_USAGE)
 #define PNL_2_SEC	((2 << PNL_2_OFFSET) | PNL_2_USAGE)
@@ -17,72 +17,72 @@
  *	1: 80000[8] & 80000[2] on
  *	0: both off
  */
-#define PRI_TP_OFFSET 4
-#define PRI_TP_MASK BIT(PRI_TP_OFFSET)
-#define PRI_TP_USAGE (PRI_TP_MASK << 16)
-#define PRI_TP_ON ((0x1 << PRI_TP_OFFSET) | PRI_TP_USAGE)
-#define PRI_TP_OFF ((0x0 << PRI_TP_OFFSET) | PRI_TP_USAGE)
+#define PRI_TP_OFFSET	4
+#define PRI_TP_MASK	BIT(PRI_TP_OFFSET)
+#define PRI_TP_USAGE	(PRI_TP_MASK << 16)
+#define PRI_TP_ON	((0x1 << PRI_TP_OFFSET) | PRI_TP_USAGE)
+#define PRI_TP_OFF	((0x0 << PRI_TP_OFFSET) | PRI_TP_USAGE)
 
 /*
  * panel sequency status
  *	80000[27:24]
  */
-#define PNL_SEQ_OFFSET 6
-#define PNL_SEQ_MASK BIT(PNL_SEQ_OFFSET)
-#define PNL_SEQ_USAGE (PNL_SEQ_MASK << 16)
-#define PNL_SEQ_ON (BIT(PNL_SEQ_OFFSET) | PNL_SEQ_USAGE)
-#define PNL_SEQ_OFF ((0 << PNL_SEQ_OFFSET) | PNL_SEQ_USAGE)
+#define PNL_SEQ_OFFSET	6
+#define PNL_SEQ_MASK	BIT(PNL_SEQ_OFFSET)
+#define PNL_SEQ_USAGE	(PNL_SEQ_MASK << 16)
+#define PNL_SEQ_ON	(BIT(PNL_SEQ_OFFSET) | PNL_SEQ_USAGE)
+#define PNL_SEQ_OFF	((0 << PNL_SEQ_OFFSET) | PNL_SEQ_USAGE)
 
 /*
  * dual digital output
  *	80000[19]
  */
-#define DUAL_TFT_OFFSET 8
-#define DUAL_TFT_MASK BIT(DUAL_TFT_OFFSET)
-#define DUAL_TFT_USAGE (DUAL_TFT_MASK << 16)
-#define DUAL_TFT_ON (BIT(DUAL_TFT_OFFSET) | DUAL_TFT_USAGE)
-#define DUAL_TFT_OFF ((0 << DUAL_TFT_OFFSET) | DUAL_TFT_USAGE)
+#define DUAL_TFT_OFFSET	8
+#define DUAL_TFT_MASK	BIT(DUAL_TFT_OFFSET)
+#define DUAL_TFT_USAGE	(DUAL_TFT_MASK << 16)
+#define DUAL_TFT_ON	(BIT(DUAL_TFT_OFFSET) | DUAL_TFT_USAGE)
+#define DUAL_TFT_OFF	((0 << DUAL_TFT_OFFSET) | DUAL_TFT_USAGE)
 
 /*
  * secondary timing & plane enable bit
  *	1:80200[8] & 80200[2] on
  *	0: both off
  */
-#define SEC_TP_OFFSET 5
-#define SEC_TP_MASK BIT(SEC_TP_OFFSET)
-#define SEC_TP_USAGE (SEC_TP_MASK << 16)
-#define SEC_TP_ON  ((0x1 << SEC_TP_OFFSET) | SEC_TP_USAGE)
-#define SEC_TP_OFF ((0x0 << SEC_TP_OFFSET) | SEC_TP_USAGE)
+#define SEC_TP_OFFSET	5
+#define SEC_TP_MASK	BIT(SEC_TP_OFFSET)
+#define SEC_TP_USAGE	(SEC_TP_MASK << 16)
+#define SEC_TP_ON	((0x1 << SEC_TP_OFFSET) | SEC_TP_USAGE)
+#define SEC_TP_OFF	((0x0 << SEC_TP_OFFSET) | SEC_TP_USAGE)
 
 /*
  * crt path select
  *	80200[19:18]
  */
-#define CRT_2_OFFSET 2
-#define CRT_2_MASK (3 << CRT_2_OFFSET)
-#define CRT_2_USAGE (CRT_2_MASK << 16)
-#define CRT_2_PRI ((0x0 << CRT_2_OFFSET) | CRT_2_USAGE)
-#define CRT_2_SEC ((0x2 << CRT_2_OFFSET) | CRT_2_USAGE)
+#define CRT_2_OFFSET	2
+#define CRT_2_MASK	(3 << CRT_2_OFFSET)
+#define CRT_2_USAGE	(CRT_2_MASK << 16)
+#define CRT_2_PRI	((0x0 << CRT_2_OFFSET) | CRT_2_USAGE)
+#define CRT_2_SEC	((0x2 << CRT_2_OFFSET) | CRT_2_USAGE)
 
 /*
  * DAC affect both DVI and DSUB
  *	4[20]
  */
-#define DAC_OFFSET 7
-#define DAC_MASK BIT(DAC_OFFSET)
-#define DAC_USAGE (DAC_MASK << 16)
-#define DAC_ON ((0x0 << DAC_OFFSET) | DAC_USAGE)
-#define DAC_OFF ((0x1 << DAC_OFFSET) | DAC_USAGE)
+#define DAC_OFFSET	7
+#define DAC_MASK	BIT(DAC_OFFSET)
+#define DAC_USAGE	(DAC_MASK << 16)
+#define DAC_ON		((0x0 << DAC_OFFSET) | DAC_USAGE)
+#define DAC_OFF		((0x1 << DAC_OFFSET) | DAC_USAGE)
 
 /*
  * DPMS only affect D-SUB head
  *	0[31:30]
  */
-#define DPMS_OFFSET 9
-#define DPMS_MASK (3 << DPMS_OFFSET)
-#define DPMS_USAGE (DPMS_MASK << 16)
-#define DPMS_OFF ((3 << DPMS_OFFSET) | DPMS_USAGE)
-#define DPMS_ON ((0 << DPMS_OFFSET) | DPMS_USAGE)
+#define DPMS_OFFSET	9
+#define DPMS_MASK	(3 << DPMS_OFFSET)
+#define DPMS_USAGE	(DPMS_MASK << 16)
+#define DPMS_OFF	((3 << DPMS_OFFSET) | DPMS_USAGE)
+#define DPMS_ON		((0 << DPMS_OFFSET) | DPMS_USAGE)
 
 /*
  * LCD1 means panel path TFT1  & panel path DVI (so enable DAC)
diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
index ec556a9..ccf49ef 100644
--- a/drivers/staging/sm750fb/ddk750_hwi2c.c
+++ b/drivers/staging/sm750fb/ddk750_hwi2c.c
@@ -5,8 +5,8 @@
 #include "ddk750_hwi2c.h"
 #include "ddk750_power.h"
 
-#define MAX_HWI2C_FIFO                  16
-#define HWI2C_WAIT_TIMEOUT              0xF0000
+#define MAX_HWI2C_FIFO		16
+#define HWI2C_WAIT_TIMEOUT	0xF0000
 
 int sm750_hw_i2c_init(unsigned char bus_speed_mode)
 {
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 5b186da..1e21fa1 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -1,14 +1,14 @@
 #ifndef LYNXDRV_H_
 #define LYNXDRV_H_
 
-#define FB_ACCEL_SMI 0xab
+#define FB_ACCEL_SMI			0xab
 
-#define MHZ(x) ((x) * 1000000)
+#define MHZ(x)				((x) * 1000000)
 
 #define DEFAULT_SM750_CHIP_CLOCK	290
 #define DEFAULT_SM750LE_CHIP_CLOCK	333
 #ifndef SM750LE_REVISION_ID
-#define SM750LE_REVISION_ID ((unsigned char)0xfe)
+#define SM750LE_REVISION_ID		((unsigned char)0xfe)
 #endif
 
 enum sm750_pnltype {
-- 
1.8.3.1

