From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: YUV Framebuffer
Date: Thu, 18 Oct 2007 15:41:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0710181537490.20173@pademelon.sonytel.be>
References: <27AAC353AE72C840926448157F375E72012B59B1@NAEX17.na.qualcomm.com>
	<Pine.LNX.4.64.0710170852350.29643@anakin>
	<27AAC353AE72C840926448157F375E72012B5A8F@NAEX17.na.qualcomm.com>
	<Pine.LNX.4.64.0710172141180.16690@anakin>
	<1192713610.8484.53.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-576117726-1192714913=:20173"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IiVdW-0005j7-MW for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 06:42:06 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IiVdU-0000iv-QJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 06:42:06 -0700
In-Reply-To: <1192713610.8484.53.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: "Rhee, C. Joon" <jrhee@qualcomm.com>, linux-fbdev-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-576117726-1192714913=:20173
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Oct 2007, Antonino A. Daplas wrote:
> On Wed, 2007-10-17 at 21:45 +0200, Geert Uytterhoeven wrote:
> > On Wed, 17 Oct 2007, Rhee, C. Joon wrote:
> > > Interleaved means YCBCR is on the same plane in this order.
> > > Y CB Y CR Y CB Y CR.... (TV-Out)
> >=20
> > So it's still FB_TYPE_PACKED_PIXELS.
> >=20
> > > The problem of matching Y=3DG, CB=3DB and CR=3DR for RGB offset is =
that the
> > > pixel cannot be represented directly since CB/CR gets shared betwee=
n Ys.
> > >=20
> > > So, bitsperpixel would be 16 bit and both B and R offset will be 8.
> >=20
> > Doesn't sound that bad to me, if you introduce a FB_VISUAL_YCBYCR
> > visual. Even pixels have a Cb, odd have a Cr component.
>=20
> We need at least 3 fields to describe YUV.
>=20
> 1. The component size - fb_bitfield.length
> 2. The sample period - fb_bitfield.offset
> 3. The component ordering - fb_bitfield.msb_right

This completely changes the meaning of the latter 2 fields...

> So if Y =3D red, U =3D green, V =3D blue
>=20
> YUV422
>=20
> red|green|blue.length =3D 8 /* 8 bits per component */
> red.offset =3D 1 /* sampled every pixel */
> green.offset =3D blue.offset =3D 2 /* sampled every 2 pixels */
> red.msb_right =3D 1, green.msb_right =3D 2, blue.msb_right =3D 3
> (Y U V order)
>=20
> UVY411
>=20
> red|green|blue.length =3D 8;
> red.offset =3D 1;
> green.offset =3D blue.offset =3D 4;
> red.msb_right =3D 3, green.msb_right =3D 2, blue.msb_right =3D 1;

And you would use bits_per_pixel =3D 8, as you no longer have access to t=
he
fb_bitfield.offsets (in the sense of `offsets within a pixel')?

How would you express YUV420?

Alternatively:
  - YUV422 really is 16 bits per pixel.
  - YUV411 and YUV420 really are 12 bits per pixel.
But I don't think this makes things easier, especially not for the 12 bpp
variants.

> The FB_VISUAL_* will differentiate if the bitfields are interpreted as
> RGB or YUV.
>=20
> That's the only way I can think of describing YUV packed pixel formats
> without adding new fields, or modifying our user-visible structures.
>=20
> We will need separate drawing functions for fbcon's use.

Of course.

> Of course, the simplest way is to use fourcc naming for our FB_VISUAL_*
> constants. But that will become too unwieldy over time.

With kind regards,
=20
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village =C2=B7 Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=
=B7 Belgium
=20
Phone:    +32 (0)2 700 8453=09
Fax:      +32 (0)2 700 8622=09
E-mail:   Geert.Uytterhoeven@sonycom.com=09
Internet: http://www.sony-europe.com/
 =09
Sony Network and Software Technology Center Europe=09
A division of Sony Service Centre (Europe) N.V.=09
Registered office: Technologielaan 7 =C2=B7 B-1840 Londerzeel =C2=B7 Belg=
ium=09
VAT BE 0413.825.160 =C2=B7 RPR Brussels=09
Fortis Bank Zaventem =C2=B7 Swift GEBABEBB08A =C2=B7 IBAN BE3900138235861=
9
---584337861-576117726-1192714913=:20173
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
---584337861-576117726-1192714913=:20173
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-576117726-1192714913=:20173--
