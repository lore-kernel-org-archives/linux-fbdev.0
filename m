From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 12/13] fb: Move and rename extern declaration for
	global_mode_option
Date: Tue, 16 Oct 2007 09:18:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0710160917500.5473@pademelon.sonytel.be>
References: <20071012145052.640177000@pademelon.sonytel.be>
	<20071012145130.867069000@pademelon.sonytel.be>
	<20071015144340.167d1cda.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-895355281-1192519114=:5473"
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20071015144340.167d1cda.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, adaplas@gmail.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-895355281-1192519114=:5473
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Oct 2007, Andrew Morton wrote:
> On Fri, 12 Oct 2007 16:51:04 +0200
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
>=20
> > -    if (mode_option || (mode_option =3D global_mode_option)) {
> > +    if (mode_option || (mode_option =3D fb_mode_option)) {
>=20
> I guess that equals-which-looks-like-it-should-be-equals-equals really
> is intended to be an assignment?
>=20
> I guess.  After staring at it for a while.  It's a pretty obnoxious way
> of coding it, especially in kernel context where such things are unexpe=
cted...

Subject: fb modedb: Refactor confusing mode_option assignment

fb modedb: Refactor confusing mode_option assignment

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/modedb.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -510,7 +510,9 @@ int fb_find_mode(struct fb_var_screeninf
 	default_bpp =3D 8;
=20
     /* Did the user specify a video mode? */
-    if (mode_option || (mode_option =3D fb_mode_option)) {
+    if (!mode_option)
+	mode_option =3D fb_mode_option;
+    if (mode_option) {
 	const char *name =3D mode_option;
 	unsigned int namelen =3D strlen(name);
 	int res_specified =3D 0, bpp_specified =3D 0, refresh_specified =3D 0;

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
---584337861-895355281-1192519114=:5473
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
---584337861-895355281-1192519114=:5473--
