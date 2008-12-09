From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH] fbdev/logo: Check compatibility of main and extra logos
Date: Tue, 9 Dec 2008 14:15:33 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812091413200.30985@vixen.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753934AbYLINPr@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="utf-8"
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Debian GNU/Linux PPC <debian-powerpc@lists.d>
Cc: Andrew Morton <akpm@linux-foundation.org>


Subject: [PATCH] fbdev/logo: Check compatibility of main and extra logo=
s

The code to draw penguin logos always uses some properties of the main =
logo.
This is incorrect if additional logos (CONFIG_FB_LOGO_EXTRA=3Dy) have d=
ifferent
types than the main logo, which causes corrupted logo images.

http://bugzilla.kernel.org/show_bug.cgi?id=3D12181

Hence skip additional logos that are not compatible with the main logo.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
Technically, it's possible to draw multiple logos of different types on
truecolor displays, but this would complicate the (already quite compli=
cated)
logo drawing code even more.

This patch fixes a problem with Debian's linux-image-2.6.26-1-powerpc64
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D508173

 drivers/video/fbmem.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -510,6 +510,10 @@ static int fb_prepare_extra_logos(struct
 		fb_logo_ex_num =3D 0;
=20
 	for (i =3D 0; i < fb_logo_ex_num; i++) {
+		if (fb_logo_ex[i].logo->type !=3D fb_logo.logo->type) {
+			fb_logo_ex[i].logo =3D NULL;
+			continue;
+		}
 		height +=3D fb_logo_ex[i].logo->height;
 		if (height > yres) {
 			height -=3D fb_logo_ex[i].logo->height;

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village =C2=B7 Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=
=B7 Belgium

Phone:    +32 (0)2 700 8453
=46ax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =C2=B7 RPR Brussels
=46ortis =C2=B7 BIC GEBABEBB =C2=B7 IBAN BE41293037680010
