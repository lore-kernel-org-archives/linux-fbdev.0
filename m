From: Andrea Ghittino <aghittino@gmail.com>
Date: Mon, 28 Nov 2016 20:29:31 +0000
Subject: [PATCH] staging: sm750fb: fix function definition argument style warning
Message-Id: <20161128202922.GA8263@myhd3>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161127164410.GA3398@myhd3>
In-Reply-To: <20161127164410.GA3398@myhd3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fixes sm750fb function definition argument style warning
found by checkpatch.pl tool

Signed-off-by: Andrea Ghittino <aghittino@gmail.com>
---
diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index e97e859..30653dd 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -91,6 +91,6 @@ void sm750_set_chip_type(unsigned short devId, char revId);
 unsigned int sm750_calc_pll_value(unsigned int request, struct  pll_value *pll);
 unsigned int sm750_format_pll_reg(struct pll_value *pPLL);
 unsigned int ddk750_get_vm_size(void);
-int ddk750_init_hw(struct initchip_param *);
+int ddk750_init_hw(struct initchip_param *p_init_param);
 
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index 8abca88..c4a4cbf 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -107,6 +107,6 @@ typedef enum _disp_output_t {
 }
 disp_output_t;
 
-void ddk750_setLogicalDispOut(disp_output_t);
+void ddk750_setLogicalDispOut(disp_output_t output);
 
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
index e846dc2..bdcfe69 100644
--- a/drivers/staging/sm750fb/ddk750_mode.h
+++ b/drivers/staging/sm750fb/ddk750_mode.h
@@ -35,7 +35,7 @@ typedef struct _mode_parameter_t {
 }
 mode_parameter_t;
 
-int ddk750_setModeTiming(mode_parameter_t *, clock_type_t);
+int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock);
 
 
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index eb088b0..6de0458 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -14,7 +14,7 @@ DPMS_t;
 	       (PEEK32(MISC_CTRL) & ~MISC_CTRL_DAC_POWER_OFF) | (off)); \
 }
 
-void ddk750_set_dpms(DPMS_t);
+void ddk750_set_dpms(DPMS_t state);
 void sm750_set_power_mode(unsigned int powerMode);
 void sm750_set_current_gate(unsigned int gate);
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 28f4b9b..3b7bced 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -184,19 +184,23 @@ static inline unsigned long ps_to_hz(unsigned int psvalue)
 }
 
 int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
-int hw_sm750_inithw(struct sm750_dev*, struct pci_dev *);
-void hw_sm750_initAccel(struct sm750_dev *);
+int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
+void hw_sm750_initAccel(struct sm750_dev *sm750_dev);
 int hw_sm750_deWait(void);
 int hw_sm750le_deWait(void);
 
-int hw_sm750_output_setMode(struct lynxfb_output*, struct fb_var_screeninfo*,
-			    struct fb_fix_screeninfo*);
-int hw_sm750_crtc_checkMode(struct lynxfb_crtc*, struct fb_var_screeninfo*);
-int hw_sm750_crtc_setMode(struct lynxfb_crtc*, struct fb_var_screeninfo*,
-			  struct fb_fix_screeninfo*);
-int hw_sm750_setColReg(struct lynxfb_crtc*, ushort, ushort, ushort, ushort);
-int hw_sm750_setBLANK(struct lynxfb_output*, int);
-int hw_sm750le_setBLANK(struct lynxfb_output*, int);
+int hw_sm750_output_setMode(struct lynxfb_output *output,
+				struct fb_var_screeninfo *var,
+				struct fb_fix_screeninfo *fix);
+int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc,
+				struct fb_var_screeninfo *var);
+int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
+				struct fb_var_screeninfo *var,
+				struct fb_fix_screeninfo *fix);
+int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
+				ushort red, ushort green, ushort blue);
+int hw_sm750_setBLANK(struct lynxfb_output *output, int blank);
+int hw_sm750le_setBLANK(struct lynxfb_output *output, int blank);
 int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
 			 const struct fb_var_screeninfo *var,
 			 const struct fb_info *info);
