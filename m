From: Rabin Vincent <rabin@rab.in>
Date: Tue, 25 Oct 2011 15:25:39 +0000
Subject: Re: fb_setcolreg(), CNVT_TOHW() and chan_to_field()
Message-Id: <20111025151300.GA11517@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111025073349.GB6027@debian>
In-Reply-To: <20111025073349.GB6027@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Tue, Oct 25, 2011 at 01:15:41PM +0200, Geert Uytterhoeven wrote:
> On Tue, Oct 25, 2011 at 09:34, Rabin Vincent <rabin@rab.in> wrote:
> > I'm trying to figure out the best way to implement fb_setcolreg() for
> > FB_VISUAL_TRUECOLOR.
>=20
> FB_VISUAL_TRUECOLOR implies the colormap is read-only.
> Perhaps you meant FB_VISUAL_DIRECTCOLOR?

I was referring to the pseudo palette usage for FB_VISUAL_TRUECOLOR, which =
is
where most of the drivers use chan_to_field(), for example in s3c2410fb.c:

	switch (info->fix.visual) {
	case FB_VISUAL_TRUECOLOR:
		/* true-colour, use pseudo-palette */

		if (regno < 16) {
			u32 *pal =3D info->pseudo_palette;

			val  =3D chan_to_field(red,   &info->var.red);

>=20
> > 14 or so drivers copy/paste the CNVT_TOHW from skeletonfb.c:
> >
> > =A0#define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
> > =A0...
> > =A0red =3D CNVT_TOHW(red, info->var.red.length);
> >
> > Another 18 or so drivers copy/paste a chan_to_field() function which has
> > a straightforward shift:
> >
> > =A0static inline u_int chan_to_field(u_int chan, struct fb_bitfield *bf)
> > =A0{
> > =A0 =A0 =A0 =A0chan &=3D 0xffff;
> > =A0 =A0 =A0 =A0chan >>=3D 16 - bf->length;
> > =A0 =A0 =A0 =A0return chan << bf->offset;
> > =A0}
> > =A0...
> > =A0val =3D chan_to_field(red, &info->var.red);
> >
> > Both methods return similar values, except that with CNVT_TOHW() the
> > extreme values seem to have a smaller range than the other values, while
> > with the chan_to_field() shift all the values have an equal range.
> >
> > What's the reason behind choosing one over the other? =A0Could/should a
> > common function be provided for all the drivers to use?
>=20
> The idea is to use the full dynamic range of the 16-bit values. I.e. 'all=
 ones'
> in the hardware-specific value should map to 'all ones' in the 16-bit exp=
anded
> value. So the macros are preferred.

I'm not sure I follow.  In the pseudo palette, where the bf->length is less
than 16, both CNVT_TOHW() and the plain shift return the same values for the
all-ones case.
