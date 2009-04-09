From: InKi Dae <daeinki@gmail.com>
Subject: It has added ARGB1888 and ARGB4888 features to Samsung SoC 
	Framebuffer driver.
Date: Thu, 9 Apr 2009 16:59:14 +0900
Message-ID: <90b950fc0904090059l39229aa9hd3399782a15e1bf9@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759382AbZDIH71@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: ben-linux@fluff.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch supports ARGB1888 and ARGB4888 for Samsung SoC Framebuffer
driver. (s3c-fb.c)
I tested and is working fine.

If this patch has any problem, please let me know.
I'll look forward to applying to mainline.

Thank you,
InKi Dae.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index e0e7899..55d2298 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -358,9 +358,16 @@ static int s3c_fb_set_par(struct fb_info *info)
  writel(data, regs + VIDOSD_B(win_no));

  data = var->xres * var->yres;
+
+ u32 osdc_data = 0;
+
+ osdc_data = VIDISD14C_ALPHA1_R(0xf) |
+  VIDISD14C_ALPHA1_G(0xf) |
+  VIDISD14C_ALPHA1_B(0xf);
+
  if (s3c_fb_has_osd_d(win_no)) {
   writel(data, regs + VIDOSD_D(win_no));
-  writel(0, regs + VIDOSD_C(win_no));
+  writel(osdc_data, regs + VIDOSD_C(win_no));
  } else
   writel(data, regs + VIDOSD_C(win_no));

@@ -409,8 +416,12 @@ static int s3c_fb_set_par(struct fb_info *info)
     data |= WINCON1_BPPMODE_19BPP_A1666;
    else
     data |= WINCON1_BPPMODE_18BPP_666;
-  } else if (var->transp.length != 0)
-   data |= WINCON1_BPPMODE_25BPP_A1888;
+  } else if (var->transp.length == 1)
+   data |= WINCON1_BPPMODE_25BPP_A1888
+    | WINCON1_BLD_PIX;
+  else if (var->transp.length == 4)
+   data |= WINCON1_BPPMODE_28BPP_A4888
+    | WINCON1_BLD_PIX | WINCON1_ALPHA_SEL;
   else
    data |= WINCON0_BPPMODE_24BPP_888;

@@ -418,6 +429,20 @@ static int s3c_fb_set_par(struct fb_info *info)
   break;
  }

+ /* It has no color key control register for window0 */
+ if (win_no > 0) {
+  u32 keycon0_data = 0, keycon1_data = 0;
+
+  keycon0_data = ~(WxKEYCON0_KEYBL_EN |
+    WxKEYCON0_KEYEN_F |
+    WxKEYCON0_DIRCON) | WxKEYCON0_COMPKEY(0);
+
+  keycon1_data = WxKEYCON1_COLVAL(0xffffff);
+
+  writel(keycon0_data, regs + WxKEYCONy(win_no-1, 0));
+  writel(keycon1_data, regs + WxKEYCONy(win_no-1, 1));
+ }
+
  writel(data, regs + WINCON(win_no));
  writel(0x0, regs + WINxMAP(win_no));
