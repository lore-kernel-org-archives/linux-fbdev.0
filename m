From: Greg Donald <gdonald@gmail.com>
Date: Thu, 18 Jun 2015 20:06:56 +0000
Subject: [PATCH] drivers: staging: sm750fb: Fix "'foo * bar' should be 'foo *bar'" errors
Message-Id: <1434658016-25751-1-git-send-email-gdonald@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: Greg Donald <gdonald@gmail.com>

Fix checkpatch.pl "'foo * bar' should be 'foo *bar'" errors

Signed-off-by: Greg Donald <gdonald@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c  |  2 +-
 drivers/staging/sm750fb/ddk750_help.c  |  4 ++--
 drivers/staging/sm750fb/ddk750_help.h  |  2 +-
 drivers/staging/sm750fb/ddk750_mode.c  |  4 ++--
 drivers/staging/sm750fb/sm750.c        |  2 +-
 drivers/staging/sm750fb/sm750.h        | 26 +++++++++++++-------------
 drivers/staging/sm750fb/sm750_accel.c  | 16 ++++++++--------
 drivers/staging/sm750fb/sm750_accel.h  |  8 ++++----
 drivers/staging/sm750fb/sm750_cursor.c | 14 +++++++-------
 drivers/staging/sm750fb/sm750_cursor.h | 14 +++++++-------
 drivers/staging/sm750fb/sm750_hw.c     | 18 +++++++++---------
 11 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 981736f..f4975d2 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -433,7 +433,7 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 	unsigned int RN, quo, rem, fl_quo;
 	unsigned int input, request;
 	unsigned int tmpClock, ret;
-	pllcalparam * xparm;
+	pllcalparam *xparm;
 
 #if 1
 	if (getChipType() = SM750LE) {
diff --git a/drivers/staging/sm750fb/ddk750_help.c b/drivers/staging/sm750fb/ddk750_help.c
index 96c18eb..1adcafc 100644
--- a/drivers/staging/sm750fb/ddk750_help.c
+++ b/drivers/staging/sm750fb/ddk750_help.c
@@ -1,11 +1,11 @@
 #include "ddk750_help.h"
 
-void __iomem * mmio750 = NULL;
+void __iomem *mmio750 = NULL;
 char revId750 = 0;
 unsigned short devId750 = 0;
 
 /* after driver mapped io registers, use this function first */
-void ddk750_set_mmio(void __iomem * addr, unsigned short devId, char revId)
+void ddk750_set_mmio(void __iomem *addr, unsigned short devId, char revId)
 {
 	mmio750 = addr;
 	devId750 = devId;
diff --git a/drivers/staging/sm750fb/ddk750_help.h b/drivers/staging/sm750fb/ddk750_help.h
index f99f907..4285b05 100644
--- a/drivers/staging/sm750fb/ddk750_help.h
+++ b/drivers/staging/sm750fb/ddk750_help.h
@@ -19,7 +19,7 @@
 #define POKE32(addr, data) writel(data, addr + mmio750)
 #endif
 
-extern void __iomem * mmio750;
+extern void __iomem *mmio750;
 extern char revId750;
 extern unsigned short devId750;
 #else
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index a054747..74313ff 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -75,7 +75,7 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 
 
 /* only timing related registers will be  programed */
-static int programModeRegisters(mode_parameter_t * pModeParam, pll_value_t * pll)
+static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 {
 	int ret = 0;
 	int cnt = 0;
@@ -185,7 +185,7 @@ static int programModeRegisters(mode_parameter_t * pModeParam, pll_value_t * pll
 	return ret;
 }
 
-int ddk750_setModeTiming(mode_parameter_t * parm, clock_type_t clock)
+int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock)
 {
 	pll_value_t pll;
 	unsigned int uiActualPixelClk;
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 6b642d7..8c35302 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1087,7 +1087,7 @@ NO_PARAM:
 }
 
 static int lynxfb_pci_probe(struct pci_dev *pdev,
-			    const struct pci_device_id * ent)
+			    const struct pci_device_id *ent)
 {
 	struct fb_info *info[] = {NULL, NULL};
 	struct lynx_share *share = NULL;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 273882f..cc80580 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -45,8 +45,8 @@ struct lynx_share{
 	/* common members */
 	u16 devid;
 	u8 revid;
-	struct pci_dev * pdev;
-	struct fb_info * fbinfo[2];
+	struct pci_dev *pdev;
+	struct fb_info *fbinfo[2];
 	struct lynx_accel accel;
 	int accel_off;
 	int dual;
@@ -59,8 +59,8 @@ struct lynx_share{
 	unsigned long vidreg_start;
 	__u32 vidmem_size;
 	__u32 vidreg_size;
-	void __iomem * pvReg;
-	unsigned char __iomem * pvMem;
+	void __iomem *pvReg;
+	unsigned char __iomem *pvMem;
 	/* locks*/
 	spinlock_t slock;
 	/* function pointers */
@@ -77,12 +77,12 @@ struct lynx_cursor{
 	int maxW;
 	int maxH;
 	/* base virtual address and offset  of cursor image */
-	char __iomem * vstart;
+	char __iomem *vstart;
 	int offset;
 	/* mmio addr of hw cursor */
 	volatile char __iomem * mmio;
 	/* the lynx_share of this adaptor */
-	struct lynx_share * share;
+	struct lynx_share *share;
 	/* proc_routines */
 	void (*enable)(struct lynx_cursor *);
 	void (*disable)(struct lynx_cursor *);
@@ -93,8 +93,8 @@ struct lynx_cursor{
 };
 
 struct lynxfb_crtc{
-	unsigned char __iomem * vCursor; /* virtual address of cursor */
-	unsigned char __iomem * vScreen; /* virtual address of on_screen */
+	unsigned char __iomem *vCursor; /* virtual address of cursor */
+	unsigned char __iomem *vScreen; /* virtual address of on_screen */
 	int oCursor; /* cursor address offset in vidmem */
 	int oScreen; /* onscreen address offset in vidmem */
 	int channel;/* which channel this crtc stands for*/
@@ -106,7 +106,7 @@ struct lynxfb_crtc{
 	u16 ypanstep;
 	u16 ywrapstep;
 
-	void * priv;
+	void *priv;
 
 	int(*proc_setMode)(struct lynxfb_crtc*,
 						struct fb_var_screeninfo*,
@@ -132,13 +132,13 @@ struct lynxfb_output{
 		paths=3:means output for both panel and crt paths
 	*/
 
-	int * channel;
+	int *channel;
 	/* 	which channel these outputs linked with,for sm750:
 		*channel=0 means primary channel
 		*channel=1 means secondary channel
 		output->channel => &crtc->channel
 	*/
-	void * priv;
+	void *priv;
 
 	int(*proc_setMode)(struct lynxfb_output*,
 						struct fb_var_screeninfo*,
@@ -155,8 +155,8 @@ struct lynxfb_par{
 	unsigned int pseudo_palette[256];
 	struct lynxfb_crtc crtc;
 	struct lynxfb_output output;
-	struct fb_info * info;
-	struct lynx_share * share;
+	struct fb_info *info;
+	struct lynx_share *share;
 };
 
 #ifndef offsetof
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index a2baffd..6eee4cd 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -18,22 +18,22 @@
 #include "sm750.h"
 #include "sm750_accel.h"
 #include "sm750_help.h"
-static inline void write_dpr(struct lynx_accel * accel, int offset, u32 regValue)
+static inline void write_dpr(struct lynx_accel *accel, int offset, u32 regValue)
 {
 	writel(regValue, accel->dprBase + offset);
 }
 
-static inline u32 read_dpr(struct lynx_accel * accel, int offset)
+static inline u32 read_dpr(struct lynx_accel *accel, int offset)
 {
 	return readl(accel->dprBase + offset);
 }
 
-static inline void write_dpPort(struct lynx_accel * accel, u32 data)
+static inline void write_dpPort(struct lynx_accel *accel, u32 data)
 {
 	writel(data, accel->dpPortBase);
 }
 
-void hw_de_init(struct lynx_accel * accel)
+void hw_de_init(struct lynx_accel *accel)
 {
 	/* setup 2d engine registers */
 	u32 reg, clr;
@@ -79,7 +79,7 @@ void hw_de_init(struct lynx_accel * accel)
  * but if you need dual framebuffer driver,need call set2dformat
  * every time you use 2d function */
 
-void hw_set2dformat(struct lynx_accel * accel, int fmt)
+void hw_set2dformat(struct lynx_accel *accel, int fmt)
 {
 	u32 reg;
 	
@@ -89,7 +89,7 @@ void hw_set2dformat(struct lynx_accel * accel, int fmt)
 	write_dpr(accel, DE_STRETCH_FORMAT, reg);
 }
 
-int hw_fillrect(struct lynx_accel * accel,
+int hw_fillrect(struct lynx_accel *accel,
 				u32 base, u32 pitch, u32 Bpp,
 				u32 x, u32 y, u32 width, u32 height,
 				u32 color, u32 rop)
@@ -137,7 +137,7 @@ int hw_fillrect(struct lynx_accel * accel,
 }
 
 int hw_copyarea(
-struct lynx_accel * accel,
+struct lynx_accel *accel,
 unsigned int sBase,  /* Address of source: offset in frame buffer */
 unsigned int sPitch, /* Pitch value of source surface in BYTE */
 unsigned int sx,
@@ -303,7 +303,7 @@ unsigned int rop2)   /* ROP value */
     return 0;
 }
 
-static unsigned int deGetTransparency(struct lynx_accel * accel)
+static unsigned int deGetTransparency(struct lynx_accel *accel)
 {
     unsigned int de_ctrl;
 
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 57e20fb..d3d256c 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -234,17 +234,17 @@
 #define BOTTOM_TO_TOP 1
 #define RIGHT_TO_LEFT 1
 
-void hw_set2dformat(struct lynx_accel * accel, int fmt);
+void hw_set2dformat(struct lynx_accel *accel, int fmt);
 
-void hw_de_init(struct lynx_accel * accel);
+void hw_de_init(struct lynx_accel *accel);
 
-int hw_fillrect(struct lynx_accel * accel,
+int hw_fillrect(struct lynx_accel *accel,
 				u32 base, u32 pitch, u32 Bpp,
 				u32 x, u32 y, u32 width, u32 height,
 				u32 color, u32 rop);
 
 int hw_copyarea(
-struct lynx_accel * accel,
+struct lynx_accel *accel,
 unsigned int sBase,  /* Address of source: offset in frame buffer */
 unsigned int sPitch, /* Pitch value of source surface in BYTE */
 unsigned int sx,
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index cb37ea3..405e24b 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -58,7 +58,7 @@ writel((data), cursor->mmio + (addr))
 
 
 /* hw_cursor_xxx works for voyager,718 and 750 */
-void hw_cursor_enable(struct lynx_cursor * cursor)
+void hw_cursor_enable(struct lynx_cursor *cursor)
 {
 	u32 reg;
 	reg = FIELD_VALUE(0, HWC_ADDRESS, ADDRESS, cursor->offset)|
@@ -66,18 +66,18 @@ void hw_cursor_enable(struct lynx_cursor * cursor)
 			FIELD_SET(0, HWC_ADDRESS, ENABLE, ENABLE);
 	POKE32(HWC_ADDRESS, reg);
 }
-void hw_cursor_disable(struct lynx_cursor * cursor)
+void hw_cursor_disable(struct lynx_cursor *cursor)
 {
 	POKE32(HWC_ADDRESS, 0);
 }
 
-void hw_cursor_setSize(struct lynx_cursor * cursor,
+void hw_cursor_setSize(struct lynx_cursor *cursor,
 						int w, int h)
 {
 	cursor->w = w;
 	cursor->h = h;
 }
-void hw_cursor_setPos(struct lynx_cursor * cursor,
+void hw_cursor_setPos(struct lynx_cursor *cursor,
 						int x, int y)
 {
 	u32 reg;
@@ -85,14 +85,14 @@ void hw_cursor_setPos(struct lynx_cursor * cursor,
 			FIELD_VALUE(0, HWC_LOCATION, X, x);
 	POKE32(HWC_LOCATION, reg);
 }
-void hw_cursor_setColor(struct lynx_cursor * cursor,
+void hw_cursor_setColor(struct lynx_cursor *cursor,
 						u32 fg, u32 bg)
 {
 	POKE32(HWC_COLOR_12, (fg<<16)|(bg&0xffff));
 	POKE32(HWC_COLOR_3, 0xffe0);
 }
 
-void hw_cursor_setData(struct lynx_cursor * cursor,
+void hw_cursor_setData(struct lynx_cursor *cursor,
 			u16 rop, const u8* pcol, const u8* pmsk)
 {
 	int i, j, count, pitch, offset;
@@ -183,7 +183,7 @@ void hw_cursor_setData(struct lynx_cursor * cursor,
 }
 
 
-void hw_cursor_setData2(struct lynx_cursor * cursor,
+void hw_cursor_setData2(struct lynx_cursor *cursor,
 			u16 rop, const u8* pcol, const u8* pmsk)
 {
 	int i, j, count, pitch, offset;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index be58868..e1716a6 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -2,16 +2,16 @@
 #define LYNX_CURSOR_H__
 
 /* hw_cursor_xxx works for voyager,718 and 750 */
-void hw_cursor_enable(struct lynx_cursor * cursor);
-void hw_cursor_disable(struct lynx_cursor * cursor);
-void hw_cursor_setSize(struct lynx_cursor * cursor,
+void hw_cursor_enable(struct lynx_cursor *cursor);
+void hw_cursor_disable(struct lynx_cursor *cursor);
+void hw_cursor_setSize(struct lynx_cursor *cursor,
 						int w, int h);
-void hw_cursor_setPos(struct lynx_cursor * cursor,
+void hw_cursor_setPos(struct lynx_cursor *cursor,
 						int x, int y);
-void hw_cursor_setColor(struct lynx_cursor * cursor,
+void hw_cursor_setColor(struct lynx_cursor *cursor,
 						u32 fg, u32 bg);
-void hw_cursor_setData(struct lynx_cursor * cursor,
+void hw_cursor_setData(struct lynx_cursor *cursor,
 			u16 rop, const u8* data, const u8* mask);
-void hw_cursor_setData2(struct lynx_cursor * cursor,
+void hw_cursor_setData2(struct lynx_cursor *cursor,
 			u16 rop, const u8* data, const u8* mask);
 #endif
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index e70961e..84381bc 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -27,7 +27,7 @@
 int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 {
 	int ret;
-	struct sm750_share * spec_share;
+	struct sm750_share *spec_share;
 	
 
 	spec_share = container_of(share, struct sm750_share, share);
@@ -100,10 +100,10 @@ exit:
 
 
 
-int hw_sm750_inithw(struct lynx_share* share, struct pci_dev * pdev)
+int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 {
-	struct sm750_share * spec_share;
-	struct init_status * parm;
+	struct sm750_share *spec_share;
+	struct init_status *parm;
 	
 	spec_share = container_of(share, struct sm750_share, share);
 	parm = &spec_share->state.initParm;
@@ -199,7 +199,7 @@ int hw_sm750_inithw(struct lynx_share* share, struct pci_dev * pdev)
 }
 
 
-resource_size_t hw_sm750_getVMSize(struct lynx_share * share)
+resource_size_t hw_sm750_getVMSize(struct lynx_share *share)
 {
 	resource_size_t ret;
 	
@@ -265,7 +265,7 @@ void hw_sm750_output_clear(struct lynxfb_output* output)
 
 int hw_sm750_crtc_checkMode(struct lynxfb_crtc* crtc, struct fb_var_screeninfo* var)
 {
-	struct lynx_share * share;
+	struct lynx_share *share;
 	
 
 	share = container_of(crtc, struct lynxfb_par, crtc)->share;
@@ -300,8 +300,8 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 	u32 reg;
 	mode_parameter_t modparm;
 	clock_type_t clock;
-	struct lynx_share * share;
-	struct lynxfb_par * par;
+	struct lynx_share *share;
+	struct lynxfb_par *par;
 
 	
 	ret = 0;
@@ -549,7 +549,7 @@ int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
 }
 
 
-void hw_sm750_initAccel(struct lynx_share * share)
+void hw_sm750_initAccel(struct lynx_share *share)
 {
 	u32 reg;
 	enable2DEngine(1);
-- 
1.9.1

