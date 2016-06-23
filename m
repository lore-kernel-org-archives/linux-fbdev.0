From: wolzstefan@web.de
Date: Thu, 23 Jun 2016 12:00:10 +0000
Subject: [PATCH 1/4] sm750fb/sm750_hw.c: corrected alignment
Message-Id: <1466683213-17477-2-git-send-email-wolzstefan@web.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1466683213-17477-1-git-send-email-wolzstefan@web.de>
In-Reply-To: <1466683213-17477-1-git-send-email-wolzstefan@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@i4.cs.fau.de, Stefan Wolz <wolzstefan@web.de>, Christian Halder <christian.halder@fau.de>, Sebastian Handwerker <sebastian.handwerker@posteo.de>

From: Stefan Wolz <wolzstefan@web.de>

Fixed alignment in multiline declarations.

Signed-off-by: Stefan Wolz <wolzstefan@web.de>
Signed-off-by: Christian Halder <christian.halder@fau.de>
Signed-off-by: Sebastian Handwerker <sebastian.handwerker@posteo.de>
---
 drivers/staging/sm750fb/sm750_hw.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 2daeedd..72380a8 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -173,7 +173,8 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 }
 
 int hw_sm750_output_setMode(struct lynxfb_output *output,
-									struct fb_var_screeninfo *var, struct fb_fix_screeninfo *fix)
+			    struct fb_var_screeninfo *var,
+			    struct fb_fix_screeninfo *fix)
 {
 	int ret;
 	disp_output_t dispSet;
@@ -244,8 +245,8 @@ int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc, struct fb_var_screeninfo *
 	set the controller's mode for @crtc charged with @var and @fix parameters
 */
 int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
-								struct fb_var_screeninfo *var,
-								struct fb_fix_screeninfo *fix)
+			  struct fb_var_screeninfo *var,
+			  struct fb_fix_screeninfo *fix)
 {
 	int ret, fmt;
 	u32 reg;
@@ -361,7 +362,7 @@ exit:
 }
 
 int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
-								ushort red, ushort green, ushort blue)
+		       ushort red, ushort green, ushort blue)
 {
 	static unsigned int add[] = {PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
 
@@ -529,8 +530,8 @@ int hw_sm750_deWait(void)
 }
 
 int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
-	const struct fb_var_screeninfo *var,
-	const struct fb_info *info)
+			 const struct fb_var_screeninfo *var,
+			 const struct fb_info *info)
 {
 	uint32_t total;
 	/* check params */
-- 
1.9.1

