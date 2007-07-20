From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: Text console scrolling
Date: Fri, 20 Jul 2007 14:21:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0707201415440.13339@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0707181708020.15632@pademelon.sonytel.be>
	<1184774936.4523.64.camel@daplas>
	<20070719202045.89106250.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-285126806-1184934104=:13339"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBrUu-0005cK-NM for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 20 Jul 2007 05:22:21 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IBrUr-0008CM-OQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 20 Jul 2007 05:22:16 -0700
In-Reply-To: <20070719202045.89106250.krzysztof.h1@wp.pl>
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
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-285126806-1184934104=:13339
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Jul 2007, Krzysztof Helt wrote:
> On Thu, 19 Jul 2007 00:08:56 +0800
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> > On Wed, 2007-07-18 at 17:10 +0200, Geert Uytterhoeven wrote:
> > > Yesterday, FBINFO_READS_FAST was faster in some cases, but much slo=
wer in
> > > others, so I didn't really know whether I should enable it or not.
> > >=20
> > > Today, FBINFO_READS_FAST is faster in all test cases, so the choice=
 is clear.
> > The improvement of scroll_move is courtesy of Ondrej's smart blitter
> > patch.
> [...]
> > =20
> > > Note that there are still a few cases where today's fastest option =
is a bit
> > > slower than yesterday's fastest option.
> > >=20
> >=20
> > All things equal, the speed of the smart blitter will depend on:
> >=20
> > The less different the contents, the more the smart blitter will spee=
d
> > up (because less characters are actually moved). If the contents are
> > totally different, then the blitter spends as much time as the old
> > (dumb) blitter plus the time spent on the compare.=20
> >=20
>=20
> My guess is that comparing is relatively fast comparing to preparation =
of the blit operation. =20
> One of the very first versions of the patch had a variant to merge smal=
l blits into bigger ones.
> It was done by regarding the first character after difference (string o=
f different character) as different too.
> An advantage was fewer blitter operations but the operations got bigger=
 at least by one character.
>=20
> You may look here (see MERGE_BLITS define):
>=20
> http://marc.info/?l=3Dlinux-fbdev-devel&m=3D117869435713671&w=3D2
>=20
> Some tests result on cards with real blitter:
>=20
> http://marc.info/?l=3Dlinux-fbdev-devel&m=3D117881573823606&w=3D2
>=20
> As you see, merging blits gave speed up on some cards (comparing to cur=
rent method) despite it had more to compare.
> But it was usually lost at higher bpp as amount of data to move grown f=
aster.
>=20
> I am interested in results of scrolling speeds with merged blits on you=
r hardware.

I manually applied your MERGE_BLITS changes (patch below) and reran my
benchmark:

                          -ga5fcaa21    -gcb32da04    -g9a79b227
mode   rot     font      DFLT   READS  DFLT   READS  READS  +MERGE
                                FAST          FAST   FAST    BLITS
480p    0   default8x16   7.32   6.63   7.49   5.18   3.69   5.24
480p    1   default8x16  11.39   5.79  11.6    7.60  10.18   8.09
480p    2   default8x16   7.35   4.34   7.5    3.90   5.40   3.67
480p    3   default8x16  11.39   8.85  11.61   9.31   6.80   9.92
720p    0   default8x16  13.04  15.91  13.33   9.28   6.62   9.35
720p    1   default8x16  22.76  12.73  23.17  18.35  23.51  19.83
720p    2   default8x16  13.10  10.22  13.34   7.30  10.04   6.84
720p    3   default8x16  22.60  19.65  23.03  19.56  14.48  21.11
1080p   0   default8x16  20.76  34.25  21.09  14.98  10.78  15.01
1080p   1   default8x16  35.13  23.82  35.78  26.27  34.15  28.11
1080p   2   default8x16  20.69  21.51  21.12  11.57  15.79  10.73
1080p   3   default8x16  34.98  37.03  35.68  29.23  21.47  31.43
WUXGA   0   default8x16  24.92  46.83  25.52  18.05  12.98  18.05
WUXGA   1   default8x16  41.19  31.08  41.98  28.61  37.90  30.99
WUXGA   2   default8x16  25.00  29.11  25.56  13.74  18.81  12.64
WUXGA   3   default8x16  41.20  49.49  42.02  34.79  25.66  37.84
480p    0   lat4-19       7.20   6.57   7.35   5.12   3.63   5.18
480p    1   lat4-19      11.19   6.02  11.36   7.86   9.97   8.31
480p    2   lat4-19       7.21   4.32   7.36   3.83   5.31   3.62
480p    3   lat4-19      11.12   8.90  11.33   9.08   7.01   9.63
720p    0   lat4-19      12.69  15.57  12.94   9.09   6.52   9.13
720p    1   lat4-19      22.43  12.92  22.86  17.46  21.68  18.89
720p    2   lat4-19      12.71  10.04  13.08   7.19   9.83   6.70
720p    3   lat4-19      22.50  20.02  22.89  20.21  15.92  21.84
1080p   0   lat4-19      20.31  33.99  20.75  14.87  10.76  14.88
1080p   1   lat4-19      34.60  24.06  35.26  25.19  31.67  27.02
1080p   2   lat4-19      20.39  21.37  20.79  11.51  15.67  10.62
1080p   3   lat4-19      34.50  37.45  35.24  29.13  22.61  31.30
WUXGA   0   lat4-19      24.72  46.92  25.26  18.06  13.03  18.01
WUXGA   1   lat4-19      40.98  32.32  41.77  30.52  38.22  33.30
WUXGA   2   lat4-19      24.80  29.13  25.28  13.73  18.78  12.59
WUXGA   3   lat4-19      41.25  50.26  42.25  35.50  27.82  38.63
                                                           =20
           RMS           24.50  26.47  24.99  18.60  18.87  19.74

(RMS =3D Root Mean Squares)

Two findings:
  - MERGE_BLITS is faster for rotations 1 and 2, but slower for rotations
    0 and 3.
  - Todays' kernel behaves different than the one from two days ago, even
    without changes to the console code.

Note that all scrolling is done by the CPU.

--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1,3 +1,4 @@
+#define MERGE_BLITS
 /*
  *  linux/drivers/video/fbcon.c -- Low level frame buffer based console =
driver
  *
@@ -1724,19 +1725,35 @@ static void fbcon_redraw_blit(struct vc_
 		unsigned short *le =3D advance_row(s, 1);
 		unsigned short c;
 		int x =3D 0;
+#ifdef MERGE_BLITS
+		int was_blit =3D 1;
+#endif
=20
 		do {
 			c =3D scr_readw(s);
=20
 			if (c =3D=3D scr_readw(d)) {
 				if (s > start) {
+#ifdef MERGE_BLITS
+				    if (!was_blit) {
+#endif
 					ops->bmove(vc, info, line + ycount, x,
 						   line, x, 1, s-start);
 					x +=3D s - start + 1;
 					start =3D s + 1;
+#ifdef MERGE_BLITS
+				    }
+				    was_blit =3D !was_blit;
+#endif
 				} else {
+#ifdef MERGE_BLITS
+				    if (was_blit) {
+#endif
 					x++;
 					start++;
+#ifdef MERGE_BLITS
+				    }
+#endif
 				}
 			}
=20

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
---584337861-285126806-1184934104=:13339
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
---584337861-285126806-1184934104=:13339
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-285126806-1184934104=:13339--
