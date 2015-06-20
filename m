From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 08:48:33 +0000
Subject: [PATCH 2/4] staging: sm750fb: fix spacing issues
Message-Id: <1434790115-21683-2-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F83JesFGDeEPbcUsMHSuXjeYocZDWyjMfUON02hf3HbCg@mail.gmail.com>
In-Reply-To: <CAFow2F83JesFGDeEPbcUsMHSuXjeYocZDWyjMfUON02hf3HbCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

Fix spacing errors and warnings caught by checkpatch.pl
ERROR: space prohibited after that open parenthesis '('
ERROR: space required before the open brace '{'
ERROR: need consistent spacing around
ERROR: trailing whitespace
WARNING: unnecessary whitespace before a quoted newline

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c    |  14 ++--
 drivers/staging/sm750fb/ddk750_display.c |  22 +++---
 drivers/staging/sm750fb/ddk750_display.h |   6 +-
 drivers/staging/sm750fb/ddk750_dvi.c     |   4 +-
 drivers/staging/sm750fb/ddk750_help.c    |   2 +-
 drivers/staging/sm750fb/ddk750_mode.c    |  16 ++---
 drivers/staging/sm750fb/ddk750_power.c   |  18 ++---
 drivers/staging/sm750fb/sm750.c          |   2 +-
 drivers/staging/sm750fb/sm750.h          |  34 ++++-----
 drivers/staging/sm750fb/sm750_accel.c    |  26 +++----
 drivers/staging/sm750fb/sm750_cursor.c   |  40 +++++------
 drivers/staging/sm750fb/sm750_help.h     |   4 +-
 drivers/staging/sm750fb/sm750_hw.c       | 120 +++++++++++++++----------------
 drivers/staging/sm750fb/sm750_hw.h       |  14 ++--
 14 files changed, 158 insertions(+), 164 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index f4975d2..d7435d7 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -268,7 +268,7 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 #endif
 
 
-	if (pInitParam->powerMode != 0 )
+	if (pInitParam->powerMode != 0)
 		pInitParam->powerMode = 0;
 	setPowerMode(pInitParam->powerMode);
 
@@ -464,17 +464,17 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 		RN = N * request;
 		quo = RN / input;
 		rem = RN % input;/* rem always small than 14318181 */
-		fl_quo = (rem * 10000 /input);
+		fl_quo = (rem * 10000 / input);
 
 		for (d = xcnt - 1; d >= 0; d--) {
 			X = xparm[d].value;
 			M = quo*X;
 			M += fl_quo * X / 10000;
 			/* round step */
-			M += (fl_quo*X % 10000)>5000?1:0;
+			M += (fl_quo*X % 10000) > 5000?1:0;
 			if (M < 256 && M > 0) {
 				unsigned int diff;
-				tmpClock = pll->inputFreq *M / N / X;
+				tmpClock = pll->inputFreq * M / N / X;
 				diff = absDiff(tmpClock, request_orig);
 				if (diff < miniDiff) {
 					pll->M = M;
@@ -599,9 +599,9 @@ unsigned int formatPllReg(pll_value_t *pPLL)
        On returning a 32 bit number, the value can be applied to any PLL in the calling function.
     */
 	ulPllReg -	FIELD_SET(  0, PANEL_PLL_CTRL, BYPASS, OFF)
-	| FIELD_SET(  0, PANEL_PLL_CTRL, POWER,  ON)
-	| FIELD_SET(  0, PANEL_PLL_CTRL, INPUT,  OSC)
+	FIELD_SET(0, PANEL_PLL_CTRL, BYPASS, OFF)
+	| FIELD_SET(0, PANEL_PLL_CTRL, POWER,  ON)
+	| FIELD_SET(0, PANEL_PLL_CTRL, INPUT,  OSC)
 #ifndef VALIDATION_CHIP
 	| FIELD_VALUE(0, PANEL_PLL_CTRL, POD,    pPLL->POD)
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 1c4049f..4a3cb86 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -49,7 +49,7 @@ static void setDisplayControl(int ctrl, int dispState)
 			{
 				cnt++;
 				POKE32(PANEL_DISPLAY_CTRL, ulDisplayCtrlReg);
-			} while((PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits) !+			} while ((PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits) ! 					(ulDisplayCtrlReg & ~ulReservedBits));
 			printk("Set Panel Plane enbit:after tried %d times\n", cnt);
 		}
@@ -104,7 +104,7 @@ static void setDisplayControl(int ctrl, int dispState)
 			{
 				cnt++;
 				POKE32(CRT_DISPLAY_CTRL, ulDisplayCtrlReg);
-			} while((PEEK32(CRT_DISPLAY_CTRL) & ~ulReservedBits) !+			} while ((PEEK32(CRT_DISPLAY_CTRL) & ~ulReservedBits) ! 					(ulDisplayCtrlReg & ~ulReservedBits));
 				printk("Set Crt Plane enbit:after tried %d times\n", cnt);
 		}
@@ -132,7 +132,7 @@ static void setDisplayControl(int ctrl, int dispState)
 static void waitNextVerticalSync(int ctrl, int delay)
 {
 	unsigned int status;
-	if(!ctrl){
+	if (!ctrl) {
 		/* primary controller */
 
 		/* Do not wait when the Primary PLL is off or display control is already off.
@@ -166,7 +166,7 @@ static void waitNextVerticalSync(int ctrl, int delay)
 			while (status = SYSTEM_CTRL_PANEL_VSYNC_INACTIVE);
 		}
 
-	}else{
+	} else {
 
 		/* Do not wait when the Primary PLL is off or display control is already off.
 			   This will prevent the software to wait forever. */
@@ -233,14 +233,14 @@ static void swPanelPowerSequence(int disp, int delay)
 void ddk750_setLogicalDispOut(disp_output_t output)
 {
 	unsigned int reg;
-	if(output & PNL_2_USAGE){
+	if (output & PNL_2_USAGE) {
 		/* set panel path controller select */
 		reg = PEEK32(PANEL_DISPLAY_CTRL);
 		reg = FIELD_VALUE(reg, PANEL_DISPLAY_CTRL, SELECT, (output & PNL_2_MASK)>>PNL_2_OFFSET);
 		POKE32(PANEL_DISPLAY_CTRL, reg);
 	}
 
-	if(output & CRT_2_USAGE){
+	if (output & CRT_2_USAGE) {
 		/* set crt path controller select */
 		reg = PEEK32(CRT_DISPLAY_CTRL);
 		reg = FIELD_VALUE(reg, CRT_DISPLAY_CTRL, SELECT, (output & CRT_2_MASK)>>CRT_2_OFFSET);
@@ -250,25 +250,25 @@ void ddk750_setLogicalDispOut(disp_output_t output)
 
 	}
 
-	if(output & PRI_TP_USAGE){
+	if (output & PRI_TP_USAGE) {
 		/* set primary timing and plane en_bit */
 		setDisplayControl(0, (output&PRI_TP_MASK)>>PRI_TP_OFFSET);
 	}
 
-	if(output & SEC_TP_USAGE){
+	if (output & SEC_TP_USAGE) {
 		/* set secondary timing and plane en_bit*/
 		setDisplayControl(1, (output&SEC_TP_MASK)>>SEC_TP_OFFSET);
 	}
 
-	if(output & PNL_SEQ_USAGE){
+	if (output & PNL_SEQ_USAGE) {
 		/* set  panel sequence */
 		swPanelPowerSequence((output&PNL_SEQ_MASK)>>PNL_SEQ_OFFSET, 4);
 	}
 
-	if(output & DAC_USAGE)
+	if (output & DAC_USAGE)
 		setDAC((output & DAC_MASK)>>DAC_OFFSET);
 
-	if(output & DPMS_USAGE)
+	if (output & DPMS_USAGE)
 		ddk750_setDPMS((output & DPMS_MASK) >> DPMS_OFFSET);
 }
 
diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index 018a661..afdf201 100644
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
@@ -129,7 +129,7 @@ typedef enum _disp_output_t
 }
 disp_output_t;
 #else
-typedef enum _disp_output_t{
+typedef enum _disp_output_t {
 	do_LCD1_PRI = PNL_2_PRI|PRI_TP_ON|PNL_SEQ_ON|DAC_ON,
 	do_LCD1_SEC = PNL_2_SEC|SEC_TP_ON|PNL_SEQ_ON|DAC_ON,
 #if 0
diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 35866fa..c42db85 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -1,4 +1,4 @@
-#define USE_DVICHIP 
+#define USE_DVICHIP
 #ifdef USE_DVICHIP
 #include "ddk750_help.h"
 #include "ddk750_reg.h"
@@ -45,7 +45,7 @@ int dviInit(
 {
 	dvi_ctrl_device_t *pCurrentDviCtrl;
 	pCurrentDviCtrl = g_dcftSupportedDviController;
-	if(pCurrentDviCtrl->pfnInit != NULL)
+	if (pCurrentDviCtrl->pfnInit != NULL)
 	{
 		return pCurrentDviCtrl->pfnInit(edgeSelect, busSelect, dualEdgeClkSelect, hsyncEnable,
 						vsyncEnable, deskewEnable, deskewSetting, continuousSyncEnable,
diff --git a/drivers/staging/sm750fb/ddk750_help.c b/drivers/staging/sm750fb/ddk750_help.c
index 1adcafc..93ed958 100644
--- a/drivers/staging/sm750fb/ddk750_help.c
+++ b/drivers/staging/sm750fb/ddk750_help.c
@@ -10,7 +10,7 @@ void ddk750_set_mmio(void __iomem *addr, unsigned short devId, char revId)
 	mmio750 = addr;
 	devId750 = devId;
 	revId750 = revId;
-	if(revId = 0xfe)
+	if (revId = 0xfe)
 		printk("found sm750le\n");
 }
 
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 1f93d07..d451e7a 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -43,7 +43,7 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 
 	/* Set bit 29:27 of display control register for the right clock */
 	/* Note that SM750LE only need to supported 7 resoluitons. */
-	if ( x = 800 && y = 600 )
+	if (x = 800 && y = 600)
 		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL41);
 	else if (x = 1024 && y = 768)
 		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL65);
@@ -80,7 +80,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 	int ret = 0;
 	int cnt = 0;
 	unsigned int ulTmpValue, ulReg;
-	if(pll->clockType = SECONDARY_PLL)
+	if (pll->clockType = SECONDARY_PLL)
 	{
 		/* programe secondary pixel clock */
 		POKE32(CRT_PLL_CTRL, formatPllReg(pll));
@@ -107,9 +107,9 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 					  FIELD_SET(0, CRT_DISPLAY_CTRL, PLANE, ENABLE);
 
 
-		if(getChipType() = SM750LE){
+		if (getChipType() = SM750LE) {
 			displayControlAdjust_SM750LE(pModeParam, ulTmpValue);
-		}else{
+		} else {
 			ulReg = PEEK32(CRT_DISPLAY_CTRL)
 					& FIELD_CLEAR(CRT_DISPLAY_CTRL, VSYNC_PHASE)
 					& FIELD_CLEAR(CRT_DISPLAY_CTRL, HSYNC_PHASE)
@@ -120,7 +120,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 		}
 
 	}
-	else if(pll->clockType = PRIMARY_PLL)
+	else if (pll->clockType = PRIMARY_PLL)
 	{
 		unsigned int ulReservedBits;
 		POKE32(PANEL_PLL_CTRL, formatPllReg(pll));
@@ -170,10 +170,10 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 
 		POKE32(PANEL_DISPLAY_CTRL, ulTmpValue|ulReg);
 #if 1
-		while((PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits) != (ulTmpValue|ulReg))
+		while ((PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits) != (ulTmpValue|ulReg))
 		{
 			cnt++;
-			if(cnt > 1000)
+			if (cnt > 1000)
 				break;
 			POKE32(PANEL_DISPLAY_CTRL, ulTmpValue|ulReg);
 		}
@@ -193,7 +193,7 @@ int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock)
 	pll.clockType = clock;
 
 	uiActualPixelClk = calcPllValue(parm->pixel_clock, &pll);
-	if(getChipType() = SM750LE){
+	if (getChipType() = SM750LE) {
 		/* set graphic mode via IO method */
 		outb_p(0x88, 0x3d4);
 		outb_p(0x06, 0x3d5);
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index b7a108b..28d4402 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -5,19 +5,19 @@
 void ddk750_setDPMS(DPMS_t state)
 {
 	unsigned int value;
-	if(getChipType() = SM750LE){
+	if (getChipType() = SM750LE) {
 		value = PEEK32(CRT_DISPLAY_CTRL);
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(value, CRT_DISPLAY_CTRL, DPMS, state));
-	}else{
+	} else {
 		value = PEEK32(SYSTEM_CTRL);
-		value= FIELD_VALUE(value, SYSTEM_CTRL, DPMS, state);
+		value = FIELD_VALUE(value, SYSTEM_CTRL, DPMS, state);
 		POKE32(SYSTEM_CTRL, value);
 	}
 }
 
 unsigned int getPowerMode(void)
 {
-	if(getChipType() = SM750LE)
+	if (getChipType() = SM750LE)
 		return 0;
 	return (FIELD_GET(PEEK32(POWER_MODE_CTRL), POWER_MODE_CTRL, MODE));
 }
@@ -33,7 +33,7 @@ void setPowerMode(unsigned int powerMode)
 
 	control_value = PEEK32(POWER_MODE_CTRL);
 
-	if(getChipType() = SM750LE)
+	if (getChipType() = SM750LE)
 		return;
 
 	switch (powerMode)
@@ -59,17 +59,17 @@ void setPowerMode(unsigned int powerMode)
 	{
 		control_value  #ifdef VALIDATION_CHIP
-		FIELD_SET(  control_value, POWER_MODE_CTRL, 336CLK, OFF) |
+		FIELD_SET(control_value, POWER_MODE_CTRL, 336CLK, OFF) |
 #endif
-		FIELD_SET(  control_value, POWER_MODE_CTRL, OSC_INPUT,  OFF);
+		FIELD_SET(control_value, POWER_MODE_CTRL, OSC_INPUT,  OFF);
 	}
 	else
 	{
 		control_value  #ifdef VALIDATION_CHIP
-		FIELD_SET(  control_value, POWER_MODE_CTRL, 336CLK, ON) |
+		FIELD_SET(control_value, POWER_MODE_CTRL, 336CLK, ON) |
 #endif
-		FIELD_SET(  control_value, POWER_MODE_CTRL, OSC_INPUT,  ON);
+		FIELD_SET(control_value, POWER_MODE_CTRL, OSC_INPUT,  ON);
 	}
 
 	/* Program new power mode. */
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8e201f1..1ff14b2 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -967,7 +967,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	var->accel_flags = 0;
 	var->vmode = FB_VMODE_NONINTERLACED;
 
-	pr_debug("#1 show info->cmap : \nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
+	pr_debug("#1 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
 		 info->cmap.start, info->cmap.len,
 		 info->cmap.red, info->cmap.green, info->cmap.blue,
 		 info->cmap.transp);
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index bf894cc..db65621 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -10,11 +10,11 @@
 #define MB(x) ((x)<<20)
 #define MHZ(x) ((x) * 1000000)
 /* align should be 2,4,8,16 */
-#define PADDING(align, data) (((data)+(align)-1)&(~((align) -1)))
+#define PADDING(align, data) (((data)+(align)-1)&(~((align) - 1)))
 extern int smi_indent;
 
 
-struct lynx_accel{
+struct lynx_accel {
 	/* base virtual address of DPR registers */
 	volatile unsigned char __iomem * dprBase;
 	/* base virtual address of de data port */
@@ -41,7 +41,7 @@ struct lynx_accel{
 /* lynx_share stands for a presentation of two frame buffer
    that use one smi adaptor , it is similar to a basic class of C++
 */
-struct lynx_share{
+struct lynx_share {
 	/* common members */
 	u16 devid;
 	u8 revid;
@@ -51,9 +51,9 @@ struct lynx_share{
 	int accel_off;
 	int dual;
 		int mtrr_off;
-		struct{
+		struct {
 			int vram;
-		}mtrr;
+		} mtrr;
 	/* all smi graphic adaptor got below attributes */
 	unsigned long vidmem_start;
 	unsigned long vidreg_start;
@@ -68,7 +68,7 @@ struct lynx_share{
 	void (*resume)(struct lynx_share*);
 };
 
-struct lynx_cursor{
+struct lynx_cursor {
 	/* cursor width ,height and size */
 	int w;
 	int h;
@@ -92,7 +92,7 @@ struct lynx_cursor{
 	void (*setData)(struct lynx_cursor *, u16, const u8*, const u8*);
 };
 
-struct lynxfb_crtc{
+struct lynxfb_crtc {
 	unsigned char __iomem *vCursor; /* virtual address of cursor */
 	unsigned char __iomem *vScreen; /* virtual address of on_screen */
 	int oCursor; /* cursor address offset in vidmem */
@@ -108,12 +108,12 @@ struct lynxfb_crtc{
 
 	void *priv;
 
-	int(*proc_setMode)(struct lynxfb_crtc*,
+	int (*proc_setMode)(struct lynxfb_crtc*,
 						struct fb_var_screeninfo*,
 						struct fb_fix_screeninfo*);
 
-	int(*proc_checkMode)(struct lynxfb_crtc*, struct fb_var_screeninfo*);
-	int(*proc_setColReg)(struct lynxfb_crtc*, ushort, ushort, ushort, ushort);
+	int (*proc_checkMode)(struct lynxfb_crtc*, struct fb_var_screeninfo*);
+	int (*proc_setColReg)(struct lynxfb_crtc*, ushort, ushort, ushort, ushort);
 	void (*clear)(struct lynxfb_crtc*);
         /* pan display */
 	int (*proc_panDisplay)(struct lynxfb_crtc *,
@@ -123,7 +123,7 @@ struct lynxfb_crtc{
 	struct lynx_cursor cursor;
 };
 
-struct lynxfb_output{
+struct lynxfb_output {
 	int dpms;
 	int paths;
 	/* which paths(s) this output stands for,for sm750:
@@ -140,16 +140,16 @@ struct lynxfb_output{
 	*/
 	void *priv;
 
-	int(*proc_setMode)(struct lynxfb_output*,
+	int (*proc_setMode)(struct lynxfb_output*,
 						struct fb_var_screeninfo*,
 						struct fb_fix_screeninfo*);
 
-	int(*proc_checkMode)(struct lynxfb_output*, struct fb_var_screeninfo*);
-	int(*proc_setBLANK)(struct lynxfb_output*, int);
+	int (*proc_checkMode)(struct lynxfb_output*, struct fb_var_screeninfo*);
+	int (*proc_setBLANK)(struct lynxfb_output*, int);
 	void  (*clear)(struct lynxfb_output*);
 };
 
-struct lynxfb_par{
+struct lynxfb_par {
 	/* either 0 or 1 for dual head adaptor,0 is the older one registered */
 	int index;
 	unsigned int pseudo_palette[256];
@@ -168,11 +168,11 @@ struct lynxfb_par{
 			({ \
 			unsigned long long hz = 1000*1000*1000*1000ULL;	\
 			do_div(hz, ps);	\
-			(unsigned long)hz;})
+			(unsigned long)hz; })
 
 static inline unsigned long ps_to_hz(unsigned int psvalue)
 {
-	unsigned long long numerator00*1000*1000*1000ULL;
+	unsigned long long numerator = 1000*1000*1000*1000ULL;
 	/* 10^12 / picosecond period gives frequency in Hz */
 	do_div(numerator, psvalue);
 	return (unsigned long)numerator;
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 806aeed..391fced 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -37,7 +37,7 @@ void hw_de_init(struct lynx_accel *accel)
 {
 	/* setup 2d engine registers */
 	u32 reg, clr;
-	
+
 	write_dpr(accel, DE_MASKS, 0xFFFFFFFF);
 
 	/* dpr1c */
@@ -82,7 +82,7 @@ void hw_de_init(struct lynx_accel *accel)
 void hw_set2dformat(struct lynx_accel *accel, int fmt)
 {
 	u32 reg;
-	
+
 	/* fmt=0,1,2 for 8,16,32,bpp on sm718/750/502 */
 	reg = read_dpr(accel, DE_STRETCH_FORMAT);
 	reg = FIELD_VALUE(reg, DE_STRETCH_FORMAT, PIXEL_FORMAT, fmt);
@@ -96,7 +96,7 @@ int hw_fillrect(struct lynx_accel *accel,
 {
 	u32 deCtrl;
 
-	if(accel->de_wait() != 0)
+	if (accel->de_wait() != 0)
 	{
 		/* int time wait and always busy,seems hardware
 		 * got something error */
@@ -247,7 +247,7 @@ unsigned int rop2)   /* ROP value */
        Note that input pitch is BYTE value, but the 2D Pitch register uses
        pixel values. Need Byte to pixel conversion.
     */
-	if(Bpp = 3){
+	if (Bpp = 3) {
 			sx *= 3;
 			dx *= 3;
 			width *= 3;
@@ -270,16 +270,16 @@ unsigned int rop2)   /* ROP value */
 	FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPitch/Bpp)) |
 	FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (sPitch/Bpp))); /* dpr3c */
 
-	if (accel->de_wait() != 0){
+	if (accel->de_wait() != 0) {
 		return -1;
 	}
 
 	write_dpr(accel, DE_SOURCE,
-		  FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
+		  FIELD_SET(0, DE_SOURCE, WRAP, DISABLE) |
 		  FIELD_VALUE(0, DE_SOURCE, X_K1, sx)   |
 		  FIELD_VALUE(0, DE_SOURCE, Y_K2, sy)); /* dpr0 */
 	write_dpr(accel, DE_DESTINATION,
-		  FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
+		  FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE) |
 		  FIELD_VALUE(0, DE_DESTINATION, X,    dx)  |
 		  FIELD_VALUE(0, DE_DESTINATION, Y,    dy)); /* dpr04 */
 	write_dpr(accel, DE_DIMENSION,
@@ -338,7 +338,7 @@ int hw_imageblit(struct lynx_accel *accel,
 	ul4BytesPerScan = ulBytesPerScan & ~3;
 	ulBytesRemain = ulBytesPerScan & 3;
 
-	if(accel->de_wait() != 0)
+	if (accel->de_wait() != 0)
 	{
 		return -1;
 	}
@@ -357,7 +357,7 @@ int hw_imageblit(struct lynx_accel *accel,
        Note that input pitch is BYTE value, but the 2D Pitch register uses
        pixel values. Need Byte to pixel conversion.
     */
-	if(bytePerPixel = 3 ){
+	if (bytePerPixel = 3) {
 		dx *= 3;
 		width *= 3;
 		startBit *= 3;
@@ -384,11 +384,11 @@ int hw_imageblit(struct lynx_accel *accel,
 	 /* Note: For 2D Source in Host Write, only X_K1_MONO field is needed, and Y_K2 field is not used.
 	    For mono bitmap, use startBit for X_K1. */
 	write_dpr(accel, DE_SOURCE,
-		  FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE)       |
+		  FIELD_SET(0, DE_SOURCE, WRAP, DISABLE)       |
 		  FIELD_VALUE(0, DE_SOURCE, X_K1_MONO, startBit)); /* dpr00 */
 
 	write_dpr(accel, DE_DESTINATION,
-		  FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
+		  FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE) |
 		  FIELD_VALUE(0, DE_DESTINATION, X,    dx)    |
 		  FIELD_VALUE(0, DE_DESTINATION, Y,    dy)); /* dpr04 */
 
@@ -408,10 +408,10 @@ int hw_imageblit(struct lynx_accel *accel,
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
index 405e24b..4ed7ca2 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -122,7 +122,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 		odd=0;
 */
 
-	for(i=0;i<count;i++)
+	for (i = 0; i < count; i++)
 	{
 		color = *pcol++;
 		mask = *pmsk++;
@@ -132,26 +132,26 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 		 * but method 2 shows no lag
 		 * and method 1 seems a bit wrong*/
 #if 0
-		if(rop = ROP_XOR)
+		if (rop = ROP_XOR)
 			opr = mask ^ color;
 		else
 			opr = mask & color;
 
-		for(j=0;j<8;j++)
+		for (j = 0; j < 8; j++)
 		{
 
-			if(opr & (0x80 >> j))
+			if (opr & (0x80 >> j))
 			{	/* use fg color,id = 2 */
 				data |= 2 << (j*2);
-			}else{
+			} else {
 				/* use bg color,id = 1 */
 				data |= 1 << (j*2);
 			}
 		}
 #else
-		for(j=0;j<8;j++){
-			if(mask & (0x80>>j)){
-				if(rop = ROP_XOR)
+		for (j = 0; j < 8; j++) {
+			if (mask & (0x80>>j)) {
+				if (rop = ROP_XOR)
 					opr = mask ^ color;
 				else
 					opr = mask & color;
@@ -165,15 +165,15 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 
 		/* assume pitch is 1,2,4,8,...*/
 #if 0
-		if(!((i+1)&(pitch-1)))   /* below line equal to is line */
+		if (!((i+1)&(pitch-1)))   /* below line equal to is line */
 #else
-		if((i+1) % pitch = 0)
+		if ((i+1) % pitch = 0)
 #endif
 		{
 			/* need a return */
 			pstart += offset;
 			pbuffer = pstart;
-		}else{
+		} else {
 			pbuffer += sizeof(u16);
 		}
 
@@ -204,7 +204,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 	pstart = cursor->vstart;
 	pbuffer = pstart;
 
-	for(i=0;i<count;i++)
+	for (i = 0; i < count; i++)
 	{
 		color = *pcol++;
 		mask = *pmsk++;
@@ -212,37 +212,37 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 
 		/* either method below works well, but method 2 shows no lag */
 #if 0
-		if(rop = ROP_XOR)
+		if (rop = ROP_XOR)
 			opr = mask ^ color;
 		else
 			opr = mask & color;
 
-		for(j=0;j<8;j++)
+		for (j = 0; j < 8; j++)
 		{
 
-			if(opr & (0x80 >> j))
+			if (opr & (0x80 >> j))
 			{	/* use fg color,id = 2 */
 				data |= 2 << (j*2);
-			}else{
+			} else {
 				/* use bg color,id = 1 */
 				data |= 1 << (j*2);
 			}
 		}
 #else
-		for(j=0;j<8;j++){
-			if(mask & (1<<j))
+		for (j = 0; j < 8; j++) {
+			if (mask & (1<<j))
 				data |= ((color & (1<<j))?1:2)<<(j*2);
 		}
 #endif
 		iowrite16(data, pbuffer);
 
 		/* assume pitch is 1,2,4,8,...*/
-		if(!(i&(pitch-1)))
+		if (!(i&(pitch-1)))
 		{
 			/* need a return */
 			pstart += offset;
 			pbuffer = pstart;
-		}else{
+		} else {
 			pbuffer += sizeof(u16);
 		}
 
diff --git a/drivers/staging/sm750fb/sm750_help.h b/drivers/staging/sm750fb/sm750_help.h
index 8ba4f8d..e7d74e6 100644
--- a/drivers/staging/sm750fb/sm750_help.h
+++ b/drivers/staging/sm750fb/sm750_help.h
@@ -43,7 +43,7 @@
 
 #define FIELD_CLEAR(reg, field) \
 ( \
-	~ _F_MASK(reg ## _ ## field) \
+	~_F_MASK(reg ## _ ## field) \
 )
 
 /* Field Macros */
@@ -73,7 +73,7 @@
 
 static inline unsigned int absDiff(unsigned int a, unsigned int b)
 {
-	if(a<b)
+	if (a < b)
 		return b-a;
 	else
 		return a-b;
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 28db9c7..af7ea2e 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -28,7 +28,6 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 {
 	int ret;
 	struct sm750_share *spec_share;
-	
 
 	spec_share = container_of(share, struct sm750_share, share);
 	ret = 0;
@@ -44,7 +43,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 	 * successfully
 	 * */
 
-	if((ret = pci_request_region(pdev, 1, "sm750fb")))
+	if ((ret = pci_request_region(pdev, 1, "sm750fb")))
 	{
 		pr_err("Can not request PCI regions.\n");
 		goto exit;
@@ -52,15 +51,15 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 
 	/* now map mmio and vidmem*/
 	share->pvReg = ioremap_nocache(share->vidreg_start, share->vidreg_size);
-	if(!share->pvReg){
+	if (!share->pvReg) {
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
-	}else{
+	} else {
 		pr_info("mmio virtual addr = %p\n", share->pvReg);
 	}
 
-	
+
 	share->accel.dprBase = share->pvReg + DE_BASE_ADDR_TYPE1;
 	share->accel.dpPortBase = share->pvReg + DE_PORT_ADDR_TYPE1;
 
@@ -78,7 +77,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 
 	/* reserve the vidmem space of smi adaptor */
 #if 0
-	if((ret = pci_request_region(pdev, 0, _moduleName_)))
+	if ((ret = pci_request_region(pdev, 0, _moduleName_)))
 	{
 		pr_err("Can not request PCI regions.\n");
 		goto exit;
@@ -87,11 +86,11 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 
 	share->pvMem = ioremap_wc(share->vidmem_start, share->vidmem_size);
 
-	if(!share->pvMem){
+	if (!share->pvMem) {
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
-	}else{
+	} else {
 		pr_info("video memory vaddr = %p\n", share->pvMem);
 	}
 exit:
@@ -104,22 +103,22 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 {
 	struct sm750_share *spec_share;
 	struct init_status *parm;
-	
+
 	spec_share = container_of(share, struct sm750_share, share);
 	parm = &spec_share->state.initParm;
-	if(parm->chip_clk = 0)
-		parm->chip_clk = (getChipType() = SM750LE)?
+	if (parm->chip_clk = 0)
+		parm->chip_clk = (getChipType() = SM750LE) ?
 						DEFAULT_SM750LE_CHIP_CLOCK :
 						DEFAULT_SM750_CHIP_CLOCK;
 
-	if(parm->mem_clk = 0)
+	if (parm->mem_clk = 0)
 		parm->mem_clk = parm->chip_clk;
-	if(parm->master_clk = 0)
+	if (parm->master_clk = 0)
 		parm->master_clk = parm->chip_clk/3;
 
 	ddk750_initHw((initchip_param_t *)&spec_share->state.initParm);
 	/* for sm718,open pci burst */
-	if(share->devid = 0x718){
+	if (share->devid = 0x718) {
 		POKE32(SYSTEM_CTRL,
 				FIELD_SET(PEEK32(SYSTEM_CTRL), SYSTEM_CTRL, PCI_BURST, ON));
 	}
@@ -130,10 +129,10 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	ddk750_initDVIDisp();
 #endif
 
-	if(getChipType() != SM750LE)
+	if (getChipType() != SM750LE)
 	{
 		/* does user need CRT ?*/
-		if(spec_share->state.nocrt){
+		if (spec_share->state.nocrt) {
 			POKE32(MISC_CTRL,
 					FIELD_SET(PEEK32(MISC_CTRL),
 					MISC_CTRL,
@@ -143,7 +142,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 					FIELD_SET(PEEK32(SYSTEM_CTRL),
 					SYSTEM_CTRL,
 					DPMS, VNHN));
-		}else{
+		} else {
 			POKE32(MISC_CTRL,
 					FIELD_SET(PEEK32(MISC_CTRL),
 					MISC_CTRL,
@@ -155,7 +154,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 					DPMS, VPHP));
 		}
 
-		switch (spec_share->state.pnltype){
+		switch (spec_share->state.pnltype) {
 			case sm750_doubleTFT:
 			case sm750_24TFT:
 			case sm750_dualTFT:
@@ -166,7 +165,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 							spec_share->state.pnltype));
 			break;
 		}
-	}else{
+	} else {
 		/* for 750LE ,no DVI chip initilization makes Monitor no signal */
 		/* Set up GPIO for software I2C to program DVI chip in the
 		   Xilinx SP605 board, in order to have video signal.
@@ -191,7 +190,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	}
 
 	/* init 2d engine */
-	if(!share->accel_off){
+	if (!share->accel_off) {
 		hw_sm750_initAccel(share);
 	}
 
@@ -202,7 +201,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 resource_size_t hw_sm750_getVMSize(struct lynx_share *share)
 {
 	resource_size_t ret;
-	
+
 	ret = ddk750_getVMSize();
 	return ret;
 }
@@ -211,7 +210,6 @@ resource_size_t hw_sm750_getVMSize(struct lynx_share *share)
 
 int hw_sm750_output_checkMode(struct lynxfb_output* output, struct fb_var_screeninfo* var)
 {
-	
 	return 0;
 }
 
@@ -222,30 +220,30 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 	int ret;
 	disp_output_t dispSet;
 	int channel;
-	
+
 	ret = 0;
 	dispSet = 0;
 	channel = *output->channel;
 
 
-	if(getChipType() != SM750LE){
-		if(channel = sm750_primary){
+	if (getChipType() != SM750LE) {
+		if (channel = sm750_primary) {
 			pr_info("primary channel\n");
-			if(output->paths & sm750_panel)
+			if (output->paths & sm750_panel)
 				dispSet |= do_LCD1_PRI;
-			if(output->paths & sm750_crt)
+			if (output->paths & sm750_crt)
 				dispSet |= do_CRT_PRI;
 
-		}else{
+		} else {
 			pr_info("secondary channel\n");
-			if(output->paths & sm750_panel)
+			if (output->paths & sm750_panel)
 				dispSet |= do_LCD1_SEC;
-			if(output->paths & sm750_crt)
+			if (output->paths & sm750_crt)
 				dispSet |= do_CRT_SEC;
 
 		}
 		ddk750_setLogicalDispOut(dispSet);
-	}else{
+	} else {
 		/* just open DISPLAY_CONTROL_750LE register bit 3:0*/
 		u32 reg;
 		reg = PEEK32(DISPLAY_CONTROL_750LE);
@@ -253,24 +251,22 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 		POKE32(DISPLAY_CONTROL_750LE, reg);
 	}
 
-	pr_info("ddk setlogicdispout done \n");
+	pr_info("ddk setlogicdispout done\n");
 	return ret;
 }
 
 void hw_sm750_output_clear(struct lynxfb_output* output)
 {
-	
 	return;
 }
 
 int hw_sm750_crtc_checkMode(struct lynxfb_crtc* crtc, struct fb_var_screeninfo* var)
 {
 	struct lynx_share *share;
-	
 
 	share = container_of(crtc, struct lynxfb_par, crtc)->share;
 
-	switch (var->bits_per_pixel){
+	switch (var->bits_per_pixel) {
 		case 8:
 		case 16:
 			break;
@@ -303,14 +299,13 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 	struct lynx_share *share;
 	struct lynxfb_par *par;
 
-	
 	ret = 0;
 	par = container_of(crtc, struct lynxfb_par, crtc);
 	share = par->share;
 #if 1
-	if(!share->accel_off){
+	if (!share->accel_off) {
 		/* set 2d engine pixel format according to mode bpp */
-		switch(var->bits_per_pixel){
+		switch (var->bits_per_pixel) {
 			case 8:
 				fmt = 0;
 				break;
@@ -330,7 +325,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 	modparm.pixel_clock = ps_to_hz(var->pixclock);
 	modparm.vertical_sync_polarity = (var->sync & FB_SYNC_HOR_HIGH_ACT) ? POS:NEG;
 	modparm.horizontal_sync_polarity = (var->sync & FB_SYNC_VERT_HIGH_ACT) ? POS:NEG;
-	modparm.clock_phase_polarity = (var->sync& FB_SYNC_COMP_HIGH_ACT) ? POS:NEG;
+	modparm.clock_phase_polarity = (var->sync & FB_SYNC_COMP_HIGH_ACT) ? POS:NEG;
 	modparm.horizontal_display_end = var->xres;
 	modparm.horizontal_sync_width = var->hsync_len;
 	modparm.horizontal_sync_start = var->xres + var->right_margin;
@@ -341,19 +336,19 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 	modparm.vertical_total = var->yres + var->upper_margin + var->lower_margin + var->vsync_len;
 
 	/* choose pll */
-	if(crtc->channel != sm750_secondary)
+	if (crtc->channel != sm750_secondary)
 		clock = PRIMARY_PLL;
 	else
 		clock = SECONDARY_PLL;
 
 	pr_debug("Request pixel clock = %lu\n", modparm.pixel_clock);
 	ret = ddk750_setModeTiming(&modparm, clock);
-	if(ret){
+	if (ret) {
 		pr_err("Set mode timing failed\n");
 		goto exit;
 	}
 
-	if(crtc->channel != sm750_secondary){
+	if (crtc->channel != sm750_secondary) {
 		/* set pitch, offset ,width,start address ,etc... */
 		POKE32(PANEL_FB_ADDRESS,
 			FIELD_SET(0, PANEL_FB_ADDRESS, STATUS, CURRENT)|
@@ -369,7 +364,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 			FIELD_VALUE(0, PANEL_FB_WIDTH, OFFSET, fix->line_length));
 
 		POKE32(PANEL_WINDOW_WIDTH,
-			FIELD_VALUE(0, PANEL_WINDOW_WIDTH, WIDTH, var->xres -1)|
+			FIELD_VALUE(0, PANEL_WINDOW_WIDTH, WIDTH, var->xres - 1)|
 			FIELD_VALUE(0, PANEL_WINDOW_WIDTH, X, var->xoffset));
 
 		POKE32(PANEL_WINDOW_HEIGHT,
@@ -389,7 +384,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 			PANEL_DISPLAY_CTRL, FORMAT,
 			(var->bits_per_pixel >> 4)
 			));
-	}else{
+	} else {
 		/* not implemented now */
 		POKE32(CRT_FB_ADDRESS, crtc->oScreen);
 		reg = var->xres * (var->bits_per_pixel >> 3);
@@ -414,22 +409,21 @@ exit:
 
 void hw_sm750_crtc_clear(struct lynxfb_crtc* crtc)
 {
-	
 	return;
 }
 
 int hw_sm750_setColReg(struct lynxfb_crtc* crtc, ushort index,
 								ushort red, ushort green, ushort blue)
 {
-	static unsigned int add[]={PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
+	static unsigned int add[] = {PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
 	POKE32(add[crtc->channel] + index*4, (red<<16)|(green<<8)|blue);
 	return 0;
 }
 
-int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank){
+int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank) {
 	int dpms, crtdb;
-	
-	switch(blank)
+
+	switch (blank)
 	{
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
 		case FB_BLANK_UNBLANK:
@@ -473,7 +467,7 @@ int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank){
 			return -EINVAL;
 	}
 
-	if(output->paths & sm750_crt){
+	if (output->paths & sm750_crt) {
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, DPMS, dpms));
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, BLANK, crtdb));
 	}
@@ -483,7 +477,7 @@ int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank){
 int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
 {
 	unsigned int dpms, pps, crtdb;
-	
+
 	dpms = pps = crtdb = 0;
 
 	switch (blank)
@@ -493,14 +487,14 @@ int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
 #else
 		case VESA_NO_BLANKING:
 #endif
-			pr_info("flag = FB_BLANK_UNBLANK \n");
+			pr_info("flag = FB_BLANK_UNBLANK\n");
 			dpms = SYSTEM_CTRL_DPMS_VPHP;
 			pps = PANEL_DISPLAY_CTRL_DATA_ENABLE;
 			crtdb = CRT_DISPLAY_CTRL_BLANK_OFF;
 			break;
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
 		case FB_BLANK_NORMAL:
-			pr_info("flag = FB_BLANK_NORMAL \n");
+			pr_info("flag = FB_BLANK_NORMAL\n");
 			dpms = SYSTEM_CTRL_DPMS_VPHP;
 			pps = PANEL_DISPLAY_CTRL_DATA_DISABLE;
 			crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
@@ -535,13 +529,13 @@ int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
 			break;
 	}
 
-	if(output->paths & sm750_crt){
+	if (output->paths & sm750_crt) {
 
 		POKE32(SYSTEM_CTRL, FIELD_VALUE(PEEK32(SYSTEM_CTRL), SYSTEM_CTRL, DPMS, dpms));
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, BLANK, crtdb));
 	}
 
-	if(output->paths & sm750_panel){
+	if (output->paths & sm750_panel) {
 		POKE32(PANEL_DISPLAY_CTRL, FIELD_VALUE(PEEK32(PANEL_DISPLAY_CTRL), PANEL_DISPLAY_CTRL, DATA, pps));
 	}
 
@@ -554,7 +548,7 @@ void hw_sm750_initAccel(struct lynx_share *share)
 	u32 reg;
 	enable2DEngine(1);
 
-	if(getChipType() = SM750LE){
+	if (getChipType() = SM750LE) {
 		reg = PEEK32(DE_STATE1);
 		reg = FIELD_SET(reg, DE_STATE1, DE_ABORT, ON);
 		POKE32(DE_STATE1, reg);
@@ -563,7 +557,7 @@ void hw_sm750_initAccel(struct lynx_share *share)
 		reg = FIELD_SET(reg, DE_STATE1, DE_ABORT, OFF);
 		POKE32(DE_STATE1, reg);
 
-	}else{
+	} else {
 		/* engine reset */
 		reg = PEEK32(SYSTEM_CTRL);
 	    reg = FIELD_SET(reg, SYSTEM_CTRL, DE_ABORT, ON);
@@ -580,10 +574,10 @@ void hw_sm750_initAccel(struct lynx_share *share)
 
 int hw_sm750le_deWait(void)
 {
-	int i=0x10000000;
-	while(i--){
+	int i = 0x10000000;
+	while (i--) {
 		unsigned int dwVal = PEEK32(DE_STATE2);
-		if((FIELD_GET(dwVal, DE_STATE2, DE_STATUS) = DE_STATE2_DE_STATUS_IDLE) &&
+		if ((FIELD_GET(dwVal, DE_STATE2, DE_STATUS) = DE_STATE2_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, DE_STATE2, DE_FIFO)  = DE_STATE2_DE_FIFO_EMPTY) &&
 			(FIELD_GET(dwVal, DE_STATE2, DE_MEM_FIFO) = DE_STATE2_DE_MEM_FIFO_EMPTY))
 		{
@@ -597,10 +591,10 @@ int hw_sm750le_deWait(void)
 
 int hw_sm750_deWait(void)
 {
-	int i=0x10000000;
-	while(i--){
+	int i = 0x10000000;
+	while (i--) {
 		unsigned int dwVal = PEEK32(SYSTEM_CTRL);
-		if((FIELD_GET(dwVal, SYSTEM_CTRL, DE_STATUS) = SYSTEM_CTRL_DE_STATUS_IDLE) &&
+		if ((FIELD_GET(dwVal, SYSTEM_CTRL, DE_STATUS) = SYSTEM_CTRL_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_FIFO)  = SYSTEM_CTRL_DE_FIFO_EMPTY) &&
 			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_MEM_FIFO) = SYSTEM_CTRL_DE_MEM_FIFO_EMPTY))
 		{
diff --git a/drivers/staging/sm750fb/sm750_hw.h b/drivers/staging/sm750fb/sm750_hw.h
index adc61edf..ef0a16f 100644
--- a/drivers/staging/sm750fb/sm750_hw.h
+++ b/drivers/staging/sm750fb/sm750_hw.h
@@ -9,7 +9,7 @@
 #endif
 
 
-enum sm750_pnltype{
+enum sm750_pnltype {
 
 	sm750_24TFT = 0,/* 24bit tft */
 
@@ -19,7 +19,7 @@ enum sm750_pnltype{
 };
 
 /* vga channel is not concerned  */
-enum sm750_dataflow{
+enum sm750_dataflow {
 	sm750_simul_pri,/* primary => all head */
 
 	sm750_simul_sec,/* secondary => all head */
@@ -30,19 +30,19 @@ enum sm750_dataflow{
 };
 
 
-enum sm750_channel{
+enum sm750_channel {
 	sm750_primary = 0,
 	/* enum value equal to the register filed data */
 	sm750_secondary = 1,
 };
 
-enum sm750_path{
+enum sm750_path {
 	sm750_panel = 1,
 	sm750_crt = 2,
 	sm750_pnc = 3,/* panel and crt */
 };
 
-struct init_status{
+struct init_status {
 	ushort powerMode;
 	/* below three clocks are in unit of MHZ*/
 	ushort chip_clk;
@@ -52,7 +52,7 @@ struct init_status{
 	ushort resetMemory;
 };
 
-struct sm750_state{
+struct sm750_state {
 	struct init_status initParm;
 	enum sm750_pnltype pnltype;
 	enum sm750_dataflow dataflow;
@@ -66,7 +66,7 @@ struct sm750_state{
    in C++
  */
 
-struct sm750_share{
+struct sm750_share {
 	/* it's better to put lynx_share struct to the first place of sm750_share */
 	struct lynx_share share;
 	struct sm750_state state;
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
