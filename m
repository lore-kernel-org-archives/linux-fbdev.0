From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 22 May 2019 10:15:34 +0000
Subject: [PATCH 1/2] video: fbdev: pvr2fb: remove function prototypes
Message-Id: <2a32648a-69c8-47a6-109a-6c2f764b2534@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190522101536eucas1p12e71e836b8d5983f26ec50324156b926@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Reorder code a bit and then remove no longer needed function
prototypes.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/pvr2fb.c |  141 ++++++++++++++++++-------------------------
 1 file changed, 61 insertions(+), 80 deletions(-)

Index: b/drivers/video/fbdev/pvr2fb.c
=================================--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -193,39 +193,6 @@ static unsigned int shdma = PVR2_CASCADE
 static unsigned int pvr2dma = ONCHIP_NR_DMA_CHANNELS;
 #endif
 
-static int pvr2fb_setcolreg(unsigned int regno, unsigned int red, unsigned int green, unsigned int blue,
-                            unsigned int transp, struct fb_info *info);
-static int pvr2fb_blank(int blank, struct fb_info *info);
-static unsigned long get_line_length(int xres_virtual, int bpp);
-static void set_color_bitfields(struct fb_var_screeninfo *var);
-static int pvr2fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info);
-static int pvr2fb_set_par(struct fb_info *info);
-static void pvr2_update_display(struct fb_info *info);
-static void pvr2_init_display(struct fb_info *info);
-static void pvr2_do_blank(void);
-static irqreturn_t pvr2fb_interrupt(int irq, void *dev_id);
-static int pvr2_init_cable(void);
-static int pvr2_get_param(const struct pvr2_params *p, const char *s,
-                            int val, int size);
-#ifdef CONFIG_PVR2_DMA
-static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
-			    size_t count, loff_t *ppos);
-#endif
-
-static struct fb_ops pvr2fb_ops = {
-	.owner		= THIS_MODULE,
-	.fb_setcolreg	= pvr2fb_setcolreg,
-	.fb_blank	= pvr2fb_blank,
-	.fb_check_var	= pvr2fb_check_var,
-	.fb_set_par	= pvr2fb_set_par,
-#ifdef CONFIG_PVR2_DMA
-	.fb_write	= pvr2fb_write,
-#endif
-	.fb_fillrect	= cfb_fillrect,
-	.fb_copyarea	= cfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
-};
-
 static struct fb_videomode pvr2_modedb[] = {
     /*
      * Broadcast video modes (PAL and NTSC).  I'm unfamiliar with
@@ -353,6 +320,36 @@ static int pvr2fb_setcolreg(unsigned int
 	return 0;
 }
 
+/*
+ * Determine the cable type and initialize the cable output format.  Don't do
+ * anything if the cable type has been overidden (via "cable:XX").
+ */
+
+#define PCTRA 0xff80002c
+#define PDTRA 0xff800030
+#define VOUTC 0xa0702c00
+
+static int pvr2_init_cable(void)
+{
+	if (cable_type < 0) {
+		fb_writel((fb_readl(PCTRA) & 0xfff0ffff) | 0x000a0000,
+	                  PCTRA);
+		cable_type = (fb_readw(PDTRA) >> 8) & 3;
+	}
+
+	/* Now select the output format (either composite or other) */
+	/* XXX: Save the previous val first, as this reg is also AICA
+	  related */
+	if (cable_type = CT_COMPOSITE)
+		fb_writel(3 << 8, VOUTC);
+	else if (cable_type = CT_RGB)
+		fb_writel(1 << 9, VOUTC);
+	else
+		fb_writel(0, VOUTC);
+
+	return cable_type;
+}
+
 static int pvr2fb_set_par(struct fb_info *info)
 {
 	struct pvr2fb_par *par = (struct pvr2fb_par *)info->par;
@@ -641,36 +638,6 @@ static irqreturn_t pvr2fb_interrupt(int
 	return IRQ_HANDLED;
 }
 
-/*
- * Determine the cable type and initialize the cable output format.  Don't do
- * anything if the cable type has been overidden (via "cable:XX").
- */
-
-#define PCTRA 0xff80002c
-#define PDTRA 0xff800030
-#define VOUTC 0xa0702c00
-
-static int pvr2_init_cable(void)
-{
-	if (cable_type < 0) {
-		fb_writel((fb_readl(PCTRA) & 0xfff0ffff) | 0x000a0000,
-	                  PCTRA);
-		cable_type = (fb_readw(PDTRA) >> 8) & 3;
-	}
-
-	/* Now select the output format (either composite or other) */
-	/* XXX: Save the previous val first, as this reg is also AICA
-	  related */
-	if (cable_type = CT_COMPOSITE)
-		fb_writel(3 << 8, VOUTC);
-	else if (cable_type = CT_RGB)
-		fb_writel(1 << 9, VOUTC);
-	else
-		fb_writel(0, VOUTC);
-
-	return cable_type;
-}
-
 #ifdef CONFIG_PVR2_DMA
 static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
 			    size_t count, loff_t *ppos)
@@ -741,6 +708,37 @@ out_unmap:
 }
 #endif /* CONFIG_PVR2_DMA */
 
+static struct fb_ops pvr2fb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_setcolreg	= pvr2fb_setcolreg,
+	.fb_blank	= pvr2fb_blank,
+	.fb_check_var	= pvr2fb_check_var,
+	.fb_set_par	= pvr2fb_set_par,
+#ifdef CONFIG_PVR2_DMA
+	.fb_write	= pvr2fb_write,
+#endif
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+};
+
+static int pvr2_get_param(const struct pvr2_params *p, const char *s, int val,
+			  int size)
+{
+	int i;
+
+	for (i = 0 ; i < size ; i++ ) {
+		if (s != NULL) {
+			if (!strncasecmp(p[i].name, s, strlen(s)))
+				return p[i].val;
+		} else {
+			if (p[i].val = val)
+				return (int)p[i].name;
+		}
+	}
+	return -1;
+}
+
 /**
  * pvr2fb_common_init
  *
@@ -990,23 +988,6 @@ static void __exit pvr2fb_pci_exit(void)
 }
 #endif /* CONFIG_PCI */
 
-static int pvr2_get_param(const struct pvr2_params *p, const char *s, int val,
-			  int size)
-{
-	int i;
-
-	for (i = 0 ; i < size ; i++ ) {
-		if (s != NULL) {
-			if (!strncasecmp(p[i].name, s, strlen(s)))
-				return p[i].val;
-		} else {
-			if (p[i].val = val)
-				return (int)p[i].name;
-		}
-	}
-	return -1;
-}
-
 /*
  * Parse command arguments.  Supported arguments are:
  *    inverse                             Use inverse color maps
