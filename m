From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Tue, 16 Mar 2010 07:57:51 +0000
Subject: Re: [RFC/PATCH 08/10] [ARM] tegra: Add framebuffer driver
Message-Id: <45a44e481003160057oaf4a75ax2ec6c9eee9f4a3e9@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4344f3c71003151538r7dc30e01uc9885ca5d3f327cd@mail.gmail.com>
	<1268721688-27550-1-git-send-email-konkers@google.com>
	<1268721688-27550-2-git-send-email-konkers@google.com>
	<1268721688-27550-3-git-send-email-konkers@google.com>
	<1268721688-27550-4-git-send-email-konkers@google.com>
	<1268721688-27550-5-git-send-email-konkers@google.com>
	<1268721688-27550-6-git-send-email-konkers@google.com>
	<1268721688-27550-7-git-send-email-konkers@google.com>
	<1268721688-27550-8-git-send-email-konkers@google.com>
	<1268721688-27550-9-git-send-email-konkers@google.com>
In-Reply-To: <1268721688-27550-9-git-send-email-konkers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Colin, Erik,

Interesting work.

I'd recommend CCing linux-fbdev as well in future so that fbdev folks
can also get a chance to review your new fbdev driver.

On Tue, Mar 16, 2010 at 2:41 PM,  <konkers@google.com> wrote:
> From: Colin Cross <ccross@android.com>
>
> Signed-off-by: Colin Cross <ccross@android.com>
> Signed-off-by: Erik Gilling <konkers@android.com>
> ---
> =A0arch/arm/mach-tegra/include/mach/tegra_fb.h | =A0 24 +
> =A0drivers/video/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 11 +
> =A0drivers/video/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A01 +
> =A0drivers/video/tegrafb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A06=
20 +++++++++++++++++++++++++++
> =A04 files changed, 656 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/mach-tegra/include/mach/tegra_fb.h
> =A0create mode 100644 drivers/video/tegrafb.c
>
> diff --git a/arch/arm/mach-tegra/include/mach/tegra_fb.h b/arch/arm/mach-=
tegra/include/mach/tegra_fb.h
> new file mode 100644
> index 0000000..f173544
> --- /dev/null
> +++ b/arch/arm/mach-tegra/include/mach/tegra_fb.h
> @@ -0,0 +1,24 @@
> +/*
> + * arch/arm/mach-tegra/include/mach/tegra_fb.h
> + *
> + * Copyright (C) 2010 Google, Inc.
> + * Author: Colin Cross <ccross@android.com>
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
> +struct tegra_fb_lcd_data {
> + =A0 =A0 =A0 int =A0 =A0 fb_xres;
> + =A0 =A0 =A0 int =A0 =A0 fb_yres;
> + =A0 =A0 =A0 int =A0 =A0 lcd_xres;
> + =A0 =A0 =A0 int =A0 =A0 lcd_yres;
> + =A0 =A0 =A0 int =A0 =A0 bits_per_pixel;
> +};

I'm trying to understand what's the difference between fb and lcd *res.

> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 5a5c303..b2e68e2 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1074,6 +1074,17 @@ config FB_RIVA_BACKLIGHT
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Say Y here if you want to control the backlight of you=
r display.
>
> +config FB_TEGRA
> + =A0 =A0 =A0 tristate "NVIDIA Tegra SoC display support"
> + =A0 =A0 =A0 depends on ARCH_TEGRA && FB =3D y
> + =A0 =A0 =A0 select FB_CFB_FILLRECT
> + =A0 =A0 =A0 select FB_CFB_COPYAREA
> + =A0 =A0 =A0 select FB_CFB_IMAGEBLIT
> + =A0 =A0 =A0 default FB
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This driver supports the NVIDIA Tegra systems-on-a-chip=
. =A0This
> + =A0 =A0 =A0 =A0 driver can not be compiled as a module.

Out of curiosity, why not?

> +
> =A0config FB_I810
> =A0 =A0 =A0 =A0tristate "Intel 810/815 support (EXPERIMENTAL)"
> =A0 =A0 =A0 =A0depends on EXPERIMENTAL && FB && PCI && X86_32 && AGP_INTEL
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 4ecb30c..d4a14f2 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -129,6 +129,7 @@ obj-$(CONFIG_XEN_FBDEV_FRONTEND) =A0+=3D xen-fbfront.o
> =A0obj-$(CONFIG_FB_CARMINE) =A0 =A0 =A0 =A0 =A0+=3D carminefb.o
> =A0obj-$(CONFIG_FB_MB862XX) =A0 =A0 =A0 =A0 +=3D mb862xx/
> =A0obj-$(CONFIG_FB_MSM) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D msm/
> +obj-$(CONFIG_FB_TEGRA) =A0 =A0 =A0 =A0 =A0 =A0+=3D tegrafb.o
>
> =A0# Platform or fallback drivers go here
> =A0obj-$(CONFIG_FB_UVESA) =A0 =A0 =A0 =A0 =A0 =A0+=3D uvesafb.o
> diff --git a/drivers/video/tegrafb.c b/drivers/video/tegrafb.c
> new file mode 100644
> index 0000000..634022b
> --- /dev/null
> +++ b/drivers/video/tegrafb.c
> @@ -0,0 +1,620 @@
> +/*
> + * drivers/video/tegrafb.c
> + *
> + * Copyright (C) 2010 Google, Inc.
> + * Author: Colin Cross <ccross@android.com>
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
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/clk.h>
> +#include <linux/wait.h>
> +#include <asm/cacheflush.h>
> +#include <mach/tegra_fb.h>
> +
> +#define DEBUG 1

You want to enable Debug by default for everyone?

> +
> +struct tegra_fb_info {
> + =A0 =A0 =A0 struct clk *clk;
> + =A0 =A0 =A0 struct resource *reg_mem;
> + =A0 =A0 =A0 struct resource *fb_mem;
> + =A0 =A0 =A0 void __iomem *reg_base;
> + =A0 =A0 =A0 wait_queue_head_t event_wq;
> + =A0 =A0 =A0 unsigned int wait_condition;
> + =A0 =A0 =A0 int lcd_xres;
> + =A0 =A0 =A0 int lcd_yres;
> + =A0 =A0 =A0 int irq;
> +};

I think a comment about lcd_.res would help us understand what its
used for and how it differs from fb_.res. How come it is being
duplicated in multiple structures?

> +static int tegra_fb_cursor(struct fb_info *info, struct fb_cursor *curso=
r)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int tegra_fb_sync(struct fb_info *info)
> +{
> + =A0 =A0 =A0 return 0;
> +}

Out of curiosity, why populate these functions if they don't do anything?

> +
> +#ifdef DEBUG
> +#define DUMP_REG(a) pr_info("%-32s\t%03x\t%08x\n", #a, a, tegra_fb_readl=
(tegra_fb, a));

Could pr_debug be useful above?

> +static struct fb_ops tegra_fb_ops =3D {
> + =A0 =A0 =A0 .fb_cursor =3D tegra_fb_cursor,
> + =A0 =A0 =A0 .fb_sync =3D tegra_fb_sync,

These 2 were the empty functions from above. I'm guessing this isn't needed.

> +
> +static int tegra_plat_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct fb_info *fb =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 struct tegra_fb_info *tegra_fb =3D fb->par;
> + =A0 =A0 =A0 clk_disable(tegra_fb->clk);
> + =A0 =A0 =A0 iounmap(fb->screen_base);
> + =A0 =A0 =A0 release_resource(tegra_fb->fb_mem);
> + =A0 =A0 =A0 iounmap(tegra_fb->reg_base);
> + =A0 =A0 =A0 release_resource(tegra_fb->reg_mem);
> + =A0 =A0 =A0 framebuffer_release(fb);
> + =A0 =A0 =A0 return 0;
> +}
> +

I didn't read through carefully but shouldn't there be an
unregister_framebuffer in above? Wouldn't the above cause a free while
the structures could still in use by fb*?

Thanks,
jaya
