From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 28 Aug 2018 15:34:32 +0000
Subject: Re: [PATCH 2/3] mach64: fix image corruption due to reading accelerator registers
Message-Id: <alpine.LRH.2.02.1808281133230.30259@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="185206533-734457481-1535470474=:30259"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1808251551020.8284@file01.intranet.prod.int.rdu2.redhat.com>
 <20180827125514.GE11867@sci.fi>
In-Reply-To: <20180827125514.GE11867@sci.fi>
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-734457481-1535470474=:30259
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



On Mon, 27 Aug 2018, Ville Syrj=E4l=E4 wrote:

> On Sat, Aug 25, 2018 at 03:51:52PM -0400, Mikulas Patocka wrote:
> > Reading the registers without waiting for engine idle returns
> > unpredictable values. These unpredictable values result in display
> > corruption - if atyfb_imageblit reads the content of DP_PIX_WIDTH with =
the
> > bit DP_HOST_TRIPLE_EN set (from previous invocation), the driver would
> > never ever clear the bit, resulting in display corruption.
> >=20
> > We don't want to wait for idle because it would degrade performance, so
> > this patch modifies the driver so that it never reads accelerator
> > registers.
> >=20
> > HOST_CNTL doesn't have to be read, we can just write it with
> > HOST_BYTE_ALIGN because no other part of the driver cares if
> > HOST_BYTE_ALIGN is set.
> >=20
> > DP_PIX_WIDTH is written in the functions atyfb_copyarea and atyfb_fillr=
ect
> > with the default value and in atyfb_imageblit with the value set accord=
ing
> > to the source image data.
> >=20
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: stable@vger.kernel.org
> >=20
> > ---
> >  drivers/video/fbdev/aty/mach64_accel.c |   22 +++++++++-------------
> >  1 file changed, 9 insertions(+), 13 deletions(-)
> >=20
> > Index: linux-stable/drivers/video/fbdev/aty/mach64_accel.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-stable.orig/drivers/video/fbdev/aty/mach64_accel.c	2018-08-24=
 19:51:34.000000000 +0200
> > +++ linux-stable/drivers/video/fbdev/aty/mach64_accel.c	2018-08-24 20:2=
8:55.000000000 +0200
> > @@ -127,7 +127,7 @@ void aty_init_engine(struct atyfb_par *p
> > =20
> >  	/* set host attributes */
> >  	wait_for_fifo(13, par);
> > -	aty_st_le32(HOST_CNTL, 0, par);
> > +	aty_st_le32(HOST_CNTL, HOST_BYTE_ALIGN, par);
> > =20
> >  	/* set pattern attributes */
> >  	aty_st_le32(PAT_REG0, 0, par);
> > @@ -233,7 +233,8 @@ void atyfb_copyarea(struct fb_info *info
> >  		rotation =3D rotation24bpp(dx, direction);
> >  	}
> > =20
> > -	wait_for_fifo(4, par);
> > +	wait_for_fifo(5, par);
> > +	aty_st_le32(DP_PIX_WIDTH, par->crtc.dp_pix_width, par);
> >  	aty_st_le32(DP_SRC, FRGD_SRC_BLIT, par);
> >  	aty_st_le32(SRC_Y_X, (sx << 16) | sy, par);
> >  	aty_st_le32(SRC_HEIGHT1_WIDTH1, (width << 16) | area->height, par);
> > @@ -269,7 +270,8 @@ void atyfb_fillrect(struct fb_info *info
> >  		rotation =3D rotation24bpp(dx, DST_X_LEFT_TO_RIGHT);
> >  	}
> > =20
> > -	wait_for_fifo(3, par);
> > +	wait_for_fifo(4, par);
> > +	aty_st_le32(DP_PIX_WIDTH, par->crtc.dp_pix_width, par);
> >  	aty_st_le32(DP_FRGD_CLR, color, par);
> >  	aty_st_le32(DP_SRC,
> >  		    BKGD_SRC_BKGD_CLR | FRGD_SRC_FRGD_CLR | MONO_SRC_ONE,
> > @@ -284,7 +286,7 @@ void atyfb_imageblit(struct fb_info *inf
> >  {
> >  	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
> >  	u32 src_bytes, dx =3D image->dx, dy =3D image->dy, width =3D image->w=
idth;
> > -	u32 pix_width_save, pix_width, host_cntl, rotation =3D 0, src, mix;
> > +	u32 pix_width, rotation =3D 0, src, mix;
> > =20
> >  	if (par->asleep)
> >  		return;
> > @@ -296,8 +298,7 @@ void atyfb_imageblit(struct fb_info *inf
> >  		return;
> >  	}
> > =20
> > -	pix_width =3D pix_width_save =3D aty_ld_le32(DP_PIX_WIDTH, par);
> > -	host_cntl =3D aty_ld_le32(HOST_CNTL, par) | HOST_BYTE_ALIGN;
> > +	pix_width =3D par->crtc.dp_pix_width;
> > =20
> >  	switch (image->depth) {
> >  	case 1:
> > @@ -370,12 +371,11 @@ void atyfb_imageblit(struct fb_info *inf
> >  		mix =3D FRGD_MIX_D_XOR_S | BKGD_MIX_D;
> >  	}
> > =20
> > -	wait_for_fifo(6, par);
> > -	aty_st_le32(DP_WRITE_MASK, 0xFFFFFFFF, par);
>=20
> Looks like init_engine() sets this one for us. So dropping should be ok.
>=20
> > +	wait_for_fifo(5, par);
> >  	aty_st_le32(DP_PIX_WIDTH, pix_width, par);
> >  	aty_st_le32(DP_MIX, mix, par);
> >  	aty_st_le32(DP_SRC, src, par);
> > -	aty_st_le32(HOST_CNTL, host_cntl, par);
> > +	aty_st_le32(HOST_CNTL, HOST_BYTE_ALIGN, par);
>=20
> Presumably we could drop this as well since it never changes.

I tried to drop this HOST_CNTL write and it didn't work. It seems that the =

register is written implicitly by some of the other commands.

Mikulas

> Either way
> Reviewed-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
>=20
> >  	aty_st_le32(DST_CNTL, DST_Y_TOP_TO_BOTTOM | DST_X_LEFT_TO_RIGHT | rot=
ation, par);
> > =20
> >  	draw_rect(dx, dy, width, image->height, par);
> > @@ -424,8 +424,4 @@ void atyfb_imageblit(struct fb_info *inf
> >  			aty_st_le32(HOST_DATA0, get_unaligned_le32(pbitmap), par);
> >  		}
> >  	}
> > -
> > -	/* restore pix_width */
> > -	wait_for_fifo(1, par);
> > -	aty_st_le32(DP_PIX_WIDTH, pix_width_save, par);
> >  }
>=20
> --=20
> Ville Syrj=E4l=E4
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/
>=20
--185206533-734457481-1535470474=:30259--
