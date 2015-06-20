From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 18:36:41 +0000
Subject: [PATCH 07/19] staging: sm750fb: add space after close brace
Message-Id: <1434825413-4994-7-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
In-Reply-To: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

fixes checkpatch.pl error:
ERROR: space required after that close brace '}'

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c |  2 +-
 drivers/staging/sm750fb/ddk750_mode.c    |  2 +-
 drivers/staging/sm750fb/ddk750_power.c   |  2 +-
 drivers/staging/sm750fb/sm750.h          |  2 +-
 drivers/staging/sm750fb/sm750_cursor.c   |  8 ++++----
 drivers/staging/sm750fb/sm750_hw.c       | 16 ++++++++--------
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index c7171a4..4a3cb86 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -166,7 +166,7 @@ static void waitNextVerticalSync(int ctrl, int delay)
 			while (status = SYSTEM_CTRL_PANEL_VSYNC_INACTIVE);
 		}
 
-	}else {
+	} else {
 
 		/* Do not wait when the Primary PLL is off or display control is already off.
 			   This will prevent the software to wait forever. */
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index efc1fab..3d8b06d 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -109,7 +109,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 
 		if (getChipType() = SM750LE) {
 			displayControlAdjust_SM750LE(pModeParam, ulTmpValue);
-		}else {
+		} else {
 			ulReg = PEEK32(CRT_DISPLAY_CTRL)
 					& FIELD_CLEAR(CRT_DISPLAY_CTRL, VSYNC_PHASE)
 					& FIELD_CLEAR(CRT_DISPLAY_CTRL, HSYNC_PHASE)
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index e2c0bb3..5f697b8 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -8,7 +8,7 @@ void ddk750_setDPMS(DPMS_t state)
 	if (getChipType() = SM750LE) {
 		value = PEEK32(CRT_DISPLAY_CTRL);
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(value, CRT_DISPLAY_CTRL, DPMS, state));
-	}else {
+	} else {
 		value = PEEK32(SYSTEM_CTRL);
 		value= FIELD_VALUE(value, SYSTEM_CTRL, DPMS, state);
 		POKE32(SYSTEM_CTRL, value);
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index bf894cc..3785afc 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -53,7 +53,7 @@ struct lynx_share{
 		int mtrr_off;
 		struct{
 			int vram;
-		}mtrr;
+		} mtrr;
 	/* all smi graphic adaptor got below attributes */
 	unsigned long vidmem_start;
 	unsigned long vidreg_start;
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 3a21af9..2fcec32 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -143,7 +143,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 			if (opr & (0x80 >> j))
 			{	/* use fg color,id = 2 */
 				data |= 2 << (j*2);
-			}else {
+			} else {
 				/* use bg color,id = 1 */
 				data |= 1 << (j*2);
 			}
@@ -173,7 +173,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 			/* need a return */
 			pstart += offset;
 			pbuffer = pstart;
-		}else {
+		} else {
 			pbuffer += sizeof(u16);
 		}
 
@@ -223,7 +223,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 			if (opr & (0x80 >> j))
 			{	/* use fg color,id = 2 */
 				data |= 2 << (j*2);
-			}else {
+			} else {
 				/* use bg color,id = 1 */
 				data |= 1 << (j*2);
 			}
@@ -242,7 +242,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 			/* need a return */
 			pstart += offset;
 			pbuffer = pstart;
-		}else {
+		} else {
 			pbuffer += sizeof(u16);
 		}
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 4dfc6e6..a43f936 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -56,7 +56,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
-	}else {
+	} else {
 		pr_info("mmio virtual addr = %p\n", share->pvReg);
 	}
 
@@ -91,7 +91,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
-	}else {
+	} else {
 		pr_info("video memory vaddr = %p\n", share->pvMem);
 	}
 exit:
@@ -143,7 +143,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 					FIELD_SET(PEEK32(SYSTEM_CTRL),
 					SYSTEM_CTRL,
 					DPMS, VNHN));
-		}else {
+		} else {
 			POKE32(MISC_CTRL,
 					FIELD_SET(PEEK32(MISC_CTRL),
 					MISC_CTRL,
@@ -166,7 +166,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 							spec_share->state.pnltype));
 			break;
 		}
-	}else {
+	} else {
 		/* for 750LE ,no DVI chip initilization makes Monitor no signal */
 		/* Set up GPIO for software I2C to program DVI chip in the
 		   Xilinx SP605 board, in order to have video signal.
@@ -236,7 +236,7 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 			if (output->paths & sm750_crt)
 				dispSet |= do_CRT_PRI;
 
-		}else {
+		} else {
 			pr_info("secondary channel\n");
 			if (output->paths & sm750_panel)
 				dispSet |= do_LCD1_SEC;
@@ -245,7 +245,7 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 
 		}
 		ddk750_setLogicalDispOut(dispSet);
-	}else {
+	} else {
 		/* just open DISPLAY_CONTROL_750LE register bit 3:0*/
 		u32 reg;
 		reg = PEEK32(DISPLAY_CONTROL_750LE);
@@ -389,7 +389,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 			PANEL_DISPLAY_CTRL, FORMAT,
 			(var->bits_per_pixel >> 4)
 			));
-	}else {
+	} else {
 		/* not implemented now */
 		POKE32(CRT_FB_ADDRESS, crtc->oScreen);
 		reg = var->xres * (var->bits_per_pixel >> 3);
@@ -563,7 +563,7 @@ void hw_sm750_initAccel(struct lynx_share *share)
 		reg = FIELD_SET(reg, DE_STATE1, DE_ABORT, OFF);
 		POKE32(DE_STATE1, reg);
 
-	}else {
+	} else {
 		/* engine reset */
 		reg = PEEK32(SYSTEM_CTRL);
 	    reg = FIELD_SET(reg, SYSTEM_CTRL, DE_ABORT, ON);
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
