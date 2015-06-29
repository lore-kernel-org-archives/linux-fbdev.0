From: Juston Li <juston.h.li@gmail.com>
Date: Mon, 29 Jun 2015 17:55:31 +0000
Subject: [PATCH v4 14/19] staging: sm750fb: remove trailing whitespace
Message-Id: <1435600536-13135-14-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-+fT0iRmFd+H_X-1gBmvCsgehxXeyr7A8Zk9TtfD0aBA@mail.gmail.com>
In-Reply-To: <CAFow2F-+fT0iRmFd+H_X-1gBmvCsgehxXeyr7A8Zk9TtfD0aBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Cc: Juston Li <juston.h.li@gmail.com>

Fixes checkpatch.pl error:
ERROR: trailing whitespace

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c  |  2 +-
 drivers/staging/sm750fb/sm750_accel.c |  4 ++--
 drivers/staging/sm750fb/sm750_hw.c    | 24 ++++++++++++------------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 4c64436..c42db85 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -1,4 +1,4 @@
-#define USE_DVICHIP 
+#define USE_DVICHIP
 #ifdef USE_DVICHIP
 #include "ddk750_help.h"
 #include "ddk750_reg.h"
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 2ea447e..866bb99 100644
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
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 4941e2a..3b8107c 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -28,7 +28,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 {
 	int ret;
 	struct sm750_share *spec_share;
-	
+
 
 	spec_share = container_of(share, struct sm750_share, share);
 	ret = 0;
@@ -60,7 +60,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 		pr_info("mmio virtual addr = %p\n", share->pvReg);
 	}
 
-	
+
 	share->accel.dprBase = share->pvReg + DE_BASE_ADDR_TYPE1;
 	share->accel.dpPortBase = share->pvReg + DE_PORT_ADDR_TYPE1;
 
@@ -104,7 +104,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 {
 	struct sm750_share *spec_share;
 	struct init_status *parm;
-	
+
 	spec_share = container_of(share, struct sm750_share, share);
 	parm = &spec_share->state.initParm;
 	if (parm->chip_clk = 0)
@@ -202,7 +202,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 resource_size_t hw_sm750_getVMSize(struct lynx_share *share)
 {
 	resource_size_t ret;
-	
+
 	ret = ddk750_getVMSize();
 	return ret;
 }
@@ -211,7 +211,7 @@ resource_size_t hw_sm750_getVMSize(struct lynx_share *share)
 
 int hw_sm750_output_checkMode(struct lynxfb_output* output, struct fb_var_screeninfo* var)
 {
-	
+
 	return 0;
 }
 
@@ -222,7 +222,7 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 	int ret;
 	disp_output_t dispSet;
 	int channel;
-	
+
 	ret = 0;
 	dispSet = 0;
 	channel = *output->channel;
@@ -259,14 +259,14 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 
 void hw_sm750_output_clear(struct lynxfb_output* output)
 {
-	
+
 	return;
 }
 
 int hw_sm750_crtc_checkMode(struct lynxfb_crtc* crtc, struct fb_var_screeninfo* var)
 {
 	struct lynx_share *share;
-	
+
 
 	share = container_of(crtc, struct lynxfb_par, crtc)->share;
 
@@ -303,7 +303,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 	struct lynx_share *share;
 	struct lynxfb_par *par;
 
-	
+
 	ret = 0;
 	par = container_of(crtc, struct lynxfb_par, crtc);
 	share = par->share;
@@ -414,7 +414,7 @@ exit:
 
 void hw_sm750_crtc_clear(struct lynxfb_crtc* crtc)
 {
-	
+
 	return;
 }
 
@@ -428,7 +428,7 @@ int hw_sm750_setColReg(struct lynxfb_crtc* crtc, ushort index,
 
 int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank) {
 	int dpms, crtdb;
-	
+
 	switch (blank)
 	{
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
@@ -483,7 +483,7 @@ int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank) {
 int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
 {
 	unsigned int dpms, pps, crtdb;
-	
+
 	dpms = pps = crtdb = 0;
 
 	switch (blank)
-- 
2.4.4

