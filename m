From: Matej Dujava <mdujava@kocurkovo.cz>
Date: Wed, 10 May 2017 21:55:54 +0000
Subject: [PATCH 4/9] staging: sm750fb: removing unnecessary binary operations
Message-Id: <1494453359-3722-5-git-send-email-mdujava@kocurkovo.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch remove unnecessary operation (eg. ``X | (0x0 << Y)`` to ``X``).

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/ddk750_display.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index cef7f46..f9e1614 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -9,8 +9,8 @@
 #define PNL_2_OFFSET	0
 #define PNL_2_MASK	(3 << PNL_2_OFFSET)
 #define PNL_2_USAGE	(PNL_2_MASK << 16)
-#define PNL_2_PRI	((0 << PNL_2_OFFSET) | PNL_2_USAGE)
-#define PNL_2_SEC	((2 << PNL_2_OFFSET) | PNL_2_USAGE)
+#define PNL_2_PRI	(PNL_2_USAGE)
+#define PNL_2_SEC	(PNL_2_USAGE | (2 << PNL_2_OFFSET))
 
 /*
  * primary timing & plane enable bit
@@ -20,8 +20,8 @@
 #define PRI_TP_OFFSET	4
 #define PRI_TP_MASK	BIT(PRI_TP_OFFSET)
 #define PRI_TP_USAGE	(PRI_TP_MASK << 16)
-#define PRI_TP_ON	((0x1 << PRI_TP_OFFSET) | PRI_TP_USAGE)
-#define PRI_TP_OFF	((0x0 << PRI_TP_OFFSET) | PRI_TP_USAGE)
+#define PRI_TP_ON	(PRI_TP_USAGE | BIT(PRI_TP_OFFSET))
+#define PRI_TP_OFF	(PRI_TP_USAGE)
 
 /*
  * panel sequency status
@@ -30,8 +30,8 @@
 #define PNL_SEQ_OFFSET	6
 #define PNL_SEQ_MASK	BIT(PNL_SEQ_OFFSET)
 #define PNL_SEQ_USAGE	(PNL_SEQ_MASK << 16)
-#define PNL_SEQ_ON	(BIT(PNL_SEQ_OFFSET) | PNL_SEQ_USAGE)
-#define PNL_SEQ_OFF	((0 << PNL_SEQ_OFFSET) | PNL_SEQ_USAGE)
+#define PNL_SEQ_ON	(PNL_SEQ_USAGE | BIT(PNL_SEQ_OFFSET))
+#define PNL_SEQ_OFF	(PNL_SEQ_USAGE)
 
 /*
  * dual digital output
@@ -40,8 +40,8 @@
 #define DUAL_TFT_OFFSET	8
 #define DUAL_TFT_MASK	BIT(DUAL_TFT_OFFSET)
 #define DUAL_TFT_USAGE	(DUAL_TFT_MASK << 16)
-#define DUAL_TFT_ON	(BIT(DUAL_TFT_OFFSET) | DUAL_TFT_USAGE)
-#define DUAL_TFT_OFF	((0 << DUAL_TFT_OFFSET) | DUAL_TFT_USAGE)
+#define DUAL_TFT_ON	(DUAL_TFT_USAGE | BIT(DUAL_TFT_OFFSET))
+#define DUAL_TFT_OFF	(DUAL_TFT_USAGE)
 
 /*
  * secondary timing & plane enable bit
@@ -51,8 +51,8 @@
 #define SEC_TP_OFFSET	5
 #define SEC_TP_MASK	BIT(SEC_TP_OFFSET)
 #define SEC_TP_USAGE	(SEC_TP_MASK << 16)
-#define SEC_TP_ON	((0x1 << SEC_TP_OFFSET) | SEC_TP_USAGE)
-#define SEC_TP_OFF	((0x0 << SEC_TP_OFFSET) | SEC_TP_USAGE)
+#define SEC_TP_ON	(SEC_TP_USAGE | BIT(SEC_TP_OFFSET))
+#define SEC_TP_OFF	(SEC_TP_USAGE)
 
 /*
  * crt path select
@@ -61,8 +61,8 @@
 #define CRT_2_OFFSET	2
 #define CRT_2_MASK	(3 << CRT_2_OFFSET)
 #define CRT_2_USAGE	(CRT_2_MASK << 16)
-#define CRT_2_PRI	((0x0 << CRT_2_OFFSET) | CRT_2_USAGE)
-#define CRT_2_SEC	((0x2 << CRT_2_OFFSET) | CRT_2_USAGE)
+#define CRT_2_PRI	(CRT_2_USAGE)
+#define CRT_2_SEC	(CRT_2_USAGE | (0x2 << CRT_2_OFFSET))
 
 /*
  * DAC affect both DVI and DSUB
@@ -71,8 +71,8 @@
 #define DAC_OFFSET	7
 #define DAC_MASK	BIT(DAC_OFFSET)
 #define DAC_USAGE	(DAC_MASK << 16)
-#define DAC_ON		((0x0 << DAC_OFFSET) | DAC_USAGE)
-#define DAC_OFF		((0x1 << DAC_OFFSET) | DAC_USAGE)
+#define DAC_ON		(DAC_USAGE)
+#define DAC_OFF		(DAC_USAGE | BIT(DAC_OFFSET))
 
 /*
  * DPMS only affect D-SUB head
@@ -81,8 +81,8 @@
 #define DPMS_OFFSET	9
 #define DPMS_MASK	(3 << DPMS_OFFSET)
 #define DPMS_USAGE	(DPMS_MASK << 16)
-#define DPMS_ON		((0 << DPMS_OFFSET) | DPMS_USAGE)
-#define DPMS_OFF	((3 << DPMS_OFFSET) | DPMS_USAGE)
+#define DPMS_ON		(DPMS_USAGE)
+#define DPMS_OFF	(DPMS_USAGE | (0x3 << DPMS_OFFSET))
 
 /*
  * LCD1 means panel path TFT1  & panel path DVI (so enable DAC)
-- 
1.8.3.1

