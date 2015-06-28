From: Anatoly Stepanov <drivengroove@gmail.com>
Date: Sun, 28 Jun 2015 23:44:00 +0000
Subject: [PATCH 07/11] staging: sm750fb: fix indentation in 'else' statements
Message-Id: <1435535044-22042-8-git-send-email-drivengroove@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



Fix indentation according to checkpatch.pl message:
"ERROR: space required after that close brace '}'"

Signed-off-by: Anatoly Stepanov <drivengroove@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 4dded62..9de2532 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -55,7 +55,7 @@ int hw_sm750_map(struct lynx_share *share, struct pci_dev *pdev)
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
-	}else{
+	} else {
 		pr_info("mmio virtual addr = %p\n", share->pvReg);
 	}
 
@@ -89,7 +89,7 @@ int hw_sm750_map(struct lynx_share *share, struct pci_dev *pdev)
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
-	}else{
+	} else {
 		pr_info("video memory vaddr = %p\n", share->pvMem);
 	}
 exit:
@@ -140,7 +140,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 					FIELD_SET(PEEK32(SYSTEM_CTRL),
 					SYSTEM_CTRL,
 					DPMS, VNHN));
-		}else{
+		} else {
 			POKE32(MISC_CTRL,
 					FIELD_SET(PEEK32(MISC_CTRL),
 					MISC_CTRL,
@@ -163,7 +163,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 							spec_share->state.pnltype));
 			break;
 		}
-	}else{
+	} else {
 		/* for 750LE ,no DVI chip initilization makes Monitor no signal */
 		/* Set up GPIO for software I2C to program DVI chip in the
 		   Xilinx SP605 board, in order to have video signal.
@@ -232,7 +232,7 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 			if (output->paths & sm750_crt)
 				dispSet |= do_CRT_PRI;
 
-		}else{
+		} else {
 			pr_info("secondary channel\n");
 			if (output->paths & sm750_panel)
 				dispSet |= do_LCD1_SEC;
@@ -241,7 +241,7 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 
 		}
 		ddk750_setLogicalDispOut(dispSet);
-	}else{
+	} else {
 		/* just open DISPLAY_CONTROL_750LE register bit 3:0*/
 		u32 reg;
 		reg = PEEK32(DISPLAY_CONTROL_750LE);
@@ -385,7 +385,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 			PANEL_DISPLAY_CTRL, FORMAT,
 			(var->bits_per_pixel >> 4)
 			));
-	}else{
+	} else {
 		/* not implemented now */
 		POKE32(CRT_FB_ADDRESS, crtc->oScreen);
 		reg = var->xres * (var->bits_per_pixel >> 3);
@@ -557,7 +557,7 @@ void hw_sm750_initAccel(struct lynx_share *share)
 		reg = FIELD_SET(reg, DE_STATE1, DE_ABORT, OFF);
 		POKE32(DE_STATE1, reg);
 
-	}else{
+	} else {
 		/* engine reset */
 		reg = PEEK32(SYSTEM_CTRL);
 	    reg = FIELD_SET(reg, SYSTEM_CTRL, DE_ABORT, ON);
-- 
2.1.0

