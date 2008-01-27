From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 09/11] ps3fb: Round up video modes
Date: Sun, 27 Jan 2008 10:53:24 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801271046590.10193@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
	<20080125153107.478948955@vixen.sonytel.be>
	<20080126220143.16c8f821.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-2012663950-1201427604=:10193"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JJ4Cj-0004g0-SK for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 Jan 2008 01:53:37 -0800
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JJ4Cg-00072g-N9
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 Jan 2008 01:53:33 -0800
In-Reply-To: <20080126220143.16c8f821.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, adaplas@gmail.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-2012663950-1201427604=:10193
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Jan 2008, Andrew Morton wrote:
> > On Fri, 25 Jan 2008 16:06:32 +0100 Geert Uytterhoeven <Geert.Uytterho=
even@sonycom.com> wrote:
> >  static int ps3fb_cmp_mode(const struct fb_videomode *vmode,
> >  			  const struct fb_var_screeninfo *var)
> >  {
> > -	/* resolution + black border must match a native resolution */
> > -	if (vmode->left_margin + vmode->xres + vmode->right_margin !=3D
> > -	    var->left_margin + var->xres + var->right_margin ||
> > -	    vmode->upper_margin + vmode->yres + vmode->lower_margin !=3D
> > -	    var->upper_margin + var->yres + var->lower_margin)
> > +	long xres, yres, left_margin, right_margin, upper_margin, lower_mar=
gin;
> > +	long dx, dy;
>=20
> I don't think these need to be longs?  And they probably don't need to =
be
> signed either.
>=20
> If a switch to u32 improves the code any, it might be worth doing..
>=20
> All the typecasting which this patch adds makes me wonder if the choice
> of types requires a general revisit...

The problems are:
  - Adding up the various fb_var_screeninfo.* timing fields (which are u3=
2) may
    cause overflows. That's why I use `long' (which is 64-bit on ppc64).
    Perhaps I should change it to s64 for readability?
  - If I make xres, yres, left_margin, right_margin, upper_margin, lower_=
margin
    u32, I need more casts for calculating dx and dy. Probably u64 would =
be OK,
    though.
  - dx and dy are signed because they can be smaller than 0.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village =C2=B7 Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=
=B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

Sony Network and Software Technology Center Europe
A division of Sony Service Centre (Europe) N.V.
Registered office: Technologielaan 7 =C2=B7 B-1840 Londerzeel =C2=B7 Belg=
ium
VAT BE 0413.825.160 =C2=B7 RPR Brussels
Fortis Bank Zaventem =C2=B7 Swift GEBABEBB08A =C2=B7 IBAN BE3900138235861=
9
---584349381-2012663950-1201427604=:10193
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
---584349381-2012663950-1201427604=:10193
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584349381-2012663950-1201427604=:10193--
