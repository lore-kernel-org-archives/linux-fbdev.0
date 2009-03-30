From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] fbdev: fix color component field length documentation
Date: Tue, 31 Mar 2009 00:00:07 +0200
Message-ID: <20090330220007.GC6540@spock.one.pl>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761490AbZC3WAa@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>, Ville =?utf-8?B?U3lyasOkbMOk?= <syrjala@sci.fi>, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

The documentation about the meaning of the color component bitfield len=
gths
in pseudocolor modes is inconsistent.  Fix it, so that it indicates the
correct interpretation everywhere, i.e. that the 1 << length is the num=
ber
of palette entries.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Ville Syrj=C3=A4l=C3=A4 <syrjala@sci.fi>
Cc: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
---
This patch will be followed by a number of patches which attempt to
introduce the correct interpretation of the length field in all fbdev
drivers.  A separate patch will be sent for each driver so that
in case I made a mistake in a specific driver, the other ones will
not be affected.

diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
index df53365..3810dae 100644
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -309,8 +309,8 @@ static int xxxfb_setcolreg(unsigned regno, unsigned=
 red, unsigned green,
      *
      * Pseudocolor:
      *    var->{color}.offset is 0
-     *    var->{color}.length contains width of DAC or the number of u=
nique
-     *                        colors available (color depth)
+     *    var->{color}.length is set so that 1 << length is the number=
 of
+     *                        available palette entries
      *    pseudo_palette is not used
      *    RAMDAC[X] is programmed to (red, green, blue)
      *    color depth =3D var->{color}.length
diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index 93fe08d..e4eeb91 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -318,13 +318,14 @@ static int vfb_setcolreg(u_int regno, u_int red, =
u_int green, u_int blue,
 	 *   {hardwarespecific} contains width of RAMDAC
 	 *   cmap[X] is programmed to (X << red.offset) | (X << green.offset)=
 | (X << blue.offset)
 	 *   RAMDAC[X] is programmed to (red, green, blue)
-	 *=20
+	 *
 	 * Pseudocolor:
-	 *    uses offset =3D 0 && length =3D RAMDAC register width.
 	 *    var->{color}.offset is 0
-	 *    var->{color}.length contains widht of DAC
+	 *    var->{color}.length is set so that 1 << length is the number of
+	 *                        available palette entries
 	 *    cmap is not used
 	 *    RAMDAC[X] is programmed to (red, green, blue)
+	 *
 	 * Truecolor:
 	 *    does not use DAC. Usually 3 are present.
 	 *    var->{color}.offset contains start of bitfield
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 31527e1..ab924b1 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -172,8 +172,11 @@ struct fb_fix_screeninfo {
 /* Interpretation of offset for color fields: All offsets are from the=
 right,
  * inside a "pixel" value, which is exactly 'bits_per_pixel' wide (mea=
ns: you
  * can use the offset as right argument to <<). A pixel afterwards is =
a bit
- * stream and is written to video memory as that unmodified. This impl=
ies
- * big-endian byte order if bits_per_pixel is greater than 8.
+ * stream and is written to video memory as that unmodified.
+ *
+ * For pseudocolor, offset is always 0 and length, which should be the=
 same
+ * for all color components, indicates the number of available palette=
 entries
+ * (i.e. # of entries =3D 1 << length).
  */
 struct fb_bitfield {
 	__u32 offset;			/* beginning of bitfield	*/
