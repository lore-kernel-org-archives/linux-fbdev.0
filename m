From: Anatoly Stepanov <drivengroove@gmail.com>
Date: Sun, 28 Jun 2015 23:44:01 +0000
Subject: [PATCH 08/11] staging: sm750fb: fix 'switch and case' indentation
Message-Id: <1435535044-22042-9-git-send-email-drivengroove@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



Fix according to checkpatch.pl message:
"ERROR: switch and case should be at the same indent"

Signed-off-by: Anatoly Stepanov <drivengroove@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 172 ++++++++++++++++++-------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 9de2532..3093c25 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -153,15 +153,15 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 		}
 
 		switch (spec_share->state.pnltype) {
-			case sm750_doubleTFT:
-			case sm750_24TFT:
-			case sm750_dualTFT:
-			POKE32(PANEL_DISPLAY_CTRL,
-				FIELD_VALUE(PEEK32(PANEL_DISPLAY_CTRL),
-							PANEL_DISPLAY_CTRL,
-							TFT_DISP,
-							spec_share->state.pnltype));
-			break;
+		case sm750_doubleTFT:
+		case sm750_24TFT:
+		case sm750_dualTFT:
+		POKE32(PANEL_DISPLAY_CTRL,
+			FIELD_VALUE(PEEK32(PANEL_DISPLAY_CTRL),
+						PANEL_DISPLAY_CTRL,
+						TFT_DISP,
+						spec_share->state.pnltype));
+		break;
 		}
 	} else {
 		/* for 750LE ,no DVI chip initilization makes Monitor no signal */
@@ -267,17 +267,17 @@ int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc, struct fb_var_screeninfo *
 	share = container_of(crtc, struct lynxfb_par, crtc)->share;
 
 	switch (var->bits_per_pixel) {
-		case 8:
-		case 16:
-			break;
-		case 32:
-			if (share->revid = SM750LE_REVISION_ID) {
-				pr_debug("750le do not support 32bpp\n");
-				return -EINVAL;
-			}
-			break;
-		default:
+	case 8:
+	case 16:
+		break;
+	case 32:
+		if (share->revid = SM750LE_REVISION_ID) {
+			pr_debug("750le do not support 32bpp\n");
 			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
 
 	}
 
@@ -307,16 +307,16 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 	if (!share->accel_off) {
 		/* set 2d engine pixel format according to mode bpp */
 		switch (var->bits_per_pixel) {
-			case 8:
-				fmt = 0;
-				break;
-			case 16:
-				fmt = 1;
-				break;
-			case 32:
-			default:
-				fmt = 2;
-				break;
+		case 8:
+			fmt = 0;
+			break;
+		case 16:
+			fmt = 1;
+			break;
+		case 32:
+		default:
+			fmt = 2;
+			break;
 		}
 		hw_set2dformat(&share->accel, fmt);
 	}
@@ -427,45 +427,45 @@ int hw_sm750le_setBLANK(struct lynxfb_output *output, int blank) {
 
 	switch (blank) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
-		case FB_BLANK_UNBLANK:
+	case FB_BLANK_UNBLANK:
 #else
-		case VESA_NO_BLANKING:
+	case VESA_NO_BLANKING:
 #endif
-			dpms = CRT_DISPLAY_CTRL_DPMS_0;
-			crtdb = CRT_DISPLAY_CTRL_BLANK_OFF;
-			break;
+		dpms = CRT_DISPLAY_CTRL_DPMS_0;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_OFF;
+		break;
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
-		case FB_BLANK_NORMAL:
-			dpms = CRT_DISPLAY_CTRL_DPMS_0;
-			crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
-			break;
+	case FB_BLANK_NORMAL:
+		dpms = CRT_DISPLAY_CTRL_DPMS_0;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
+		break;
 #endif
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
-		case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_VSYNC_SUSPEND:
 #else
-		case VESA_VSYNC_SUSPEND:
+	case VESA_VSYNC_SUSPEND:
 #endif
-			dpms = CRT_DISPLAY_CTRL_DPMS_2;
-			crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
-			break;
+		dpms = CRT_DISPLAY_CTRL_DPMS_2;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
+		break;
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
-		case FB_BLANK_HSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
 #else
-		case VESA_HSYNC_SUSPEND:
+	case VESA_HSYNC_SUSPEND:
 #endif
-			dpms = CRT_DISPLAY_CTRL_DPMS_1;
-			crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
-			break;
+		dpms = CRT_DISPLAY_CTRL_DPMS_1;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
+		break;
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
-		case FB_BLANK_POWERDOWN:
+	case FB_BLANK_POWERDOWN:
 #else
-		case VESA_POWERDOWN:
+	case VESA_POWERDOWN:
 #endif
-			dpms = CRT_DISPLAY_CTRL_DPMS_3;
-			crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
-			break;
-		default:
-			return -EINVAL;
+		dpms = CRT_DISPLAY_CTRL_DPMS_3;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	if (output->paths & sm750_crt) {
@@ -483,50 +483,50 @@ int hw_sm750_setBLANK(struct lynxfb_output *output, int blank)
 
 	switch (blank) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
-		case FB_BLANK_UNBLANK:
+	case FB_BLANK_UNBLANK:
 #else
-		case VESA_NO_BLANKING:
+	case VESA_NO_BLANKING:
 #endif
-			pr_info("flag = FB_BLANK_UNBLANK \n");
-			dpms = SYSTEM_CTRL_DPMS_VPHP;
-			pps = PANEL_DISPLAY_CTRL_DATA_ENABLE;
-			crtdb = CRT_DISPLAY_CTRL_BLANK_OFF;
-			break;
+		pr_info("flag = FB_BLANK_UNBLANK \n");
+		dpms = SYSTEM_CTRL_DPMS_VPHP;
+		pps = PANEL_DISPLAY_CTRL_DATA_ENABLE;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_OFF;
+		break;
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
-		case FB_BLANK_NORMAL:
-			pr_info("flag = FB_BLANK_NORMAL \n");
-			dpms = SYSTEM_CTRL_DPMS_VPHP;
-			pps = PANEL_DISPLAY_CTRL_DATA_DISABLE;
-			crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
-			break;
+	case FB_BLANK_NORMAL:
+		pr_info("flag = FB_BLANK_NORMAL \n");
+		dpms = SYSTEM_CTRL_DPMS_VPHP;
+		pps = PANEL_DISPLAY_CTRL_DATA_DISABLE;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
+		break;
 #endif
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
-		case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_VSYNC_SUSPEND:
 #else
-		case VESA_VSYNC_SUSPEND:
+	case VESA_VSYNC_SUSPEND:
 #endif
-			dpms = SYSTEM_CTRL_DPMS_VNHP;
-			pps = PANEL_DISPLAY_CTRL_DATA_DISABLE;
-			crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
-			break;
+		dpms = SYSTEM_CTRL_DPMS_VNHP;
+		pps = PANEL_DISPLAY_CTRL_DATA_DISABLE;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
+		break;
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
-		case FB_BLANK_HSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
 #else
-		case VESA_HSYNC_SUSPEND:
+	case VESA_HSYNC_SUSPEND:
 #endif
-			dpms = SYSTEM_CTRL_DPMS_VPHN;
-			pps = PANEL_DISPLAY_CTRL_DATA_DISABLE;
-			crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
-			break;
+		dpms = SYSTEM_CTRL_DPMS_VPHN;
+		pps = PANEL_DISPLAY_CTRL_DATA_DISABLE;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
+		break;
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
-		case FB_BLANK_POWERDOWN:
+	case FB_BLANK_POWERDOWN:
 #else
-		case VESA_POWERDOWN:
+	case VESA_POWERDOWN:
 #endif
-			dpms = SYSTEM_CTRL_DPMS_VNHN;
-			pps = PANEL_DISPLAY_CTRL_DATA_DISABLE;
-			crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
-			break;
+		dpms = SYSTEM_CTRL_DPMS_VNHN;
+		pps = PANEL_DISPLAY_CTRL_DATA_DISABLE;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
+		break;
 	}
 
 	if (output->paths & sm750_crt) {
-- 
2.1.0

