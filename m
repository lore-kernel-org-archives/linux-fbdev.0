From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: scroll modes
Date: Fri, 02 Dec 2005 11:55:15 +0100
Message-ID: <43902813.2010604@t-online.de>
References: <438D9E60.7040007@t-online.de> <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be> <438DE211.2060900@t-online.de> <438E0E23.2000203@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ei9UM-0000Uw-Cg
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Dec 2005 03:54:06 -0800
Received: from mailout05.sul.t-online.com ([194.25.134.82])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ei9UK-00051n-Qp
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Dec 2005 03:54:06 -0800
In-Reply-To: <438E0E23.2000203@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Tony

first of all, in updatescrollmode we introduce a the local fh, but latero=
n
vc->vc_font.height is often read again. Fixing that would be a cosmetic=20
change, as
the compiler should optimize that anyway.

>diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon=
.c
>index 1a8f0ea..5ebe68f 100644
>--- a/drivers/video/console/fbcon.c
>+++ b/drivers/video/console/fbcon.c
>@@ -1972,12 +1972,6 @@ static __inline__ void updatescrollmode(
> 	int fast_imageblit =3D (cap & FBINFO_HWACCEL_IMAGEBLIT) &&
> 		!(cap & FBINFO_HWACCEL_DISABLED);
>=20
>-	p->vrows =3D vyres/fh;
>-	if (yres > (fh * (vc->vc_rows + 1)))
>-		p->vrows -=3D (yres - (fh * vc->vc_rows)) / fh;
>-	if ((yres % fh) && (vyres % fh < yres % fh))
>-		p->vrows--;
>-
> 	if (good_wrap || good_pan) {
> 		if (reading_fast || fast_copyarea)
> 			p->scrollmode =3D good_wrap ?
>@@ -1991,6 +1985,16 @@ static __inline__ void updatescrollmode(
> 		else
> 			p->scrollmode =3D SCROLL_REDRAW;
> 	}
>+
>+	p->vrows =3D vyres/fh;
> =20
>
ok, does not change anything.

>+
>+	if (p->scrollmode !=3D SCROLL_WRAP_MOVE &&
>+	    (yres > (fh * (vc->vc_rows + 1))))
>+		    p->vrows -=3D (yres - (fh * vc->vc_rows)) / fh;
>+
> =20
>
1024x768, vyres 2048, seems to  work with and without that extra
"p->scrollmode !=3D SCROLL_WRAP_MOVE", but could you please
explain when  "yres > (fh * (vc->vc_rows + 1))" will be true?

>+	if ((yres % fh) && (vyres % fh < yres % fh))
>+		p->vrows--;
> =20
>
ok, does not change anything.

Further comments to updatescrollmode:

      int good_wrap =3D (cap & FBINFO_HWACCEL_YWRAP) &&
              divides(ywrap, vc->vc_font.height) &&
              divides(vc->vc_font.height, vyres);

is broken as it does not check that vyres * vxres =3D=3D whole available =
video
memory. Or is there hardware that has an adjustable wrap address? Hmm, I
even can think of a way to reprogram the cyberblade/i1 to wrap at the 1, =
2,
4 or 8MB boundaries while the system is running.

Even if that additional check would be introduced it would have problems
- with drivers like vesafb that do not map all available memory
- with drivers that do not know about all available memory
- with drivers that allow users to specify arbitraty values for the=20
video memory size.

I don=B4t like the whole concept of updatescrollmode based on the evaluat=
ion
of various flags, asumptions and values.

Scrolling with YWRAP_MOVE is faster than scrolling with YPAN_MOVE,
often much faster. Execution time of  a "cat testfile" drops for mode=20
1024x768-32
from 1.225s to 0.835s with cyblafb.

But I don=B4t like that the bottom status line of my curses based editor=20
jumps while
scrolling up/down. So I have several options:

  - Don=B4t use ywrap scrolling
  - Ignore the anoying flicker of the base line
  - change the working YWRAP_MOVE
  - submit an alternative YWRAP_SOMETHING

But how should that YWRAP_SOMETHING be selected by updatescrollmode?
The individual driver does know best about the hardware about user=20
preferences
and of the supported scroll modes in any situation.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
Wouldn=B4t it be easier and cleaner to introduce a new optional fb_ops=20
function
fb_scrollmode(...) that would, if implemented in the driver, replace and=20
extend
the functionality  implemented in updatescrollmode?!
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

cu,
 Knut



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
