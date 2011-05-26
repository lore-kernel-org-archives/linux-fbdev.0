From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 May 2011 09:32:22 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdcfb: Reduce scope and rename result variable
Message-Id: <201105261132.23268.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306392790-17462-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1306392790-17462-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Damian,

On Thursday 26 May 2011 08:53:10 Damian Hobson-Garcia wrote:
> Commit 69843ba7f24950f8ef5dadacfbfbd08f53e3455b
> reduces the scope of the variable that was used to get the
> return value of ops->meram_register() in sh_mobile_lcdc_start.
>=20
> In order to avoid conflicts with that patch, the variable has been renamed
> and scoped within the local if-clause.

Is there a need for this patch after=20
http://git.kernel.org/?p=3Dlinux/kernel/git/lethal/fbdev-2.6.git;a=3Dcommit=
diff;h=C046a54e7e98577d3f04ce9d7ef1ec43a41c9061;hpw32eeb425419599de15096ce9=
2d7eb6a51d749a=20
?

> ---
>  drivers/video/sh_mobile_lcdcfb.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/sh_mobile_lcdcfb.c
> b/drivers/video/sh_mobile_lcdcfb.c index 404c03b..596b662 100644
> --- a/drivers/video/sh_mobile_lcdcfb.c
> +++ b/drivers/video/sh_mobile_lcdcfb.c
> @@ -617,6 +617,7 @@ static int sh_mobile_lcdc_start(struct
> sh_mobile_lcdc_priv *priv) unsigned long icb_addr_y, icb_addr_c;
>  			int icb_pitch;
>  			int pf;
> +			int retval;
>=20
>  			cfg =3D ch->cfg.meram_cfg;
>  			mdev =3D priv->meram_dev;
> @@ -637,7 +638,7 @@ static int sh_mobile_lcdc_start(struct
> sh_mobile_lcdc_priv *priv) pf =3D SH_MOBILE_MERAM_PF_RGB;
>  			}
>=20
> -			ret =3D mdev->ops->meram_register(mdev, cfg, pitch,
> +			retval =3D mdev->ops->meram_register(mdev, cfg, pitch,
>  						ch->info->var.yres,
>  						pf,
>  						base_addr_y,
> @@ -645,7 +646,7 @@ static int sh_mobile_lcdc_start(struct
> sh_mobile_lcdc_priv *priv) &icb_addr_y,
>  						&icb_addr_c,
>  						&icb_pitch);
> -			if (!ret)  {
> +			if (!retval)  {
>  				/* set LDSA1R value */
>  				base_addr_y =3D icb_addr_y;
>  				pitch =3D icb_pitch;

--=20
Regards,

Laurent Pinchart
