From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 14 Aug 2017 06:43:55 +0000
Subject: Re: [PATCH 2/3] mfd: tps65010: move header file out of I2C realm
Message-Id: <20170814064355.foiilzr5cmwk65hr@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-3-wsa@the-dreams.de>
 <20170523071819.4zpdef7ofzz3moil@dell>
 <20170813133445.vqbfelwshvrififp@ninjato>
In-Reply-To: <20170813133445.vqbfelwshvrififp@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Sun, 13 Aug 2017, Wolfram Sang wrote:

> On Tue, May 23, 2017 at 08:18:19AM +0100, Lee Jones wrote:
> > On Mon, 22 May 2017, Wolfram Sang wrote:
> >=20
> > > include/linux/i2c is not for client devices. Move the header file to a
> > > more appropriate location.
> > >=20
> > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > > ---
> > >  arch/arm/mach-omap1/board-h2-mmc.c      | 2 +-
> > >  arch/arm/mach-omap1/board-h2.c          | 2 +-
> > >  arch/arm/mach-omap1/board-h3-mmc.c      | 2 +-
> > >  arch/arm/mach-omap1/board-h3.c          | 2 +-
> > >  arch/arm/mach-omap1/board-osk.c         | 2 +-
> > >  arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 2 +-
> > >  arch/arm/mach-s3c24xx/mach-osiris.c     | 2 +-
> >=20
> > >  drivers/mfd/tps65010.c                  | 2 +-
> >=20
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>=20
> Same here: ok for 4.14 or something needed?

Can this patch be applied on its own, or does it have dependencies?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
