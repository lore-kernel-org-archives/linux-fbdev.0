From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Date: Fri, 12 Nov 2010 12:07:06 +0000
Subject: Re: [PATCH] OMAP: DSS2: OMAPFB: Fix null pointer check
Message-Id: <20101112120705.GF27763@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289562435-8056-1-git-send-email-samreen@ti.com>
In-Reply-To: <1289562435-8056-1-git-send-email-samreen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ext Samreen <samreen@ti.com>
Cc: "Valkeinen Tomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, Nov 12, 2010 at 12:47:15PM +0100, ext Samreen wrote:
> A null pointer check added.
>=20
> Signed-off-by: Samreen <samreen@ti.com>
> ---
>  drivers/video/omap2/omapfb/omapfb-main.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/oma=
p2/omapfb/omapfb-main.c
> index 6a704f1..55bed89 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -2133,6 +2133,8 @@ static int omapfb_parse_def_modes(struct omapfb2_de=
vice *fbdev)
>  	int r =3D 0;
> =20
>  	str =3D kmalloc(strlen(def_mode) + 1, GFP_KERNEL);
> +	if (str =3D NULL)
> +		return -EINVAL;
>  	strcpy(str, def_mode);

While you're at it you could change the code to use kstrdup().

--=20
Ville Syrj=E4l=E4
