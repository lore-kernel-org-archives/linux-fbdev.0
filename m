From: Joe Perches <joe@perches.com>
Date: Sat, 27 Aug 2016 03:18:06 +0000
Subject: Re: [PATCH] mx3fb: Fix print format string
Message-Id: <1472267886.26978.3.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1472267137-810445-1-git-send-email-green@linuxhacker.ru>
In-Reply-To: <1472267137-810445-1-git-send-email-green@linuxhacker.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Oleg Drokin <green@linuxhacker.ru>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2016-08-26 at 23:05 -0400, Oleg Drokin wrote:
> %ul was probably meant as %lu since the former would print
> an unsigned value and a letter l.
>=20
> But in fact the whole value we are printing in u32 anyway, so
> we don't need the format to be long. Therefore just drop the l
> altogether.
[]
> Also do we really need 1000UL specification if we
> cast to u32 anyway? Or should we drop away the cast instead?
> Are pixelclocks over 4GHz possible here?

It's a debugging printk, it doesn't matter much.
Why not use "%u kHz" and drop the "* 1000UL"?

> diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
[]
> @@ -845,7 +845,7 @@ static int __set_par(struct fb_info *fbi, bool lock)
> =A0		if (fbi->var.sync & FB_SYNC_SHARP_MODE)
> =A0			mode =3D IPU_PANEL_SHARP_TFT;
> =A0
> -		dev_dbg(fbi->device, "pixclock =3D %ul Hz\n",
> +		dev_dbg(fbi->device, "pixclock =3D %u Hz\n",
> =A0			(u32) (PICOS2KHZ(fbi->var.pixclock) * 1000UL));
> =A0
> =A0		if (sdc_init_panel(mx3fb, mode,
