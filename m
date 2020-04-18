From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 18 Apr 2020 10:14:52 +0000
Subject: Re: [PATCH 1/8] fbdev: w100fb: clean up mach-pxa compile-time dependency
Message-Id: <CAK8P3a3DD3qy=SkZjy=X3+1ooHUcXEWu05JApeeyoQN4VOntCQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
 <20200417155553.675905-2-arnd@arndb.de>
 <877dydp0ih.fsf@belgarion.home>
In-Reply-To: <877dydp0ih.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, David Airlie <airlied@linux.ie>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Marek Vasut <marex@denx.de>, Thomas Hellstrom <thellstrom@vmware.com>, dsd@laptop.org, Jason Gunthorpe <jgg@ziepe.ca>, Masahiro Yamada <masahiroy@kernel.org>, Saeed Mahameed <saeedm@mellanox.com>, Geert Uytterhoeven <geert@linux-m68k.org>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, dri-devel <dri-devel@lists.freedesktop.org>, jfrederich@gmail.com, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Daniel Mack <daniel@zonque.org>

On Sat, Apr 18, 2020 at 12:11 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
> Arnd Bergmann <arnd@arndb.de> writes:
>
> Hi Arnd,
>
> > diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> > index f60bc29aef68..8444d40df1b3 100644
> > --- a/arch/arm/mach-pxa/Kconfig
> > +++ b/arch/arm/mach-pxa/Kconfig
> > @@ -549,9 +549,6 @@ config MACH_ICONTROL
> >
> >  config ARCH_PXA_ESERIES
> >       bool "PXA based Toshiba e-series PDAs"
> > -     select FB_W100
> > -     select FB
> > -     select PXA25x
> This last line puzzles me a bit in this patch. Why removing the PXA25x select ?

It's a mistake, fixed now. Thanks for taking a look!

      Arnd
