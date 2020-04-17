From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Apr 2020 19:55:43 +0000
Subject: Re: [PATCH 7/8] fbdev: rework backlight dependencies
Message-Id: <CAK8P3a31OMHOycpGv5tjQXS=NBGw+OoFRGQ0Za7QWw9=EcwgZg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
 <20200417155553.675905-8-arnd@arndb.de>
 <20200417170444.GB30483@ravnborg.org>
In-Reply-To: <20200417170444.GB30483@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Marek Vasut <marex@denx.de>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dsd@laptop.org, Nicolas Pitre <nico@fluxnic.net>, David Airlie <airlied@linux.ie>, Masahiro Yamada <masahiroy@kernel.org>, jfrederich@gmail.com, Saeed Mahameed <saeedm@mellanox.com>, Thomas Hellstrom <thellstrom@vmware.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, dri-devel <dri-devel@lists.freedesktop.org>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Jason Gunthorpe <jgg@ziepe.ca>, Daniel Mack <daniel@zonque.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>

On Fri, Apr 17, 2020 at 7:04 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Arnd.
>
> On Fri, Apr 17, 2020 at 05:55:52PM +0200, Arnd Bergmann wrote:
> > Rather than having CONFIG_FB_BACKLIGHT select CONFIG_BACKLIGHT_CLASS_DEVICE,
> > make any driver that needs it have a dependency on the class device
> > being available, to prevent circular dependencies.
> >
> > This is the same way that the backlight is already treated for the DRM
> > subsystem.
>
> I am not happy with the direction of this patch.
> It is not easy to understand that one has to enable backlight to
> be allowed to select a display or an fbdev driver.
>
>
> How about somthing like this:
>
> config BACKLIGHT_CLASS_DEVICE
>         tristate
>         # Will enable backlight module
>         # Has no dependencies
>
> config  BACKLIGHT
>         bool "Backlight drivers"
>         # Will make the backlight drivers visible - a visibility option
>         # only
>
> All drivers outside video/backlight/ can then select
> BACKLIGHT_CLASS_DEVICE to get the backlight core
> module.
> Or in other words BACKLIGHT_CLASS_DEVICE is used as a sort
> of library symbol that gices us access to backlight functionality.

Right, this could work as long as nobody puts back any "depends on
BACKLIGHT_CLASS_DEVICE, but it does cause another problem: There
are a couple of drivers that can optionally use backlight support
or just leave it out depending on CONFIG_BACKLIGHT_CLASS_DEVICE.

Changing them to select the class device support unconditionally
would make it impossible to build those drivers without it.
Instead we could all need an individual Kconfig symbol, or use
have "select BACKLIGHT_CLASS_DEVICE if BACKLIGHT"
in each case, but I'm not sure if that's still a win over having a
simple 'depends on BACKLIGHT_CLASS_DEVICE'.

On a related note, the NEW_LEDS/LEDS_CLASS option probably
falls into the same category, and could also be done as you suggest.
At the moment, this has the problem that both symbols are user
visible and also frequently selected by device drivers (but not others),
which is causing another set of dependency issues.

      Arnd
