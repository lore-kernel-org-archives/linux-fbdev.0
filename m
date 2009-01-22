From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] atyfb: fix distorted image on PowerMacs
Date: Thu, 22 Jan 2009 22:12:04 +0200
Message-ID: <20090122201204.GD4996@sci.fi>
References: <46e1c7760901221022p697f1689ubf03c909cdf1b99b@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757722AbZAVUbq@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46e1c7760901221022p697f1689ubf03c909cdf1b99b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Risto Suominen <risto.suominen@gmail.com>
Cc: Alex Kern <alex.kern@gmx.de>, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net

On Thu, Jan 22, 2009 at 08:22:48PM +0200, Risto Suominen wrote:
> Since the complete re-write in 2.6.10, some PowerMacs (At least Power=
Mac 5500
> and PowerMac G3 Beige rev A) with ATI Mach64 chip have suffered from =
unstable
> columns in their framebuffer image. This seems to depend on a value (=
4) read
> from PLL_EXT_CNTL register, which leads to incorrect DSP config param=
eters to
> be written to the chip. This patch uses a value calculated by aty_ini=
t_pll_ct
> instead, as a starting point.

AFAICS it should be the right thing to do on other systems too. I have
a good collection of mach64 pci cards and laptops so I'll try to find
some time next week to test that theory on x86.

Also cc:ing fbdev-devel...

> Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
> ---
> The testing is done on kernel version 2.6.18.
>=20
> --- a/drivers/video/aty/mach64_ct.c.org	2006-09-20 06:42:06.000000000=
 +0300
> +++ b/drivers/video/aty/mach64_ct.c	2009-01-22 14:28:13.000000000 +02=
00
> @@ -7,6 +7,7 @@
>  #include <linux/delay.h>
>  #include <asm/io.h>
>  #include <video/mach64.h>
> +#include <asm/machdep.h>
>  #include "atyfb.h"
>=20
>  #undef DEBUG
> @@ -536,6 +537,14 @@ static int __init aty_init_pll_ct(const
>  	pll->ct.xclk_post_div_real =3D postdividers[xpost_div];
>  	pll->ct.mclk_fb_div =3D q * pll->ct.xclk_post_div_real / 8;
>=20
> +#ifdef CONFIG_PPC
> +	if (machine_is(powermac)) {
> +		/* Override PLL_EXT_CNTL & 0x07. */
> +		pll->ct.xclk_post_div =3D xpost_div;
> +		pll->ct.xclk_ref_div =3D 1;
> +	}
> +#endif
> +
>  #ifdef DEBUG
>  	pllmclk =3D (1000000 * pll->ct.mclk_fb_mult * pll->ct.mclk_fb_div) =
/
>  			(par->ref_clk_per * pll->ct.pll_ref_div);

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
