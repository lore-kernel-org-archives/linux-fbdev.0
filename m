From: Erik Gilling <konkers@android.com>
Date: Wed, 25 Aug 2010 22:04:12 +0000
Subject: Re: [PATCH] video: tegra: add tegra display controller and fb driver
Message-Id: <AANLkTikXUU23ouXeR_40SAPay94FnUb_DUEEjCTpenSg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1281568272-25871-1-git-send-email-konkers@android.com>
In-Reply-To: <1281568272-25871-1-git-send-email-konkers@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

ping.  any more comments.  I'd like to have this ready for the next
merge window.

On Wed, Aug 11, 2010 at 4:11 PM, Erik Gilling <konkers@android.com> wrote:
> This patch supersedes the previous framebuffer patch
>
> Supports:
> =A0 =A0 =A0 =A0* panel setup
> =A0 =A0 =A0 =A0* overlays
> =A0 =A0 =A0 =A0* suspend / resume
>
> Notable ommisions:
> =A0 =A0 =A0 =A0* support for anything but lvds panels
> =A0 =A0 =A0 =A0* inegration with nvhost driver to sync updates with 3D
> =A0 =A0 =A0 =A0* FB physical geometry is not set
> =A0 =A0 =A0 =A0* lacks interface to set overlay/window x,y offset
>
> Signed-off-by: Erik Gilling <konkers@android.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Travis Geiselbrecht <travis@palm.com>
> ---
> =A0arch/arm/mach-tegra/include/mach/dc.h | =A0152 ++++++
> =A0arch/arm/mach-tegra/include/mach/fb.h | =A0 44 ++
> =A0drivers/video/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/video/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/video/tegra/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 15 +
> =A0drivers/video/tegra/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0drivers/video/tegra/dc/Makefile =A0 =A0 =A0 | =A0 =A02 +
> =A0drivers/video/tegra/dc/dc.c =A0 =A0 =A0 =A0 =A0 | =A0894 +++++++++++++=
++++++++++++++++++++
> =A0drivers/video/tegra/dc/dc_priv.h =A0 =A0 =A0| =A0 86 ++++
> =A0drivers/video/tegra/dc/dc_reg.h =A0 =A0 =A0 | =A0342 +++++++++++++
> =A0drivers/video/tegra/dc/rgb.c =A0 =A0 =A0 =A0 =A0| =A0 63 +++
> =A0drivers/video/tegra/fb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0311 +++++++++=
+++
> =A012 files changed, 1913 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/mach-tegra/include/mach/dc.h
> =A0create mode 100644 arch/arm/mach-tegra/include/mach/fb.h
> =A0create mode 100644 drivers/video/tegra/Kconfig
> =A0create mode 100644 drivers/video/tegra/Makefile
> =A0create mode 100644 drivers/video/tegra/dc/Makefile
> =A0create mode 100644 drivers/video/tegra/dc/dc.c
> =A0create mode 100644 drivers/video/tegra/dc/dc_priv.h
> =A0create mode 100644 drivers/video/tegra/dc/dc_reg.h
> =A0create mode 100644 drivers/video/tegra/dc/rgb.c
> =A0create mode 100644 drivers/video/tegra/fb.c
>
> diff --git a/arch/arm/mach-tegra/include/mach/dc.h b/arch/arm/mach-tegra/=
include/mach/dc.h
> new file mode 100644
> index 0000000..b8a0e7a
> --- /dev/null
> +++ b/arch/arm/mach-tegra/include/mach/dc.h
> @@ -0,0 +1,152 @@
> +/*
> + * arch/arm/mach-tegra/include/mach/dc.h
> + *
> + * Copyright (C) 2010 Google, Inc.
> + *
> + * Author:
> + * =A0 =A0 Erik Gilling <konkers@google.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __MACH_TEGRA_DC_H
> +#define __MACH_TEGRA_DC_H
> +
> +
> +#define TEGRA_MAX_DC =A0 =A0 =A0 =A0 =A0 2
> +#define DC_N_WINDOWS =A0 =A0 =A0 =A0 =A0 3
> +
> +struct tegra_dc_blend {
> + =A0 =A0 =A0 u32 =A0 =A0 nokey;
> + =A0 =A0 =A0 u32 =A0 =A0 one_win;
> + =A0 =A0 =A0 u32 =A0 =A0 two_win_x;
> + =A0 =A0 =A0 u32 =A0 =A0 two_win_y;
> + =A0 =A0 =A0 u32 =A0 =A0 three_win_xy;
> +};
> +
> +#define BLEND(key, control, weight0, weight1) =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 (CKEY_ ## key | BLEND_CONTROL_ ## control | =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0BLEND_WEIGHT0(weight0) | BLEND_WEIGHT0(weight1))
> +
> +struct tegra_dc_mode {
> + =A0 =A0 =A0 int =A0 =A0 pclk;
> + =A0 =A0 =A0 int =A0 =A0 h_ref_to_sync;
> + =A0 =A0 =A0 int =A0 =A0 v_ref_to_sync;
> + =A0 =A0 =A0 int =A0 =A0 h_sync_width;
> + =A0 =A0 =A0 int =A0 =A0 v_sync_width;
> + =A0 =A0 =A0 int =A0 =A0 h_back_porch;
> + =A0 =A0 =A0 int =A0 =A0 v_back_porch;
> + =A0 =A0 =A0 int =A0 =A0 h_active;
> + =A0 =A0 =A0 int =A0 =A0 v_active;
> + =A0 =A0 =A0 int =A0 =A0 h_front_porch;
> + =A0 =A0 =A0 int =A0 =A0 v_front_porch;
> +};
> +
> +enum {
> + =A0 =A0 =A0 TEGRA_DC_OUT_RGB,
> +};
> +
> +struct tegra_dc_out {
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type;
> +
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0order;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0align;
> +
> + =A0 =A0 =A0 struct tegra_dc_mode =A0 =A0*modes;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 n_modes;
> +};
> +
> +#define TEGRA_DC_ALIGN_MSB =A0 =A0 =A0 =A0 =A0 =A0 0
> +#define TEGRA_DC_ALIGN_LSB =A0 =A0 =A0 =A0 =A0 =A0 1
> +
> +#define TEGRA_DC_ORDER_RED_BLUE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
> +#define TEGRA_DC_ORDER_BLUE_RED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> +
> +struct tegra_dc;
> +
> +struct tegra_dc_win {
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0idx;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fmt;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags;
> +
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*virt_addr;
> + =A0 =A0 =A0 dma_addr_t =A0 =A0 =A0 =A0 =A0 =A0 =A0phys_addr;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0x;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0y;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0h;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_w;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_h;
> +
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dirty;
> + =A0 =A0 =A0 struct tegra_dc =A0 =A0 =A0 =A0 *dc;
> +};
> +
> +#define TEGRA_WIN_FLAG_ENABLED =A0 =A0 =A0 =A0 (1 << 0)
> +#define TEGRA_WIN_FLAG_COLOR_EXPAND =A0 =A0(1 << 1)
> +
> +/* Note: These are the actual values written to the DC_WIN_COLOR_DEPTH r=
egister
> + * and may change in new tegra architectures.
> + */
> +#define TEGRA_WIN_FMT_P1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> +#define TEGRA_WIN_FMT_P2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
> +#define TEGRA_WIN_FMT_P4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2
> +#define TEGRA_WIN_FMT_P8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3
> +#define TEGRA_WIN_FMT_B4G4R4A4 =A0 =A0 =A0 =A0 4
> +#define TEGRA_WIN_FMT_B5G5R5A =A0 =A0 =A0 =A0 =A05
> +#define TEGRA_WIN_FMT_B5G6R5 =A0 =A0 =A0 =A0 =A0 6
> +#define TEGRA_WIN_FMT_AB5G5R5 =A0 =A0 =A0 =A0 =A07
> +#define TEGRA_WIN_FMT_B8G8R8A8 =A0 =A0 =A0 =A0 12
> +#define TEGRA_WIN_FMT_R8G8B8A8 =A0 =A0 =A0 =A0 13
> +#define TEGRA_WIN_FMT_B6x2G6x2R6x2A8 =A0 14
> +#define TEGRA_WIN_FMT_R6x2G6x2B6x2A8 =A0 15
> +#define TEGRA_WIN_FMT_YCbCr422 =A0 =A0 =A0 =A0 16
> +#define TEGRA_WIN_FMT_YUV422 =A0 =A0 =A0 =A0 =A0 17
> +#define TEGRA_WIN_FMT_YCbCr420P =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A018
> +#define TEGRA_WIN_FMT_YUV420P =A0 =A0 =A0 =A0 =A019
> +#define TEGRA_WIN_FMT_YCbCr422P =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A020
> +#define TEGRA_WIN_FMT_YUV422P =A0 =A0 =A0 =A0 =A021
> +#define TEGRA_WIN_FMT_YCbCr422R =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A022
> +#define TEGRA_WIN_FMT_YUV422R =A0 =A0 =A0 =A0 =A023
> +#define TEGRA_WIN_FMT_YCbCr422RA =A0 =A0 =A0 24
> +#define TEGRA_WIN_FMT_YUV422RA =A0 =A0 =A0 =A0 25
> +
> +struct tegra_fb_data {
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 win;
> +
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 xres;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 yres;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 bits_per_pixel;
> +};
> +
> +struct tegra_dc_platform_data {
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 flags;
> + =A0 =A0 =A0 struct tegra_dc_out =A0 =A0 *default_out;
> + =A0 =A0 =A0 struct tegra_fb_data =A0 =A0*fb;
> +};
> +
> +#define TEGRA_DC_FLAG_ENABLED =A0 =A0 =A0 =A0 =A0(1 << 0)
> +
> +struct tegra_dc *tegra_dc_get_dc(unsigned idx);
> +struct tegra_dc_win *tegra_dc_get_window(struct tegra_dc *dc, unsigned w=
in);
> +
> +/* tegra_dc_update_windows and tegra_dc_sync_windows do not support wind=
ows
> + * with differenct dcs in one call
> + */
> +int tegra_dc_update_windows(struct tegra_dc_win *windows[], int n);
> +int tegra_dc_sync_windows(struct tegra_dc_win *windows[], int n);
> +
> +/* will probably be replaced with an interface describing the window ord=
er */
> +void tegra_dc_set_blending(struct tegra_dc *dc, struct tegra_dc_blend *b=
lend);
> +
> +int tegra_dc_set_mode(struct tegra_dc *dc, struct tegra_dc_mode *mode);
> +
> +#endif
> diff --git a/arch/arm/mach-tegra/include/mach/fb.h b/arch/arm/mach-tegra/=
include/mach/fb.h
> new file mode 100644
> index 0000000..9e5f7f8
> --- /dev/null
> +++ b/arch/arm/mach-tegra/include/mach/fb.h
> @@ -0,0 +1,44 @@
> +/*
> + * arch/arm/mach-tegra/include/mach/fb.h
> + *
> + * Copyright (C) 2010 Google, Inc.
> + *
> + * Author:
> + * =A0 =A0 Erik Gilling <konkers@google.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __MACH_TEGRA_FB_H
> +#define __MACH_TEGRA_FB_H
> +
> +#ifdef CONFIG_FB_TEGRA
> +struct tegra_fb_info *tegra_fb_register(struct platform_device *pdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct tegra_dc *dc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct tegra_fb_data *fb_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct resource *fb_mem);
> +void tegra_fb_unregister(struct tegra_fb_info *fb_info);
> +#else
> +static inline
> +struct tegra_fb_info *tegra_fb_register(struct platform_device *pdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct tegra_dc *dc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct tegra_fb_data *fb_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct resource *fb_mem)
> +{
> + =A0 =A0 =A0 return NULL;
> +}
> +
> +static inline void tegra_fb_unregister(struct tegra_fb_info *fb_info)
> +{
> +}
> +#endif
> +
> +#endif
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 3d94a14..1eb0ac1 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2231,6 +2231,7 @@ config FB_BROADSHEET
>
> =A0source "drivers/video/omap/Kconfig"
> =A0source "drivers/video/omap2/Kconfig"
> +source "drivers/video/tegra/Kconfig"
>
> =A0source "drivers/video/backlight/Kconfig"
> =A0source "drivers/video/display/Kconfig"
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index ddc2af2..21b527d 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -131,6 +131,7 @@ obj-$(CONFIG_FB_CARMINE) =A0 =A0 =A0 =A0 =A0+=3D carm=
inefb.o
> =A0obj-$(CONFIG_FB_MB862XX) =A0 =A0 =A0 =A0 +=3D mb862xx/
> =A0obj-$(CONFIG_FB_MSM) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D msm/
> =A0obj-$(CONFIG_FB_NUC900) =A0 =A0 =A0 =A0 =A0 +=3D nuc900fb.o
> +obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D tegra/
>
> =A0# Platform or fallback drivers go here
> =A0obj-$(CONFIG_FB_UVESA) =A0 =A0 =A0 =A0 =A0 =A0+=3D uvesafb.o
> diff --git a/drivers/video/tegra/Kconfig b/drivers/video/tegra/Kconfig
> new file mode 100644
> index 0000000..b01dc95
> --- /dev/null
> +++ b/drivers/video/tegra/Kconfig
> @@ -0,0 +1,15 @@
> +config TEGRA_DC
> + =A0 =A0 =A0 tristate "Tegra Display Contoller"
> + =A0 =A0 =A0 depends on ARCH_TEGRA
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Tegra display controller support.
> +
> +config FB_TEGRA
> + =A0 =A0 =A0 tristate "Tegra Framebuffer driver"
> + =A0 =A0 =A0 depends on TEGRA_DC && FB =3D y
> + =A0 =A0 =A0 select FB_CFB_FILLRECT
> + =A0 =A0 =A0 select FB_CFB_COPYAREA
> + =A0 =A0 =A0 select FB_CFB_IMAGEBLIT
> + =A0 =A0 =A0 default FB
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Framebuffer device support for the Tegra display contro=
ller.
> diff --git a/drivers/video/tegra/Makefile b/drivers/video/tegra/Makefile
> new file mode 100644
> index 0000000..8f9d0e2
> --- /dev/null
> +++ b/drivers/video/tegra/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_TEGRA_DC) +=3D dc/
> +obj-$(CONFIG_FB_TEGRA) +=3D fb.o
> diff --git a/drivers/video/tegra/dc/Makefile b/drivers/video/tegra/dc/Mak=
efile
> new file mode 100644
> index 0000000..3ecb63c
> --- /dev/null
> +++ b/drivers/video/tegra/dc/Makefile
> @@ -0,0 +1,2 @@
> +obj-y +=3D dc.o
> +obj-y +=3D rgb.o
> \ No newline at end of file
> diff --git a/drivers/video/tegra/dc/dc.c b/drivers/video/tegra/dc/dc.c
> new file mode 100644
> index 0000000..261bced
> --- /dev/null
> +++ b/drivers/video/tegra/dc/dc.c
> @@ -0,0 +1,894 @@
> +/*
> + * drivers/video/tegra/dc/dc.c
> + *
> + * Copyright (C) 2010 Google, Inc.
> + * Author: Erik Gilling <konkers@android.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/workqueue.h>
> +#include <linux/ktime.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +
> +#include <mach/clk.h>
> +#include <mach/dc.h>
> +#include <mach/fb.h>
> +
> +#include "dc_reg.h"
> +#include "dc_priv.h"
> +
> +struct tegra_dc_blend tegra_dc_blend_modes[][DC_N_WINDOWS] =3D {
> + =A0 =A0 =A0 {{.nokey =3D BLEND(NOKEY, FIX, 0xff, 0xff),
> + =A0 =A0 =A0 =A0 .one_win =3D BLEND(NOKEY, FIX, 0xff, 0xff),
> + =A0 =A0 =A0 =A0 .two_win_x =3D BLEND(NOKEY, FIX, 0x00, 0x00),
> + =A0 =A0 =A0 =A0 .two_win_y =3D BLEND(NOKEY, DEPENDANT, 0x00, 0x00),
> + =A0 =A0 =A0 =A0 .three_win_xy =3D BLEND(NOKEY, FIX, 0x00, 0x00)},
> + =A0 =A0 =A0 =A0{.nokey =3D BLEND(NOKEY, FIX, 0xff, 0xff),
> + =A0 =A0 =A0 =A0 .one_win =3D BLEND(NOKEY, FIX, 0xff, 0xff),
> + =A0 =A0 =A0 =A0 .two_win_x =3D BLEND(NOKEY, FIX, 0xff, 0xff),
> + =A0 =A0 =A0 =A0 .two_win_y =3D BLEND(NOKEY, DEPENDANT, 0x00, 0x00),
> + =A0 =A0 =A0 =A0 .three_win_xy =3D BLEND(NOKEY, DEPENDANT, 0x00, 0x00)},
> + =A0 =A0 =A0 =A0{.nokey =3D BLEND(NOKEY, FIX, 0xff, 0xff),
> + =A0 =A0 =A0 =A0 .one_win =3D BLEND(NOKEY, FIX, 0xff, 0xff),
> + =A0 =A0 =A0 =A0 .two_win_x =3D BLEND(NOKEY, ALPHA, 0xff, 0xff),
> + =A0 =A0 =A0 =A0 .two_win_y =3D BLEND(NOKEY, ALPHA, 0xff, 0xff),
> + =A0 =A0 =A0 =A0 .three_win_xy =3D BLEND(NOKEY, ALPHA, 0xff, 0xff)}
> + =A0 =A0 =A0 }
> +};
> +
> +struct tegra_dc *tegra_dcs[TEGRA_MAX_DC];
> +
> +DEFINE_MUTEX(tegra_dc_lock);
> +
> +static inline int tegra_dc_fmt_bpp(int fmt)
> +{
> + =A0 =A0 =A0 switch (fmt) {
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_P1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> +
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_P2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 2;
> +
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_P4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 4;
> +
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_P8:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 8;
> +
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_B4G4R4A4:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_B5G5R5A:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_B5G6R5:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_AB5G5R5:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 16;
> +
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_B8G8R8A8:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_R8G8B8A8:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_B6x2G6x2R6x2A8:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_R6x2G6x2B6x2A8:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 32;
> +
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_YCbCr422:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_YUV422:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_YCbCr420P:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_YUV420P:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_YCbCr422P:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_YUV422P:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_YCbCr422R:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_YUV422R:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_YCbCr422RA:
> + =A0 =A0 =A0 case TEGRA_WIN_FMT_YUV422RA:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: need to know the bpp of these for=
mats */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#define DUMP_REG(a) do { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 snprintf(buff, sizeof(buff), "%-32s\t%03x\t%08lx\n", \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#a, a, tegra_dc_readl(dc, a)); =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 print(data, buff); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 } while (0)
> +
> +static void _dump_regs(struct tegra_dc *dc, void *data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void (* print)(void *data, c=
onst char *str))
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 char buff[256];
> +
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_GENERAL_INCR_SYNCPT);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_GENERAL_INCR_SYNCPT_CNTRL);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_GENERAL_INCR_SYNCPT_ERROR);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_WIN_A_INCR_SYNCPT);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_WIN_A_INCR_SYNCPT_CNTRL);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_WIN_A_INCR_SYNCPT_ERROR);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_WIN_B_INCR_SYNCPT);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_WIN_B_INCR_SYNCPT_CNTRL);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_WIN_B_INCR_SYNCPT_ERROR);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_WIN_C_INCR_SYNCPT);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_WIN_C_INCR_SYNCPT_CNTRL);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_WIN_C_INCR_SYNCPT_ERROR);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_CONT_SYNCPT_VSYNC);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_DISPLAY_COMMAND_OPTION0);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_DISPLAY_COMMAND);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_SIGNAL_RAISE);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_INT_STATUS);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_INT_MASK);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_INT_ENABLE);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_INT_TYPE);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_INT_POLARITY);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_SIGNAL_RAISE1);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_SIGNAL_RAISE2);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_SIGNAL_RAISE3);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_STATE_ACCESS);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_STATE_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_DISPLAY_WINDOW_HEADER);
> + =A0 =A0 =A0 DUMP_REG(DC_CMD_REG_ACT_CONTROL);
> +
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_DISP_SIGNAL_OPTIONS0);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_DISP_SIGNAL_OPTIONS1);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_DISP_WIN_OPTIONS);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_MEM_HIGH_PRIORITY);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_MEM_HIGH_PRIORITY_TIMER);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_DISP_TIMING_OPTIONS);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_REF_TO_SYNC);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_SYNC_WIDTH);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_BACK_PORCH);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_DISP_ACTIVE);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_FRONT_PORCH);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE0_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE0_POSITION_A);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE0_POSITION_B);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE0_POSITION_C);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE0_POSITION_D);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE1_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE1_POSITION_A);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE1_POSITION_B);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE1_POSITION_C);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE1_POSITION_D);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE2_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE2_POSITION_A);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE2_POSITION_B);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE2_POSITION_C);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_H_PULSE2_POSITION_D);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_V_PULSE0_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_V_PULSE0_POSITION_A);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_V_PULSE0_POSITION_B);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_V_PULSE0_POSITION_C);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_V_PULSE1_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_V_PULSE1_POSITION_A);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_V_PULSE1_POSITION_B);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_V_PULSE1_POSITION_C);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_V_PULSE2_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_V_PULSE2_POSITION_A);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_V_PULSE3_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_V_PULSE3_POSITION_A);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_M0_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_M1_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_DI_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_PP_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_PP_SELECT_A);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_PP_SELECT_B);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_PP_SELECT_C);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_PP_SELECT_D);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_DISP_CLOCK_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_DISP_INTERFACE_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_DISP_COLOR_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_SHIFT_CLOCK_OPTIONS);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_DATA_ENABLE_OPTIONS);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_SERIAL_INTERFACE_OPTIONS);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_LCD_SPI_OPTIONS);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_BORDER_COLOR);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_COLOR_KEY0_LOWER);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_COLOR_KEY0_UPPER);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_COLOR_KEY1_LOWER);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_COLOR_KEY1_UPPER);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_CURSOR_FOREGROUND);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_CURSOR_BACKGROUND);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_CURSOR_START_ADDR);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_CURSOR_START_ADDR_NS);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_CURSOR_POSITION);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_CURSOR_POSITION_NS);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_INIT_SEQ_CONTROL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_SPI_INIT_SEQ_DATA_A);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_SPI_INIT_SEQ_DATA_B);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_SPI_INIT_SEQ_DATA_C);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_SPI_INIT_SEQ_DATA_D);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_DC_MCCIF_FIFOCTRL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_MCCIF_DISPLAY0A_HYST);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_MCCIF_DISPLAY0B_HYST);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_MCCIF_DISPLAY0C_HYST);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_MCCIF_DISPLAY1B_HYST);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_DAC_CRT_CTRL);
> + =A0 =A0 =A0 DUMP_REG(DC_DISP_DISP_MISC_CONTROL);
> +
> +
> + =A0 =A0 =A0 for (i =3D 0; i < 3; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 print(data, "\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(buff, sizeof(buff), "WINDOW %c:\n"=
, 'A' + i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 print(data, buff);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, WINDOW_A_SELECT << i,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_CMD_DISP=
LAY_WINDOW_HEADER);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_CMD_DISPLAY_WINDOW_HEADER);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_WIN_OPTIONS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_BYTE_SWAP);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_BUFFER_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_COLOR_DEPTH);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_POSITION);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_SIZE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_PRESCALED_SIZE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_H_INITIAL_DDA);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_V_INITIAL_DDA);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_DDA_INCREMENT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_LINE_STRIDE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_BUF_STRIDE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_BLEND_NOKEY);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_BLEND_1WIN);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_BLEND_2WIN_X);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_BLEND_2WIN_Y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WIN_BLEND_3WIN_XY);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WINBUF_START_ADDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WINBUF_ADDR_H_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_REG(DC_WINBUF_ADDR_V_OFFSET);
> + =A0 =A0 =A0 }
> +}
> +
> +#undef DUMP_REG
> +
> +#ifdef DEBUG
> +static void dump_regs_print(void *data, const char *str)
> +{
> + =A0 =A0 =A0 struct tegra_dc *dc =3D data;
> + =A0 =A0 =A0 dev_dbg(&dc->pdev->dev, "%s", str);
> +}
> +
> +static void dump_regs(struct tegra_dc *dc)
> +{
> + =A0 =A0 =A0 _dump_regs(dc, dc, dump_regs_print);
> +}
> +#else
> +
> +static void dump_regs(struct tegra_dc *dc) {}
> +
> +#endif
> +
> +#ifdef CONFIG_DEBUG_FS
> +
> +static void dbg_regs_print(void *data, const char *str)
> +{
> + =A0 =A0 =A0 struct seq_file *s =3D data;
> +
> + =A0 =A0 =A0 seq_printf(s, "%s", str);
> +}
> +
> +#undef DUMP_REG
> +
> +static int dbg_dc_show(struct seq_file *s, void *unused)
> +{
> + =A0 =A0 =A0 struct tegra_dc *dc =3D s->private;
> +
> + =A0 =A0 =A0 _dump_regs(dc, s, dbg_regs_print);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +
> +static int dbg_dc_open(struct inode *inode, struct file *file)
> +{
> + =A0 =A0 =A0 return single_open(file, dbg_dc_show, inode->i_private);
> +}
> +
> +static const struct file_operations dbg_fops =3D {
> + =A0 =A0 =A0 .open =A0 =A0 =A0 =A0 =A0 =3D dbg_dc_open,
> + =A0 =A0 =A0 .read =A0 =A0 =A0 =A0 =A0 =3D seq_read,
> + =A0 =A0 =A0 .llseek =A0 =A0 =A0 =A0 =3D seq_lseek,
> + =A0 =A0 =A0 .release =A0 =A0 =A0 =A0=3D single_release,
> +};
> +
> +static void tegra_dc_dbg_add(struct tegra_dc *dc)
> +{
> + =A0 =A0 =A0 char name[32];
> +
> + =A0 =A0 =A0 snprintf(name, sizeof(name), "tegra_dc%d_regs", dc->pdev->i=
d);
> + =A0 =A0 =A0 (void) debugfs_create_file(name, S_IRUGO, NULL, dc, &dbg_fo=
ps);
> +}
> +#else
> +static void tegra_dc_dbg_add(struct tegra_dc *dc) {}
> +
> +#endif
> +
> +
> +static int tegra_dc_add(struct tegra_dc *dc, int index)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 mutex_lock(&tegra_dc_lock);
> + =A0 =A0 =A0 if (index >=3D TEGRA_MAX_DC) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (tegra_dcs[index] !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tegra_dcs[index] =3D dc;
> +
> +out:
> + =A0 =A0 =A0 mutex_unlock(&tegra_dc_lock);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +struct tegra_dc *tegra_dc_get_dc(unsigned idx)
> +{
> + =A0 =A0 =A0 if (idx < TEGRA_MAX_DC)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return tegra_dcs[idx];
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +}
> +EXPORT_SYMBOL(tegra_dc_get_dc);
> +
> +struct tegra_dc_win *tegra_dc_get_window(struct tegra_dc *dc, unsigned w=
in)
> +{
> + =A0 =A0 =A0 if (win >=3D dc->n_windows)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 return &dc->windows[win];
> +}
> +EXPORT_SYMBOL(tegra_dc_get_window);
> +
> +/* does not support updating windows on multiple dcs in one call */
> +int tegra_dc_update_windows(struct tegra_dc_win *windows[], int n)
> +{
> + =A0 =A0 =A0 struct tegra_dc *dc;
> + =A0 =A0 =A0 unsigned long update_mask =3D GENERAL_ACT_REQ;
> + =A0 =A0 =A0 unsigned long val;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 dc =3D windows[0]->dc;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&dc->lock, flags);
> + =A0 =A0 =A0 for (i =3D 0; i < n; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct tegra_dc_win *win =3D windows[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned h_dda;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned v_dda;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned stride;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, WINDOW_A_SELECT << win-=
>idx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_CMD_DISP=
LAY_WINDOW_HEADER);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_mask |=3D WIN_A_ACT_REQ << win->idx;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(win->flags & TEGRA_WIN_FLAG_ENABLED))=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, 0, DC_W=
IN_WIN_OPTIONS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, win->fmt, DC_WIN_COLOR_=
DEPTH);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, 0, DC_WIN_BYTE_SWAP);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 stride =3D win->w * tegra_dc_fmt_bpp(win->f=
mt) / 8;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* TODO: implement filter on settings */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 h_dda =3D (win->w * 0x1000) / (win->out_w -=
 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v_dda =3D (win->h * 0x1000) / (win->out_h -=
 1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 V_POSITION(=
win->y) | H_POSITION(win->x),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_WIN_POSI=
TION);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 V_SIZE(win-=
>out_h) | H_SIZE(win->out_w),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_WIN_SIZE=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 V_PRESCALED=
_SIZE(win->out_h) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 H_PRESCALED=
_SIZE(stride),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_WIN_PRES=
CALED_SIZE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, 0, DC_WIN_H_INITIAL_DDA=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, 0, DC_WIN_V_INITIAL_DDA=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, V_DDA_INC(v_dda) | H_DD=
A_INC(h_dda),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_WIN_DDA_=
INCREMENT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, stride, DC_WIN_LINE_STR=
IDE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, 0, DC_WIN_BUF_STRIDE);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D WIN_ENABLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (win->flags & TEGRA_WIN_FLAG_COLOR_EXPAN=
D)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D COLOR_EXPAND;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, val, DC_WIN_WIN_OPTIONS=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, (unsigned long)win->phy=
s_addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_WINBUF_S=
TART_ADDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, 0, DC_WINBUF_ADDR_H_OFF=
SET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, 0, DC_WINBUF_ADDR_V_OFF=
SET);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 win->dirty =3D 1;
> +
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tegra_dc_writel(dc, update_mask << 8, DC_CMD_STATE_CONTROL);
> +
> + =A0 =A0 =A0 val =3D tegra_dc_readl(dc, DC_CMD_INT_ENABLE);
> + =A0 =A0 =A0 val |=3D FRAME_END_INT;
> + =A0 =A0 =A0 tegra_dc_writel(dc, val, DC_CMD_INT_ENABLE);
> +
> + =A0 =A0 =A0 val =3D tegra_dc_readl(dc, DC_CMD_INT_MASK);
> + =A0 =A0 =A0 val |=3D FRAME_END_INT;
> + =A0 =A0 =A0 tegra_dc_writel(dc, val, DC_CMD_INT_MASK);
> +
> + =A0 =A0 =A0 tegra_dc_writel(dc, update_mask, DC_CMD_STATE_CONTROL);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&dc->lock, flags);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(tegra_dc_update_windows);
> +
> +static bool tegra_dc_windows_are_clean(struct tegra_dc_win *windows[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0int n)
> +{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < n; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (windows[i]->dirty)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return true;
> +}
> +
> +/* does not support syncing windows on multiple dcs in one call */
> +int tegra_dc_sync_windows(struct tegra_dc_win *windows[], int n)
> +{
> + =A0 =A0 =A0 if (n < 1 || n > DC_N_WINDOWS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 return wait_event_interruptible_timeout(windows[0]->dc->wq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0tegra_dc_windows_are_clean(windows, n),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0HZ);
> +}
> +EXPORT_SYMBOL(tegra_dc_sync_windows);
> +
> +void tegra_dc_set_blending(struct tegra_dc *dc, struct tegra_dc_blend *b=
lend)
> +{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < DC_N_WINDOWS; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, WINDOW_A_SELECT << i,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_CMD_DISP=
LAY_WINDOW_HEADER);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, blend[i].nokey, DC_WIN_=
BLEND_NOKEY);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, blend[i].one_win, DC_WI=
N_BLEND_1WIN);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, blend[i].two_win_x, DC_=
WIN_BLEND_2WIN_X);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, blend[i].two_win_y, DC_=
WIN_BLEND_2WIN_Y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, blend[i].three_win_xy,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_WIN_BLEN=
D_3WIN_XY);
> + =A0 =A0 =A0 }
> +}
> +EXPORT_SYMBOL(tegra_dc_set_blending);
> +
> +int tegra_dc_set_mode(struct tegra_dc *dc, struct tegra_dc_mode *mode)
> +{
> + =A0 =A0 =A0 unsigned long val;
> + =A0 =A0 =A0 unsigned long rate;
> + =A0 =A0 =A0 unsigned long div;
> +
> + =A0 =A0 =A0 tegra_dc_writel(dc, 0x0, DC_DISP_DISP_TIMING_OPTIONS);
> + =A0 =A0 =A0 tegra_dc_writel(dc, mode->h_ref_to_sync | (mode->v_ref_to_s=
ync << 16),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_DISP_REF_TO_SYNC);
> + =A0 =A0 =A0 tegra_dc_writel(dc, mode->h_sync_width | (mode->v_sync_widt=
h << 16),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_DISP_SYNC_WIDTH);
> + =A0 =A0 =A0 tegra_dc_writel(dc, mode->h_back_porch | (mode->v_back_porc=
h << 16),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_DISP_BACK_PORCH);
> + =A0 =A0 =A0 tegra_dc_writel(dc, mode->h_active | (mode->v_active << 16),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_DISP_DISP_ACTIVE);
> + =A0 =A0 =A0 tegra_dc_writel(dc, mode->h_front_porch | (mode->v_front_po=
rch << 16),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_DISP_FRONT_PORCH);
> +
> + =A0 =A0 =A0 tegra_dc_writel(dc, DE_SELECT_ACTIVE | DE_CONTROL_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_DISP_DATA_ENABLE_OPTIONS=
);
> +
> + =A0 =A0 =A0 /* TODO: MIPI/CRT/HDMI clock cals */
> +
> + =A0 =A0 =A0 val =3D DISP_DATA_FORMAT_DF1P1C;
> +
> + =A0 =A0 =A0 if (dc->out->align =3D TEGRA_DC_ALIGN_MSB)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D DISP_DATA_ALIGNMENT_MSB;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D DISP_DATA_ALIGNMENT_LSB;
> +
> + =A0 =A0 =A0 if (dc->out->order =3D TEGRA_DC_ORDER_RED_BLUE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D DISP_DATA_ORDER_RED_BLUE;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D DISP_DATA_ORDER_BLUE_RED;
> +
> + =A0 =A0 =A0 tegra_dc_writel(dc, val, DC_DISP_DISP_INTERFACE_CONTROL);
> +
> + =A0 =A0 =A0 rate =3D clk_get_rate(dc->clk);
> +
> + =A0 =A0 =A0 div =3D ((rate * 2 + mode->pclk / 2) / mode->pclk) - 2;
> +
> + =A0 =A0 =A0 if (rate * 2 / (div + 2) < (mode->pclk / 100 * 99) ||
> + =A0 =A0 =A0 =A0 =A0 rate * 2 / (div + 2) > (mode->pclk / 100 * 109)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dc->pdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "can't divide %ld clock to =
%d -1/+9%% %ld %d %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rate, mode->pclk,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rate / div, (mode->pclk / 1=
00 * 99),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mode->pclk / 100 * 109));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tegra_dc_writel(dc, 0x00010001,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_DISP_SHIFT_CLOCK_OPTIONS=
);
> + =A0 =A0 =A0 tegra_dc_writel(dc, PIXEL_CLK_DIVIDER_PCD1 | SHIFT_CLK_DIVI=
DER(div),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_DISP_DISP_CLOCK_CONTROL);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(tegra_dc_set_mode);
> +
> +static void tegra_dc_set_out(struct tegra_dc *dc, struct tegra_dc_out *o=
ut)
> +{
> + =A0 =A0 =A0 dc->out =3D out;
> +
> + =A0 =A0 =A0 if (out->n_modes > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dc->mode =3D &dc->out->modes[0];
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dc->pdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "No default modes specified=
. =A0Leaving output disabled.\n");
> +
> + =A0 =A0 =A0 switch (out->type) {
> + =A0 =A0 =A0 case TEGRA_DC_OUT_RGB:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dc->out_ops =3D &tegra_dc_rgb_ops;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dc->out_ops =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +}
> +
> +
> +static irqreturn_t tegra_dc_irq(int irq, void *ptr)
> +{
> + =A0 =A0 =A0 struct tegra_dc *dc =3D ptr;
> + =A0 =A0 =A0 unsigned long status;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 unsigned long val;
> + =A0 =A0 =A0 int i;
> +
> +
> + =A0 =A0 =A0 status =3D tegra_dc_readl(dc, DC_CMD_INT_STATUS);
> + =A0 =A0 =A0 tegra_dc_writel(dc, status, DC_CMD_INT_STATUS);
> +
> + =A0 =A0 =A0 if (status & FRAME_END_INT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int completed =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int dirty =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&dc->lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D tegra_dc_readl(dc, DC_CMD_STATE_CON=
TROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < DC_N_WINDOWS; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(val & (WIN_A_ACT_REQ =
<< i))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dc->windows=
[i].dirty =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 completed =
=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dirty =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!dirty) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D tegra_dc_readl(dc, =
DC_CMD_INT_ENABLE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~FRAME_END_INT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, val, DC=
_CMD_INT_ENABLE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dc->lock, flags);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (completed)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up(&dc->wq);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static void tegra_dc_init(struct tegra_dc *dc)
> +{
> + =A0 =A0 =A0 tegra_dc_writel(dc, 0x00000100, DC_CMD_GENERAL_INCR_SYNCPT_=
CNTRL);
> + =A0 =A0 =A0 if (dc->pdev->id =3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, 0x0000011a, DC_CMD_CONT=
_SYNCPT_VSYNC);
> + =A0 =A0 =A0 else if (dc->pdev->id =3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, 0x0000011b, DC_CMD_CONT=
_SYNCPT_VSYNC);
> + =A0 =A0 =A0 tegra_dc_writel(dc, 0x00004700, DC_CMD_INT_TYPE);
> + =A0 =A0 =A0 tegra_dc_writel(dc, 0x0001c700, DC_CMD_INT_POLARITY);
> + =A0 =A0 =A0 tegra_dc_writel(dc, 0x00000020, DC_DISP_MEM_HIGH_PRIORITY);
> + =A0 =A0 =A0 tegra_dc_writel(dc, 0x00000001, DC_DISP_MEM_HIGH_PRIORITY_T=
IMER);
> +
> + =A0 =A0 =A0 tegra_dc_writel(dc, 0x0001c702, DC_CMD_INT_MASK);
> + =A0 =A0 =A0 tegra_dc_writel(dc, 0x0001c700, DC_CMD_INT_ENABLE);
> +
> + =A0 =A0 =A0 if (dc->mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_set_mode(dc, dc->mode);
> +
> +
> + =A0 =A0 =A0 if (dc->out_ops && dc->out_ops->init)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dc->out_ops->init(dc);
> +}
> +
> +static int tegra_dc_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct tegra_dc *dc;
> + =A0 =A0 =A0 struct clk *clk;
> + =A0 =A0 =A0 struct clk *host1x_clk;
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 struct resource *base_res;
> + =A0 =A0 =A0 struct resource *fb_mem =3D NULL;
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 void __iomem *base;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (!pdev->dev.platform_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no platform data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dc =3D kzalloc(sizeof(struct tegra_dc), GFP_KERNEL);
> + =A0 =A0 =A0 if (!dc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can't allocate memory =
for tegra_dc\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 irq =3D platform_get_irq_byname(pdev, "irq");
> + =A0 =A0 =A0 if (irq <=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no irq\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, =
"regs");
> + =A0 =A0 =A0 if (!res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 base_res =3D request_mem_region(res->start, resource_size(r=
es), pdev->name);
> + =A0 =A0 =A0 if (!base_res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "request_mem_region fai=
led\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 base =3D ioremap(res->start, resource_size(res));
> + =A0 =A0 =A0 if (!base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "registers can't be map=
ped\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_release_resource_reg;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, =
"fbmem");
> + =A0 =A0 =A0 if (res)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb_mem =3D request_mem_region(res->start, r=
esource_size(res), pdev->name);
> +
> + =A0 =A0 =A0 host1x_clk =3D clk_get(&pdev->dev, "host1x");
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(host1x_clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can't get host1x clock=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_iounmap_reg;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 clk_enable(host1x_clk);
> +
> + =A0 =A0 =A0 clk =3D clk_get(&pdev->dev, NULL);
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can't get clock\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_put_host1x_clk;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 clk_enable(clk);
> + =A0 =A0 =A0 tegra_periph_reset_deassert(clk);
> +
> + =A0 =A0 =A0 dc->clk =3D clk;
> + =A0 =A0 =A0 dc->host1x_clk =3D host1x_clk;
> + =A0 =A0 =A0 dc->base_res =3D base_res;
> + =A0 =A0 =A0 dc->base =3D base;
> + =A0 =A0 =A0 dc->irq =3D irq;
> + =A0 =A0 =A0 dc->pdev =3D pdev;
> + =A0 =A0 =A0 dc->pdata =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 spin_lock_init(&dc->lock);
> + =A0 =A0 =A0 init_waitqueue_head(&dc->wq);
> +
> +
> + =A0 =A0 =A0 dc->n_windows =3D DC_N_WINDOWS;
> + =A0 =A0 =A0 for (i =3D 0; i < dc->n_windows; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dc->windows[i].idx =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dc->windows[i].dc =3D dc;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (request_irq(irq, tegra_dc_irq, IRQF_DISABLED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(&pdev->dev), dc)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "request_irq %d failed\=
n", irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_put_clk;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D tegra_dc_add(dc, pdev->id);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can't add dc\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (dc->pdata->flags & TEGRA_DC_FLAG_ENABLED) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dc->pdata->default_out)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_set_out(dc, dc->pd=
ata->default_out);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "No def=
ault output specified. =A0Leaving output disabled.\n");
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tegra_dc_init(dc);
> +
> + =A0 =A0 =A0 tegra_dc_set_blending(dc, tegra_dc_blend_modes[0]);
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, dc);
> +
> + =A0 =A0 =A0 tegra_dc_dbg_add(dc);
> +
> + =A0 =A0 =A0 dev_info(&pdev->dev, "probed\n");
> +
> + =A0 =A0 =A0 if (fb_mem && dc->pdata->fb) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dc->fb =3D tegra_fb_register(pdev, dc, dc->=
pdata->fb, fb_mem);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR_OR_NULL(dc->fb))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dc->fb =3D NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_free_irq:
> + =A0 =A0 =A0 free_irq(irq, dc);
> +err_put_clk:
> + =A0 =A0 =A0 clk_disable(clk);
> + =A0 =A0 =A0 clk_put(clk);
> +err_put_host1x_clk:
> + =A0 =A0 =A0 clk_disable(host1x_clk);
> + =A0 =A0 =A0 clk_put(host1x_clk);
> +err_iounmap_reg:
> + =A0 =A0 =A0 iounmap(base);
> + =A0 =A0 =A0 if (fb_mem)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_resource(fb_mem);
> +err_release_resource_reg:
> + =A0 =A0 =A0 release_resource(base_res);
> +err_free:
> + =A0 =A0 =A0 kfree(dc);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int tegra_dc_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct tegra_dc *dc =3D platform_get_drvdata(pdev);
> +
> + =A0 =A0 =A0 if (dc->fb) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_fb_unregister(dc->fb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_resource(dc->fb_mem);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 free_irq(dc->irq, dc);
> + =A0 =A0 =A0 tegra_periph_reset_assert(dc->clk);
> + =A0 =A0 =A0 clk_disable(dc->clk);
> + =A0 =A0 =A0 clk_put(dc->clk);
> + =A0 =A0 =A0 clk_disable(dc->host1x_clk);
> + =A0 =A0 =A0 clk_put(dc->host1x_clk);
> + =A0 =A0 =A0 iounmap(dc->base);
> + =A0 =A0 =A0 release_resource(dc->base_res);
> + =A0 =A0 =A0 kfree(dc);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int tegra_dc_suspend(struct platform_device *pdev, pm_message_t s=
tate)
> +{
> + =A0 =A0 =A0 struct tegra_dc *dc =3D platform_get_drvdata(pdev);
> +
> + =A0 =A0 =A0 dev_info(&pdev->dev, "suspend\n");
> +
> + =A0 =A0 =A0 disable_irq(dc->irq);
> + =A0 =A0 =A0 tegra_periph_reset_assert(dc->clk);
> + =A0 =A0 =A0 clk_disable(dc->clk);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int tegra_dc_resume(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct tegra_dc *dc =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 struct tegra_dc_win *wins[DC_N_WINDOWS];
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 dev_info(&pdev->dev, "resume\n");
> +
> + =A0 =A0 =A0 clk_enable(dc->clk);
> + =A0 =A0 =A0 tegra_periph_reset_deassert(dc->clk);
> + =A0 =A0 =A0 enable_irq(dc->irq);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < dc->n_windows; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wins[i] =3D &dc->windows[i];
> +
> + =A0 =A0 =A0 tegra_dc_init(dc);
> +
> + =A0 =A0 =A0 tegra_dc_set_blending(dc, tegra_dc_blend_modes[0]);
> + =A0 =A0 =A0 tegra_dc_update_windows(wins, dc->n_windows);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#endif
> +
> +extern int suspend_set(const char *val, struct kernel_param *kp)
> +{
> + =A0 =A0 =A0 if (!strcmp(val, "dump"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dump_regs(tegra_dcs[0]);
> +#ifdef CONFIG_PM
> + =A0 =A0 =A0 else if (!strcmp(val, "suspend"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_suspend(tegra_dcs[0]->pdev, PMSG_S=
USPEND);
> + =A0 =A0 =A0 else if (!strcmp(val, "resume"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_resume(tegra_dcs[0]->pdev);
> +#endif
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +extern int suspend_get(char *buffer, struct kernel_param *kp)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int suspend;
> +
> +module_param_call(suspend, suspend_set, suspend_get, &suspend, 0644);
> +
> +struct platform_driver tegra_dc_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "tegradc",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =3D tegra_dc_probe,
> + =A0 =A0 =A0 .remove =3D tegra_dc_remove,
> +#ifdef CONFIG_PM
> + =A0 =A0 =A0 .suspend =3D tegra_dc_suspend,
> + =A0 =A0 =A0 .resume =3D tegra_dc_resume,
> +#endif
> +};
> +
> +static int __init tegra_dc_module_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&tegra_dc_driver);
> +}
> +
> +static void __exit tegra_dc_module_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&tegra_dc_driver);
> +}
> +
> +module_exit(tegra_dc_module_exit);
> +module_init(tegra_dc_module_init);
> diff --git a/drivers/video/tegra/dc/dc_priv.h b/drivers/video/tegra/dc/dc=
_priv.h
> new file mode 100644
> index 0000000..b2351b1
> --- /dev/null
> +++ b/drivers/video/tegra/dc/dc_priv.h
> @@ -0,0 +1,86 @@
> +/*
> + * drivers/video/tegra/dc/dc_priv.h
> + *
> + * Copyright (C) 2010 Google, Inc.
> + * Author: Erik Gilling <konkers@android.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __DRIVERS_VIDEO_TEGRA_DC_DC_PRIV_H
> +#define __DRIVERS_VIDEO_TEGRA_DC_DC_PRIV_H
> +
> +#include <linux/wait.h>
> +#include <linux/list.h>
> +#include <linux/io.h>
> +
> +struct tegra_dc;
> +
> +struct tegra_dc_out_ops {
> + =A0 =A0 =A0 void (*init)(struct tegra_dc *dc);
> +};
> +
> +struct tegra_dc {
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list;
> +
> + =A0 =A0 =A0 struct platform_device =A0 =A0 =A0 =A0 =A0*pdev;
> + =A0 =A0 =A0 struct tegra_dc_platform_data =A0 *pdata;
> +
> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *base_res;
> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*base;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 irq;
> +
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*host=
1x_clk;
> +
> + =A0 =A0 =A0 struct tegra_dc_out =A0 =A0 =A0 =A0 =A0 =A0 *out;
> + =A0 =A0 =A0 struct tegra_dc_out_ops =A0 =A0 =A0 =A0 *out_ops;
> +
> + =A0 =A0 =A0 struct tegra_dc_mode =A0 =A0 =A0 =A0 =A0 =A0*mode;
> +
> + =A0 =A0 =A0 struct tegra_dc_win =A0 =A0 =A0 =A0 =A0 =A0 windows[DC_N_WI=
NDOWS];
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 n_windows;
> +
> + =A0 =A0 =A0 wait_queue_head_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 wq;
> +
> + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
> +
> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *fb_mem;
> + =A0 =A0 =A0 struct tegra_fb_info =A0 =A0 =A0 =A0 =A0 =A0*fb;
> +};
> +
> +static inline unsigned long tegra_dc_readl(struct tegra_dc *dc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0unsigned long reg)
> +{
> + =A0 =A0 =A0 return readl(dc->base + reg * 4);
> +}
> +
> +static inline void tegra_dc_writel(struct tegra_dc *dc, unsigned long va=
l,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsi=
gned long reg)
> +{
> + =A0 =A0 =A0 writel(val, dc->base + reg * 4);
> +}
> +
> +static inline void _tegra_dc_write_table(struct tegra_dc *dc, const u32 =
*table,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0unsigned len)
> +{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < len; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dc_writel(dc, table[i * 2 + 1], table=
[i * 2]);
> +}
> +
> +#define tegra_dc_write_table(dc, table) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 _tegra_dc_write_table(dc, table, ARRAY_SIZE(table) / 2)
> +
> +extern struct tegra_dc_out_ops tegra_dc_rgb_ops;
> +
> +#endif
> diff --git a/drivers/video/tegra/dc/dc_reg.h b/drivers/video/tegra/dc/dc_=
reg.h
> new file mode 100644
> index 0000000..6d6b3ba
> --- /dev/null
> +++ b/drivers/video/tegra/dc/dc_reg.h
> @@ -0,0 +1,342 @@
> +/*
> + * drivers/video/tegra/dc/dc_reg.h
> + *
> + * Copyright (C) 2010 Google, Inc.
> + * Author: Erik Gilling <konkers@android.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __DRIVERS_VIDEO_TEGRA_DC_DC_REG_H
> +#define __DRIVERS_VIDEO_TEGRA_DC_DC_REG_H
> +
> +#define DC_CMD_GENERAL_INCR_SYNCPT =A0 =A0 =A0 =A0 =A0 =A0 0x000
> +#define DC_CMD_GENERAL_INCR_SYNCPT_CNTRL =A0 =A0 =A0 0x001
> +#define DC_CMD_GENERAL_INCR_SYNCPT_ERROR =A0 =A0 =A0 0x002
> +#define DC_CMD_WIN_A_INCR_SYNCPT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x008
> +#define DC_CMD_WIN_A_INCR_SYNCPT_CNTRL =A0 =A0 =A0 =A0 0x009
> +#define DC_CMD_WIN_A_INCR_SYNCPT_ERROR =A0 =A0 =A0 =A0 0x00a
> +#define DC_CMD_WIN_B_INCR_SYNCPT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x010
> +#define DC_CMD_WIN_B_INCR_SYNCPT_CNTRL =A0 =A0 =A0 =A0 0x011
> +#define DC_CMD_WIN_B_INCR_SYNCPT_ERROR =A0 =A0 =A0 =A0 0x012
> +#define DC_CMD_WIN_C_INCR_SYNCPT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x018
> +#define DC_CMD_WIN_C_INCR_SYNCPT_CNTRL =A0 =A0 =A0 =A0 0x019
> +#define DC_CMD_WIN_C_INCR_SYNCPT_ERROR =A0 =A0 =A0 =A0 0x01a
> +#define DC_CMD_CONT_SYNCPT_VSYNC =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x028
> +#define DC_CMD_DISPLAY_COMMAND_OPTION0 =A0 =A0 =A0 =A0 0x031
> +#define DC_CMD_DISPLAY_COMMAND =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x032
> +#define =A0DISP_COMMAND_RAISE =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
> +#define =A0DISP_CTRL_MODE_STOP =A0 =A0 =A0 =A0 =A0 (0 << 5)
> +#define =A0DISP_CTRL_MODE_C_DISPLAY =A0 =A0 =A0(1 << 5)
> +#define =A0DISP_CTRL_MODE_NC_DISPLAY =A0 =A0 (2 << 5)
> +#define =A0DISP_COMMAND_RAISE_VECTOR(x) =A0(((x) & 0x1f) << 22)
> +#define =A0DISP_COMMAND_RAISE_CHANNEL_ID(x) =A0 =A0 =A0(((x) & 0xf) << 2=
7)
> +
> +#define DC_CMD_SIGNAL_RAISE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x033
> +#define DC_CMD_DISPLAY_POWER_CONTROL =A0 =A0 =A0 =A0 =A0 0x036
> +#define =A0PW0_ENABLE =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
> +#define =A0PW1_ENABLE =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
> +#define =A0PW2_ENABLE =A0 =A0 =A0 =A0 =A0 =A0(1 << 4)
> +#define =A0PW3_ENABLE =A0 =A0 =A0 =A0 =A0 =A0(1 << 6)
> +#define =A0PW4_ENABLE =A0 =A0 =A0 =A0 =A0 =A0(1 << 8)
> +#define =A0PM0_ENABLE =A0 =A0 =A0 =A0 =A0 =A0(1 << 16)
> +#define =A0PM1_ENABLE =A0 =A0 =A0 =A0 =A0 =A0(1 << 18)
> +#define =A0SPI_ENABLE =A0 =A0 =A0 =A0 =A0 =A0(1 << 24)
> +#define =A0HSPI_ENABLE =A0 =A0 =A0 =A0 =A0 (1 << 25)
> +
> +#define DC_CMD_INT_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
37
> +#define DC_CMD_INT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x038
> +#define DC_CMD_INT_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
39
> +#define DC_CMD_INT_TYPE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x03a
> +#define DC_CMD_INT_POLARITY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x03b
> +#define =A0CTXSW_INT =A0 =A0 =A0 =A0 =A0 =A0 (1 << 0)
> +#define =A0FRAME_END_INT =A0 =A0 =A0 =A0 (1 << 1)
> +#define =A0V_BLANK_INT =A0 =A0 =A0 =A0 =A0 (1 << 2)
> +#define =A0H_BLANK_INT =A0 =A0 =A0 =A0 =A0 (1 << 3)
> +#define =A0V_PULSE3_INT =A0 =A0 =A0 =A0 =A0(1 << 4)
> +#define =A0SPI_BUSY_INT =A0 =A0 =A0 =A0 =A0(1 << 7)
> +#define =A0WIN_A_UF_INT =A0 =A0 =A0 =A0 =A0(1 << 8)
> +#define =A0WIN_B_UF_INT =A0 =A0 =A0 =A0 =A0(1 << 9)
> +#define =A0WIN_C_UF_INT =A0 =A0 =A0 =A0 =A0(1 << 10)
> +#define =A0MSF_INT =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 12)
> +#define =A0SSF_INT =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 13)
> +#define =A0WIN_A_OF_INT =A0 =A0 =A0 =A0 =A0(1 << 14)
> +#define =A0WIN_B_OF_INT =A0 =A0 =A0 =A0 =A0(1 << 15)
> +#define =A0WIN_C_OF_INT =A0 =A0 =A0 =A0 =A0(1 << 16)
> +#define =A0GPIO_0_INT =A0 =A0 =A0 =A0 =A0 =A0(1 << 18)
> +#define =A0GPIO_1_INT =A0 =A0 =A0 =A0 =A0 =A0(1 << 19)
> +#define =A0GPIO_2_INT =A0 =A0 =A0 =A0 =A0 =A0(1 << 20)
> +
> +#define DC_CMD_SIGNAL_RAISE1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x03c
> +#define DC_CMD_SIGNAL_RAISE2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x03d
> +#define DC_CMD_SIGNAL_RAISE3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x03e
> +#define DC_CMD_STATE_ACCESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x040
> +#define DC_CMD_STATE_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x041
> +#define =A0GENERAL_ACT_REQ =A0 =A0 =A0 (1 << 0)
> +#define =A0WIN_A_ACT_REQ =A0 =A0 =A0 =A0 (1 << 1)
> +#define =A0WIN_B_ACT_REQ =A0 =A0 =A0 =A0 (1 << 2)
> +#define =A0WIN_C_ACT_REQ =A0 =A0 =A0 =A0 (1 << 3)
> +
> +#define DC_CMD_DISPLAY_WINDOW_HEADER =A0 =A0 =A0 =A0 =A0 0x042
> +#define =A0WINDOW_A_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
> +#define =A0WINDOW_B_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5)
> +#define =A0WINDOW_C_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 6)
> +
> +#define DC_CMD_REG_ACT_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x043
> +
> +#define DC_COM_CRC_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x300
> +#define DC_COM_CRC_CHECKSUM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x301
> +#define DC_COM_PIN_OUTPUT_ENABLE0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x302
> +#define DC_COM_PIN_OUTPUT_ENABLE1 =A0 =A0 =A0 =A0 =A0 =A0 =A00x303
> +#define DC_COM_PIN_OUTPUT_ENABLE2 =A0 =A0 =A0 =A0 =A0 =A0 =A00x304
> +#define DC_COM_PIN_OUTPUT_ENABLE3 =A0 =A0 =A0 =A0 =A0 =A0 =A00x305
> +#define DC_COM_PIN_OUTPUT_POLARITY0 =A0 =A0 =A0 =A0 =A0 =A00x306
> +#define DC_COM_PIN_OUTPUT_POLARITY1 =A0 =A0 =A0 =A0 =A0 =A00x307
> +#define DC_COM_PIN_OUTPUT_POLARITY2 =A0 =A0 =A0 =A0 =A0 =A00x308
> +#define DC_COM_PIN_OUTPUT_POLARITY3 =A0 =A0 =A0 =A0 =A0 =A00x309
> +#define DC_COM_PIN_OUTPUT_DATA0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x30a
> +#define DC_COM_PIN_OUTPUT_DATA1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x30b
> +#define DC_COM_PIN_OUTPUT_DATA2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x30c
> +#define DC_COM_PIN_OUTPUT_DATA3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x30d
> +#define DC_COM_PIN_INPUT_ENABLE0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x30e
> +#define DC_COM_PIN_INPUT_ENABLE1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x30f
> +#define DC_COM_PIN_INPUT_ENABLE2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x310
> +#define DC_COM_PIN_INPUT_ENABLE3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x311
> +#define DC_COM_PIN_INPUT_DATA0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x312
> +#define DC_COM_PIN_INPUT_DATA1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x313
> +#define DC_COM_PIN_OUTPUT_SELECT0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x314
> +#define DC_COM_PIN_OUTPUT_SELECT1 =A0 =A0 =A0 =A0 =A0 =A0 =A00x315
> +#define DC_COM_PIN_OUTPUT_SELECT2 =A0 =A0 =A0 =A0 =A0 =A0 =A00x316
> +#define DC_COM_PIN_OUTPUT_SELECT3 =A0 =A0 =A0 =A0 =A0 =A0 =A00x317
> +#define DC_COM_PIN_OUTPUT_SELECT4 =A0 =A0 =A0 =A0 =A0 =A0 =A00x318
> +#define DC_COM_PIN_OUTPUT_SELECT5 =A0 =A0 =A0 =A0 =A0 =A0 =A00x319
> +#define DC_COM_PIN_OUTPUT_SELECT6 =A0 =A0 =A0 =A0 =A0 =A0 =A00x31a
> +#define DC_COM_PIN_MISC_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x31b
> +#define DC_COM_PM0_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x31c
> +#define DC_COM_PM0_DUTY_CYCLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x31d
> +#define DC_COM_PM1_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x31e
> +#define DC_COM_PM1_DUTY_CYCLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x31f
> +#define DC_COM_SPI_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x320
> +#define DC_COM_SPI_START_BYTE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x321
> +#define DC_COM_HSPI_WRITE_DATA_AB =A0 =A0 =A0 =A0 =A0 =A0 =A00x322
> +#define DC_COM_HSPI_WRITE_DATA_CD =A0 =A0 =A0 =A0 =A0 =A0 =A00x323
> +#define DC_COM_HSPI_CS_DC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x3=
24
> +#define DC_COM_SCRATCH_REGISTER_A =A0 =A0 =A0 =A0 =A0 =A0 =A00x325
> +#define DC_COM_SCRATCH_REGISTER_B =A0 =A0 =A0 =A0 =A0 =A0 =A00x326
> +#define DC_COM_GPIO_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3=
27
> +#define DC_COM_GPIO_DEBOUNCE_COUNTER =A0 =A0 =A0 =A0 =A0 0x328
> +#define DC_COM_CRC_CHECKSUM_LATCHED =A0 =A0 =A0 =A0 =A0 =A00x329
> +
> +#define DC_DISP_DISP_SIGNAL_OPTIONS0 =A0 =A0 =A0 =A0 =A0 0x400
> +#define DC_DISP_DISP_SIGNAL_OPTIONS1 =A0 =A0 =A0 =A0 =A0 0x401
> +#define DC_DISP_DISP_WIN_OPTIONS =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x402
> +#define DC_DISP_MEM_HIGH_PRIORITY =A0 =A0 =A0 =A0 =A0 =A0 =A00x403
> +#define DC_DISP_MEM_HIGH_PRIORITY_TIMER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x404
> +#define DC_DISP_DISP_TIMING_OPTIONS =A0 =A0 =A0 =A0 =A0 =A00x405
> +#define DC_DISP_REF_TO_SYNC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x406
> +#define DC_DISP_SYNC_WIDTH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x407
> +#define DC_DISP_BACK_PORCH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x408
> +#define DC_DISP_DISP_ACTIVE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x409
> +#define DC_DISP_FRONT_PORCH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x40a
> +#define DC_DISP_H_PULSE0_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x40b
> +#define DC_DISP_H_PULSE0_POSITION_A =A0 =A0 =A0 =A0 =A0 =A00x40c
> +#define DC_DISP_H_PULSE0_POSITION_B =A0 =A0 =A0 =A0 =A0 =A00x40d
> +#define DC_DISP_H_PULSE0_POSITION_C =A0 =A0 =A0 =A0 =A0 =A00x40e
> +#define DC_DISP_H_PULSE0_POSITION_D =A0 =A0 =A0 =A0 =A0 =A00x40f
> +#define DC_DISP_H_PULSE1_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x410
> +#define DC_DISP_H_PULSE1_POSITION_A =A0 =A0 =A0 =A0 =A0 =A00x411
> +#define DC_DISP_H_PULSE1_POSITION_B =A0 =A0 =A0 =A0 =A0 =A00x412
> +#define DC_DISP_H_PULSE1_POSITION_C =A0 =A0 =A0 =A0 =A0 =A00x413
> +#define DC_DISP_H_PULSE1_POSITION_D =A0 =A0 =A0 =A0 =A0 =A00x414
> +#define DC_DISP_H_PULSE2_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x415
> +#define DC_DISP_H_PULSE2_POSITION_A =A0 =A0 =A0 =A0 =A0 =A00x416
> +#define DC_DISP_H_PULSE2_POSITION_B =A0 =A0 =A0 =A0 =A0 =A00x417
> +#define DC_DISP_H_PULSE2_POSITION_C =A0 =A0 =A0 =A0 =A0 =A00x418
> +#define DC_DISP_H_PULSE2_POSITION_D =A0 =A0 =A0 =A0 =A0 =A00x419
> +#define DC_DISP_V_PULSE0_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x41a
> +#define DC_DISP_V_PULSE0_POSITION_A =A0 =A0 =A0 =A0 =A0 =A00x41b
> +#define DC_DISP_V_PULSE0_POSITION_B =A0 =A0 =A0 =A0 =A0 =A00x41c
> +#define DC_DISP_V_PULSE0_POSITION_C =A0 =A0 =A0 =A0 =A0 =A00x41d
> +#define DC_DISP_V_PULSE1_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x41e
> +#define DC_DISP_V_PULSE1_POSITION_A =A0 =A0 =A0 =A0 =A0 =A00x41f
> +#define DC_DISP_V_PULSE1_POSITION_B =A0 =A0 =A0 =A0 =A0 =A00x420
> +#define DC_DISP_V_PULSE1_POSITION_C =A0 =A0 =A0 =A0 =A0 =A00x421
> +#define DC_DISP_V_PULSE2_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x422
> +#define DC_DISP_V_PULSE2_POSITION_A =A0 =A0 =A0 =A0 =A0 =A00x423
> +#define DC_DISP_V_PULSE3_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x424
> +#define DC_DISP_V_PULSE3_POSITION_A =A0 =A0 =A0 =A0 =A0 =A00x425
> +#define DC_DISP_M0_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x426
> +#define DC_DISP_M1_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x427
> +#define DC_DISP_DI_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x428
> +#define DC_DISP_PP_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x429
> +#define DC_DISP_PP_SELECT_A =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x42a
> +#define DC_DISP_PP_SELECT_B =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x42b
> +#define DC_DISP_PP_SELECT_C =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x42c
> +#define DC_DISP_PP_SELECT_D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x42d
> +#define DC_DISP_DISP_CLOCK_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 0x42e
> +#define =A0PIXEL_CLK_DIVIDER_PCD1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0 << 8)
> +#define =A0PIXEL_CLK_DIVIDER_PCD1H =A0 =A0 =A0 (1 << 8)
> +#define =A0PIXEL_CLK_DIVIDER_PCD2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(2 << 8)
> +#define =A0PIXEL_CLK_DIVIDER_PCD3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(3 << 8)
> +#define =A0PIXEL_CLK_DIVIDER_PCD4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(4 << 8)
> +#define =A0PIXEL_CLK_DIVIDER_PCD6 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(5 << 8)
> +#define =A0PIXEL_CLK_DIVIDER_PCD8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(6 << 8)
> +#define =A0PIXEL_CLK_DIVIDER_PCD9 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(7 << 8)
> +#define =A0PIXEL_CLK_DIVIDER_PCD12 =A0 =A0 =A0 (8 << 8)
> +#define =A0PIXEL_CLK_DIVIDER_PCD16 =A0 =A0 =A0 (9 << 8)
> +#define =A0PIXEL_CLK_DIVIDER_PCD18 =A0 =A0 =A0 (10 << 8)
> +#define =A0PIXEL_CLK_DIVIDER_PCD24 =A0 =A0 =A0 (11 << 8)
> +#define =A0PIXEL_CLK_DIVIDER_PCD13 =A0 =A0 =A0 (12 << 8)
> +#define =A0SHIFT_CLK_DIVIDER(x) =A0 =A0 =A0 =A0 =A0((x) & 0xff)
> +
> +#define DC_DISP_DISP_INTERFACE_CONTROL =A0 =A0 =A0 =A0 0x42f
> +#define =A0DISP_DATA_FORMAT_DF1P1C =A0 =A0 =A0 (0 << 0)
> +#define =A0DISP_DATA_FORMAT_DF1P2C24B =A0 =A0(1 << 0)
> +#define =A0DISP_DATA_FORMAT_DF1P2C18B =A0 =A0(2 << 0)
> +#define =A0DISP_DATA_FORMAT_DF1P2C16B =A0 =A0(3 << 0)
> +#define =A0DISP_DATA_FORMAT_DF2S =A0 =A0 =A0 =A0 (5 << 0)
> +#define =A0DISP_DATA_FORMAT_DF3S =A0 =A0 =A0 =A0 (6 << 0)
> +#define =A0DISP_DATA_FORMAT_DFSPI =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(7 << 0)
> +#define =A0DISP_DATA_FORMAT_DF1P3C24B =A0 =A0(8 << 0)
> +#define =A0DISP_DATA_FORMAT_DF1P3C18B =A0 =A0(9 << 0)
> +#define =A0DISP_DATA_ALIGNMENT_MSB =A0 =A0 =A0 (0 << 8)
> +#define =A0DISP_DATA_ALIGNMENT_LSB =A0 =A0 =A0 (1 << 8)
> +#define =A0DISP_DATA_ORDER_RED_BLUE =A0 =A0 =A0(0 << 9)
> +#define =A0DISP_DATA_ORDER_BLUE_RED =A0 =A0 =A0(1 << 9)
> +
> +#define DC_DISP_DISP_COLOR_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 0x430
> +#define DC_DISP_SHIFT_CLOCK_OPTIONS =A0 =A0 =A0 =A0 =A0 =A00x431
> +#define DC_DISP_DATA_ENABLE_OPTIONS =A0 =A0 =A0 =A0 =A0 =A00x432
> +#define =A0 DE_SELECT_ACTIVE_BLANK =A0 =A0 =A0 0x0
> +#define =A0 DE_SELECT_ACTIVE =A0 =A0 =A0 =A0 =A0 =A0 0x1
> +#define =A0 DE_SELECT_ACTIVE_IS =A0 =A0 =A0 =A0 =A00x2
> +#define =A0 DE_CONTROL_ONECLK =A0 =A0 =A0 =A0 =A0 =A0(0 << 2)
> +#define =A0 DE_CONTROL_NORMAL =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
> +#define =A0 DE_CONTROL_EARLY_EXT =A0 =A0 =A0 =A0 (2 << 2)
> +#define =A0 DE_CONTROL_EARLY =A0 =A0 =A0 =A0 =A0 =A0 (3 << 2)
> +#define =A0 DE_CONTROL_ACTIVE_BLANK =A0 =A0 =A0(4 << 2)
> +
> +#define DC_DISP_SERIAL_INTERFACE_OPTIONS =A0 =A0 =A0 0x433
> +#define DC_DISP_LCD_SPI_OPTIONS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x434
> +#define DC_DISP_BORDER_COLOR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x435
> +#define DC_DISP_COLOR_KEY0_LOWER =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x436
> +#define DC_DISP_COLOR_KEY0_UPPER =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x437
> +#define DC_DISP_COLOR_KEY1_LOWER =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x438
> +#define DC_DISP_COLOR_KEY1_UPPER =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x439
> +#define DC_DISP_CURSOR_FOREGROUND =A0 =A0 =A0 =A0 =A0 =A0 =A00x43c
> +#define DC_DISP_CURSOR_BACKGROUND =A0 =A0 =A0 =A0 =A0 =A0 =A00x43d
> +#define DC_DISP_CURSOR_START_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A00x43e
> +#define DC_DISP_CURSOR_START_ADDR_NS =A0 =A0 =A0 =A0 =A0 0x43f
> +#define DC_DISP_CURSOR_POSITION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x440
> +#define DC_DISP_CURSOR_POSITION_NS =A0 =A0 =A0 =A0 =A0 =A0 0x441
> +#define DC_DISP_INIT_SEQ_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x442
> +#define DC_DISP_SPI_INIT_SEQ_DATA_A =A0 =A0 =A0 =A0 =A0 =A00x443
> +#define DC_DISP_SPI_INIT_SEQ_DATA_B =A0 =A0 =A0 =A0 =A0 =A00x444
> +#define DC_DISP_SPI_INIT_SEQ_DATA_C =A0 =A0 =A0 =A0 =A0 =A00x445
> +#define DC_DISP_SPI_INIT_SEQ_DATA_D =A0 =A0 =A0 =A0 =A0 =A00x446
> +#define DC_DISP_DC_MCCIF_FIFOCTRL =A0 =A0 =A0 =A0 =A0 =A0 =A00x480
> +#define DC_DISP_MCCIF_DISPLAY0A_HYST =A0 =A0 =A0 =A0 =A0 0x481
> +#define DC_DISP_MCCIF_DISPLAY0B_HYST =A0 =A0 =A0 =A0 =A0 0x482
> +#define DC_DISP_MCCIF_DISPLAY0C_HYST =A0 =A0 =A0 =A0 =A0 0x483
> +#define DC_DISP_MCCIF_DISPLAY1B_HYST =A0 =A0 =A0 =A0 =A0 0x484
> +#define DC_DISP_DAC_CRT_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x4c0
> +#define DC_DISP_DISP_MISC_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A00x4c1
> +
> +#define DC_WINC_COLOR_PALETTE(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x500 + (x=
))
> +
> +#define DC_WINC_PALETTE_COLOR_EXT =A0 =A0 =A0 =A0 =A0 =A0 =A00x600
> +#define DC_WINC_H_FILTER_P(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x601 =
+ (x))
> +#define DC_WINC_CSC_YOF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x611
> +#define DC_WINC_CSC_KYRGB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6=
12
> +#define DC_WINC_CSC_KUR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x613
> +#define DC_WINC_CSC_KVR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x614
> +#define DC_WINC_CSC_KUG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x615
> +#define DC_WINC_CSC_KVG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x616
> +#define DC_WINC_CSC_KUB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x617
> +#define DC_WINC_CSC_KVB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x618
> +#define DC_WINC_V_FILTER_P(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x619 =
+ (x))
> +#define DC_WIN_WIN_OPTIONS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x700
> +#define =A0H_DIRECTION_INCREMENT =A0 =A0 =A0 =A0 (0 << 0)
> +#define =A0H_DIRECTION_DECREMENTT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
> +#define =A0V_DIRECTION_INCREMENT =A0 =A0 =A0 =A0 (0 << 2)
> +#define =A0V_DIRECTION_DECREMENTT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
> +#define =A0COLOR_EXPAND =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 6)
> +#define =A0CP_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 16)
> +#define =A0DV_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 20)
> +#define =A0WIN_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 30)
> +
> +#define DC_WIN_BYTE_SWAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x7=
01
> +#define =A0BYTE_SWAP_NOSWAP =A0 =A0 =A0 =A0 =A0 =A0 =A00
> +#define =A0BYTE_SWAP_SWAP2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
> +#define =A0BYTE_SWAP_SWAP4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2
> +#define =A0BYTE_SWAP_SWAP4HW =A0 =A0 =A0 =A0 =A0 =A0 3
> +
> +#define DC_WIN_BUFFER_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x702
> +#define =A0BUFFER_CONTROL_HOST =A0 =A0 =A0 =A0 =A0 0
> +#define =A0BUFFER_CONTROL_VI =A0 =A0 =A0 =A0 =A0 =A0 1
> +#define =A0BUFFER_CONTROL_EPP =A0 =A0 =A0 =A0 =A0 =A02
> +#define =A0BUFFER_CONTROL_MPEGE =A0 =A0 =A0 =A0 =A03
> +#define =A0BUFFER_CONTROL_SB2D =A0 =A0 =A0 =A0 =A0 4
> +
> +#define DC_WIN_COLOR_DEPTH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x703
> +
> +#define DC_WIN_POSITION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x704
> +#define =A0H_POSITION(x) =A0 =A0 =A0 =A0 (((x) & 0xfff) << 0)
> +#define =A0V_POSITION(x) =A0 =A0 =A0 =A0 (((x) & 0xfff) << 16)
> +
> +#define DC_WIN_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x705
> +#define =A0H_SIZE(x) =A0 =A0 =A0 =A0 =A0 =A0 (((x) & 0xfff) << 0)
> +#define =A0V_SIZE(x) =A0 =A0 =A0 =A0 =A0 =A0 (((x) & 0xfff) << 16)
> +
> +#define DC_WIN_PRESCALED_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x706
> +#define =A0H_PRESCALED_SIZE(x) =A0 (((x) & 0x3fff) << 0)
> +#define =A0V_PRESCALED_SIZE(x) =A0 (((x) & 0xfff) << 16)
> +
> +#define DC_WIN_H_INITIAL_DDA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x707
> +#define DC_WIN_V_INITIAL_DDA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x708
> +#define DC_WIN_DDA_INCREMENT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x709
> +#define =A0H_DDA_INC(x) =A0 =A0 =A0 =A0 =A0(((x) & 0xffff) << 0)
> +#define =A0V_DDA_INC(x) =A0 =A0 =A0 =A0 =A0(((x) & 0xffff) << 16)
> +
> +#define DC_WIN_LINE_STRIDE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x70a
> +#define DC_WIN_BUF_STRIDE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x7=
0b
> +#define DC_WIN_UV_BUF_STRIDE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x70c
> +#define DC_WIN_BUFFER_ADDR_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x70d
> +#define DC_WIN_DV_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x7=
0e
> +#define DC_WIN_BLEND_NOKEY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x70f
> +#define DC_WIN_BLEND_1WIN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x7=
10
> +#define DC_WIN_BLEND_2WIN_X =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x711
> +#define DC_WIN_BLEND_2WIN_Y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x712
> +#define DC_WIN_BLEND_3WIN_XY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x713
> +#define =A0CKEY_NOKEY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0 << 0)
> +#define =A0CKEY_KEY0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 0)
> +#define =A0CKEY_KEY1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (2 << 0)
> +#define =A0CKEY_KEY01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(3 << 0)
> +#define =A0BLEND_CONTROL_FIX =A0 =A0 =A0 =A0 =A0 =A0 (0 << 2)
> +#define =A0BLEND_CONTROL_ALPHA =A0 =A0 =A0 =A0 =A0 (1 << 2)
> +#define =A0BLEND_CONTROL_DEPENDANT =A0 =A0 =A0 (2 << 2)
> +#define =A0BLEND_WEIGHT0(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0(((x) & 0xff) << =
8)
> +#define =A0BLEND_WEIGHT1(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0(((x) & 0xff) << =
16)
> +
> +#define DC_WIN_HP_FETCH_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x714
> +#define DC_WINBUF_START_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x800
> +#define DC_WINBUF_START_ADDR_NS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x801
> +#define DC_WINBUF_START_ADDR_U =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x802
> +#define DC_WINBUF_START_ADDR_U_NS =A0 =A0 =A0 =A0 =A0 =A0 =A00x803
> +#define DC_WINBUF_START_ADDR_V =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x804
> +#define DC_WINBUF_START_ADDR_V_NS =A0 =A0 =A0 =A0 =A0 =A0 =A00x805
> +#define DC_WINBUF_ADDR_H_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x806
> +#define DC_WINBUF_ADDR_H_OFFSET_NS =A0 =A0 =A0 =A0 =A0 =A0 0x807
> +#define DC_WINBUF_ADDR_V_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x808
> +#define DC_WINBUF_ADDR_V_OFFSET_NS =A0 =A0 =A0 =A0 =A0 =A0 0x809
> +#define DC_WINBUF_UFLOW_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x80a
> +
> +#endif
> diff --git a/drivers/video/tegra/dc/rgb.c b/drivers/video/tegra/dc/rgb.c
> new file mode 100644
> index 0000000..de1a8fa
> --- /dev/null
> +++ b/drivers/video/tegra/dc/rgb.c
> @@ -0,0 +1,63 @@
> +/*
> + * drivers/video/tegra/dc/rgb.c
> + *
> + * Copyright (C) 2010 Google, Inc.
> + * Author: Erik Gilling <konkers@android.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +
> +#include <mach/dc.h>
> +
> +#include "dc_reg.h"
> +#include "dc_priv.h"
> +
> +
> +static const u32 tegra_dc_rgb_pintable[] =3D {
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_ENABLE0, =A0 =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_ENABLE1, =A0 =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_ENABLE2, =A0 =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_ENABLE3, =A0 =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_POLARITY0, =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_POLARITY1, =A0 =A00x01000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_POLARITY2, =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_POLARITY3, =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_DATA0, =A0 =A0 =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_DATA1, =A0 =A0 =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_DATA2, =A0 =A0 =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_DATA3, =A0 =A0 =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_SELECT0, =A0 =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_SELECT1, =A0 =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_SELECT2, =A0 =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_SELECT3, =A0 =A0 =A00x00000000,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_SELECT4, =A0 =A0 =A00x00210222,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_SELECT5, =A0 =A0 =A00x00002200,
> + =A0 =A0 =A0 DC_COM_PIN_OUTPUT_SELECT6, =A0 =A0 =A00x00020000,
> +};
> +
> +
> +void tegra_dc_rgb_init(struct tegra_dc *dc)
> +{
> + =A0 =A0 =A0 tegra_dc_writel(dc, PW0_ENABLE | PW1_ENABLE | PW2_ENABLE | =
PW3_ENABLE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PW4_ENABLE | PM0_ENABLE | P=
M1_ENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DC_CMD_DISPLAY_POWER_CONTRO=
L);
> +
> + =A0 =A0 =A0 tegra_dc_writel(dc, DISP_CTRL_MODE_C_DISPLAY, DC_CMD_DISPLA=
Y_COMMAND);
> +
> + =A0 =A0 =A0 tegra_dc_write_table(dc, tegra_dc_rgb_pintable);
> +}
> +
> +struct tegra_dc_out_ops tegra_dc_rgb_ops =3D {
> + =A0 =A0 =A0 .init =3D tegra_dc_rgb_init,
> +};
> +
> diff --git a/drivers/video/tegra/fb.c b/drivers/video/tegra/fb.c
> new file mode 100644
> index 0000000..4db3958
> --- /dev/null
> +++ b/drivers/video/tegra/fb.c
> @@ -0,0 +1,311 @@
> +/*
> + * drivers/video/tegra/fb.c
> + *
> + * Copyright (C) 2010 Google, Inc.
> + * Author: Erik Gilling <konkers@android.com>
> + * =A0 =A0 =A0 =A0 Colin Cross <ccross@android.com>
> + * =A0 =A0 =A0 =A0 Travis Geiselbrecht <travis@palm.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/fb.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/atomic.h>
> +
> +#include <mach/dc.h>
> +#include <mach/fb.h>
> +
> +struct tegra_fb_info {
> + =A0 =A0 =A0 struct tegra_dc_win =A0 =A0 *win;
> + =A0 =A0 =A0 struct platform_device =A0*pdev;
> + =A0 =A0 =A0 struct fb_info =A0 =A0 =A0 =A0 =A0*info;
> +
> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *fb_mem;
> +
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xres;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 yres;
> +
> + =A0 =A0 =A0 atomic_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in_use;
> +};
> +
> +/* palette array used by the fbcon */
> +static u32 pseudo_palette[16];
> +
> +static int tegra_fb_open(struct fb_info *info, int user)
> +{
> + =A0 =A0 =A0 struct tegra_fb_info *tegra_fb =3D info->par;
> +
> + =A0 =A0 =A0 if (atomic_xchg(&tegra_fb->in_use, 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int tegra_fb_release(struct fb_info *info, int user)
> +{
> + =A0 =A0 =A0 struct tegra_fb_info *tegra_fb =3D info->par;
> +
> + =A0 =A0 =A0 WARN_ON(!atomic_xchg(&tegra_fb->in_use, 0));
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int tegra_fb_check_var(struct fb_var_screeninfo *var,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct fb_info =
*info)
> +{
> + =A0 =A0 =A0 if ((var->xres !=3D info->var.xres) ||
> + =A0 =A0 =A0 =A0 =A0 (var->yres !=3D info->var.yres) ||
> + =A0 =A0 =A0 =A0 =A0 (var->xres_virtual !=3D info->var.xres_virtual) ||
> + =A0 =A0 =A0 =A0 =A0 (var->yres_virtual !=3D info->var.yres_virtual) ||
> + =A0 =A0 =A0 =A0 =A0 (var->grayscale !=3D info->var.grayscale))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int tegra_fb_set_par(struct fb_info *info)
> +{
> + =A0 =A0 =A0 struct tegra_fb_info *tegra_fb =3D info->par;
> + =A0 =A0 =A0 struct fb_var_screeninfo *var =3D &info->var;
> +
> + =A0 =A0 =A0 /* we only support RGB ordering for now */
> + =A0 =A0 =A0 switch (var->bits_per_pixel) {
> + =A0 =A0 =A0 case 32:
> + =A0 =A0 =A0 case 24:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->red.offset =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->red.length =3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->green.offset =3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->green.length =3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->blue.offset =3D 16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->blue.length =3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_fb->win->fmt =3D TEGRA_WIN_FMT_R8G8B8=
A8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 16:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->red.offset =3D 11;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->red.length =3D 5;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->green.offset =3D 5;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->green.length =3D 6;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->blue.offset =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->blue.length =3D 5;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_fb->win->fmt =3D TEGRA_WIN_FMT_B5G6R5;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 info->fix.line_length =3D var->xres * var->bits_per_pixel /=
 8;
> +
> + =A0 =A0 =A0 tegra_dc_update_windows(&tegra_fb->win, 1);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int tegra_fb_setcolreg(unsigned regno, unsigned red, unsigned gre=
en,
> + =A0 =A0 =A0 unsigned blue, unsigned transp, struct fb_info *info)
> +{
> + =A0 =A0 =A0 struct fb_var_screeninfo *var =3D &info->var;
> +
> + =A0 =A0 =A0 if (info->fix.visual =3D FB_VISUAL_TRUECOLOR ||
> + =A0 =A0 =A0 =A0 =A0 info->fix.visual =3D FB_VISUAL_DIRECTCOLOR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 v;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (regno >=3D 16)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D (red << var->red.offset) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (green << var->green.offset=
) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (blue << var->blue.offset);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((u32 *)info->pseudo_palette)[regno] =3D v;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int tegra_fb_pan_display(struct fb_var_screeninfo *var,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct fb_i=
nfo *info)
> +{
> + =A0 =A0 =A0 struct tegra_fb_info *tegra_fb =3D info->par;
> + =A0 =A0 =A0 char __iomem *flush_start;
> + =A0 =A0 =A0 char __iomem *flush_end;
> + =A0 =A0 =A0 u32 addr;
> +
> + =A0 =A0 =A0 flush_start =3D info->screen_base + (var->yoffset * info->f=
ix.line_length);
> + =A0 =A0 =A0 flush_end =3D flush_start + (var->yres * info->fix.line_len=
gth);
> +
> + =A0 =A0 =A0 info->var.xoffset =3D var->xoffset;
> + =A0 =A0 =A0 info->var.yoffset =3D var->yoffset;
> +
> + =A0 =A0 =A0 addr =3D info->fix.smem_start + (var->yoffset * info->fix.l=
ine_length) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (var->xoffset * (var->bits_per_pixel/8));
> +
> + =A0 =A0 =A0 tegra_fb->win->phys_addr =3D addr;
> + =A0 =A0 =A0 /* TODO: update virt_addr */
> +
> + =A0 =A0 =A0 tegra_dc_update_windows(&tegra_fb->win, 1);
> + =A0 =A0 =A0 tegra_dc_sync_windows(&tegra_fb->win, 1);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void tegra_fb_fillrect(struct fb_info *info,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct fb=
_fillrect *rect)
> +{
> + =A0 =A0 =A0 cfb_fillrect(info, rect);
> +}
> +
> +static void tegra_fb_copyarea(struct fb_info *info,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct fb=
_copyarea *region)
> +{
> + =A0 =A0 =A0 cfb_copyarea(info, region);
> +}
> +
> +static void tegra_fb_imageblit(struct fb_info *info,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct=
 fb_image *image)
> +{
> + =A0 =A0 =A0 cfb_imageblit(info, image);
> +}
> +
> +static struct fb_ops tegra_fb_ops =3D {
> + =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 .fb_open =3D tegra_fb_open,
> + =A0 =A0 =A0 .fb_release =3D tegra_fb_release,
> + =A0 =A0 =A0 .fb_check_var =3D tegra_fb_check_var,
> + =A0 =A0 =A0 .fb_set_par =3D tegra_fb_set_par,
> + =A0 =A0 =A0 .fb_setcolreg =3D tegra_fb_setcolreg,
> + =A0 =A0 =A0 .fb_pan_display =3D tegra_fb_pan_display,
> + =A0 =A0 =A0 .fb_fillrect =3D tegra_fb_fillrect,
> + =A0 =A0 =A0 .fb_copyarea =3D tegra_fb_copyarea,
> + =A0 =A0 =A0 .fb_imageblit =3D tegra_fb_imageblit,
> +};
> +
> +struct tegra_fb_info *tegra_fb_register(struct platform_device *pdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct tegra_dc *dc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct tegra_fb_data *fb_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct resource *fb_mem)
> +{
> + =A0 =A0 =A0 struct tegra_dc_win *win;
> + =A0 =A0 =A0 struct fb_info *info;
> + =A0 =A0 =A0 struct tegra_fb_info *tegra_fb;
> + =A0 =A0 =A0 void __iomem *fb_base;
> + =A0 =A0 =A0 unsigned long fb_size;
> + =A0 =A0 =A0 unsigned long fb_phys;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 win =3D tegra_dc_get_window(dc, fb_data->win);
> + =A0 =A0 =A0 if (!win) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "dc does not have a win=
dow at index %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb_data->win);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOENT);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 info =3D framebuffer_alloc(sizeof(struct tegra_fb_info), &p=
dev->dev);
> + =A0 =A0 =A0 if (!info) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 fb_size =3D resource_size(fb_mem);
> + =A0 =A0 =A0 fb_phys =3D fb_mem->start;
> + =A0 =A0 =A0 fb_base =3D ioremap_nocache(fb_phys, fb_size);
> + =A0 =A0 =A0 if (!fb_base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "fb can't be mapped\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tegra_fb =3D info->par;
> + =A0 =A0 =A0 tegra_fb->win =3D win;
> + =A0 =A0 =A0 tegra_fb->pdev =3D pdev;
> + =A0 =A0 =A0 tegra_fb->fb_mem =3D fb_mem;
> + =A0 =A0 =A0 tegra_fb->xres =3D fb_data->xres;
> + =A0 =A0 =A0 tegra_fb->yres =3D fb_data->yres;
> + =A0 =A0 =A0 atomic_set(&tegra_fb->in_use, 0);
> +
> + =A0 =A0 =A0 info->fbops =3D &tegra_fb_ops;
> + =A0 =A0 =A0 info->pseudo_palette =3D pseudo_palette;
> + =A0 =A0 =A0 info->screen_base =3D fb_base;
> + =A0 =A0 =A0 info->screen_size =3D fb_size;
> +
> + =A0 =A0 =A0 strlcpy(info->fix.id, "tegra_fb", sizeof(info->fix.id));
> + =A0 =A0 =A0 info->fix.type =A0 =A0 =A0 =A0 =A0=3D FB_TYPE_PACKED_PIXELS;
> + =A0 =A0 =A0 info->fix.visual =A0 =A0 =A0 =A0=3D FB_VISUAL_TRUECOLOR;
> + =A0 =A0 =A0 info->fix.xpanstep =A0 =A0 =A0=3D 1;
> + =A0 =A0 =A0 info->fix.ypanstep =A0 =A0 =A0=3D 1;
> + =A0 =A0 =A0 info->fix.accel =A0 =A0 =A0 =A0 =3D FB_ACCEL_NONE;
> + =A0 =A0 =A0 info->fix.smem_start =A0 =A0=3D fb_phys;
> + =A0 =A0 =A0 info->fix.smem_len =A0 =A0 =A0=3D fb_size;
> +
> + =A0 =A0 =A0 info->var.xres =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D fb_da=
ta->xres;
> + =A0 =A0 =A0 info->var.yres =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D fb_da=
ta->yres;
> + =A0 =A0 =A0 info->var.xres_virtual =A0 =A0 =A0 =A0 =A0=3D fb_data->xres;
> + =A0 =A0 =A0 info->var.yres_virtual =A0 =A0 =A0 =A0 =A0=3D fb_data->yres=
*2;
> + =A0 =A0 =A0 info->var.bits_per_pixel =A0 =A0 =A0 =A0=3D fb_data->bits_p=
er_pixel;
> + =A0 =A0 =A0 info->var.activate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D FB_ACTIVA=
TE_VBL;
> + =A0 =A0 =A0 /* TODO: fill in the following by querying the DC */
> + =A0 =A0 =A0 info->var.height =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D -1;
> + =A0 =A0 =A0 info->var.width =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D -1;
> + =A0 =A0 =A0 info->var.pixclock =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 24500;
> + =A0 =A0 =A0 info->var.left_margin =A0 =A0 =A0 =A0 =A0 =3D 0;
> + =A0 =A0 =A0 info->var.right_margin =A0 =A0 =A0 =A0 =A0=3D 0;
> + =A0 =A0 =A0 info->var.upper_margin =A0 =A0 =A0 =A0 =A0=3D 0;
> + =A0 =A0 =A0 info->var.lower_margin =A0 =A0 =A0 =A0 =A0=3D 0;
> + =A0 =A0 =A0 info->var.hsync_len =A0 =A0 =A0 =A0 =A0 =A0 =3D 0;
> + =A0 =A0 =A0 info->var.vsync_len =A0 =A0 =A0 =A0 =A0 =A0 =3D 0;
> + =A0 =A0 =A0 info->var.vmode =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D FB_VMOD=
E_NONINTERLACED;
> +
> + =A0 =A0 =A0 win->x =3D 0;
> + =A0 =A0 =A0 win->y =3D 0;
> + =A0 =A0 =A0 win->w =3D fb_data->xres;
> + =A0 =A0 =A0 win->h =3D fb_data->yres;
> + =A0 =A0 =A0 /* TODO: set to output res dc */
> + =A0 =A0 =A0 win->out_w =3D fb_data->xres;
> + =A0 =A0 =A0 win->out_h =3D fb_data->yres;
> + =A0 =A0 =A0 win->phys_addr =3D fb_phys;
> + =A0 =A0 =A0 win->virt_addr =3D fb_base;
> + =A0 =A0 =A0 win->flags =3D TEGRA_WIN_FLAG_ENABLED | TEGRA_WIN_FLAG_COLO=
R_EXPAND;
> +
> + =A0 =A0 =A0 tegra_fb_set_par(info);
> +
> + =A0 =A0 =A0 if (register_framebuffer(info)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to register fra=
mebuffer\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_iounmap_fb;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tegra_fb->info =3D info;
> +
> + =A0 =A0 =A0 dev_info(&pdev->dev, "probed\n");
> +
> + =A0 =A0 =A0 return tegra_fb;
> +
> +err_iounmap_fb:
> + =A0 =A0 =A0 iounmap(fb_base);
> +err_free:
> + =A0 =A0 =A0 framebuffer_release(info);
> +err:
> + =A0 =A0 =A0 return ERR_PTR(ret);
> +}
> +
> +void tegra_fb_unregister(struct tegra_fb_info *fb_info)
> +{
> + =A0 =A0 =A0 struct fb_info *info =3D fb_info->info;
> +
> + =A0 =A0 =A0 unregister_framebuffer(info);
> + =A0 =A0 =A0 iounmap(info->screen_base);
> + =A0 =A0 =A0 framebuffer_release(info);
> +}
> --
> 1.6.5.6
>
>
