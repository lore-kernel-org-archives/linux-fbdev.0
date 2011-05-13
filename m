From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 13 May 2011 15:54:49 +0000
Subject: [PATCH 5/5] video: mb862xxfb: add support for L1 displaying
Message-Id: <1305302089-7666-6-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Allow displaying L1 video data on top of the primary L0 layer.
The L1 layer position and dimensions can be configured and the
layer enabled/disabled by using the appropriate L1 controls
added by this patch.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/mb862xx/mb862xx_reg.h |   31 +++++++++
 drivers/video/mb862xx/mb862xxfb.c   |  116 ++++++++++++++++++++++++++++++++++-
 drivers/video/mb862xx/mb862xxfb.h   |   27 ++++++++
 3 files changed, 173 insertions(+), 1 deletions(-)

diff --git a/drivers/video/mb862xx/mb862xx_reg.h b/drivers/video/mb862xx/mb862xx_reg.h
index 5784b01..9df48b8 100644
--- a/drivers/video/mb862xx/mb862xx_reg.h
+++ b/drivers/video/mb862xx/mb862xx_reg.h
@@ -51,10 +51,16 @@
 #define GC_L0OA0		0x00000024
 #define GC_L0DA0		0x00000028
 #define GC_L0DY_L0DX		0x0000002c
+#define GC_L1M			0x00000030
+#define GC_L1DA			0x00000034
 #define GC_DCM1			0x00000100
 #define GC_L0EM			0x00000110
 #define GC_L0WY_L0WX		0x00000114
 #define GC_L0WH_L0WW		0x00000118
+#define GC_L1EM			0x00000120
+#define GC_L1WY_L1WX		0x00000124
+#define GC_L1WH_L1WW		0x00000128
+#define GC_DLS			0x00000180
 #define GC_DCM2			0x00000104
 #define GC_DCM3			0x00000108
 #define GC_CPM_CUTC		0x000000a0
@@ -66,6 +72,11 @@
 
 #define GC_CPM_CEN0		0x00100000
 #define GC_CPM_CEN1		0x00200000
+#define GC_DCM1_DEN		0x80000000
+#define GC_DCM1_L1E		0x00020000
+#define GC_L1M_16		0x80000000
+#define GC_L1M_YC		0x40000000
+#define GC_L1M_CS		0x20000000
 
 #define GC_DCM01_ESY		0x00000004
 #define GC_DCM01_SC		0x00003f00
@@ -77,6 +88,7 @@
 #define GC_L0M_L0C_16		0x80000000
 #define GC_L0EM_L0EC_24		0x40000000
 #define GC_L0M_L0W_UNIT		64
+#define GC_L1EM_DM		0x02000000
 
 #define GC_DISP_REFCLK_400	400
 
@@ -101,6 +113,25 @@
 #define I2C_TRX			0x80
 #define I2C_LRB			0x10
 
+/* Capture registers and bits */
+#define GC_CAP_VCM		0x00000000
+#define GC_CAP_CSC		0x00000004
+#define GC_CAP_VCS		0x00000008
+#define GC_CAP_CBM		0x00000010
+#define GC_CAP_CBOA		0x00000014
+#define GC_CAP_CBLA		0x00000018
+#define GC_CAP_IMG_START	0x0000001C
+#define GC_CAP_IMG_END		0x00000020
+#define GC_CAP_CMSS		0x00000048
+#define GC_CAP_CMDS		0x0000004C
+
+#define GC_VCM_VIE		0x80000000
+#define GC_VCM_CM		0x03000000
+#define GC_VCM_VS_PAL		0x00000002
+#define GC_CBM_OO		0x80000000
+#define GC_CBM_HRV		0x00000010
+#define GC_CBM_CBST		0x00000001
+
 /* Carmine specific */
 #define MB86297_DRAW_BASE		0x00020000
 #define MB86297_DISP0_BASE		0x00100000
diff --git a/drivers/video/mb862xx/mb862xxfb.c b/drivers/video/mb862xx/mb862xxfb.c
index a9779f8..c098b88 100644
--- a/drivers/video/mb862xx/mb862xxfb.c
+++ b/drivers/video/mb862xx/mb862xxfb.c
@@ -27,7 +27,7 @@
 
 #define NR_PALETTE		256
 #define MB862XX_MEM_SIZE	0x1000000
-#define CORALP_MEM_SIZE		0x4000000
+#define CORALP_MEM_SIZE		0x2000000
 #define CARMINE_MEM_SIZE	0x8000000
 #define DRV_NAME		"mb862xxfb"
 
@@ -309,6 +309,97 @@ static int mb862xxfb_blank(int mode, struct fb_info *fbi)
 	return 0;
 }
 
+static int mb862xxfb_ioctl(struct fb_info *fbi, unsigned int cmd,
+			   unsigned long arg)
+{
+	struct mb862xxfb_par *par = fbi->par;
+	struct mb862xx_l1_cfg *l1_cfg = &par->l1_cfg;
+	void __user *argp = (void __user *)arg;
+	int *enable;
+	u32 l1em = 0;
+
+	switch (cmd) {
+	case MB862XX_L1_GET_CFG:
+		if (copy_to_user(argp, l1_cfg, sizeof(*l1_cfg)))
+			return -EFAULT;
+		break;
+	case MB862XX_L1_SET_CFG:
+		if (copy_from_user(l1_cfg, argp, sizeof(*l1_cfg)))
+			return -EFAULT;
+		if ((l1_cfg->sw >= l1_cfg->dw) && (l1_cfg->sh >= l1_cfg->dh)) {
+			/* downscaling */
+			outreg(cap, GC_CAP_CSC,
+				pack((l1_cfg->sh << 11) / l1_cfg->dh,
+				     (l1_cfg->sw << 11) / l1_cfg->dw));
+			l1em = inreg(disp, GC_L1EM);
+			l1em &= ~GC_L1EM_DM;
+		} else if ((l1_cfg->sw <= l1_cfg->dw) &&
+			   (l1_cfg->sh <= l1_cfg->dh)) {
+			/* upscaling */
+			outreg(cap, GC_CAP_CSC,
+				pack((l1_cfg->sh << 11) / l1_cfg->dh,
+				     (l1_cfg->sw << 11) / l1_cfg->dw));
+			outreg(cap, GC_CAP_CMSS,
+				pack(l1_cfg->sw >> 1, l1_cfg->sh));
+			outreg(cap, GC_CAP_CMDS,
+				pack(l1_cfg->dw >> 1, l1_cfg->dh));
+			l1em = inreg(disp, GC_L1EM);
+			l1em |= GC_L1EM_DM;
+		}
+
+		if (l1_cfg->mirror) {
+			outreg(cap, GC_CAP_CBM,
+				inreg(cap, GC_CAP_CBM) | GC_CBM_HRV);
+			l1em |= l1_cfg->dw * 2 - 8;
+		} else {
+			outreg(cap, GC_CAP_CBM,
+				inreg(cap, GC_CAP_CBM) & ~GC_CBM_HRV);
+			l1em &= 0xffff0000;
+		}
+		outreg(disp, GC_L1EM, l1em);
+		break;
+	case MB862XX_L1_ENABLE:
+		enable = (int *)arg;
+		if (*enable) {
+			outreg(disp, GC_L1DA, par->cap_buf);
+			outreg(cap, GC_CAP_IMG_START,
+				pack(l1_cfg->sy >> 1, l1_cfg->sx));
+			outreg(cap, GC_CAP_IMG_END,
+				pack(l1_cfg->sh, l1_cfg->sw));
+			outreg(disp, GC_L1M, GC_L1M_16 | GC_L1M_YC | GC_L1M_CS |
+					     (par->l1_stride << 16));
+			outreg(disp, GC_L1WY_L1WX,
+				pack(l1_cfg->dy, l1_cfg->dx));
+			outreg(disp, GC_L1WH_L1WW,
+				pack(l1_cfg->dh - 1, l1_cfg->dw));
+			outreg(disp, GC_DLS, 1);
+			outreg(cap, GC_CAP_VCM,
+				GC_VCM_VIE | GC_VCM_CM | GC_VCM_VS_PAL);
+			outreg(disp, GC_DCM1, inreg(disp, GC_DCM1) |
+					      GC_DCM1_DEN | GC_DCM1_L1E);
+		} else {
+			outreg(cap, GC_CAP_VCM,
+				inreg(cap, GC_CAP_VCM) & ~GC_VCM_VIE);
+			outreg(disp, GC_DCM1,
+				inreg(disp, GC_DCM1) & ~GC_DCM1_L1E);
+		}
+		break;
+	case MB862XX_L1_CAP_CTL:
+		enable = (int *)arg;
+		if (*enable) {
+			outreg(cap, GC_CAP_VCM,
+				inreg(cap, GC_CAP_VCM) | GC_VCM_VIE);
+		} else {
+			outreg(cap, GC_CAP_VCM,
+				inreg(cap, GC_CAP_VCM) & ~GC_VCM_VIE);
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /* framebuffer ops */
 static struct fb_ops mb862xxfb_ops = {
 	.owner		= THIS_MODULE,
@@ -320,6 +411,7 @@ static struct fb_ops mb862xxfb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
+	.fb_ioctl	= mb862xxfb_ioctl,
 };
 
 /* initialize fb_info data */
@@ -328,6 +420,7 @@ static int mb862xxfb_init_fbinfo(struct fb_info *fbi)
 	struct mb862xxfb_par *par = fbi->par;
 	struct mb862xx_gc_mode *mode = par->gc_mode;
 	unsigned long reg;
+	int stride;
 
 	fbi->fbops = &mb862xxfb_ops;
 	fbi->pseudo_palette = par->pseudo_palette;
@@ -420,6 +513,27 @@ static int mb862xxfb_init_fbinfo(struct fb_info *fbi)
 	fbi->fix.line_length = (fbi->var.xres_virtual *
 				fbi->var.bits_per_pixel) / 8;
 	fbi->fix.smem_len = fbi->fix.line_length * fbi->var.yres_virtual;
+
+	/*
+	 * reserve space for capture buffers and two cursors
+	 * at the end of vram: 720x576 * 2 * 2.2 + 64x64 * 16.
+	 */
+	par->cap_buf = par->mapped_vram - 0x1bd800 - 0x10000;
+	par->cap_len = 0x1bd800;
+	par->l1_cfg.sx = 0;
+	par->l1_cfg.sy = 0;
+	par->l1_cfg.sw = 720;
+	par->l1_cfg.sh = 576;
+	par->l1_cfg.dx = 0;
+	par->l1_cfg.dy = 0;
+	par->l1_cfg.dw = 720;
+	par->l1_cfg.dh = 576;
+	stride = par->l1_cfg.sw * (fbi->var.bits_per_pixel / 8);
+	par->l1_stride = stride / 64 + ((stride % 64) ? 1 : 0);
+	outreg(cap, GC_CAP_CBM, GC_CBM_OO | GC_CBM_CBST |
+				(par->l1_stride << 16));
+	outreg(cap, GC_CAP_CBOA, par->cap_buf);
+	outreg(cap, GC_CAP_CBLA, par->cap_buf + par->cap_len);
 	return 0;
 }
 
diff --git a/drivers/video/mb862xx/mb862xxfb.h b/drivers/video/mb862xx/mb862xxfb.h
index f0f57ea..12ba0f0 100644
--- a/drivers/video/mb862xx/mb862xxfb.h
+++ b/drivers/video/mb862xx/mb862xxfb.h
@@ -1,6 +1,26 @@
 #ifndef __MB862XX_H__
 #define __MB862XX_H__
 
+struct mb862xx_l1_cfg {
+	unsigned short sx;
+	unsigned short sy;
+	unsigned short sw;
+	unsigned short sh;
+	unsigned short dx;
+	unsigned short dy;
+	unsigned short dw;
+	unsigned short dh;
+	int mirror;
+};
+
+#define MB862XX_BASE		'M'
+#define MB862XX_L1_GET_CFG	_IOR(MB862XX_BASE, 0, struct mb862xx_l1_cfg*)
+#define MB862XX_L1_SET_CFG	_IOW(MB862XX_BASE, 1, struct mb862xx_l1_cfg*)
+#define MB862XX_L1_ENABLE	_IOW(MB862XX_BASE, 2, int)
+#define MB862XX_L1_CAP_CTL	_IOW(MB862XX_BASE, 3, int)
+
+#ifdef __KERNEL__
+
 #define PCI_VENDOR_ID_FUJITSU_LIMITED	0x10cf
 #define PCI_DEVICE_ID_FUJITSU_CORALP	0x2019
 #define PCI_DEVICE_ID_FUJITSU_CORALPA	0x201e
@@ -38,6 +58,8 @@ struct mb862xxfb_par {
 	void __iomem		*mmio_base;	/* remapped registers */
 	size_t			mapped_vram;	/* length of remapped vram */
 	size_t			mmio_len;	/* length of register region */
+	unsigned long		cap_buf;	/* capture buffers offset */
+	size_t			cap_len;	/* length of capture buffers */
 
 	void __iomem		*host;		/* relocatable reg. bases */
 	void __iomem		*i2c;
@@ -60,6 +82,9 @@ struct mb862xxfb_par {
 	struct i2c_adapter	*adap;		/* GDC I2C bus adapter */
 	int			i2c_rs;
 
+	struct mb862xx_l1_cfg	l1_cfg;
+	int			l1_stride;
+
 	u32			pseudo_palette[16];
 };
 
@@ -85,4 +110,6 @@ extern int mb862xx_i2c_init(struct mb862xxfb_par *par);
 
 #define pack(a, b)	(((a) << 16) | (b))
 
+#endif /* __KERNEL__ */
+
 #endif
-- 
1.7.1

