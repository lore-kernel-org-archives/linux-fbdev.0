From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 10 Jun 2011 17:01:56 +0000
Subject: Re: [PATCH 15/29] mx3fb: use display information in info not in var for panning
Message-Id: <201106101901.56984.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306364301-8195-16-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1306364301-8195-16-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Guennadi,

On Friday 10 June 2011 11:01:46 Guennadi Liakhovetski wrote:
> On Thu, 26 May 2011, Laurent Pinchart wrote:
> > We must not use any information in the passed var besides xoffset,
> > yoffset and vmode as otherwise applications might abuse it. Also use the
> > aligned fix.line_length and not the (possible) unaligned xres_virtual.
> >=20
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >=20
> >  drivers/video/mx3fb.c |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> > index 7e3a490..759e244 100644
> > --- a/drivers/video/mx3fb.c
> > +++ b/drivers/video/mx3fb.c
> > @@ -1062,15 +1062,15 @@ static int mx3fb_pan_display(struct
> > fb_var_screeninfo *var,
> >=20
> >  	y_bottom =3D var->yoffset;
> >  =09
> >  	if (!(var->vmode & FB_VMODE_YWRAP))
> >=20
> > -		y_bottom +=3D var->yres;
> > +		y_bottom +=3D fbi->var.yres;
> >=20
> >  	if (y_bottom > fbi->var.yres_virtual)
> >  =09
> >  		return -EINVAL;
> >  =09
> >  	mutex_lock(&mx3_fbi->mutex);
> >=20
> > -	offset =3D (var->yoffset * var->xres_virtual + var->xoffset) *
> > -		(var->bits_per_pixel / 8);
> > +	offset =3D var->yoffset * fbi->fix.line_length
> > +	       + var->xoffset * (var->bits_per_pixel / 8);
>=20
> Didn't you mean
>=20
> +	       + var->xoffset * (fbi->var.bits_per_pixel / 8);

Yes, my bad. Thank you.

> With this fix:
>=20
> Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>=20
> (tested using http://git.ideasonboard.org/?p=FBdev-test.git;a=3Dsummary)

Thanks.

--=20
Regards,

Laurent Pinchart
