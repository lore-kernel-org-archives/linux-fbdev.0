From: Ondrej Zary <linux@rainbow-software.org>
Date: Tue, 29 Mar 2011 19:07:08 +0000
Subject: [PATCH] s3fb: fix Virge/GX2
Message-Id: <201103292107.11969.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>

Fix Virge/GX2 support in s3fb:
- fix IDs: 86C357 is GX2, 86C359 is GX2+, 86C356 probably does not exist
- add memory size detection
- drive it the same way as Trio3D/2X

The original IDs most likely came from S3 website which claims that:
- 356 is Virge/GX2 with ID=8A10, driver included in Windows 2K, XP
- 357 is Virge/GX2+ with ID=8A11, driver included in Windows ME
- 359 is Virge/GX2+ with ID=8A12, driver included in Windows ME
but:
- google search for 86C356 only reveals references to Trio3D (probably
because of a typo - Trio3D is 86C365)
- my card is clearly marked as 86C357, Virge/GX2 and has ID=8A10
- there is no driver for IDs 8A11 and 8A12 in Windows ME
- there is a driver for ID 8A10 in Windows ME that says it's GX2 (357)

Tested with #9 Reality 334 (86C357 Virge/GX2, ID=3D0x8A10).

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.38-rc4-/drivers/video/s3fb.c	2011-03-29 17:17:48.000000000 +0=
200
+++ linux-2.6.38-rc4/drivers/video/s3fb.c	2011-03-29 20:25:12.000000000 +02=
00
@@ -71,9 +71,9 @@ static const int s3_memsizes[] =3D {4096,
=20
 static const char * const s3_names[] =3D {"S3 Unknown", "S3 Trio32", "S3 T=
rio64", "S3 Trio64V+",
 			"S3 Trio64UV+", "S3 Trio64V2/DX", "S3 Trio64V2/GX",
-			"S3 Plato/PX", "S3 Aurora64VP", "S3 Virge",
+			"S3 Plato/PX", "S3 Aurora64V+", "S3 Virge",
 			"S3 Virge/VX", "S3 Virge/DX", "S3 Virge/GX",
-			"S3 Virge/GX2", "S3 Virge/GX2P", "S3 Virge/GX2P",
+			"S3 Virge/GX2", "S3 Virge/GX2+", "",
 			"S3 Trio3D/1X", "S3 Trio3D/2X", "S3 Trio3D/2X",
 			"S3 Trio3D"};
=20
@@ -90,9 +90,8 @@ static const char * const s3_names[] =3D {
 #define CHIP_988_VIRGE_VX	0x0A
 #define CHIP_375_VIRGE_DX	0x0B
 #define CHIP_385_VIRGE_GX	0x0C
-#define CHIP_356_VIRGE_GX2	0x0D
-#define CHIP_357_VIRGE_GX2P	0x0E
-#define CHIP_359_VIRGE_GX2P	0x0F
+#define CHIP_357_VIRGE_GX2	0x0D
+#define CHIP_359_VIRGE_GX2P	0x0E
 #define CHIP_360_TRIO3D_1X	0x10
 #define CHIP_362_TRIO3D_2X	0x11
 #define CHIP_368_TRIO3D_2X	0x12
@@ -359,7 +358,9 @@ static void s3_set_pixclock(struct fb_in
 	vga_w(par->state.vgabase, VGA_MIS_W, regval | VGA_MIS_ENB_PLL_LOAD);
=20
 	/* Set S3 clock registers */
-	if (par->chip =3D CHIP_360_TRIO3D_1X ||
+	if (par->chip =3D CHIP_357_VIRGE_GX2 ||
+	    par->chip =3D CHIP_359_VIRGE_GX2P ||
+	    par->chip =3D CHIP_360_TRIO3D_1X ||
 	    par->chip =3D CHIP_362_TRIO3D_2X ||
 	    par->chip =3D CHIP_368_TRIO3D_2X) {
 		vga_wseq(par->state.vgabase, 0x12, (n - 2) | ((r & 3) << 6));	/* n and t=
wo bits of r */
@@ -560,7 +561,9 @@ static int s3fb_set_par(struct fb_info *
 	pr_debug("fb%d: offset register       : %d\n", info->node, offset_value);
 	svga_wcrt_multi(par->state.vgabase, s3_offset_regs, offset_value);
=20
-	if (par->chip !=3D CHIP_360_TRIO3D_1X &&
+	if (par->chip !=3D CHIP_357_VIRGE_GX2 &&
+	    par->chip !=3D CHIP_359_VIRGE_GX2P &&
+	    par->chip !=3D CHIP_360_TRIO3D_1X &&
 	    par->chip !=3D CHIP_362_TRIO3D_2X &&
 	    par->chip !=3D CHIP_368_TRIO3D_2X) {
 		vga_wcrt(par->state.vgabase, 0x54, 0x18); /* M parameter */
@@ -604,7 +607,9 @@ static int s3fb_set_par(struct fb_info *
 		vga_wcrt(par->state.vgabase, 0x66, 0x90);
 	}
=20
-	if (par->chip =3D CHIP_360_TRIO3D_1X ||
+	if (par->chip =3D CHIP_357_VIRGE_GX2 ||
+	    par->chip =3D CHIP_359_VIRGE_GX2P ||
+	    par->chip =3D CHIP_360_TRIO3D_1X ||
 	    par->chip =3D CHIP_362_TRIO3D_2X ||
 	    par->chip =3D CHIP_368_TRIO3D_2X ||
 	    par->chip =3D CHIP_365_TRIO3D    ||
@@ -617,8 +622,7 @@ static int s3fb_set_par(struct fb_info *
 		vga_wcrt(par->state.vgabase, 0x66, 0x81);
 	}
=20
-	if (par->chip =3D CHIP_356_VIRGE_GX2  ||
-	    par->chip =3D CHIP_357_VIRGE_GX2P ||
+	if (par->chip =3D CHIP_357_VIRGE_GX2  ||
 	    par->chip =3D CHIP_359_VIRGE_GX2P ||
 	    par->chip =3D CHIP_360_TRIO3D_1X ||
 	    par->chip =3D CHIP_362_TRIO3D_2X ||
@@ -674,6 +678,8 @@ static int s3fb_set_par(struct fb_info *
 		pr_debug("fb%d: 8 bit pseudocolor\n", info->node);
 		svga_wcrt_mask(par->state.vgabase, 0x50, 0x00, 0x30);
 		if (info->var.pixclock > 20000 ||
+		    par->chip =3D CHIP_357_VIRGE_GX2 ||
+		    par->chip =3D CHIP_359_VIRGE_GX2P ||
 		    par->chip =3D CHIP_360_TRIO3D_1X ||
 		    par->chip =3D CHIP_362_TRIO3D_2X ||
 		    par->chip =3D CHIP_368_TRIO3D_2X)
@@ -702,7 +708,9 @@ static int s3fb_set_par(struct fb_info *
 		} else {
 			svga_wcrt_mask(par->state.vgabase, 0x50, 0x10, 0x30);
 			svga_wcrt_mask(par->state.vgabase, 0x67, 0x30, 0xF0);
-			if (par->chip !=3D CHIP_360_TRIO3D_1X &&
+			if (par->chip !=3D CHIP_357_VIRGE_GX2 &&
+			    par->chip !=3D CHIP_359_VIRGE_GX2P &&
+			    par->chip !=3D CHIP_360_TRIO3D_1X &&
 			    par->chip !=3D CHIP_362_TRIO3D_2X &&
 			    par->chip !=3D CHIP_368_TRIO3D_2X)
 				hmul =3D 2;
@@ -727,7 +735,9 @@ static int s3fb_set_par(struct fb_info *
 		} else {
 			svga_wcrt_mask(par->state.vgabase, 0x50, 0x10, 0x30);
 			svga_wcrt_mask(par->state.vgabase, 0x67, 0x50, 0xF0);
-			if (par->chip !=3D CHIP_360_TRIO3D_1X &&
+			if (par->chip !=3D CHIP_357_VIRGE_GX2 &&
+			    par->chip !=3D CHIP_359_VIRGE_GX2P &&
+			    par->chip !=3D CHIP_360_TRIO3D_1X &&
 			    par->chip !=3D CHIP_362_TRIO3D_2X &&
 			    par->chip !=3D CHIP_368_TRIO3D_2X)
 				hmul =3D 2;
@@ -1069,6 +1079,16 @@ static int __devinit s3_pci_probe(struct
 			info->screen_size =3D 2 << 20;
 			break;
 		}
+	} else if (par->chip =3D CHIP_357_VIRGE_GX2 ||
+		   par->chip =3D CHIP_359_VIRGE_GX2P) {
+		switch ((regval & 0xC0) >> 6) {
+		case 1: /* 4MB */
+			info->screen_size =3D 4 << 20;
+			break;
+		case 3: /* 2MB */
+			info->screen_size =3D 2 << 20;
+			break;
+		}
 	} else
 		info->screen_size =3D s3_memsizes[regval >> 5] << 10;
 	info->fix.smem_len =3D info->screen_size;
@@ -1275,8 +1295,8 @@ static struct pci_device_id s3_devices[]
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x5631), .driver_data =3D CHIP_325_VIRGE},
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x883D), .driver_data =3D CHIP_988_VIRGE_VX=
},
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8A01), .driver_data =3D CHIP_XXX_VIRGE_DX=
GX},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8A10), .driver_data =3D CHIP_356_VIRGE_GX=
2},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8A11), .driver_data =3D CHIP_357_VIRGE_GX=
2P},
+	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8A10), .driver_data =3D CHIP_357_VIRGE_GX=
2},
+	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8A11), .driver_data =3D CHIP_359_VIRGE_GX=
2P},
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8A12), .driver_data =3D CHIP_359_VIRGE_GX=
2P},
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8A13), .driver_data =3D CHIP_36X_TRIO3D_1=
X_2X},
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8904), .driver_data =3D CHIP_365_TRIO3D},

--=20
Ondrej Zary
