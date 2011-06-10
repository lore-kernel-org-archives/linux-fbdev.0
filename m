From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 10 Jun 2011 09:01:46 +0000
Subject: Re: [PATCH 15/29] mx3fb: use display information in info not in var
Message-Id: <Pine.LNX.4.64.1106101045300.12671@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306364301-8195-16-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1306364301-8195-16-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Thu, 26 May 2011, Laurent Pinchart wrote:

> We must not use any information in the passed var besides xoffset,
> yoffset and vmode as otherwise applications might abuse it. Also use the
> aligned fix.line_length and not the (possible) unaligned xres_virtual.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/video/mx3fb.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> index 7e3a490..759e244 100644
> --- a/drivers/video/mx3fb.c
> +++ b/drivers/video/mx3fb.c
> @@ -1062,15 +1062,15 @@ static int mx3fb_pan_display(struct fb_var_screen=
info *var,
>  	y_bottom =3D var->yoffset;
> =20
>  	if (!(var->vmode & FB_VMODE_YWRAP))
> -		y_bottom +=3D var->yres;
> +		y_bottom +=3D fbi->var.yres;
> =20
>  	if (y_bottom > fbi->var.yres_virtual)
>  		return -EINVAL;
> =20
>  	mutex_lock(&mx3_fbi->mutex);
> =20
> -	offset =3D (var->yoffset * var->xres_virtual + var->xoffset) *
> -		(var->bits_per_pixel / 8);
> +	offset =3D var->yoffset * fbi->fix.line_length
> +	       + var->xoffset * (var->bits_per_pixel / 8);

Didn't you mean

+	       + var->xoffset * (fbi->var.bits_per_pixel / 8);

With this fix:

Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

(tested using http://git.ideasonboard.org/?p=FBdev-test.git;a=3Dsummary)

Thanks
Guennadi

>  	base =3D fbi->fix.smem_start + offset;
> =20
>  	dev_dbg(fbi->device, "Updating SDC BG buf %d address=3D0x%08lX\n",
> --=20
> 1.7.3.4
>=20

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
