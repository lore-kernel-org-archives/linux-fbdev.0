From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] uvesafb: fix color component length for pseudocolor modes
Date: Tue, 31 Mar 2009 00:02:46 +0200
Message-ID: <20090330220246.GA6894@spock.one.pl>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761793AbZC3WDQ@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>, Ville =?utf-8?B?U3lyasOkbMOk?= <syrjala@sci.fi>, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

uvesafb incorrectly sets the length of the color fields to 6 bits
for PSEUDOCOLOR modes, even though 8 bits are always used per pixel.
=46ix this by setting the length to 8.

The switch of the DAC width from the default 6 bits to 8 bits is
retained and tracked internally in the driver, but never exposed
to userspace.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Ville Syrj=C3=A4l=C3=A4 <syrjala@sci.fi>
Cc: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
---
diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 74ae758..5b59198 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -55,6 +55,7 @@ static u16 maxvf	__devinitdata; /* maximum vertical f=
requency */
 static u16 maxhf	__devinitdata; /* maximum horizontal frequency */
 static u16 vbemode	__devinitdata; /* force use of a specific VBE mode =
*/
 static char *mode_option __devinitdata;
+static u8  dac_width	=3D 6;
=20
 static struct uvesafb_ktask *uvfb_tasks[UVESAFB_TASKS_MAX];
 static DEFINE_MUTEX(uvfb_lock);
@@ -303,22 +304,10 @@ static void uvesafb_setup_var(struct fb_var_scree=
ninfo *var,
 		var->blue.offset   =3D 0;
 		var->transp.offset =3D 0;
=20
-		/*
-		 * We're assuming that we can switch the DAC to 8 bits. If
-		 * this proves to be incorrect, we'll update the fields
-		 * later in set_par().
-		 */
-		if (par->vbe_ib.capabilities & VBE_CAP_CAN_SWITCH_DAC) {
-			var->red.length    =3D 8;
-			var->green.length  =3D 8;
-			var->blue.length   =3D 8;
-			var->transp.length =3D 0;
-		} else {
-			var->red.length    =3D 6;
-			var->green.length  =3D 6;
-			var->blue.length   =3D 6;
-			var->transp.length =3D 0;
-		}
+		var->red.length    =3D 8;
+		var->green.length  =3D 8;
+		var->blue.length   =3D 8;
+		var->transp.length =3D 0;
 	}
 }
=20
@@ -1001,7 +990,7 @@ static int uvesafb_setcolreg(unsigned regno, unsig=
ned red, unsigned green,
 		struct fb_info *info)
 {
 	struct uvesafb_pal_entry entry;
-	int shift =3D 16 - info->var.green.length;
+	int shift =3D 16 - dac_width;
 	int err =3D 0;
=20
 	if (regno >=3D info->cmap.len)
@@ -1050,7 +1039,7 @@ static int uvesafb_setcolreg(unsigned regno, unsi=
gned red, unsigned green,
 static int uvesafb_setcmap(struct fb_cmap *cmap, struct fb_info *info)
 {
 	struct uvesafb_pal_entry *entries;
-	int shift =3D 16 - info->var.green.length;
+	int shift =3D 16 - dac_width;
 	int i, err =3D 0;
=20
 	if (info->var.bits_per_pixel =3D=3D 8) {
@@ -1312,13 +1301,9 @@ setmode:
 		err =3D uvesafb_exec(task);
 		if (err || (task->t.regs.eax & 0xffff) !=3D 0x004f ||
 		    ((task->t.regs.ebx & 0xff00) >> 8) !=3D 8) {
-			/*
-			 * We've failed to set the DAC palette format -
-			 * time to correct var.
-			 */
-			info->var.red.length    =3D 6;
-			info->var.green.length  =3D 6;
-			info->var.blue.length   =3D 6;
+			dac_width =3D 6;
+		} else {
+			dac_width =3D 8;
 		}
 	}
=20
