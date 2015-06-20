From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 18:36:46 +0000
Subject: [PATCH 12/19] staging: sm750fb: add spaces around operators
Message-Id: <1434825413-4994-12-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
In-Reply-To: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

fixes checkpath.pl error:
ERROR: spaces required around that ''

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c  |  2 +-
 drivers/staging/sm750fb/ddk750_power.c |  2 +-
 drivers/staging/sm750fb/sm750.h        |  2 +-
 drivers/staging/sm750fb/sm750_accel.c  |  4 ++--
 drivers/staging/sm750fb/sm750_cursor.c | 12 ++++++------
 drivers/staging/sm750fb/sm750_help.h   |  2 +-
 drivers/staging/sm750fb/sm750_hw.c     |  8 ++++----
 7 files changed, 16 insertions(+), 16 deletions(-)

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
index b0ff0b5..4f56dcb 100644
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
index 25dc15b..2ea447e 100644
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
index 493af3a..e7d74e6 100644
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
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 7a5d522..4941e2a 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -108,7 +108,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	spec_share = container_of(share, struct sm750_share, share);
 	parm = &spec_share->state.initParm;
 	if (parm->chip_clk = 0)
-		parm->chip_clk = (getChipType() = SM750LE)?
+		parm->chip_clk = (getChipType() = SM750LE) ?
 						DEFAULT_SM750LE_CHIP_CLOCK :
 						DEFAULT_SM750_CHIP_CLOCK;
 
@@ -421,7 +421,7 @@ void hw_sm750_crtc_clear(struct lynxfb_crtc* crtc)
 int hw_sm750_setColReg(struct lynxfb_crtc* crtc, ushort index,
 								ushort red, ushort green, ushort blue)
 {
-	static unsigned int add[]={PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
+	static unsigned int add[] = {PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
 	POKE32(add[crtc->channel] + index*4, (red<<16)|(green<<8)|blue);
 	return 0;
 }
@@ -580,7 +580,7 @@ void hw_sm750_initAccel(struct lynx_share *share)
 
 int hw_sm750le_deWait(void)
 {
-	int i=0x10000000;
+	int i = 0x10000000;
 	while (i--) {
 		unsigned int dwVal = PEEK32(DE_STATE2);
 		if ((FIELD_GET(dwVal, DE_STATE2, DE_STATUS) = DE_STATE2_DE_STATUS_IDLE) &&
@@ -597,7 +597,7 @@ int hw_sm750le_deWait(void)
 
 int hw_sm750_deWait(void)
 {
-	int i=0x10000000;
+	int i = 0x10000000;
 	while (i--) {
 		unsigned int dwVal = PEEK32(SYSTEM_CTRL);
 		if ((FIELD_GET(dwVal, SYSTEM_CTRL, DE_STATUS) = SYSTEM_CTRL_DE_STATUS_IDLE) &&
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
