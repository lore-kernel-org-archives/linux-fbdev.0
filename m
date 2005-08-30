From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
Date: Tue, 30 Aug 2005 21:13:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0508302039160.3743@scrub.home>
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be>
 <43149E5B.7040006@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-1053673453-1125429223=:3743"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EABYp-00083R-VL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Aug 2005 12:14:19 -0700
Received: from scrub.xs4all.nl ([194.109.195.176] ident=mail)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EABYp-0000Xd-Bd
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Aug 2005 12:14:19 -0700
In-Reply-To: <43149E5B.7040006@t-online.de>
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
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Jochen Hein <jochen@jochen.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-1053673453-1125429223=:3743
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 30 Aug 2005, Knut Petersen wrote:

> > Probably you can make it even faster by avoiding the multiplication, li=
ke
> >=20
> >    unsigned int offset =3D 0;
> >    for (i =3D 0; i < image.height; i++) {
> > =09dst[offset] =3D src[i];
> > =09offset +=3D pitch;
> >    }
> >=20
>=20
> More than two decades ago I learned to avoid mul and imul. Use shifts, ad=
d and
> lea instead,
> that was the credo those days. The name of the game was CP/M 80/86, a86, =
d86
> and ddt ;-)
>=20
> But let=B4s get serious again.
>=20
> Your proposed change of the patch results in a 21 ms performance decrease=
 on
> my system.
> Yes, I do know that this is hard to believe. I tested a similar variation
> before, and the results
> were even worse.

Could you try the patch below, for a few extra cycles you might want to=20
make it an inline function.

bye, Roman

Index: linux-2.6/drivers/video/fbmem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/video/fbmem.c=092005-08-30 01:55:18.000000000 +0=
200
+++ linux-2.6/drivers/video/fbmem.c=092005-08-30 21:10:25.705462837 +0200
@@ -82,11 +82,11 @@ void fb_pad_aligned_buffer(u8 *dst, u32=20
 {
 =09int i, j;
=20
+=09d_pitch -=3D s_pitch;
 =09for (i =3D height; i--; ) {
 =09=09/* s_pitch is a few bytes at the most, memcpy is suboptimal */
 =09=09for (j =3D 0; j < s_pitch; j++)
-=09=09=09dst[j] =3D src[j];
-=09=09src +=3D s_pitch;
+=09=09=09*dst++ =3D *src++;
 =09=09dst +=3D d_pitch;
 =09}
 }
---1463811837-1053673453-1125429223=:3743--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
