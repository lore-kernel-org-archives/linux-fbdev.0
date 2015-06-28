From: Anatoly Stepanov <drivengroove@gmail.com>
Date: Sun, 28 Jun 2015 23:43:58 +0000
Subject: [PATCH 05/11] staging: sm750fb: fix indentation of pointer operator
Message-Id: <1435535044-22042-6-git-send-email-drivengroove@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



Fix indentation of pointer operator '*' according to checkpatch.pl message:
"ERROR: 'foo* bar' should be 'foo *bar' "

Signed-off-by: Anatoly Stepanov <drivengroove@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 0e98cd3..4f4ec93 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -24,7 +24,7 @@
 #include "ddk750.h"
 #include "sm750_accel.h"
 
-int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
+int hw_sm750_map(struct lynx_share *share, struct pci_dev *pdev)
 {
 	int ret;
 	struct sm750_share *spec_share;
@@ -209,15 +209,15 @@ resource_size_t hw_sm750_getVMSize(struct lynx_share *share)
 
 
 
-int hw_sm750_output_checkMode(struct lynxfb_output* output, struct fb_var_screeninfo* var)
+int hw_sm750_output_checkMode(struct lynxfb_output *output, struct fb_var_screeninfo *var)
 {
 
 	return 0;
 }
 
 
-int hw_sm750_output_setMode(struct lynxfb_output* output,
-									struct fb_var_screeninfo* var, struct fb_fix_screeninfo* fix)
+int hw_sm750_output_setMode(struct lynxfb_output *output,
+									struct fb_var_screeninfo *var, struct fb_fix_screeninfo *fix)
 {
 	int ret;
 	disp_output_t dispSet;
@@ -257,13 +257,13 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 	return ret;
 }
 
-void hw_sm750_output_clear(struct lynxfb_output* output)
+void hw_sm750_output_clear(struct lynxfb_output *output)
 {
 
 	return;
 }
 
-int hw_sm750_crtc_checkMode(struct lynxfb_crtc* crtc, struct fb_var_screeninfo* var)
+int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc, struct fb_var_screeninfo *var)
 {
 	struct lynx_share *share;
 
@@ -292,9 +292,9 @@ int hw_sm750_crtc_checkMode(struct lynxfb_crtc* crtc, struct fb_var_screeninfo*
 /*
 	set the controller's mode for @crtc charged with @var and @fix parameters
 */
-int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
-								struct fb_var_screeninfo* var,
-								struct fb_fix_screeninfo* fix)
+int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
+								struct fb_var_screeninfo *var,
+								struct fb_fix_screeninfo *fix)
 {
 	int ret, fmt;
 	u32 reg;
@@ -412,13 +412,13 @@ exit:
 	return ret;
 }
 
-void hw_sm750_crtc_clear(struct lynxfb_crtc* crtc)
+void hw_sm750_crtc_clear(struct lynxfb_crtc *crtc)
 {
 
 	return;
 }
 
-int hw_sm750_setColReg(struct lynxfb_crtc* crtc, ushort index,
+int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
 								ushort red, ushort green, ushort blue)
 {
 	static unsigned int add[]={PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
@@ -426,7 +426,7 @@ int hw_sm750_setColReg(struct lynxfb_crtc* crtc, ushort index,
 	return 0;
 }
 
-int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank) {
+int hw_sm750le_setBLANK(struct lynxfb_output *output, int blank) {
 	int dpms, crtdb;
 
 	switch (blank)
@@ -480,7 +480,7 @@ int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank) {
 	return 0;
 }
 
-int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
+int hw_sm750_setBLANK(struct lynxfb_output *output, int blank)
 {
 	unsigned int dpms, pps, crtdb;
 
-- 
2.1.0

