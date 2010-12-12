From: Liu Ying <liu.y.victor@gmail.com>
Date: Sun, 12 Dec 2010 06:13:40 +0000
Subject: Re: [PATCH 5/9] Add i.MX5 framebuffer driver
Message-Id: <AANLkTikZowDCK4JPiCyEou1ekRuYA1qGnKrBPT5dXB+8@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-6-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1291902441-24712-6-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello, Sascha,

I have following comments to this patch:
1) Please modify the commit message, as IPUv3 is not embedded in i.MX50 SoC.
2) ADC is not supported yet in the framebuffer driver, so please
modify this comment:
   > + * Framebuffer Framebuffer Driver for SDC and ADC.
3) 'ipu_dp_set_window_pos()' is called only once in
imx_ipu_fb_set_par_overlay(). So, the framebuffer driver doesn't
support to change the overlay framebuffer position. Need a
mechanism/interface for users to change the overlay framebuffer
position.
4) Need to make sure the framebuffer on DP-FG is blanked before the
framebuffer on DP-BG is blanked. Meanwhile, the framebuffer on DP-FG
should be unblanked after the framebuffer on DP-BG is unblanked
5) Need to check the framebuffer on DP-FG doesn't run out of the range
of the framebuffer on DP-BG.
6) I prefer to find the video mode in modedb first, and if we cannot
find the video mode in common video mode data base, we can find a
video mode in custom video mode data base which is defined in platform
data. In this way, we don't need to export common modefb.

Best Regards,
Liu Ying


2010/12/9 Sascha Hauer <s.hauer@pengutronix.de>:
> This patch adds framebuffer support to the Freescale i.MX SoCs
> equipped with an IPU v3, so far these are the i.MX50/51/53.
>
> This driver has been tested on the i.MX51 babbage board with
> both DVI and analog VGA in different resolutions and color depths.
> It has also been tested on a custom i.MX51 board using a fixed
> resolution panel.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> =A0drivers/video/Kconfig =A0| =A0 11 +
> =A0drivers/video/Makefile | =A0 =A01 +
> =A0drivers/video/mx5fb.c =A0| =A0846 ++++++++++++++++++++++++++++++++++++=
++++++++++++
> =A03 files changed, 858 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/video/mx5fb.c
>
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 27c1fb4..1901915 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2236,6 +2236,17 @@ config FB_MX3
> =A0 =A0 =A0 =A0 =A0far only synchronous displays are supported. If you pl=
an to use
> =A0 =A0 =A0 =A0 =A0an LCD display with your i.MX31 system, say Y here.
>
> +config FB_MX5
> + =A0 =A0 =A0 tristate "MX5 Framebuffer support"
> + =A0 =A0 =A0 depends on FB && MFD_IMX_IPU_V3
> + =A0 =A0 =A0 select FB_CFB_FILLRECT
> + =A0 =A0 =A0 select FB_CFB_COPYAREA
> + =A0 =A0 =A0 select FB_CFB_IMAGEBLIT
> + =A0 =A0 =A0 select FB_MODE_HELPERS
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This is a framebuffer device for the i.MX51 LCD Control=
ler. If you
> + =A0 =A0 =A0 =A0 plan to use an LCD display with your i.MX51 system, say=
 Y here.
> +
> =A0config FB_BROADSHEET
> =A0 =A0 =A0 =A0tristate "E-Ink Broadsheet/Epson S1D13521 controller suppo=
rt"
> =A0 =A0 =A0 =A0depends on FB
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 485e8ed..ad408d2 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -145,6 +145,7 @@ obj-$(CONFIG_FB_BF54X_LQ043) =A0 =A0 =A0 =A0 =A0+=3D =
bf54x-lq043fb.o
> =A0obj-$(CONFIG_FB_BFIN_LQ035Q1) =A0 =A0 +=3D bfin-lq035q1-fb.o
> =A0obj-$(CONFIG_FB_BFIN_T350MCQB) =A0 +=3D bfin-t350mcqb-fb.o
> =A0obj-$(CONFIG_FB_MX3) =A0 =A0 =A0 =A0 =A0 =A0 +=3D mx3fb.o
> +obj-$(CONFIG_FB_MX5) =A0 =A0 =A0 =A0 =A0 =A0 +=3D mx5fb.o
> =A0obj-$(CONFIG_FB_DA8XX) =A0 =A0 =A0 =A0 =A0 +=3D da8xx-fb.o
>
> =A0# the test framebuffer is last
> diff --git a/drivers/video/mx5fb.c b/drivers/video/mx5fb.c
> new file mode 100644
> index 0000000..fd9baf4
> --- /dev/null
> +++ b/drivers/video/mx5fb.c
> @@ -0,0 +1,846 @@
> +/*
> + * Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + *
> + * Framebuffer Framebuffer Driver for SDC and ADC.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <linux/fb.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/console.h>
> +#include <linux/mfd/imx-ipu-v3.h>
> +#include <asm/uaccess.h>
> +#include <mach/ipu-v3.h>
> +
> +#define DRIVER_NAME "imx-ipuv3-fb"
> +
> +struct imx_ipu_fb_info {
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ipu_channel_num;
> + =A0 =A0 =A0 struct ipu_channel =A0 =A0 =A0*ipu_ch;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dc;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ipu_di;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ipu_di_pix_fmt;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ipu_in_pix_fmt;
> +
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pseudo_palette[=
16];
> +
> + =A0 =A0 =A0 struct ipu_dp =A0 =A0 =A0 =A0 =A0 *dp;
> + =A0 =A0 =A0 struct dmfc_channel =A0 =A0 *dmfc;
> + =A0 =A0 =A0 struct fb_info =A0 =A0 =A0 =A0 =A0*slave;
> + =A0 =A0 =A0 struct fb_info =A0 =A0 =A0 =A0 =A0*master;
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enabled;
> +};
> +
> +static int imx_ipu_fb_set_fix(struct fb_info *info)
> +{
> + =A0 =A0 =A0 struct fb_fix_screeninfo *fix =3D &info->fix;
> + =A0 =A0 =A0 struct fb_var_screeninfo *var =3D &info->var;
> +
> + =A0 =A0 =A0 fix->line_length =3D var->xres_virtual * var->bits_per_pixe=
l / 8;
> +
> + =A0 =A0 =A0 fix->type =3D FB_TYPE_PACKED_PIXELS;
> + =A0 =A0 =A0 fix->accel =3D FB_ACCEL_NONE;
> + =A0 =A0 =A0 fix->visual =3D FB_VISUAL_TRUECOLOR;
> + =A0 =A0 =A0 fix->xpanstep =3D 1;
> + =A0 =A0 =A0 fix->ypanstep =3D 1;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int imx_ipu_fb_map_video_memory(struct fb_info *fbi)
> +{
> + =A0 =A0 =A0 int size;
> +
> + =A0 =A0 =A0 size =3D fbi->var.yres_virtual * fbi->fix.line_length;
> +
> + =A0 =A0 =A0 if (fbi->screen_base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fbi->fix.smem_len >=3D size)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_writecombine(fbi->device, fbi->fix=
.smem_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fbi->screen_bas=
e, fbi->fix.smem_start);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 fbi->screen_base =3D dma_alloc_writecombine(fbi->device,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dma_addr_t=
 *)&fbi->fix.smem_start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_DMA);
> + =A0 =A0 =A0 if (fbi->screen_base =3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(fbi->device, "Unable to allocate fr=
amebuffer memory (%d)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fbi->fix.sm=
em_len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fbi->fix.smem_len =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fbi->fix.smem_start =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 fbi->fix.smem_len =3D size;
> + =A0 =A0 =A0 fbi->screen_size =3D fbi->fix.smem_len;
> +
> + =A0 =A0 =A0 dev_dbg(fbi->device, "allocated fb @ paddr=3D0x%08lx, size=
=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fbi->fix.smem_start, fbi->fix.smem_len);
> +
> + =A0 =A0 =A0 /* Clear the screen */
> + =A0 =A0 =A0 memset((char *)fbi->screen_base, 0, fbi->fix.smem_len);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void imx_ipu_fb_enable(struct fb_info *fbi)
> +{
> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_fbi =3D fbi->par;
> +
> + =A0 =A0 =A0 if (mxc_fbi->enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 ipu_di_enable(mxc_fbi->ipu_di);
> + =A0 =A0 =A0 ipu_dmfc_enable_channel(mxc_fbi->dmfc);
> + =A0 =A0 =A0 ipu_idmac_enable_channel(mxc_fbi->ipu_ch);
> + =A0 =A0 =A0 ipu_dc_enable_channel(mxc_fbi->dc);
> + =A0 =A0 =A0 ipu_dp_enable_channel(mxc_fbi->dp);
> + =A0 =A0 =A0 mxc_fbi->enabled =3D 1;
> +}
> +
> +static void imx_ipu_fb_disable(struct fb_info *fbi)
> +{
> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_fbi =3D fbi->par;
> +
> + =A0 =A0 =A0 if (!mxc_fbi->enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 ipu_dp_disable_channel(mxc_fbi->dp);
> + =A0 =A0 =A0 ipu_dc_disable_channel(mxc_fbi->dc);
> + =A0 =A0 =A0 ipu_idmac_disable_channel(mxc_fbi->ipu_ch);
> + =A0 =A0 =A0 ipu_dmfc_disable_channel(mxc_fbi->dmfc);
> + =A0 =A0 =A0 ipu_di_disable(mxc_fbi->ipu_di);
> +
> + =A0 =A0 =A0 mxc_fbi->enabled =3D 0;
> +}
> +
> +static int calc_vref(struct fb_var_screeninfo *var)
> +{
> + =A0 =A0 =A0 unsigned long htotal, vtotal;
> +
> + =A0 =A0 =A0 htotal =3D var->xres + var->right_margin + var->hsync_len +=
 var->left_margin;
> + =A0 =A0 =A0 vtotal =3D var->yres + var->lower_margin + var->vsync_len +=
 var->upper_margin;
> +
> + =A0 =A0 =A0 if (!htotal || !vtotal)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 60;
> +
> + =A0 =A0 =A0 return PICOS2KHZ(var->pixclock) * 1000 / vtotal / htotal;
> +}
> +
> +static int calc_bandwidth(struct fb_var_screeninfo *var, unsigned int vr=
ef)
> +{
> + =A0 =A0 =A0 return var->xres * var->yres * vref;
> +}
> +
> +static int imx_ipu_fb_set_par(struct fb_info *fbi)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 struct ipu_di_signal_cfg sig_cfg;
> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_fbi =3D fbi->par;
> + =A0 =A0 =A0 u32 out_pixel_fmt;
> + =A0 =A0 =A0 int interlaced =3D 0;
> + =A0 =A0 =A0 struct fb_var_screeninfo *var =3D &fbi->var;
> + =A0 =A0 =A0 int enabled =3D mxc_fbi->enabled;
> +
> + =A0 =A0 =A0 dev_dbg(fbi->device, "Reconfiguring framebuffer %dx%d-%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fbi->var.xres, fbi->var.yres, fbi->var.bits=
_per_pixel);
> +
> + =A0 =A0 =A0 if (enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 imx_ipu_fb_disable(fbi);
> +
> + =A0 =A0 =A0 fbi->fix.line_length =3D var->xres_virtual * var->bits_per_=
pixel / 8;
> +
> + =A0 =A0 =A0 var->yres_virtual =3D var->yres;
> +
> + =A0 =A0 =A0 ret =3D imx_ipu_fb_map_video_memory(fbi);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 if (var->vmode & FB_VMODE_INTERLACED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interlaced =3D 1;
> +
> + =A0 =A0 =A0 memset(&sig_cfg, 0, sizeof(sig_cfg));
> + =A0 =A0 =A0 out_pixel_fmt =3D mxc_fbi->ipu_di_pix_fmt;
> +
> + =A0 =A0 =A0 if (var->vmode & FB_VMODE_INTERLACED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_cfg.interlaced =3D 1;
> + =A0 =A0 =A0 if (var->vmode & FB_VMODE_ODD_FLD_FIRST) /* PAL */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_cfg.odd_field_first =3D 1;
> + =A0 =A0 =A0 if (var->sync & FB_SYNC_EXT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_cfg.ext_clk =3D 1;
> + =A0 =A0 =A0 if (var->sync & FB_SYNC_HOR_HIGH_ACT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_cfg.Hsync_pol =3D 1;
> + =A0 =A0 =A0 if (var->sync & FB_SYNC_VERT_HIGH_ACT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_cfg.Vsync_pol =3D 1;
> + =A0 =A0 =A0 if (!(var->sync & FB_SYNC_CLK_LAT_FALL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_cfg.clk_pol =3D 1;
> + =A0 =A0 =A0 if (var->sync & FB_SYNC_DATA_INVERT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_cfg.data_pol =3D 1;
> + =A0 =A0 =A0 if (!(var->sync & FB_SYNC_OE_LOW_ACT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_cfg.enable_pol =3D 1;
> + =A0 =A0 =A0 if (var->sync & FB_SYNC_CLK_IDLE_EN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_cfg.clkidle_en =3D 1;
> +
> + =A0 =A0 =A0 dev_dbg(fbi->device, "pixclock =3D %lu.%03lu MHz\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PICOS2KHZ(var->pixclock) / 1000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PICOS2KHZ(var->pixclock) % 1000);
> +
> + =A0 =A0 =A0 sig_cfg.width =3D var->xres;
> + =A0 =A0 =A0 sig_cfg.height =3D var->yres;
> + =A0 =A0 =A0 sig_cfg.pixel_fmt =3D out_pixel_fmt;
> + =A0 =A0 =A0 sig_cfg.h_start_width =3D var->left_margin;
> + =A0 =A0 =A0 sig_cfg.h_sync_width =3D var->hsync_len;
> + =A0 =A0 =A0 sig_cfg.h_end_width =3D var->right_margin;
> + =A0 =A0 =A0 sig_cfg.v_start_width =3D var->upper_margin;
> + =A0 =A0 =A0 sig_cfg.v_sync_width =3D var->vsync_len;
> + =A0 =A0 =A0 sig_cfg.v_end_width =3D var->lower_margin;
> + =A0 =A0 =A0 sig_cfg.v_to_h_sync =3D 0;
> +
> + =A0 =A0 =A0 if (mxc_fbi->dp) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ipu_dp_setup_channel(mxc_fbi->dp, m=
xc_fbi->ipu_in_pix_fmt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_pixel_f=
mt, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(fbi->device, "initi=
alizing display processor failed with %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D ipu_dc_init_sync(mxc_fbi->dc, mxc_fbi->ipu_di, inte=
rlaced,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_pixel_fmt, fbi->var.xre=
s);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(fbi->device, "initializing display =
controller failed with %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D ipu_di_init_sync_panel(mxc_fbi->ipu_di,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PICOS2KHZ(v=
ar->pixclock) * 1000UL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &sig_cfg);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(fbi->device, "initializing panel fa=
iled with %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 fbi->mode =3D (struct fb_videomode *)fb_match_mode(var, &fb=
i->modelist);
> + =A0 =A0 =A0 var->xoffset =3D var->yoffset =3D 0;
> +
> + =A0 =A0 =A0 if (fbi->var.vmode & FB_VMODE_INTERLACED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interlaced =3D 1;
> +
> + =A0 =A0 =A0 ret =3D ipu_idmac_init_channel_buffer(mxc_fbi->ipu_ch,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mxc_fbi->ipu_in_pix_fmt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 var->xres, var->yres,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 fbi->fix.line_length,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 IPU_ROTATE_NONE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 fbi->fix.smem_start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0, 0, interlaced);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(fbi->device, "init channel buffer f=
ailed with %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D ipu_dmfc_init_channel(mxc_fbi->dmfc, var->xres);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(fbi->device, "initializing dmfc cha=
nnel failed with %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D ipu_dmfc_alloc_bandwidth(mxc_fbi->dmfc, calc_bandwi=
dth(var, calc_vref(var)));
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(fbi->device, "allocating dmfc bandw=
idth failed with %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 imx_ipu_fb_enable(fbi);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/*
> + * These are the bitfields for each
> + * display depth that we support.
> + */
> +struct imxfb_rgb {
> + =A0 =A0 =A0 struct fb_bitfield =A0 =A0 =A0red;
> + =A0 =A0 =A0 struct fb_bitfield =A0 =A0 =A0green;
> + =A0 =A0 =A0 struct fb_bitfield =A0 =A0 =A0blue;
> + =A0 =A0 =A0 struct fb_bitfield =A0 =A0 =A0transp;
> +};
> +
> +static struct imxfb_rgb def_rgb_8 =3D {
> + =A0 =A0 =A0 .red =A0 =A0=3D { .offset =3D =A05, .length =3D 3, },
> + =A0 =A0 =A0 .green =A0=3D { .offset =3D =A02, .length =3D 3, },
> + =A0 =A0 =A0 .blue =A0 =3D { .offset =3D =A00, .length =3D 2, },
> + =A0 =A0 =A0 .transp =3D { .offset =3D =A00, .length =3D 0, },
> +};
> +
> +static struct imxfb_rgb def_rgb_16 =3D {
> + =A0 =A0 =A0 .red =A0 =A0=3D { .offset =3D 11, .length =3D 5, },
> + =A0 =A0 =A0 .green =A0=3D { .offset =3D =A05, .length =3D 6, },
> + =A0 =A0 =A0 .blue =A0 =3D { .offset =3D =A00, .length =3D 5, },
> + =A0 =A0 =A0 .transp =3D { .offset =3D =A00, .length =3D 0, },
> +};
> +
> +static struct imxfb_rgb def_rgb_24 =3D {
> + =A0 =A0 =A0 .red =A0 =A0=3D { .offset =3D 16, .length =3D 8, },
> + =A0 =A0 =A0 .green =A0=3D { .offset =3D =A08, .length =3D 8, },
> + =A0 =A0 =A0 .blue =A0 =3D { .offset =3D =A00, .length =3D 8, },
> + =A0 =A0 =A0 .transp =3D { .offset =3D =A00, .length =3D 0, },
> +};
> +
> +static struct imxfb_rgb def_rgb_32 =3D {
> + =A0 =A0 =A0 .red =A0 =A0=3D { .offset =3D 16, .length =3D 8, },
> + =A0 =A0 =A0 .green =A0=3D { .offset =3D =A08, .length =3D 8, },
> + =A0 =A0 =A0 .blue =A0 =3D { .offset =3D =A00, .length =3D 8, },
> + =A0 =A0 =A0 .transp =3D { .offset =3D 24, .length =3D 8, },
> +};
> +
> +/*
> + * Check framebuffer variable parameters and adjust to valid values.
> + *
> + * @param =A0 =A0 =A0 var =A0 =A0 =A0framebuffer variable parameters
> + *
> + * @param =A0 =A0 =A0 info =A0 =A0 framebuffer information pointer
> + */
> +static int imx_ipu_fb_check_var(struct fb_var_screeninfo *var, struct fb=
_info *info)
> +{
> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_fbi =3D info->par;
> + =A0 =A0 =A0 struct imxfb_rgb *rgb;
> +
> + =A0 =A0 =A0 /* we don't support xpan, force xres_virtual to be equal to=
 xres */
> + =A0 =A0 =A0 var->xres_virtual =3D var->xres;
> +
> + =A0 =A0 =A0 if (var->yres_virtual < var->yres)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->yres_virtual =3D var->yres;
> +
> + =A0 =A0 =A0 switch (var->bits_per_pixel) {
> + =A0 =A0 =A0 case 8:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rgb =3D &def_rgb_8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 16:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rgb =3D &def_rgb_16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mxc_fbi->ipu_in_pix_fmt =3D IPU_PIX_FMT_RGB=
565;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 24:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rgb =3D &def_rgb_24;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mxc_fbi->ipu_in_pix_fmt =3D IPU_PIX_FMT_BGR=
24;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rgb =3D &def_rgb_32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mxc_fbi->ipu_in_pix_fmt =3D IPU_PIX_FMT_BGR=
32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->bits_per_pixel =3D 24;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rgb =3D &def_rgb_24;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mxc_fbi->ipu_in_pix_fmt =3D IPU_PIX_FMT_BGR=
24;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 var->red =A0 =A0=3D rgb->red;
> + =A0 =A0 =A0 var->green =A0=3D rgb->green;
> + =A0 =A0 =A0 var->blue =A0 =3D rgb->blue;
> + =A0 =A0 =A0 var->transp =3D rgb->transp;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static inline unsigned int chan_to_field(u_int chan, struct fb_bitfield =
*bf)
> +{
> + =A0 =A0 =A0 chan &=3D 0xffff;
> + =A0 =A0 =A0 chan >>=3D 16 - bf->length;
> + =A0 =A0 =A0 return chan << bf->offset;
> +}
> +
> +static int imx_ipu_fb_setcolreg(u_int regno, u_int red, u_int green, u_i=
nt blue,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u_int trans, struct =
fb_info *fbi)
> +{
> + =A0 =A0 =A0 unsigned int val;
> + =A0 =A0 =A0 int ret =3D 1;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If greyscale is true, then we convert the RGB value
> + =A0 =A0 =A0 =A0* to greyscale no matter what visual we are using.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (fbi->var.grayscale)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 red =3D green =3D blue =3D (19595 * red + 3=
8470 * green +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 7471 * blue) >> 16;
> + =A0 =A0 =A0 switch (fbi->fix.visual) {
> + =A0 =A0 =A0 case FB_VISUAL_TRUECOLOR:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 16-bit True Colour. =A0We encode the R=
GB value
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* according to the RGB bitfield informat=
ion.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (regno < 16) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 *pal =3D fbi->pseudo_pa=
lette;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D chan_to_field(red, =
&fbi->var.red);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D chan_to_field(gree=
n, &fbi->var.green);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D chan_to_field(blue=
, &fbi->var.blue);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pal[regno] =3D val;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case FB_VISUAL_STATIC_PSEUDOCOLOR:
> + =A0 =A0 =A0 case FB_VISUAL_PSEUDOCOLOR:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int imx_ipu_fb_blank(int blank, struct fb_info *info)
> +{
> + =A0 =A0 =A0 dev_dbg(info->device, "blank =3D %d\n", blank);
> +
> + =A0 =A0 =A0 switch (blank) {
> + =A0 =A0 =A0 case FB_BLANK_POWERDOWN:
> + =A0 =A0 =A0 case FB_BLANK_VSYNC_SUSPEND:
> + =A0 =A0 =A0 case FB_BLANK_HSYNC_SUSPEND:
> + =A0 =A0 =A0 case FB_BLANK_NORMAL:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 imx_ipu_fb_disable(info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case FB_BLANK_UNBLANK:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 imx_ipu_fb_enable(info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int imx_ipu_fb_pan_display(struct fb_var_screeninfo *var,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct fb_info *info)
> +{
> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_fbi =3D info->par;
> + =A0 =A0 =A0 unsigned long base;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 if (info->var.yoffset =3D var->yoffset)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0; =A0 =A0 =A0 /* No change, do noth=
ing */
> +
> + =A0 =A0 =A0 base =3D var->yoffset * var->xres_virtual * var->bits_per_p=
ixel / 8;
> + =A0 =A0 =A0 base +=3D info->fix.smem_start;
> +
> + =A0 =A0 =A0 ret =3D ipu_wait_for_interrupt(IPU_IRQ_EOF(mxc_fbi->ipu_cha=
nnel_num), 100);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 if (ipu_idmac_update_channel_buffer(mxc_fbi->ipu_ch, 0, bas=
e)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(info->device,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Error updating SDC buf to =
address=3D0x%08lX\n", base);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 info->var.yoffset =3D var->yoffset;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct fb_ops imx_ipu_fb_ops =3D {
> + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 .fb_set_par =A0 =A0 =3D imx_ipu_fb_set_par,
> + =A0 =A0 =A0 .fb_check_var =A0 =3D imx_ipu_fb_check_var,
> + =A0 =A0 =A0 .fb_setcolreg =A0 =3D imx_ipu_fb_setcolreg,
> + =A0 =A0 =A0 .fb_pan_display =3D imx_ipu_fb_pan_display,
> + =A0 =A0 =A0 .fb_fillrect =A0 =A0=3D cfb_fillrect,
> + =A0 =A0 =A0 .fb_copyarea =A0 =A0=3D cfb_copyarea,
> + =A0 =A0 =A0 .fb_imageblit =A0 =3D cfb_imageblit,
> + =A0 =A0 =A0 .fb_blank =A0 =A0 =A0 =3D imx_ipu_fb_blank,
> +};
> +
> +/*
> + * Overlay functions
> + */
> +static int imx_ipu_fb_enable_overlay(struct fb_info *fbi)
> +{
> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_fbi =3D fbi->par;
> +
> + =A0 =A0 =A0 ipu_dmfc_enable_channel(mxc_fbi->dmfc);
> + =A0 =A0 =A0 ipu_idmac_enable_channel(mxc_fbi->ipu_ch);
> + =A0 =A0 =A0 ipu_dp_enable_fg(mxc_fbi->dp);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int imx_ipu_fb_disable_overlay(struct fb_info *fbi)
> +{
> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_fbi =3D fbi->par;
> +
> + =A0 =A0 =A0 ipu_dp_disable_fg(mxc_fbi->dp);
> + =A0 =A0 =A0 ipu_idmac_disable_channel(mxc_fbi->ipu_ch);
> + =A0 =A0 =A0 ipu_dmfc_disable_channel(mxc_fbi->dmfc);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int imx_ipu_fb_set_par_overlay(struct fb_info *fbi)
> +{
> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_fbi =3D fbi->par;
> + =A0 =A0 =A0 struct fb_var_screeninfo *var =3D &fbi->var;
> + =A0 =A0 =A0 struct fb_info *fbi_master =3D mxc_fbi->master;
> + =A0 =A0 =A0 struct fb_var_screeninfo *var_master =3D &fbi_master->var;
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int interlaced =3D 0;
> + =A0 =A0 =A0 int enabled =3D mxc_fbi->enabled;
> +
> + =A0 =A0 =A0 dev_dbg(fbi->device, "Reconfiguring framebuffer %dx%d-%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fbi->var.xres, fbi->var.yres, fbi->var.bits=
_per_pixel);
> +
> + =A0 =A0 =A0 if (enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 imx_ipu_fb_disable_overlay(fbi);
> +
> + =A0 =A0 =A0 fbi->fix.line_length =3D var->xres_virtual *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0var-=
>bits_per_pixel / 8;
> +
> + =A0 =A0 =A0 ret =3D imx_ipu_fb_map_video_memory(fbi);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 ipu_dp_set_window_pos(mxc_fbi->dp, 64, 64);
> +
> + =A0 =A0 =A0 var->xoffset =3D var->yoffset =3D 0;
> +
> + =A0 =A0 =A0 if (var->vmode & FB_VMODE_INTERLACED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interlaced =3D 1;
> +
> + =A0 =A0 =A0 ret =3D ipu_idmac_init_channel_buffer(mxc_fbi->ipu_ch,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mxc_fbi->ipu_in_pix_fmt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 var->xres, var->yres,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 fbi->fix.line_length,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 IPU_ROTATE_NONE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 fbi->fix.smem_start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0, 0, interlaced);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(fbi->device, "init channel buffer f=
ailed with %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D ipu_dmfc_init_channel(mxc_fbi->dmfc, var->xres);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(fbi->device, "initializing dmfc cha=
nnel failed with %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D ipu_dmfc_alloc_bandwidth(mxc_fbi->dmfc, calc_bandwi=
dth(var, calc_vref(var_master)));
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(fbi->device, "allocating dmfc bandw=
idth failed with %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 imx_ipu_fb_enable_overlay(fbi);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int imx_ipu_fb_blank_overlay(int blank, struct fb_info *fbi)
> +{
> + =A0 =A0 =A0 dev_dbg(fbi->device, "blank =3D %d\n", blank);
> +
> + =A0 =A0 =A0 switch (blank) {
> + =A0 =A0 =A0 case FB_BLANK_POWERDOWN:
> + =A0 =A0 =A0 case FB_BLANK_VSYNC_SUSPEND:
> + =A0 =A0 =A0 case FB_BLANK_HSYNC_SUSPEND:
> + =A0 =A0 =A0 case FB_BLANK_NORMAL:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 imx_ipu_fb_disable_overlay(fbi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case FB_BLANK_UNBLANK:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 imx_ipu_fb_enable_overlay(fbi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct fb_ops imx_ipu_fb_overlay_ops =3D {
> + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 .fb_set_par =A0 =A0 =3D imx_ipu_fb_set_par_overlay,
> + =A0 =A0 =A0 .fb_check_var =A0 =3D imx_ipu_fb_check_var,
> + =A0 =A0 =A0 .fb_setcolreg =A0 =3D imx_ipu_fb_setcolreg,
> + =A0 =A0 =A0 .fb_pan_display =3D imx_ipu_fb_pan_display,
> + =A0 =A0 =A0 .fb_fillrect =A0 =A0=3D cfb_fillrect,
> + =A0 =A0 =A0 .fb_copyarea =A0 =A0=3D cfb_copyarea,
> + =A0 =A0 =A0 .fb_imageblit =A0 =3D cfb_imageblit,
> + =A0 =A0 =A0 .fb_blank =A0 =A0 =A0 =3D imx_ipu_fb_blank_overlay,
> +};
> +
> +static struct fb_info *imx_ipu_fb_init_fbinfo(struct device *dev, struct=
 fb_ops *ops)
> +{
> + =A0 =A0 =A0 struct fb_info *fbi;
> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_fbi;
> +
> + =A0 =A0 =A0 fbi =3D framebuffer_alloc(sizeof(struct imx_ipu_fb_info), d=
ev);
> + =A0 =A0 =A0 if (!fbi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 BUG_ON(fbi->par =3D NULL);
> + =A0 =A0 =A0 mxc_fbi =3D fbi->par;
> +
> + =A0 =A0 =A0 fbi->var.activate =3D FB_ACTIVATE_NOW;
> +
> + =A0 =A0 =A0 fbi->fbops =3D ops;
> + =A0 =A0 =A0 fbi->flags =3D FBINFO_FLAG_DEFAULT;
> + =A0 =A0 =A0 fbi->pseudo_palette =3D mxc_fbi->pseudo_palette;
> +
> + =A0 =A0 =A0 fb_alloc_cmap(&fbi->cmap, 16, 0);
> +
> + =A0 =A0 =A0 return fbi;
> +}
> +
> +static int imx_ipu_fb_init_overlay(struct platform_device *pdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct fb_info *fbi_master, int ipu_channel)
> +{
> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_fbi_master =3D fbi_master->par;
> + =A0 =A0 =A0 struct fb_info *ovlfbi;
> + =A0 =A0 =A0 struct imx_ipu_fb_info *ovl_mxc_fbi;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ovlfbi =3D imx_ipu_fb_init_fbinfo(&pdev->dev, &imx_ipu_fb_o=
verlay_ops);
> + =A0 =A0 =A0 if (!ovlfbi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 ovl_mxc_fbi =3D ovlfbi->par;
> + =A0 =A0 =A0 ovl_mxc_fbi->ipu_ch =3D ipu_idmac_get(ipu_channel);
> + =A0 =A0 =A0 ovl_mxc_fbi->dmfc =3D ipu_dmfc_get(ipu_channel);
> + =A0 =A0 =A0 ovl_mxc_fbi->ipu_di =3D -1;
> + =A0 =A0 =A0 ovl_mxc_fbi->dp =3D mxc_fbi_master->dp;
> + =A0 =A0 =A0 ovl_mxc_fbi->master =3D fbi_master;
> + =A0 =A0 =A0 mxc_fbi_master->slave =3D ovlfbi;
> +
> + =A0 =A0 =A0 ovlfbi->var.xres =3D 240;
> + =A0 =A0 =A0 ovlfbi->var.yres =3D 320;
> + =A0 =A0 =A0 ovlfbi->var.yres_virtual =3D ovlfbi->var.yres;
> + =A0 =A0 =A0 ovlfbi->var.xres_virtual =3D ovlfbi->var.xres;
> + =A0 =A0 =A0 imx_ipu_fb_check_var(&ovlfbi->var, ovlfbi);
> + =A0 =A0 =A0 imx_ipu_fb_set_fix(ovlfbi);
> +
> + =A0 =A0 =A0 ret =3D register_framebuffer(ovlfbi);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 framebuffer_release(ovlfbi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ipu_dp_set_global_alpha(ovl_mxc_fbi->dp, 1, 0x80, 1);
> + =A0 =A0 =A0 ipu_dp_set_color_key(ovl_mxc_fbi->dp, 0, 0);
> +
> + =A0 =A0 =A0 imx_ipu_fb_set_par_overlay(ovlfbi);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void imx_ipu_fb_exit_overlay(struct platform_device *pdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct fb_info *fbi_master, int ipu_channel)
> +{
> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_fbi_master =3D fbi_master->par;
> + =A0 =A0 =A0 struct fb_info *ovlfbi =3D mxc_fbi_master->slave;
> + =A0 =A0 =A0 struct imx_ipu_fb_info *ovl_mxc_fbi =3D ovlfbi->par;
> +
> + =A0 =A0 =A0 imx_ipu_fb_blank_overlay(FB_BLANK_POWERDOWN, ovlfbi);
> +
> + =A0 =A0 =A0 unregister_framebuffer(ovlfbi);
> +
> + =A0 =A0 =A0 ipu_idmac_put(ovl_mxc_fbi->ipu_ch);
> + =A0 =A0 =A0 ipu_dmfc_free_bandwidth(ovl_mxc_fbi->dmfc);
> + =A0 =A0 =A0 ipu_dmfc_put(ovl_mxc_fbi->dmfc);
> +
> + =A0 =A0 =A0 framebuffer_release(ovlfbi);
> +}
> +
> +static int imx_ipu_fb_find_mode(struct fb_info *fbi)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 struct fb_videomode *mode_array;
> + =A0 =A0 =A0 struct fb_modelist *modelist;
> + =A0 =A0 =A0 struct fb_var_screeninfo *var =3D &fbi->var;
> + =A0 =A0 =A0 int i =3D 0;
> +
> + =A0 =A0 =A0 list_for_each_entry(modelist, &fbi->modelist, list)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> +
> + =A0 =A0 =A0 mode_array =3D kmalloc(sizeof (struct fb_modelist) * i, GFP=
_KERNEL);
> + =A0 =A0 =A0 if (!mode_array)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 i =3D 0;
> + =A0 =A0 =A0 list_for_each_entry(modelist, &fbi->modelist, list)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode_array[i++] =3D modelist->mode;
> +
> + =A0 =A0 =A0 ret =3D fb_find_mode(&fbi->var, fbi, NULL, mode_array, i, N=
ULL, 16);
> + =A0 =A0 =A0 if (ret =3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 dev_dbg(fbi->device, "found %dx%d-%d hs:%d:%d:%d vs:%d:%d:%=
d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->xres, var->yres, var->=
bits_per_pixel,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->hsync_len, var->left_m=
argin, var->right_margin,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->vsync_len, var->upper_=
margin, var->lower_margin);
> +
> + =A0 =A0 =A0 kfree(mode_array);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __devinit imx_ipu_fb_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct fb_info *fbi;
> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_fbi;
> + =A0 =A0 =A0 struct ipuv3_fb_platform_data *plat_data =3D pdev->dev.plat=
form_data;
> + =A0 =A0 =A0 int ret =3D 0, i;
> +
> + =A0 =A0 =A0 pdev->dev.coherent_dma_mask =3D DMA_BIT_MASK(32);
> +
> + =A0 =A0 =A0 fbi =3D imx_ipu_fb_init_fbinfo(&pdev->dev, &imx_ipu_fb_ops);
> + =A0 =A0 =A0 if (!fbi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 mxc_fbi =3D fbi->par;
> +
> + =A0 =A0 =A0 mxc_fbi->ipu_channel_num =3D plat_data->ipu_channel_bg;
> + =A0 =A0 =A0 mxc_fbi->dc =3D plat_data->dc_channel;
> + =A0 =A0 =A0 mxc_fbi->ipu_di_pix_fmt =3D plat_data->interface_pix_fmt;
> + =A0 =A0 =A0 mxc_fbi->ipu_di =3D pdev->id;
> +
> + =A0 =A0 =A0 mxc_fbi->ipu_ch =3D ipu_idmac_get(plat_data->ipu_channel_bg=
);
> + =A0 =A0 =A0 if (IS_ERR(mxc_fbi->ipu_ch)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(mxc_fbi->ipu_ch);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_request_ipu;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mxc_fbi->dmfc =3D ipu_dmfc_get(plat_data->ipu_channel_bg);
> + =A0 =A0 =A0 if (IS_ERR(mxc_fbi->ipu_ch)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(mxc_fbi->ipu_ch);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_request_dmfc;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (plat_data->dp_channel >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mxc_fbi->dp =3D ipu_dp_get(plat_data->dp_ch=
annel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(mxc_fbi->dp)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(mxc_fbi->ip=
u_ch);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_request_dp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 fbi->var.yres_virtual =3D fbi->var.yres;
> +
> + =A0 =A0 =A0 INIT_LIST_HEAD(&fbi->modelist);
> + =A0 =A0 =A0 for (i =3D 0; i < plat_data->num_modes; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb_add_videomode(&plat_data->modes[i], &fbi=
->modelist);
> +
> + =A0 =A0 =A0 if (plat_data->flags & IMX_IPU_FB_USE_MODEDB) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < num_fb_modes; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb_add_videomode(&fb_modes[=
i], &fbi->modelist);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 imx_ipu_fb_find_mode(fbi);
> +
> + =A0 =A0 =A0 imx_ipu_fb_check_var(&fbi->var, fbi);
> + =A0 =A0 =A0 imx_ipu_fb_set_fix(fbi);
> + =A0 =A0 =A0 ret =3D register_framebuffer(fbi);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_register;
> +
> + =A0 =A0 =A0 imx_ipu_fb_set_par(fbi);
> + =A0 =A0 =A0 imx_ipu_fb_blank(FB_BLANK_UNBLANK, fbi);
> +
> + =A0 =A0 =A0 if (plat_data->ipu_channel_fg >=3D 0 && plat_data->flags & =
IMX_IPU_FB_USE_OVERLAY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 imx_ipu_fb_init_overlay(pdev, fbi, plat_dat=
a->ipu_channel_fg);
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, fbi);
> +
> + =A0 =A0 =A0 return 0;
> +
> +failed_register:
> + =A0 =A0 =A0 if (plat_data->dp_channel >=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ipu_dp_put(mxc_fbi->dp);
> +failed_request_dp:
> + =A0 =A0 =A0 ipu_dmfc_put(mxc_fbi->dmfc);
> +failed_request_dmfc:
> + =A0 =A0 =A0 ipu_idmac_put(mxc_fbi->ipu_ch);
> +failed_request_ipu:
> + =A0 =A0 =A0 fb_dealloc_cmap(&fbi->cmap);
> + =A0 =A0 =A0 framebuffer_release(fbi);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int __devexit imx_ipu_fb_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct fb_info *fbi =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_fbi =3D fbi->par;
> + =A0 =A0 =A0 struct ipuv3_fb_platform_data *plat_data =3D pdev->dev.plat=
form_data;
> +
> + =A0 =A0 =A0 if (plat_data->ipu_channel_fg >=3D 0 && plat_data->flags & =
IMX_IPU_FB_USE_OVERLAY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 imx_ipu_fb_exit_overlay(pdev, fbi, plat_dat=
a->ipu_channel_fg);
> +
> + =A0 =A0 =A0 imx_ipu_fb_blank(FB_BLANK_POWERDOWN, fbi);
> +
> + =A0 =A0 =A0 dma_free_writecombine(fbi->device, fbi->fix.smem_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fbi->screen_bas=
e, fbi->fix.smem_start);
> +
> + =A0 =A0 =A0 if (&fbi->cmap)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb_dealloc_cmap(&fbi->cmap);
> +
> + =A0 =A0 =A0 unregister_framebuffer(fbi);
> +
> + =A0 =A0 =A0 if (plat_data->dp_channel >=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ipu_dp_put(mxc_fbi->dp);
> + =A0 =A0 =A0 ipu_dmfc_free_bandwidth(mxc_fbi->dmfc);
> + =A0 =A0 =A0 ipu_dmfc_put(mxc_fbi->dmfc);
> + =A0 =A0 =A0 ipu_idmac_put(mxc_fbi->ipu_ch);
> +
> + =A0 =A0 =A0 framebuffer_release(fbi);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver imx_ipu_fb_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D DRIVER_NAME,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =3D imx_ipu_fb_probe,
> + =A0 =A0 =A0 .remove =3D __devexit_p(imx_ipu_fb_remove),
> +};
> +
> +static int __init imx_ipu_fb_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&imx_ipu_fb_driver);
> +}
> +
> +static void __exit imx_ipu_fb_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&imx_ipu_fb_driver);
> +}
> +
> +module_init(imx_ipu_fb_init);
> +module_exit(imx_ipu_fb_exit);
> +
> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> +MODULE_DESCRIPTION("i.MX framebuffer driver");
> +MODULE_LICENSE("GPL");
> +MODULE_SUPPORTED_DEVICE("fb");
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
