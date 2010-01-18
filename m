From: Peter =?utf-8?q?H=C3=BCwe?= <PeterHuewe@gmx.de>
Date: Mon, 18 Jan 2010 19:27:29 +0000
Subject: Re: [PATCH] video/matrox: Checkpatch cleanups for matroxfb_crtc2.c
Message-Id: <201001182027.29805.PeterHuewe@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001181934.49519.PeterHuewe@gmx.de> <1263842269.26846.122.camel@Joe-Laptop.home>
In-Reply-To: <1263842269.26846.122.camel@Joe-Laptop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Joe Perches <joe@perches.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@linux-foundation.org>, Jean Delvare <khali@linux-fr.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Am Montag 18 Januar 2010 20:17:49 schrieb Joe Perches:
> On Mon, 2010-01-18 at 19:34 +0100, Peter H=C3=BCwe wrote:
> > From: Peter Huewe <peterhuewe@gmx.de>
> > Date: Mon, 18 Jan 2010 19:21:02 +0100
> > This patch fixes all 77 errors reported by checkpatch - no functional
> > change was made. The line over 80 chars warnings were left untouched.
> > diff --git a/drivers/video/matrox/matroxfb_crtc2.c
> > b/drivers/video/matrox/matroxfb_crtc2.c index 78414ba..790ca47 100644
> > --- a/drivers/video/matrox/matroxfb_crtc2.c
> > +++ b/drivers/video/matrox/matroxfb_crtc2.c
> > @@ -42,42 +43,41 @@ static int matroxfb_dh_setcolreg(unsigned regno,
> > unsigned red, unsigned green, blue =3D CNVT_TOHW(blue,
> > m2info->fbcon.var.blue.length);
> >  	transp =3D CNVT_TOHW(transp, m2info->fbcon.var.transp.length);
> >
> > -	col =3D (red << m2info->fbcon.var.red.offset)     |
> > -	      (green << m2info->fbcon.var.green.offset) |
> > -	      (blue << m2info->fbcon.var.blue.offset)   |
> > -	      (transp << m2info->fbcon.var.transp.offset);
> > +	col =3D	(red << m2info->fbcon.var.red.offset)		|
> > +			(green << m2info->fbcon.var.green.offset)	|
> > +			(blue << m2info->fbcon.var.blue.offset)		|
> > +			(transp << m2info->fbcon.var.transp.offset);
>=20
> I think this is not an improvement.
>=20

Hi,
the reason behind this change was that spaces and tabs were mixed for=20
indention.=20



-       col =3D   (red << m2info->fbcon.var.red.offset)           |
-                       (green << m2info->fbcon.var.green.offset)       |
-                       (blue << m2info->fbcon.var.blue.offset)         |
-                       (transp << m2info->fbcon.var.transp.offset);
+       col =3D (red << m2info->fbcon.var.red.offset)             |
+               (green << m2info->fbcon.var.green.offset)       |
+               (blue << m2info->fbcon.var.blue.offset)         |
+               (transp << m2info->fbcon.var.transp.offset);

How about this indention? Would this be better?

I'll wait for your response and wrap up the other changes then and resubmit=
=20
it.


Thanks for your comments!

Peter

