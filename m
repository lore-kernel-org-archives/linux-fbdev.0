From: Antonino Daplas <adaplas@pol.net>
Subject: Re: 2.5.51 -- rivafb is whacky (characters
	flipped on vertical axis, 640x480 usable area shown inside a higher-res
	area, etc).
Date: 12 Dec 2002 20:00:45 +0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1039705243.1006.1.camel@localhost.localdomain>
References: <3DF6894E.3090802@attbi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-iKTOqthPXgNZZLRXzZip"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18MS7v-0007FE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 Dec 2002 04:07:40 -0800
In-Reply-To: <3DF6894E.3090802@attbi.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Miles Lane <miles.lane@attbi.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-iKTOqthPXgNZZLRXzZip
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-12-11 at 05:39, Miles Lane wrote: 
> Hi,
> 
> I have tried getting rivafb to work in 2.5.51.  It is much better
> than before (thanks!).  It compiles and sorta works.
> 
Can you test the attached patch (rivafb1.diff)?  It fixes some things: 

1. double ioremap/request_mem_region of the framebuffer memory.  Might
cause some initialization weirdness :-) 

2. riva_hw.c is outdated (no support for NV_ARCH_20) which will crash
the GeForce3's (I think I read one report of that in the  kernel mailing
list). 

3.  Matched the initialization ordering of rivafb in linux-2.4, except
that RivaGetConfig is executed at rivafb_open(). 

3. Not sure if the color problem will be fixed.  Miles, are you by
offchance using bpp > 8?  Because setting the DAC at 8 bpp should be a
very simple matter compared with directcolor which requires some
juggling acts 

Also, you mentioned that everything is okay except the characters are
mirrored in the vertical axis, is this correct?  Meaning colors are fine
etc.  If this is the case, try this patch also: 

diff -Naur linux-2.5.51/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- linux-2.5.51/drivers/video/riva/fbdev.c	2002-12-12 13:59:07.000000000 +0000
+++ linux/drivers/video/riva/fbdev.c	2002-12-12 13:59:30.000000000 +0000
@@ -917,9 +917,11 @@
 	size = width * h;
 	dat = cdat;
 
-	for (i = 0; i < size; i++) {
-		*dat = byte_rev[*dat];
-		dat++;
+	if (par->riva.Architecture == NV_ARCH_03) {
+		for (i = 0; i < size; i++) {
+			*dat = byte_rev[*dat];
+			dat++;
+		}
 	}
 
 	switch (info->var.bits_per_pixel) {

Tony

--=-iKTOqthPXgNZZLRXzZip
Content-Disposition: attachment; filename=rivafb1.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=rivafb1.diff; charset=UTF-8

diff -Naur linux-2.5.51/drivers/video/riva/fbdev.c linux/drivers/video/riva=
/fbdev.c
--- linux-2.5.51/drivers/video/riva/fbdev.c	2002-12-12 13:57:09.000000000 +=
0000
+++ linux/drivers/video/riva/fbdev.c	2002-12-12 13:58:05.000000000 +0000
@@ -916,6 +916,7 @@
=20
 	size =3D width * h;
 	dat =3D cdat;
+
 	for (i =3D 0; i < size; i++) {
 		*dat =3D byte_rev[*dat];
 		dat++;
@@ -923,17 +924,11 @@
=20
 	switch (info->var.bits_per_pixel) {
 	case 8:
-		fgx =3D image->fg_color | ~((1 << 8) - 1);
-		bgx =3D image->bg_color | ~((1 << 8) - 1);
+		fgx =3D image->fg_color;
+		bgx =3D image->bg_color;
 	=09
 		break;
 	case 16:
-		/* set alpha bit */
-		if (info->var.green.length =3D=3D 5) {
-			fgx =3D 1 << 15;
-			bgx =3D fgx;
-		}
-        /* Fall through... */
 	case 32:
 		fgx |=3D par->riva_palette[image->fg_color];
 		bgx |=3D par->riva_palette[image->bg_color];
@@ -1169,6 +1164,9 @@
 		save_vga(&par->state);
=20
 		RivaGetConfig(&par->riva);
+		CRTCout(par, 0x11, 0xFF);	/* vgaHWunlock() + riva unlock (0x7F) */
+		par->riva.LockUnlock(&par->riva, 0);
+
 		riva_save_state(par, &par->initial_state);
 	}
 =09
@@ -1554,13 +1552,14 @@
 	info->display_fg =3D NULL;
 	info->pseudo_palette =3D pseudo_palette;
=20
-	cmap_len =3D riva_get_cmap_len(&info->var);
-	fb_alloc_cmap(&info->cmap, cmap_len, 0);
 #ifndef MODULE
 	if (mode_option)
 		fb_find_mode(&info->var, info, mode_option,
 			     NULL, 0, NULL, 8);
 #endif
+	cmap_len =3D riva_get_cmap_len(&info->var);
+	fb_alloc_cmap(&info->cmap, cmap_len, 0);
+
 	return 0;
 }
=20
@@ -1713,13 +1712,6 @@
 		goto err_out_free_base1;
 	}
 =09
-	info->screen_base =3D ioremap(rivafb_fix.smem_start,
-				   rivafb_fix.smem_len);
-	if (!info->screen_base) {
-		printk(KERN_ERR PFX "cannot ioremap FB base\n");
-		goto err_out_iounmap_ctrl;
-	}
-=09
 	default_par->riva.EnableIRQ =3D 0;
 	default_par->riva.PRAMDAC =3D (unsigned *)(default_par->ctrl_base +=20
 						 0x00680000);
@@ -1744,6 +1736,25 @@
=20
 	default_par->riva.IO =3D (MISCin(default_par) & 0x01) ? 0x3D0 : 0x3B0;
=20
+	if (default_par->riva.Architecture =3D=3D NV_ARCH_03) {
+		/*
+		 * We have to map the full BASE_1 aperture for Riva128's
+		 * because they use the PRAMIN set in "framebuffer" space
+		 */
+		if (!request_mem_region(rivafb_fix.smem_start,
+					rivafb_fix.smem_len, "rivafb")) {
+			printk(KERN_ERR PFX "cannot reserve FB region\n");
+			goto err_out_free_base0;
+		}
+=09
+		info->screen_base =3D ioremap(rivafb_fix.smem_start,
+					 rivafb_fix.smem_len);
+		if (!info->screen_base) {
+			printk(KERN_ERR PFX "cannot ioremap FB base\n");
+			goto err_out_iounmap_ctrl;
+		}
+	}
+
 	switch (default_par->riva.Architecture) {
 	case NV_ARCH_03:
 		default_par->riva.PRAMIN =3D (unsigned *)(info->screen_base +=20
@@ -1767,17 +1778,23 @@
=20
 	info->par =3D default_par;
=20
-	if (!request_mem_region(rivafb_fix.smem_start,
-				rivafb_fix.smem_len, "rivafb")) {
-		printk(KERN_ERR PFX "cannot reserve FB region\n");
-		goto err_out_free_base0;
-	}
+	if (default_par->riva.Architecture !=3D NV_ARCH_03) {
+		/*
+		 * Now the _normal_ chipsets can just map the amount of
+		 * real physical ram instead of the whole aperture
+		 */
+		if (!request_mem_region(rivafb_fix.smem_start,
+					rivafb_fix.smem_len, "rivafb")) {
+			printk(KERN_ERR PFX "cannot reserve FB region\n");
+			goto err_out_free_base0;
+		}
 =09
-	info->screen_base =3D ioremap(rivafb_fix.smem_start,
-				 	  rivafb_fix.smem_len);
-	if (!info->screen_base) {
-		printk(KERN_ERR PFX "cannot ioremap FB base\n");
-		goto err_out_iounmap_ctrl;
+		info->screen_base =3D ioremap(rivafb_fix.smem_start,
+					    rivafb_fix.smem_len);
+		if (!info->screen_base) {
+			printk(KERN_ERR PFX "cannot ioremap FB base\n");
+			goto err_out_iounmap_ctrl;
+		}
 	}
=20
 #ifdef CONFIG_MTRR
diff -Naur linux-2.5.51/drivers/video/riva/riva_hw.c linux/drivers/video/ri=
va/riva_hw.c
--- linux-2.5.51/drivers/video/riva/riva_hw.c	2002-12-12 13:57:09.000000000=
 +0000
+++ linux/drivers/video/riva/riva_hw.c	2002-12-12 13:17:40.000000000 +0000
@@ -41,7 +41,7 @@
  * GPL licensing note -- nVidia is allowing a liberal interpretation of
  * the documentation restriction above, to merely say that this nVidia's
  * copyright and disclaimer should be included with all code derived
- * from this source.  -- Jeff Garzik <jgarzik@pobox.com>, 01/Nov/99=20
+ * from this source.  -- Jeff Garzik <jgarzik@mandrakesoft.com>, 01/Nov/99=
=20
  */
=20
 /* $XFree86: xc/programs/Xserver/hw/xfree86/drivers/nv/riva_hw.c,v 1.8 200=
0/02/08 17:19:11 dawes Exp $ */
@@ -1220,6 +1220,7 @@
             state->repaint1 =3D hDisplaySize < 1280 ? 0x04 : 0x00;
             break;
         case NV_ARCH_10:
+	case NV_ARCH_20:
             nv10UpdateArbitrationSettings(VClk,=20
                                           pixelDepth * 8,=20
                                          &(state->arbitration0),
@@ -1285,6 +1286,7 @@
             chip->Tri05 =3D (RivaTexturedTriangle05 *)&(chip->FIFO[0x0000E=
000/4]);
             break;
         case NV_ARCH_10:
+	case NV_ARCH_20:
             /*
              * Initialize state for the RivaTriangle3D05 routines.
              */
@@ -1393,6 +1395,7 @@
             chip->PGRAPH[0x0000067C/4] =3D state->pitch3;
             break;
         case NV_ARCH_10:
+	case NV_ARCH_20:
             LOAD_FIXED_STATE(nv10,PFIFO);
             LOAD_FIXED_STATE(nv10,PRAMIN);
             LOAD_FIXED_STATE(nv10,PGRAPH);
@@ -1421,15 +1424,31 @@
                     chip->Tri03 =3D 0L;
                     break;
             }
-            chip->PGRAPH[0x00000640/4] =3D state->offset0;
-            chip->PGRAPH[0x00000644/4] =3D state->offset1;
-            chip->PGRAPH[0x00000648/4] =3D state->offset2;
-            chip->PGRAPH[0x0000064C/4] =3D state->offset3;
-            chip->PGRAPH[0x00000670/4] =3D state->pitch0;
-            chip->PGRAPH[0x00000674/4] =3D state->pitch1;
-            chip->PGRAPH[0x00000678/4] =3D state->pitch2;
-            chip->PGRAPH[0x0000067C/4] =3D state->pitch3;
-            chip->PGRAPH[0x00000680/4] =3D state->pitch3;
+
+	    if (chip->Architecture =3D=3D NV_ARCH_10) {
+            	chip->PGRAPH[0x00000640/4] =3D state->offset0;
+            	chip->PGRAPH[0x00000644/4] =3D state->offset1;
+            	chip->PGRAPH[0x00000648/4] =3D state->offset2;
+            	chip->PGRAPH[0x0000064C/4] =3D state->offset3;
+            	chip->PGRAPH[0x00000670/4] =3D state->pitch0;
+            	chip->PGRAPH[0x00000674/4] =3D state->pitch1;
+            	chip->PGRAPH[0x00000678/4] =3D state->pitch2;
+            	chip->PGRAPH[0x0000067C/4] =3D state->pitch3;
+            	chip->PGRAPH[0x00000680/4] =3D state->pitch3;
+	    } else {
+		chip->PGRAPH[0x00000820/4] =3D state->offset0;
+		chip->PGRAPH[0x00000824/4] =3D state->offset1;
+		chip->PGRAPH[0x00000828/4] =3D state->offset2;
+		chip->PGRAPH[0x0000082C/4] =3D state->offset3;
+		chip->PGRAPH[0x00000850/4] =3D state->pitch0;
+		chip->PGRAPH[0x00000854/4] =3D state->pitch1;
+		chip->PGRAPH[0x00000858/4] =3D state->pitch2;
+		chip->PGRAPH[0x0000085C/4] =3D state->pitch3;
+		chip->PGRAPH[0x00000860/4] =3D state->pitch3;
+		chip->PGRAPH[0x00000864/4] =3D state->pitch3;
+		chip->PGRAPH[0x000009A4/4] =3D chip->PFB[0x00000200/4];
+		chip->PGRAPH[0x000009A8/4] =3D chip->PFB[0x00000204/4];
+	    }
             chip->PGRAPH[0x00000B00/4] =3D chip->PFB[0x00000240/4];
             chip->PGRAPH[0x00000B04/4] =3D chip->PFB[0x00000244/4];
             chip->PGRAPH[0x00000B08/4] =3D chip->PFB[0x00000248/4];
@@ -1607,6 +1626,7 @@
             state->pitch3   =3D chip->PGRAPH[0x0000067C/4];
             break;
         case NV_ARCH_10:
+	case NV_ARCH_20:
             state->offset0  =3D chip->PGRAPH[0x00000640/4];
             state->offset1  =3D chip->PGRAPH[0x00000644/4];
             state->offset2  =3D chip->PGRAPH[0x00000648/4];
@@ -1970,6 +1990,7 @@
             nv4GetConfig(chip);
             break;
         case NV_ARCH_10:
+	case NV_ARCH_20:
             nv10GetConfig(chip);
             break;
         default:
diff -Naur linux-2.5.51/drivers/video/riva/riva_hw.h linux/drivers/video/ri=
va/riva_hw.h
--- linux-2.5.51/drivers/video/riva/riva_hw.h	2002-12-12 13:57:09.000000000=
 +0000
+++ linux/drivers/video/riva/riva_hw.h	2002-12-12 13:17:42.000000000 +0000
@@ -41,7 +41,7 @@
  * GPL licensing note -- nVidia is allowing a liberal interpretation of
  * the documentation restriction above, to merely say that this nVidia's
  * copyright and disclaimer should be included with all code derived
- * from this source.  -- Jeff Garzik <jgarzik@pobox.com>, 01/Nov/99=20
+ * from this source.  -- Jeff Garzik <jgarzik@mandrakesoft.com>, 01/Nov/99=
=20
  */
=20
 /* $XFree86: xc/programs/Xserver/hw/xfree86/drivers/nv/riva_hw.h,v 1.6 200=
0/02/08 17:19:12 dawes Exp $ */
@@ -75,6 +75,7 @@
 #define NV_ARCH_04  0x04
 #define NV_ARCH_10  0x10
 #define NV_ARCH_20  0x20
+
 /*************************************************************************=
**\
 *                                                                         =
  *
 *                             FIFO registers.                             =
  *
diff -Naur linux-2.5.51/drivers/video/riva/riva_tbl.h linux/drivers/video/r=
iva/riva_tbl.h
--- linux-2.5.51/drivers/video/riva/riva_tbl.h	2002-12-12 13:57:09.00000000=
0 +0000
+++ linux/drivers/video/riva/riva_tbl.h	2002-12-12 13:17:42.000000000 +0000
@@ -41,7 +41,7 @@
  * GPL licensing note -- nVidia is allowing a liberal interpretation of
  * the documentation restriction above, to merely say that this nVidia's
  * copyright and disclaimer should be included with all code derived
- * from this source.  -- Jeff Garzik <jgarzik@pobox.com>, 01/Nov/99=20
+ * from this source.  -- Jeff Garzik <jgarzik@mandrakesoft.com>, 01/Nov/99=
=20
  */
=20
 /* $XFree86: xc/programs/Xserver/hw/xfree86/drivers/nv/riva_tbl.h,v 1.5 20=
00/02/08 17:19:12 dawes Exp $ */

--=-iKTOqthPXgNZZLRXzZip--




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
