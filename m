From: Brian Stottler <brianstottler@gmail.com>
Date: Mon, 31 Aug 2015 01:42:53 +0000
Subject: [PATCHv2] staging: sm750fb: fix improper typedef usage
Message-Id: <20150831014253.GB10267@brian_archtop.etown.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fix typedef usage which does not comply with kernel style guidelines.

Signed-off-by: Brian Stottler <brianstottler@gmail.com>
---
v2: Recreated patch against proper source tree

 drivers/staging/sm750fb/ddk750_chip.c    | 31 ++++++++++++++---------------
 drivers/staging/sm750fb/ddk750_chip.h    | 34 ++++++++++++++------------------
 drivers/staging/sm750fb/ddk750_display.c |  2 +-
 drivers/staging/sm750fb/ddk750_display.h | 12 +++++------
 drivers/staging/sm750fb/ddk750_dvi.c     | 12 +++++------
 drivers/staging/sm750fb/ddk750_dvi.h     |  4 ++--
 drivers/staging/sm750fb/ddk750_mode.c    |  8 ++++----
 drivers/staging/sm750fb/ddk750_mode.h    | 18 ++++++++---------
 drivers/staging/sm750fb/ddk750_power.c   |  2 +-
 drivers/staging/sm750fb/ddk750_power.h   |  7 +++----
 drivers/staging/sm750fb/ddk750_sii164.c  |  2 +-
 drivers/staging/sm750fb/ddk750_sii164.h  |  4 ++--
 drivers/staging/sm750fb/sm750_hw.c       |  8 ++++----
 13 files changed, 67 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 5e6798e..20f2630 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -2,20 +2,19 @@
 #include "ddk750_reg.h"
 #include "ddk750_chip.h"
 #include "ddk750_power.h"
-typedef struct _pllcalparam {
+struct pllcalparam {
 	unsigned char power;/* d : 0~ 6*/
 	unsigned char pod;
 	unsigned char od;
 	unsigned char value;/* value of  2 power d (2^d) */
-}
-pllcalparam;
+};
 
 
-logical_chip_type_t getChipType(void)
+enum logical_chip_type_t getChipType(void)
 {
 	unsigned short physicalID;
 	char physicalRev;
-	logical_chip_type_t chip;
+	enum logical_chip_type_t chip;
 
 	physicalID = devId750; /* either 0x718 or 0x750 */
 	physicalRev = revId750;
@@ -44,12 +43,12 @@ inline unsigned int twoToPowerOfx(unsigned long x)
 	return result;
 }
 
-inline unsigned int calcPLL(pll_value_t *pPLL)
+inline unsigned int calcPLL(struct pll_value_t *pPLL)
 {
 	return (pPLL->inputFreq * pPLL->M / pPLL->N / twoToPowerOfx(pPLL->OD) / twoToPowerOfx(pPLL->POD));
 }
 
-unsigned int getPllValue(clock_type_t clockType, pll_value_t *pPLL)
+unsigned int getPllValue(enum clock_type_t clockType, struct pll_value_t *pPLL)
 {
 	unsigned int ulPllReg = 0;
 
@@ -85,7 +84,7 @@ unsigned int getPllValue(clock_type_t clockType, pll_value_t *pPLL)
 
 unsigned int getChipClock(void)
 {
-	pll_value_t pll;
+	struct pll_value_t pll;
 #if 1
 	if (getChipType() = SM750LE)
 		return MHz(130);
@@ -102,7 +101,7 @@ unsigned int getChipClock(void)
  */
 void setChipClock(unsigned int frequency)
 {
-	pll_value_t pll;
+	struct pll_value_t pll;
 	unsigned int ulActualMxClk;
 #if 1
 	/* Cheok_0509: For SM750LE, the chip clock is fixed. Nothing to set. */
@@ -252,7 +251,7 @@ unsigned int ddk750_getVMSize(void)
 
 }
 
-int ddk750_initHw(initchip_param_t *pInitParam)
+int ddk750_initHw(struct initchip_param_t *pInitParam)
 {
 
 	unsigned int ulReg;
@@ -405,10 +404,10 @@ unsigned int absDiff(unsigned int a, unsigned int b)
 	M = {1,...,255}
 	N = {2,...,15}
 */
-unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
+unsigned int calcPllValue(unsigned int request_orig, struct pll_value_t *pll)
 {
 	/* used for primary and secondary channel pixel clock pll */
-	static pllcalparam xparm_PIXEL[] = {
+	static struct pllcalparam xparm_PIXEL[] = {
 		/* 2^0 = 1*/			{0, 0, 0, 1},
 		/* 2^ 1 =2*/			{1, 0, 1, 2},
 		/* 2^ 2  = 4*/		{2, 0, 2, 4},
@@ -419,7 +418,7 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 							};
 
 	/* used for MXCLK (chip clock) */
-	static pllcalparam xparm_MXCLK[] = {
+	static struct pllcalparam xparm_MXCLK[] = {
 		/* 2^0 = 1*/			{0, 0, 0, 1},
 		/* 2^ 1 =2*/			{1, 0, 1, 2},
 		/* 2^ 2  = 4*/		{2, 0, 2, 4},
@@ -433,7 +432,7 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 	unsigned int RN, quo, rem, fl_quo;
 	unsigned int input, request;
 	unsigned int tmpClock, ret;
-	pllcalparam *xparm;
+	struct pllcalparam *xparm;
 
 #if 1
 	if (getChipType() = SM750LE) {
@@ -493,7 +492,7 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 
 unsigned int calcPllValue2(
 unsigned int ulRequestClk, /* Required pixel clock in Hz unit */
-pll_value_t *pPLL           /* Structure to hold the value to be set in PLL */
+struct pll_value_t *pPLL           /* Structure to hold the value to be set in PLL */
 )
 {
 	unsigned int M, N, OD, POD = 0, diff, pllClk, odPower, podPower;
@@ -591,7 +590,7 @@ pll_value_t *pPLL           /* Structure to hold the value to be set in PLL */
 
 
 
-unsigned int formatPllReg(pll_value_t *pPLL)
+unsigned int formatPllReg(struct pll_value_t *pPLL)
 {
 	unsigned int ulPllReg = 0;
 
diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index 6ff0436..26b3b4a6 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -8,26 +8,24 @@
 #include <linux/io.h>
 
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
 
-typedef struct _pll_value_t {
-	clock_type_t clockType;
+struct pll_value_t {
+	enum clock_type_t clockType;
 	unsigned long inputFreq; /* Input clock frequency to the PLL */
 
 	/* Use this when clockType = PANEL_PLL */
@@ -35,11 +33,10 @@ typedef struct _pll_value_t {
 	unsigned long N;
 	unsigned long OD;
 	unsigned long POD;
-}
-pll_value_t;
+};
 
 /* input struct to initChipParam() function */
-typedef struct _initchip_param_t {
+struct initchip_param_t {
 	unsigned short powerMode;    /* Use power mode 0 or 1 */
 	unsigned short chipClock;    /**
 				      * Speed of main chip clock in MHz unit
@@ -67,18 +64,17 @@ typedef struct _initchip_param_t {
 				      */
 
 	/* More initialization parameter can be added if needed */
-}
-initchip_param_t;
+};
 
 
-logical_chip_type_t getChipType(void);
-unsigned int calcPllValue(unsigned int request, pll_value_t *pll);
-unsigned int calcPllValue2(unsigned int, pll_value_t *);
-unsigned int formatPllReg(pll_value_t *pPLL);
+enum logical_chip_type_t getChipType(void);
+unsigned int calcPllValue(unsigned int request, struct pll_value_t *pll);
+unsigned int calcPllValue2(unsigned int, struct pll_value_t *);
+unsigned int formatPllReg(struct pll_value_t *pPLL);
 void ddk750_set_mmio(void __iomem *, unsigned short, char);
 unsigned int ddk750_getVMSize(void);
-int ddk750_initHw(initchip_param_t *);
-unsigned int getPllValue(clock_type_t clockType, pll_value_t *pPLL);
+int ddk750_initHw(struct initchip_param_t *);
+unsigned int getPllValue(enum clock_type_t clockType, struct pll_value_t *pPLL);
 unsigned int getChipClock(void);
 void setChipClock(unsigned int);
 void setMemoryClock(unsigned int frequency);
diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 8348113..a40871e 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -208,7 +208,7 @@ static void swPanelPowerSequence(int disp, int delay)
 
 }
 
-void ddk750_setLogicalDispOut(disp_output_t output)
+void ddk750_setLogicalDispOut(enum disp_output_t output)
 {
 	unsigned int reg;
 
diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index abccf84..a06bb8e 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -86,7 +86,7 @@
 	CRT means crt path DSUB
 */
 #if 0
-typedef enum _disp_output_t {
+enum disp_output_t {
 	NO_DISPLAY = DPMS_OFF,
 
 	LCD1_PRI = PNL_2_PRI|PRI_TP_ON|PNL_SEQ_ON|DPMS_OFF|DAC_ON,
@@ -125,10 +125,9 @@ typedef enum _disp_output_t {
 						CRT_2_SEC|PRI_TP_OFF|DPMS_ON|DUAL_TFT_ON,
 
 
-}
-disp_output_t;
+};
 #else
-typedef enum _disp_output_t {
+enum disp_output_t {
 	do_LCD1_PRI = PNL_2_PRI|PRI_TP_ON|PNL_SEQ_ON|DAC_ON,
 	do_LCD1_SEC = PNL_2_SEC|SEC_TP_ON|PNL_SEQ_ON|DAC_ON,
 #if 0
@@ -149,11 +148,10 @@ typedef enum _disp_output_t {
 	do_CRT_PRI = CRT_2_PRI|PRI_TP_ON|DPMS_ON|DAC_ON,
 	do_CRT_SEC = CRT_2_SEC|SEC_TP_ON|DPMS_ON|DAC_ON,
 #endif
-}
-disp_output_t;
+};
 #endif
 
-void ddk750_setLogicalDispOut(disp_output_t);
+void ddk750_setLogicalDispOut(enum disp_output_t);
 int ddk750_initDVIDisp(void);
 
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index a7a2351..1a8ca6d 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -9,7 +9,7 @@
 /* This global variable contains all the supported driver and its corresponding
    function API. Please set the function pointer to NULL whenever the function
    is not supported. */
-static dvi_ctrl_device_t g_dcftSupportedDviController[] = {
+static struct dvi_ctrl_device_t g_dcftSupportedDviController[] = {
 #ifdef DVI_CTRL_SII164
 	{
 		.pfnInit = sii164InitChip,
@@ -42,7 +42,7 @@ int dviInit(
 	unsigned char pllFilterValue
 			)
 {
-	dvi_ctrl_device_t *pCurrentDviCtrl;
+	struct dvi_ctrl_device_t *pCurrentDviCtrl;
 
 	pCurrentDviCtrl = g_dcftSupportedDviController;
 	if (pCurrentDviCtrl->pfnInit != NULL) {
@@ -63,10 +63,10 @@ int dviInit(
  */
 unsigned short dviGetVendorID(void)
 {
-	dvi_ctrl_device_t *pCurrentDviCtrl;
+	struct dvi_ctrl_device_t *pCurrentDviCtrl;
 
 	pCurrentDviCtrl = g_dcftSupportedDviController;
-	if (pCurrentDviCtrl != (dvi_ctrl_device_t *)0)
+	if (pCurrentDviCtrl != (struct dvi_ctrl_device_t *)0)
 		return pCurrentDviCtrl->pfnGetVendorId();
 
 	return 0x0000;
@@ -82,10 +82,10 @@ unsigned short dviGetVendorID(void)
  */
 unsigned short dviGetDeviceID(void)
 {
-	dvi_ctrl_device_t *pCurrentDviCtrl;
+	struct dvi_ctrl_device_t *pCurrentDviCtrl;
 
 	pCurrentDviCtrl = g_dcftSupportedDviController;
-	if (pCurrentDviCtrl != (dvi_ctrl_device_t *)0)
+	if (pCurrentDviCtrl != (struct dvi_ctrl_device_t *)0)
 		return pCurrentDviCtrl->pfnGetDeviceId();
 
 	return 0x0000;
diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index e1d4c9a..7181e5d 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -26,7 +26,7 @@ typedef unsigned char (*PFN_DVICTRL_CHECKINTERRUPT)(void);
 typedef void (*PFN_DVICTRL_CLEARINTERRUPT)(void);
 
 /* Structure to hold all the function pointer to the DVI Controller. */
-typedef struct _dvi_ctrl_device_t {
+struct dvi_ctrl_device_t {
 	PFN_DVICTRL_INIT		pfnInit;
 	PFN_DVICTRL_RESETCHIP		pfnResetChip;
 	PFN_DVICTRL_GETCHIPSTRING	pfnGetChipString;
@@ -37,7 +37,7 @@ typedef struct _dvi_ctrl_device_t {
 	PFN_DVICTRL_ISCONNECTED		pfnIsConnected;
 	PFN_DVICTRL_CHECKINTERRUPT	pfnCheckInterrupt;
 	PFN_DVICTRL_CLEARINTERRUPT	pfnClearInterrupt;
-} dvi_ctrl_device_t;
+};
 
 #define DVI_CTRL_SII164
 
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 2399b17..df5e94b7 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -13,7 +13,7 @@
     HW only supports 7 predefined pixel clocks, and clock select is
     in bit 29:27 of	Display Control register.
 */
-static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam, unsigned long dispControl)
+static unsigned long displayControlAdjust_SM750LE(struct mode_parameter_t *pModeParam, unsigned long dispControl)
 {
 	unsigned long x, y;
 
@@ -75,7 +75,7 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 
 
 /* only timing related registers will be  programed */
-static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
+static int programModeRegisters(struct mode_parameter_t *pModeParam, struct pll_value_t *pll)
 {
 	int ret = 0;
 	int cnt = 0;
@@ -182,9 +182,9 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 	return ret;
 }
 
-int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock)
+int ddk750_setModeTiming(struct mode_parameter_t *parm, enum clock_type_t clock)
 {
-	pll_value_t pll;
+	struct pll_value_t pll;
 	unsigned int uiActualPixelClk;
 
 	pll.inputFreq = DEFAULT_INPUT_CLOCK;
diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
index e846dc2..4310c10 100644
--- a/drivers/staging/sm750fb/ddk750_mode.h
+++ b/drivers/staging/sm750fb/ddk750_mode.h
@@ -3,27 +3,26 @@
 
 #include "ddk750_chip.h"
 
-typedef enum _spolarity_t {
+enum spolarity_t {
 	POS = 0, /* positive */
 	NEG, /* negative */
-}
-spolarity_t;
+};
 
 
-typedef struct _mode_parameter_t {
+struct mode_parameter_t {
 	/* Horizontal timing. */
 	unsigned long horizontal_total;
 	unsigned long horizontal_display_end;
 	unsigned long horizontal_sync_start;
 	unsigned long horizontal_sync_width;
-	spolarity_t horizontal_sync_polarity;
+	enum spolarity_t horizontal_sync_polarity;
 
 	/* Vertical timing. */
 	unsigned long vertical_total;
 	unsigned long vertical_display_end;
 	unsigned long vertical_sync_start;
 	unsigned long vertical_sync_height;
-	spolarity_t vertical_sync_polarity;
+	enum spolarity_t vertical_sync_polarity;
 
 	/* Refresh timing. */
 	unsigned long pixel_clock;
@@ -31,11 +30,10 @@ typedef struct _mode_parameter_t {
 	unsigned long vertical_frequency;
 
 	/* Clock Phase. This clock phase only applies to Panel. */
-	spolarity_t clock_phase_polarity;
-}
-mode_parameter_t;
+	enum spolarity_t clock_phase_polarity;
+};
 
-int ddk750_setModeTiming(mode_parameter_t *, clock_type_t);
+int ddk750_setModeTiming(struct mode_parameter_t *, enum clock_type_t);
 
 
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index e580dab..ae76a6d 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -2,7 +2,7 @@
 #include "ddk750_reg.h"
 #include "ddk750_power.h"
 
-void ddk750_setDPMS(DPMS_t state)
+void ddk750_setDPMS(enum DPMS_t state)
 {
 	unsigned int value;
 
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index b7cf6b2..ab0477b 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -1,13 +1,12 @@
 #ifndef DDK750_POWER_H__
 #define DDK750_POWER_H__
 
-typedef enum _DPMS_t {
+enum DPMS_t {
 	crtDPMS_ON = 0x0,
 	crtDPMS_STANDBY = 0x1,
 	crtDPMS_SUSPEND = 0x2,
 	crtDPMS_OFF = 0x3,
-}
-DPMS_t;
+};
 
 #define setDAC(off) \
 		{	\
@@ -17,7 +16,7 @@ DPMS_t;
 									off));	\
 		}
 
-void ddk750_setDPMS(DPMS_t);
+void ddk750_setDPMS(enum DPMS_t);
 
 unsigned int getPowerMode(void);
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 0bdf3db..637d1ca 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -303,7 +303,7 @@ void sii164SetPower(
  *      This function selects the mode of the hot plug detection.
  */
 static void sii164SelectHotPlugDetectionMode(
-	sii164_hot_plug_mode_t hotPlugMode
+	enum sii164_hot_plug_mode_t hotPlugMode
 )
 {
 	unsigned char detectReg;
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index f2610c9..1ca985e 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -4,12 +4,12 @@
 #define USE_DVICHIP
 
 /* Hot Plug detection mode structure */
-typedef enum _sii164_hot_plug_mode_t {
+enum sii164_hot_plug_mode_t {
 	SII164_HOTPLUG_DISABLE = 0,         /* Disable Hot Plug output bit (always high). */
 	SII164_HOTPLUG_USE_MDI,             /* Use Monitor Detect Interrupt bit. */
 	SII164_HOTPLUG_USE_RSEN,            /* Use Receiver Sense detect bit. */
 	SII164_HOTPLUG_USE_HTPLG            /* Use Hot Plug detect bit. */
-} sii164_hot_plug_mode_t;
+};
 
 
 /* Silicon Image SiI164 chip prototype */
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 7317ba9..5152688 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -116,7 +116,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	if (parm->master_clk = 0)
 		parm->master_clk = parm->chip_clk/3;
 
-	ddk750_initHw((initchip_param_t *)&spec_share->state.initParm);
+	ddk750_initHw((struct initchip_param_t *)&spec_share->state.initParm);
 	/* for sm718,open pci burst */
 	if (share->devid = 0x718) {
 		POKE32(SYSTEM_CTRL,
@@ -216,7 +216,7 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 									struct fb_var_screeninfo *var, struct fb_fix_screeninfo *fix)
 {
 	int ret;
-	disp_output_t dispSet;
+	enum disp_output_t dispSet;
 	int channel;
 
 	ret = 0;
@@ -295,8 +295,8 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 {
 	int ret, fmt;
 	u32 reg;
-	mode_parameter_t modparm;
-	clock_type_t clock;
+	struct mode_parameter_t modparm;
+	enum clock_type_t clock;
 	struct lynx_share *share;
 	struct lynxfb_par *par;
 
-- 
2.5.0

