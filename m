From: Juston Li <juston.h.li@gmail.com>
Date: Wed, 15 Jul 2015 04:14:40 +0000
Subject: [PATCH v5 11/19] staging: sm750fb: consistent spacing around operators
Message-Id: <1436933688-5408-11-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
In-Reply-To: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

Fixes checkpatch.pl error:
ERROR: need consistent spacing around operator

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c    | 4 ++--
 drivers/staging/sm750fb/ddk750_display.h | 4 ++--
 drivers/staging/sm750fb/sm750.h          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

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
index 2d04c0f..ae872bd 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -10,7 +10,7 @@
 #define MB(x) ((x)<<20)
 #define MHZ(x) ((x) * 1000000)
 /* align should be 2,4,8,16 */
-#define PADDING(align, data) (((data)+(align)-1)&(~((align) -1)))
+#define PADDING(align, data) (((data)+(align)-1)&(~((align) - 1)))
 extern int smi_indent;
 
 
-- 
2.4.5

