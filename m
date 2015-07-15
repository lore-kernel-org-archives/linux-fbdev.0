From: Juston Li <juston.h.li@gmail.com>
Date: Wed, 15 Jul 2015 04:14:41 +0000
Subject: [PATCH v5 12/19] staging: sm750fb: add spaces around operators
Message-Id: <1436933688-5408-12-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
In-Reply-To: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

Fixes checkpath.pl error:
ERROR: spaces required around that operator

Note running checkpatch.pl with '--strict' catches more
of these errors along with cases where spacing is optional
but preferred. Take care of these in a future patch.

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c  |  2 +-
 drivers/staging/sm750fb/ddk750_power.c |  2 +-
 drivers/staging/sm750fb/sm750.h        |  2 +-
 drivers/staging/sm750fb/sm750_accel.c  |  4 ++--
 drivers/staging/sm750fb/sm750_cursor.c | 12 ++++++------
 drivers/staging/sm750fb/sm750_help.h   |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 633201e..d7435d7 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -471,7 +471,7 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 			M = quo*X;
 			M += fl_quo * X / 10000;
 			/* round step */
-			M += (fl_quo*X % 10000)>5000?1:0;
+			M += (fl_quo*X % 10000) > 5000?1:0;
 			if (M < 256 && M > 0) {
 				unsigned int diff;
 				tmpClock = pll->inputFreq * M / N / X;
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index 5f697b8..28d4402 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -10,7 +10,7 @@ void ddk750_setDPMS(DPMS_t state)
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(value, CRT_DISPLAY_CTRL, DPMS, state));
 	} else {
 		value = PEEK32(SYSTEM_CTRL);
-		value= FIELD_VALUE(value, SYSTEM_CTRL, DPMS, state);
+		value = FIELD_VALUE(value, SYSTEM_CTRL, DPMS, state);
 		POKE32(SYSTEM_CTRL, value);
 	}
 }
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index ae872bd..d6916fd 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -172,7 +172,7 @@ struct lynxfb_par {
 
 static inline unsigned long ps_to_hz(unsigned int psvalue)
 {
-	unsigned long long numerator00*1000*1000*1000ULL;
+	unsigned long long numerator = 1000*1000*1000*1000ULL;
 	/* 10^12 / picosecond period gives frequency in Hz */
 	do_div(numerator, psvalue);
 	return (unsigned long)numerator;
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index afe73e8..0cfe96c 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -414,10 +414,10 @@ int hw_imageblit(struct lynx_accel *accel,
 	write_dpr(accel, DE_CONTROL, de_ctrl | deGetTransparency(accel));
 
 	/* Write MONO data (line by line) to 2D Engine data port */
-	for (i=0; i<height; i++)
+	for (i = 0; i < height; i++)
 	{
 		/* For each line, send the data in chunks of 4 bytes */
-		for (j=0; j<(ul4BytesPerScan/4); j++)
+		for (j = 0; j < (ul4BytesPerScan/4); j++)
 		{
 			write_dpPort(accel, *(unsigned int *)(pSrcbuf + (j * 4)));
 		}
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 2fcec32..9dabac1 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -122,7 +122,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 		odd=0;
 */
 
-	for (i=0;i<count;i++)
+	for (i = 0;i < count;i++)
 	{
 		color = *pcol++;
 		mask = *pmsk++;
@@ -137,7 +137,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 		else
 			opr = mask & color;
 
-		for (j=0;j<8;j++)
+		for (j = 0;j < 8;j++)
 		{
 
 			if (opr & (0x80 >> j))
@@ -149,7 +149,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 			}
 		}
 #else
-		for (j=0;j<8;j++) {
+		for (j = 0;j < 8;j++) {
 			if (mask & (0x80>>j)) {
 				if (rop = ROP_XOR)
 					opr = mask ^ color;
@@ -204,7 +204,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 	pstart = cursor->vstart;
 	pbuffer = pstart;
 
-	for (i=0;i<count;i++)
+	for (i = 0;i < count;i++)
 	{
 		color = *pcol++;
 		mask = *pmsk++;
@@ -217,7 +217,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 		else
 			opr = mask & color;
 
-		for (j=0;j<8;j++)
+		for (j = 0;j < 8;j++)
 		{
 
 			if (opr & (0x80 >> j))
@@ -229,7 +229,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 			}
 		}
 #else
-		for (j=0;j<8;j++) {
+		for (j = 0;j < 8;j++) {
 			if (mask & (1<<j))
 				data |= ((color & (1<<j))?1:2)<<(j*2);
 		}
diff --git a/drivers/staging/sm750fb/sm750_help.h b/drivers/staging/sm750fb/sm750_help.h
index 544ac41..8dc6bd2 100644
--- a/drivers/staging/sm750fb/sm750_help.h
+++ b/drivers/staging/sm750fb/sm750_help.h
@@ -73,7 +73,7 @@
 
 static inline unsigned int absDiff(unsigned int a, unsigned int b)
 {
-	if (a<b)
+	if (a < b)
 		return b-a;
 	else
 		return a-b;
-- 
2.4.5

