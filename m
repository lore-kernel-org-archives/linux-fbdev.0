From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 2/9] ps3: Use symbolic names for
	video modes
Date: Tue, 27 Nov 2007 09:17:17 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0711270915180.10168@pademelon.sonytel.be>
References: <20071126172455.308741000@pademelon.sonytel.be>
	<20071126172712.128301000@pademelon.sonytel.be>
	<20071127110538.32f8dfef.sfr@canb.auug.org.au>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-213149330-1196151437=:10168"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwvdH-0005uj-N9 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Nov 2007 00:17:27 -0800
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwvdF-0006Rv-LK
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Nov 2007 00:17:27 -0800
In-Reply-To: <20071127110538.32f8dfef.sfr@canb.auug.org.au>
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
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-213149330-1196151437=:10168
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Nov 2007, Stephen Rothwell wrote:
> On Mon, 26 Nov 2007 18:24:57 +0100 Geert Uytterhoeven <Geert.Uytterhoev=
en@sonycom.com> wrote:
> > @@ -594,20 +594,21 @@ static const struct {
> >  	unsigned mask : 19;
> >  	unsigned id :  4;
> >  } ps3av_preferred_modes[] =3D {
> > -	{ .mask =3D PS3AV_RESBIT_WUXGA		<< SHIFT_VESA,	.id =3D 13 },
> > -	{ .mask =3D PS3AV_RESBIT_1920x1080P	<< SHIFT_60,	.id =3D 5 },
> > -	{ .mask =3D PS3AV_RESBIT_1920x1080P	<< SHIFT_50,	.id =3D 10 },
> > -	{ .mask =3D PS3AV_RESBIT_1920x1080I	<< SHIFT_60,	.id =3D 4 },
> > -	{ .mask =3D PS3AV_RESBIT_1920x1080I	<< SHIFT_50,	.id =3D 9 },
> > -	{ .mask =3D PS3AV_RESBIT_SXGA		<< SHIFT_VESA,	.id =3D 12 },
> > -	{ .mask =3D PS3AV_RESBIT_WXGA		<< SHIFT_VESA,	.id =3D 11 },
> > -	{ .mask =3D PS3AV_RESBIT_1280x720P	<< SHIFT_60,	.id =3D 3 },
> > -	{ .mask =3D PS3AV_RESBIT_1280x720P	<< SHIFT_50,	.id =3D 8 },
> > -	{ .mask =3D PS3AV_RESBIT_720x480P		<< SHIFT_60,	.id =3D 2 },
> > -	{ .mask =3D PS3AV_RESBIT_720x576P		<< SHIFT_50,	.id =3D 7 },
> > +	{ PS3AV_RESBIT_WUXGA      << SHIFT_VESA, PS3AV_MODE_WUXGA   },
> > +	{ PS3AV_RESBIT_1920x1080P << SHIFT_60,   PS3AV_MODE_1080P60 },
> > +	{ PS3AV_RESBIT_1920x1080P << SHIFT_50,   PS3AV_MODE_1080P50 },
> > +	{ PS3AV_RESBIT_1920x1080I << SHIFT_60,   PS3AV_MODE_1080I60 },
> > +	{ PS3AV_RESBIT_1920x1080I << SHIFT_50,   PS3AV_MODE_1080I50 },
> > +	{ PS3AV_RESBIT_SXGA       << SHIFT_VESA, PS3AV_MODE_SXGA    },
> > +	{ PS3AV_RESBIT_WXGA       << SHIFT_VESA, PS3AV_MODE_WXGA    },
> > +	{ PS3AV_RESBIT_1280x720P  << SHIFT_60,   PS3AV_MODE_720P60  },
> > +	{ PS3AV_RESBIT_1280x720P  << SHIFT_50,   PS3AV_MODE_720P50  },
> > +	{ PS3AV_RESBIT_720x480P   << SHIFT_60,   PS3AV_MODE_480P    },
> > +	{ PS3AV_RESBIT_720x576P   << SHIFT_50,   PS3AV_MODE_576P    },
>=20
> Why did you remove the C99 style initialisers?

Because else things no longer fit on one line.
I prefered a clean structural overview over the protection against the
(almost nonexisting) risk of initializing the wrong member.

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
---584337861-213149330-1196151437=:10168
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
---584337861-213149330-1196151437=:10168
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-213149330-1196151437=:10168--
