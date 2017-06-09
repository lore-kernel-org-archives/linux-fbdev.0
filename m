From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 09 Jun 2017 07:49:00 +0000
Subject: Re: [PATCH 1/2] video: adp8860: move header file out of I2C realm
Message-Id: <20170609074900.owjczluv7kkoso3f@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170521220953.2602-1-wsa@the-dreams.de>
 <20170521220953.2602-2-wsa@the-dreams.de>
 <20170609074345.v5jkajra5qdsn2x7@dell>
In-Reply-To: <20170609074345.v5jkajra5qdsn2x7@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Steven Miao <realmz6@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, 09 Jun 2017, Lee Jones wrote:

> On Mon, 22 May 2017, Wolfram Sang wrote:
>=20
> > include/linux/i2c is not for client devices. Move the header file to a
> > more appropriate location.
> >=20
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> >  arch/blackfin/mach-bf537/boards/stamp.c        | 2 +-
> >  drivers/video/backlight/adp8860_bl.c           | 2 +-
> >  include/linux/{i2c =3D> platform_data}/adp8860.h | 0
> >  3 files changed, 2 insertions(+), 2 deletions(-)
> >  rename include/linux/{i2c =3D> platform_data}/adp8860.h (100%)
>=20
> Applied, thanks.

Scrap that.  I can't actually apply these without Steven's Ack.

> > diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/ma=
ch-bf537/boards/stamp.c
> > index 24985e658c19cd..7db90c72bd8ddc 100644
> > --- a/arch/blackfin/mach-bf537/boards/stamp.c
> > +++ b/arch/blackfin/mach-bf537/boards/stamp.c
> > @@ -2047,7 +2047,7 @@ static struct adp8870_backlight_platform_data adp=
8870_pdata =3D {
> >  #endif
> > =20
> >  #if IS_ENABLED(CONFIG_BACKLIGHT_ADP8860)
> > -#include <linux/i2c/adp8860.h>
> > +#include <linux/platform_data/adp8860.h>
> >  static struct led_info adp8860_leds[] =3D {
> >  	{
> >  		.name =3D "adp8860-led7",
> > diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backl=
ight/adp8860_bl.c
> > index 510e559c060e59..e7315bf14d6015 100644
> > --- a/drivers/video/backlight/adp8860_bl.c
> > +++ b/drivers/video/backlight/adp8860_bl.c
> > @@ -18,7 +18,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/workqueue.h>
> > =20
> > -#include <linux/i2c/adp8860.h>
> > +#include <linux/platform_data/adp8860.h>
> >  #define ADP8860_EXT_FEATURES
> >  #define ADP8860_USE_LEDS
> > =20
> > diff --git a/include/linux/i2c/adp8860.h b/include/linux/platform_data/=
adp8860.h
> > similarity index 100%
> > rename from include/linux/i2c/adp8860.h
> > rename to include/linux/platform_data/adp8860.h
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
