From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 29 Feb 2016 16:39:59 +0000
Subject: Re: [PATCH v2] video: exynos: fix modular build
Message-Id: <6291541.7IMAnfX0g2@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456490307-823812-1-git-send-email-arnd@arndb.de>
 <56D46DFD.6090706@ti.com>
In-Reply-To: <56D46DFD.6090706@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 29 February 2016 18:12:45 Tomi Valkeinen wrote:
> Hi,
> 
> On 26/02/16 14:38, Arnd Bergmann wrote:
> > The s6e8ax0 driver has a dependency on BACKLIGHT_CLASS_DEVICE,
> > which can be configured as a loadable module, so we have to
> > make the driver a tristate symbol as well, to avoid this error:
> > 
> > drivers/built-in.o: In function `s6e8ax0_probe':
> > :(.text+0x23a48): undefined reference to `devm_backlight_device_register'
> 
> If a 'bool' Kconfig option depends on BACKLIGHT_CLASS_DEVICE, shouldn't
> the Kconfig dependency take care of having BACKLIGHT_CLASS_DEVICE as
> built-in?

No, that's not how Kconfig interprets it. There are many bool option
that depend on tristate options but can be enabled if the dependency
is built-in.

Take this one for example:

config FIRMWARE_EDID
       bool "Enable firmware EDID"
       depends on FB

We clearly want to be able to turn this on even for FB=m.

> > This also means we get another error from a missing export, which
> > this fixes as well:
> > 
> > ERROR: "exynos_mipi_dsi_register_lcd_driver" [drivers/video/fbdev/exynos/s6e8ax0.ko] undefined!
> > 
> > The drivers are all written to be loadable modules already,
> > except the Kconfig options for that are missing, which makes
> > the patch really easy.
> 
> Looks and sound fine, except doesn't this tell that the drivers have
> never been tested as modules? Did you or someone else actually test these?

No, this is not runtime tested. Generally there is very little that
can go wrong here though.

An alternative would be to change the dependency to

	depends on BACKLIGHT_CLASS_DEVICE=y

which doesn't allow the driver to be turned on for the =m case.
However, no other framebuffer driver does this.

> > diff --git a/drivers/video/fbdev/exynos/Makefile b/drivers/video/fbdev/exynos/Makefile
> > index b5b1bd228abb..02d8dc522fea 100644
> > --- a/drivers/video/fbdev/exynos/Makefile
> > +++ b/drivers/video/fbdev/exynos/Makefile
> > @@ -2,6 +2,8 @@
> >  # Makefile for the exynos video drivers.
> >  #
> >  
> > -obj-$(CONFIG_EXYNOS_MIPI_DSI)		+= exynos_mipi_dsi.o exynos_mipi_dsi_common.o \
> > -				     	exynos_mipi_dsi_lowlevel.o
> > +obj-$(CONFIG_EXYNOS_MIPI_DSI)		+= exynos-mipi-dsi-mod.o
> > +
> > +exynos-mipi-dsi-mod-objs		+= exynos_mipi_dsi.o exynos_mipi_dsi_common.o \
> > +					   exynos_mipi_dsi_lowlevel.o
> 
> Hmm, why is this makefile change needed?

The original Makefile would link each file into a separate module, but that
cannot work, because they reference symbols from each other that are not
exported to other modules.

With my change, all the files get linked into a single module.

	Arnd
