From: Antonino Daplas <adaplas@pol.net>
Subject: rivafb color fix?
Date: 26 Nov 2002 09:37:42 +0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1038285168.1359.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-2CX0qrBjHCSFzOS3fTUW"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18GUwr-0004NO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Nov 2002 17:55:38 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Ani Joshi <ajoshi@shell.unixbox.com>


--=-2CX0qrBjHCSFzOS3fTUW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, 

I happened to find my old Riva128 card and tried the rivafb driver. 
Noticed that color (and the logo)is wrong at > 8bpp.

Looking at the code, it exports the visual as FB_VISUAL_DIRECTCOLOR at
16 and 32 bpp, but the DAC was not set up as such.  Also the palette is
set up as Truecolor.

What I found interesting was that accessing the framebuffer directly,
the pixel must be in directcolor (with a properly configured DAC) but
using the accel functions, the pixel value that is passed must be in
truecolor format.  

I'm not sure if this is true for all NV hardware, but I'm attaching a
patch that fixed this problem for the Riva 128 at least.  If no other
archs are affected, I'll fix the patch to be specific for NV_ARCH_03
only. (patch is against 2.4.19)

Tony

PS:

James,

While doing this, I was able to modify the rivafb 2.5 driver and included
hardware supported drawing functions.  I'm planning to port the hardware cursor as well.
You may wish to work with other cards then.

(Ani, only if you don't mind -- since I'm planning to revive an old box using the 
Riva card and rivafb)

--=-2CX0qrBjHCSFzOS3fTUW
Content-Disposition: attachment; filename=riva_colorfix.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=riva_colorfix.diff; charset=UTF-8

diff -Naur linux-2.4.19/drivers/video/riva/fbdev.c linux/drivers/video/riva=
/fbdev.c
--- linux-2.4.19/drivers/video/riva/fbdev.c	2002-11-26 04:07:50.000000000 +=
0000
+++ linux/drivers/video/riva/fbdev.c	2002-11-26 04:13:42.000000000 +0000
@@ -1122,24 +1122,20 @@
=20
 	assert(var !=3D NULL);
=20
-	switch (var->bits_per_pixel) {
-#ifdef FBCON_HAS_CFB8
+	/* assume green component has the most weight */
+	switch (var->green.length) {
+#if defined (FBCON_HAS_CFB8) || defined (FBCON_HAS_CFB32)
 	case 8:
-		rc =3D 256;	/* pseudocolor... 256 entries HW palette */
+		rc =3D 256;	/* pseudocolor or truecolor >=3D 24bpp... 256 entries HW pal=
ette */
 		break;
 #endif
 #ifdef FBCON_HAS_CFB16
-	case 15:
-		rc =3D 15;	/* fix for 15 bpp depths on Riva 128 based cards */
+	case 5:
+	        rc =3D 32;	/* 5-bit - 32 entries spaced 8 indices apart */
 		break;
-	case 16:
-		rc =3D 16;	/* directcolor... 16 entries SW palette */
-		break;		/* Mystique: truecolor, 16 entries SW palette, HW palette hardwi=
red into 1:1 mapping */
-#endif
-#ifdef FBCON_HAS_CFB32
-	case 32:
-		rc =3D 16;	/* directcolor... 16 entries SW palette */
-		break;		/* Mystique: truecolor, 16 entries SW palette, HW palette hardwi=
red into 1:1 mapping */
+	case 6:
+		rc =3D 64;	/* 6-bit - 64 entries spaced 4 indices apart */
+		break;	=09
 #endif
 	default:
 		/* should not occur */
@@ -1222,6 +1218,7 @@
 	struct rivafb_info *rivainfo =3D (struct rivafb_info *)info;
 	RIVA_HW_INST *chip =3D &rivainfo->riva;
 	struct display *p;
+	int i;
=20
 	DPRINTK("ENTER\n");
=20
@@ -1233,6 +1230,15 @@
 	if (regno >=3D riva_get_cmap_len(&p->var))
 		return -EINVAL;
=20
+	if (!regno) {
+		/* Reset palette */
+		for (i =3D 0; i < 256; i++) {
+			rivainfo->palette[regno].red =3D 0;
+			rivainfo->palette[regno].green =3D 0;
+			rivainfo->palette[regno].blue =3D 0;
+		}
+	}
+
 	rivainfo->palette[regno].red =3D red;
 	rivainfo->palette[regno].green =3D green;
 	rivainfo->palette[regno].blue =3D blue;
@@ -1243,40 +1249,56 @@
 		    (red * 77 + green * 151 + blue * 28) >> 8;
 	}
=20
-	switch (p->var.bits_per_pixel) {
-#ifdef FBCON_HAS_CFB8
-	case 8:
+	if (p->var.green.length =3D=3D 5) {
+		for (i =3D 0; i < 8; i++) {
+			riva_wclut(chip, (regno*8)+i, (u8) red, (u8) green, (u8) blue);
+		}
+	}
+	else if (p->var.green.length =3D=3D 6) {
+		if (regno < 32) {
+			for (i =3D 0; i < 8; i++) {
+				riva_wclut(chip, (regno*8)+i, (u8) red,=20
+					   rivainfo->palette[regno*2].green,
+					   (u8) blue);
+			}
+		}
+		for (i =3D 0; i < 4; i++) {
+			riva_wclut(chip, (regno*4)+i, rivainfo->palette[regno/2].red,
+				   (u8) green, rivainfo->palette[regno/2].blue);
+		}
+	}
+	else {
 		/* "transparent" stuff is completely ignored. */
 		riva_wclut(chip, regno, red >> 8, green >> 8, blue >> 8);
-		break;
-#endif /* FBCON_HAS_CFB8 */
+	}		  =20
+	if (regno < 16) {
+		switch (p->var.bits_per_pixel) {
 #ifdef FBCON_HAS_CFB16
-	case 16:
-		assert(regno < 16);
-		if (p->var.green.length =3D=3D 5) {
-			/* 0rrrrrgg gggbbbbb */
-			rivainfo->con_cmap.cfb16[regno] =3D
-			    ((red & 0xf800) >> 1) |
-			    ((green & 0xf800) >> 6) | ((blue & 0xf800) >> 11);
-		} else {
-			/* rrrrrggg gggbbbbb */
-			rivainfo->con_cmap.cfb16[regno] =3D
-			    ((red & 0xf800) >> 0) |
-			    ((green & 0xf800) >> 5) | ((blue & 0xf800) >> 11);
-		}
-		break;
+		case 16:
+			if (p->var.green.length =3D=3D 5) {
+				/* 0rrrrrgg gggbbbbb */
+				rivainfo->con_cmap.cfb16[regno] =3D
+					((red & 0xf800) >> 1) |
+					((green & 0xf800) >> 6) | ((blue & 0xf800) >> 11);
+			} else {
+				/* rrrrrggg gggbbbbb */
+				rivainfo->con_cmap.cfb16[regno] =3D
+					((red & 0xf800) >> 0) |
+					((green & 0xf800) >> 5) | ((blue & 0xf800) >> 11);
+			}
+			break;
 #endif /* FBCON_HAS_CFB16 */
 #ifdef FBCON_HAS_CFB32
-	case 32:
-		assert(regno < 16);
-		rivainfo->con_cmap.cfb32[regno] =3D
-		    ((red & 0xff00) << 8) |
-		    ((green & 0xff00)) | ((blue & 0xff00) >> 8);
-		break;
+		case 32:
+			rivainfo->con_cmap.cfb32[regno] =3D
+				((red & 0xff00) << 8) |
+				((green & 0xff00)) | ((blue & 0xff00) >> 8);
+			break;
 #endif /* FBCON_HAS_CFB32 */
-	default:
-		/* do nothing */
-		break;
+		default:
+			/* do nothing */
+			break;
+		}
 	}
=20
 	return 0;
@@ -1403,6 +1425,13 @@
=20
 	memcpy(&v, var, sizeof(v));
=20
+	/*
+	 * Riva 128 supports RGB555 only=20
+	 */
+	if (rivainfo->riva.Architecture =3D=3D NV_ARCH_03 &&
+	    v.bits_per_pixel =3D=3D 16)
+		v.bits_per_pixel =3D 15;
+
 	accel =3D v.accel_flags & FB_ACCELF_TEXT;
=20
 	switch (v.bits_per_pixel) {

--=-2CX0qrBjHCSFzOS3fTUW--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
