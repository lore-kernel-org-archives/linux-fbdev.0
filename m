From: Stuffed Crust <pizza@shaftnet.org>
Subject: [patch] [radeonfb] Radeon Mobility X700 (M26) and ATOM bios support
Date: Tue, 3 Jan 2006 15:44:04 -0500
Message-ID: <20060103204404.GA23313@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ett5U-0003T1-3G
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Jan 2006 12:48:56 -0800
Received: from rrcs-24-73-230-86.se.biz.rr.com
	([24.73.230.86] helo=shaft.shaftnet.org ident=[Dlg38mwsb8i9MFgJDNxdiNexLUZeIfCp])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Ett5S-0004M5-7h
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Jan 2006 12:48:56 -0800
Received: from shaft.shaftnet.org (localhost [127.0.0.1])
	by shaft.shaftnet.org (8.12.11/8.12.11) with ESMTP id k03Ki4fO023479
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 3 Jan 2006 15:44:04 -0500
Received: (from pizza@localhost)
	by shaft.shaftnet.org (8.12.11/8.12.8/Submit) id k03Ki4bs023476
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 3 Jan 2006 15:44:04 -0500
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net


--eJnRUKwClWJh1Khz
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by:  Solomon Peachy <pizza@shaftnet.org>

Newer Radeon graphics cards use a different table layout in their=20
BIOSes, known as 'ATOM'. =20

I've attached a patch (against 2.6.15) which implements the PLL and LVDS
parsing out of the ATOM BIOSes, using the current X.org sources as a
reference.  Notably absent is the code which detects the connectors and
TDMS information, but it's of lesser importance at the moment.

This code still has quirks, but I'm not sure if those are due to bugs in
my patch or incomplete/buggy support for the RV410.  So I'd appreciate
it if people could try this out, especially if they have a newer ATOM
BIOS in their radeon card, and let me know what happens.=20

Finally, this patch also has PCI IDs added for my Radeon Mobility X700=20
(M26) adapter.=20

Below is the dump of my system with this driver:

radeonfb_pci_register BEGIN
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 217
radeonfb (0000:01:00.0): Found 131072k of DDR 128 bits wide videoram
radeonfb (0000:01:00.0): mapped 16384k videoram
ATOM BIOS detected
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D330.00 Mhz, System=
=3D358.00 MHz
radeonfb: PLL min 20000 max 50000
XXXX Write ATOM BIOS connector parse
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
Non-DDC laptop panel detected
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type CRT found
radeonfb: detected LVDS panel size from BIOS: 1680x1050
BIOS provided panel power delay: 15369
Setting up default mode based on panel info
radeonfb: Dynamic Clock Power Management enabled
hStart =3D 1728, hEnd =3D 1760, hTotal =3D 1840
vStart =3D 1053, vEnd =3D 1059, vTotal =3D 1080
h_total_disp =3D 0xd100e5           hsync_strt_wid =3D 0x406ba
v_total_disp =3D 0x4190437          vsync_strt_wid =3D 0x6041c
pixclock =3D 8387
freq =3D 11923
freq =3D 11923, PLL min =3D 20000, PLL max =3D 50000
ref_div =3D 12, ref_clk =3D 2700, output_freq =3D 23846
ref_div =3D 12, ref_clk =3D 2700, output_freq =3D 23846
post div =3D 0x1
fb_div =3D 0x6a
ppll_div_3 =3D 0x1006a
Console: switching to colour frame buffer device 210x65
radeonfb (0000:01:00.0): ATI Radeon VS=20
radeonfb_pci_register END

And at this point, I have yummy hires fbdev goodness. =20

I also have a question about the panel_info.pwr_delay field --- Is this
is supposed to be the time we wait for the LCD to settle after a power
state change?  X.org seems to use 200ms everywhere, but the default in
radeonfb seems to be 2000ms, and my panel is reporting a whopping
15369ms.  I'm also forced to use the default pll.ref_div of 12, and I've
tweaked the code to make that default universal if the BIOS information
is clearly bogus.

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radeon_atom_bios.diff"
Content-Transfer-Encoding: quoted-printable

diff -ur /tmp/linux-2.6.15/drivers/video/aty/ati_ids.h ./aty/ati_ids.h
--- /tmp/linux-2.6.15/drivers/video/aty/ati_ids.h	2006-01-03 14:30:15.00000=
0000 -0500
+++ ./aty/ati_ids.h	2006-01-03 15:12:01.000000000 -0500
@@ -185,6 +185,8 @@
 #define PCI_CHIP_R423_UQ                0x5551
 #define PCI_CHIP_R423_UR                0x5552
 #define PCI_CHIP_R423_UT                0x5554
+#define PCI_CHIP_RV410_5652             0x5652
+#define PCI_CHIP_RV410_VS               0x5653
 #define PCI_CHIP_MACH64VT		0x5654
 #define PCI_CHIP_MACH64VU		0x5655
 #define PCI_CHIP_MACH64VV		0x5656
diff -ur /tmp/linux-2.6.15/drivers/video/aty/radeon_base.c ./aty/radeon_bas=
e.c
--- /tmp/linux-2.6.15/drivers/video/aty/radeon_base.c	2006-01-03 14:30:15.0=
00000000 -0500
+++ ./aty/radeon_base.c	2006-01-03 15:13:48.000000000 -0500
@@ -214,6 +214,8 @@
 	CHIP_DEF(PCI_CHIP_R420_JL,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JM,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JN,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_5652,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VS,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
 	CHIP_DEF(PCI_CHIP_R420_JP,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UH,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UI,	R420,	CHIP_HAS_CRTC2),
@@ -342,7 +344,7 @@
 	 * to phase out Open Firmware images.
 	 *
 	 * Currently, we only look at the first PCI data, we could iteratre and d=
eal with
-	 * them all, and we should use fb_bios_start relative to start of image a=
nd not
+	 * them all, and we should use fp_bios_start relative to start of image a=
nd not
 	 * relative start of ROM, but so far, I never found a dual-image ATI card
 	 *
 	 * typedef struct {
@@ -655,8 +657,6 @@
 		rinfo->pll.ref_clk =3D 2700;
 		break;
 	}
-	rinfo->pll.ref_div =3D INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK;
-
=20
 #ifdef CONFIG_PPC_OF
 	/*
@@ -673,14 +673,31 @@
 	 * and if yes, retreive them
 	 */
 	if (!force_measure_pll && rinfo->bios_seg) {
-		u16 pll_info_block =3D BIOS_IN16(rinfo->fp_bios_start + 0x30);
+		u16 pll_info_block;
+		if (rinfo->is_atom_bios) {
+			pll_info_block =3D BIOS_IN16(rinfo->atom_data_start + 12);
+
+			rinfo->pll.sclk =3D BIOS_IN32(pll_info_block + 8);
+			rinfo->pll.mclk =3D BIOS_IN32(pll_info_block + 12);
+			rinfo->pll.ref_clk =3D BIOS_IN16(pll_info_block + 82);
+			rinfo->pll.ref_div =3D 0; /* Have to get it elsewhere */
+			rinfo->pll.ppll_min =3D BIOS_IN16(pll_info_block + 78);
+			rinfo->pll.ppll_max =3D BIOS_IN32(pll_info_block + 32);
+
+			if (rinfo->pll.sclk =3D=3D 0)  rinfo->pll.sclk =3D 20000;
+			if (rinfo->pll.mclk =3D=3D 0)  rinfo->pll.mclk =3D 20000;
=20
-		rinfo->pll.sclk		=3D BIOS_IN16(pll_info_block + 0x08);
-		rinfo->pll.mclk		=3D BIOS_IN16(pll_info_block + 0x0a);
-		rinfo->pll.ref_clk	=3D BIOS_IN16(pll_info_block + 0x0e);
-		rinfo->pll.ref_div	=3D BIOS_IN16(pll_info_block + 0x10);
-		rinfo->pll.ppll_min	=3D BIOS_IN32(pll_info_block + 0x12);
-		rinfo->pll.ppll_max	=3D BIOS_IN32(pll_info_block + 0x16);
+		} else {
+			pll_info_block =3D BIOS_IN16(rinfo->fp_bios_start + 0x30);
+		=09
+			rinfo->pll.sclk		=3D BIOS_IN16(pll_info_block + 0x08);
+			rinfo->pll.mclk		=3D BIOS_IN16(pll_info_block + 0x0a);
+			rinfo->pll.ref_clk	=3D BIOS_IN16(pll_info_block + 0x0e);
+			rinfo->pll.ref_div	=3D BIOS_IN16(pll_info_block + 0x10);
+			rinfo->pll.ppll_min	=3D BIOS_IN32(pll_info_block + 0x12);
+			rinfo->pll.ppll_max	=3D BIOS_IN32(pll_info_block + 0x16);
+		=09
+		}
=20
 		printk(KERN_INFO "radeonfb: Retreived PLL infos from BIOS\n");
 		goto found;
@@ -701,6 +718,22 @@
        	printk(KERN_INFO "radeonfb: Used default PLL infos\n");
=20
 found:
+
+	/* Check and fix-up the PLL divisor if necessary */
+	if (rinfo->pll.ref_div < 2) {
+		int tmp =3D INPLL(PPLL_REF_DIV);
+		if (rinfo->family =3D=3D CHIP_FAMILY_RS300) {
+			rinfo->pll.ref_div =3D (tmp & R300_PPLL_REF_DIV_ACC_MASK) >> R300_PPLL_=
REF_DIV_ACC_SHIFT;
+		} else {
+			rinfo->pll.ref_div =3D tmp & PPLL_REF_DIV_MASK;
+		}
+	=09
+		/* Sane default */
+		if (rinfo->pll.ref_div < 2) {	=09
+			rinfo->pll.ref_div =3D 12;
+		}
+	}	=09
+
 	/*
 	 * Some methods fail to retreive SCLK and MCLK values, we apply default
 	 * settings in this case (200Mhz). If that really happne often, we could
@@ -2412,6 +2445,7 @@
 	 * We probably need to make sure this is the primary display,
 	 * but that is difficult without some arch support.
 	 */
+
 #ifdef CONFIG_X86
 	if (rinfo->bios_seg =3D=3D NULL)
 		radeon_find_mem_vbios(rinfo);
@@ -2423,6 +2457,28 @@
 	if (rinfo->bios_seg =3D=3D NULL && rinfo->is_mobility)
 		radeon_map_ROM(rinfo, pdev);
=20
+	/* Check BIOS Type */
+	{
+	  int tmp =3D rinfo->fp_bios_start + 4;
+	  if ((BIOS_IN8(tmp) =3D=3D 'A' &&
+	       BIOS_IN8(tmp+1) =3D=3D 'T' &&
+	       BIOS_IN8(tmp+2) =3D=3D 'O' &&
+	       BIOS_IN8(tmp+3) =3D=3D 'M') ||
+	      (BIOS_IN8(tmp) =3D=3D 'M' &&
+	       BIOS_IN8(tmp+1) =3D=3D 'O' &&
+	       BIOS_IN8(tmp+2) =3D=3D 'T' &&
+	       BIOS_IN8(tmp+3) =3D=3D 'A')) {
+		  rinfo->is_atom_bios =3D 1;
+	  } else {
+		  rinfo->is_atom_bios =3D 0;
+	  }
+	}
+=09
+	if (rinfo->is_atom_bios) {
+		rinfo->atom_data_start =3D BIOS_IN16(rinfo->fp_bios_start + 32);
+		printk("ATOM BIOS detected\n");
+	}
+
 	/* Get informations about the board's PLL */
 	radeon_get_pllinfo(rinfo);
=20
diff -ur /tmp/linux-2.6.15/drivers/video/aty/radeon_monitor.c ./aty/radeon_=
monitor.c
--- /tmp/linux-2.6.15/drivers/video/aty/radeon_monitor.c	2005-10-27 20:02:0=
8.000000000 -0400
+++ ./aty/radeon_monitor.c	2006-01-03 12:15:55.000000000 -0500
@@ -169,76 +169,117 @@
 	if (!rinfo->bios_seg)
 		return 0;
=20
-	if (!(tmp =3D BIOS_IN16(rinfo->fp_bios_start + 0x40))) {
-		printk(KERN_ERR "radeonfb: Failed to detect DFP panel info using BIOS\n"=
);
-		rinfo->panel_info.pwr_delay =3D 200;
-		return 0;
-	}
=20
-	for(i=3D0; i<24; i++)
-		stmp[i] =3D BIOS_IN8(tmp+i+1);
-	stmp[24] =3D 0;
-	printk("radeonfb: panel ID string: %s\n", stmp);
-	rinfo->panel_info.xres =3D BIOS_IN16(tmp + 25);
-	rinfo->panel_info.yres =3D BIOS_IN16(tmp + 27);
-	printk("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
-		rinfo->panel_info.xres, rinfo->panel_info.yres);
-
-	rinfo->panel_info.pwr_delay =3D BIOS_IN16(tmp + 44);
-	RTRACE("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_del=
ay);
-	if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay <=
=3D 0)
-		rinfo->panel_info.pwr_delay =3D 2000;
+	if (rinfo->is_atom_bios) {
+		tmp =3D BIOS_IN16(rinfo->atom_data_start + 16);
+		if (!tmp) {
+			printk(KERN_ERR "radeonfb: Failed to detect DFP panel info using BIOS\n=
");
+			rinfo->panel_info.pwr_delay =3D 200;
+			return 0;
+		}
=20
-	/*
-	 * Some panels only work properly with some divider combinations
-	 */
-	rinfo->panel_info.ref_divider =3D BIOS_IN16(tmp + 46);
-	rinfo->panel_info.post_divider =3D BIOS_IN8(tmp + 48);
-	rinfo->panel_info.fbk_divider =3D BIOS_IN16(tmp + 49);
-	if (rinfo->panel_info.ref_divider !=3D 0 &&
-	    rinfo->panel_info.fbk_divider > 3) {
-		rinfo->panel_info.use_bios_dividers =3D 1;
-		printk(KERN_INFO "radeondb: BIOS provided dividers will be used\n");
-		RTRACE("ref_divider =3D %x\n", rinfo->panel_info.ref_divider);
-		RTRACE("post_divider =3D %x\n", rinfo->panel_info.post_divider);
-		RTRACE("fbk_divider =3D %x\n", rinfo->panel_info.fbk_divider);
-	}
-	RTRACE("Scanning BIOS table ...\n");
-	for(i=3D0; i<32; i++) {
-		tmp0 =3D BIOS_IN16(tmp+64+i*2);
-		if (tmp0 =3D=3D 0)
-			break;
-		RTRACE(" %d x %d\n", BIOS_IN16(tmp0), BIOS_IN16(tmp0+2));
-		if ((BIOS_IN16(tmp0) =3D=3D rinfo->panel_info.xres) &&
-		    (BIOS_IN16(tmp0+2) =3D=3D rinfo->panel_info.yres)) {
-			rinfo->panel_info.hblank =3D (BIOS_IN16(tmp0+17) - BIOS_IN16(tmp0+19)) =
* 8;
-			rinfo->panel_info.hOver_plus =3D ((BIOS_IN16(tmp0+21) -
-							 BIOS_IN16(tmp0+19) -1) * 8) & 0x7fff;
-			rinfo->panel_info.hSync_width =3D BIOS_IN8(tmp0+23) * 8;
-			rinfo->panel_info.vblank =3D BIOS_IN16(tmp0+24) - BIOS_IN16(tmp0+26);
-			rinfo->panel_info.vOver_plus =3D (BIOS_IN16(tmp0+28) & 0x7ff) - BIOS_IN=
16(tmp0+26);
-			rinfo->panel_info.vSync_width =3D (BIOS_IN16(tmp0+28) & 0xf800) >> 11;
-			rinfo->panel_info.clock =3D BIOS_IN16(tmp0+9);
-			/* Assume high active syncs for now until ATI tells me more... maybe we
-			 * can probe register values here ?
-			 */
-			rinfo->panel_info.hAct_high =3D 1;
-			rinfo->panel_info.vAct_high =3D 1;
-			/* Mark panel infos valid */
-			rinfo->panel_info.valid =3D 1;
-
-			RTRACE("Found panel in BIOS table:\n");
-			RTRACE("  hblank: %d\n", rinfo->panel_info.hblank);
-			RTRACE("  hOver_plus: %d\n", rinfo->panel_info.hOver_plus);
-			RTRACE("  hSync_width: %d\n", rinfo->panel_info.hSync_width);
-			RTRACE("  vblank: %d\n", rinfo->panel_info.vblank);
-			RTRACE("  vOver_plus: %d\n", rinfo->panel_info.vOver_plus);
-			RTRACE("  vSync_width: %d\n", rinfo->panel_info.vSync_width);
-			RTRACE("  clock: %d\n", rinfo->panel_info.clock);
+		rinfo->panel_info.xres =3D BIOS_IN16(tmp+6);
+		rinfo->panel_info.yres =3D BIOS_IN16(tmp+10);
+		printk("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
+		       rinfo->panel_info.xres, rinfo->panel_info.yres);
+		rinfo->panel_info.pwr_delay =3D BIOS_IN16(tmp+40);
+		RTRACE("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_de=
lay);
+		if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay <=
=3D 0)
+			rinfo->panel_info.pwr_delay =3D 2000;
+	=09
+		/* No special divider combinations? */
+		      =20
+		rinfo->panel_info.hblank =3D BIOS_IN16(tmp+8);
+		rinfo->panel_info.hOver_plus =3D BIOS_IN16(tmp+14);
+		rinfo->panel_info.hSync_width =3D BIOS_IN16(tmp+16);
+		rinfo->panel_info.vblank =3D BIOS_IN16(tmp+12);
+		rinfo->panel_info.vOver_plus =3D BIOS_IN16(tmp+18);
+		rinfo->panel_info.vSync_width =3D BIOS_IN16(tmp+20);
+		rinfo->panel_info.clock =3D BIOS_IN16(tmp+4);
+
+		/* Assume high active syncs for now until ATI tells me more... maybe we
+		 * can probe register values here ?
+		 */
+		rinfo->panel_info.hAct_high =3D 1;
+		rinfo->panel_info.vAct_high =3D 1;
+		/* Mark panel infos valid */
+		rinfo->panel_info.valid =3D 1;
+
+		return 1;
+	} else {
+		if (!(tmp =3D BIOS_IN16(rinfo->fp_bios_start + 0x40))) {
+			printk(KERN_ERR "radeonfb: Failed to detect DFP panel info using BIOS\n=
");
+			rinfo->panel_info.pwr_delay =3D 200;
+			return 0;
+		}
+	=09
+		for(i=3D0; i<24; i++)
+			stmp[i] =3D BIOS_IN8(tmp+i+1);
+		stmp[24] =3D 0;
+		printk("radeonfb: panel ID string: %s\n", stmp);
+		rinfo->panel_info.xres =3D BIOS_IN16(tmp + 25);
+		rinfo->panel_info.yres =3D BIOS_IN16(tmp + 27);
+		printk("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
+		       rinfo->panel_info.xres, rinfo->panel_info.yres);
+	=09
+		rinfo->panel_info.pwr_delay =3D BIOS_IN16(tmp + 44);
+		RTRACE("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_de=
lay);
+		if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay <=
=3D 0)
+			rinfo->panel_info.pwr_delay =3D 2000;
+	=09
+		/*
+		 * Some panels only work properly with some divider combinations
+		 */
+		rinfo->panel_info.ref_divider =3D BIOS_IN16(tmp + 46);
+		rinfo->panel_info.post_divider =3D BIOS_IN8(tmp + 48);
+		rinfo->panel_info.fbk_divider =3D BIOS_IN16(tmp + 49);
+		if (rinfo->panel_info.ref_divider !=3D 0 &&
+		    rinfo->panel_info.fbk_divider > 3) {
+			rinfo->panel_info.use_bios_dividers =3D 1;
+			printk(KERN_INFO "radeondb: BIOS provided dividers will be used\n");
+			RTRACE("ref_divider =3D %x\n", rinfo->panel_info.ref_divider);
+			RTRACE("post_divider =3D %x\n", rinfo->panel_info.post_divider);
+			RTRACE("fbk_divider =3D %x\n", rinfo->panel_info.fbk_divider);
+		}
+
+		RTRACE("Scanning BIOS table ...\n");
+		for(i=3D0; i<32; i++) {
+			tmp0 =3D BIOS_IN16(tmp+64+i*2);
+			if (tmp0 =3D=3D 0)
+				break;
+			RTRACE(" %d x %d\n", BIOS_IN16(tmp0), BIOS_IN16(tmp0+2));
+			if ((BIOS_IN16(tmp0) =3D=3D rinfo->panel_info.xres) &&
+			    (BIOS_IN16(tmp0+2) =3D=3D rinfo->panel_info.yres)) {
+				rinfo->panel_info.hblank =3D (BIOS_IN16(tmp0+17) - BIOS_IN16(tmp0+19))=
 * 8;
+				rinfo->panel_info.hOver_plus =3D ((BIOS_IN16(tmp0+21) -
+								 BIOS_IN16(tmp0+19) -1) * 8) & 0x7fff;
+				rinfo->panel_info.hSync_width =3D BIOS_IN8(tmp0+23) * 8;
+				rinfo->panel_info.vblank =3D BIOS_IN16(tmp0+24) - BIOS_IN16(tmp0+26);
+				rinfo->panel_info.vOver_plus =3D (BIOS_IN16(tmp0+28) & 0x7ff) - BIOS_I=
N16(tmp0+26);
+				rinfo->panel_info.vSync_width =3D (BIOS_IN16(tmp0+28) & 0xf800) >> 11;
+				rinfo->panel_info.clock =3D BIOS_IN16(tmp0+9);
+				/* Assume high active syncs for now until ATI tells me more... maybe we
+				 * can probe register values here ?
+				 */
+				rinfo->panel_info.hAct_high =3D 1;
+				rinfo->panel_info.vAct_high =3D 1;
+				/* Mark panel infos valid */
+				rinfo->panel_info.valid =3D 1;
 			=09
-			return 1;
+				RTRACE("Found panel in BIOS table:\n");
+				RTRACE("  hblank: %d\n", rinfo->panel_info.hblank);
+				RTRACE("  hOver_plus: %d\n", rinfo->panel_info.hOver_plus);
+				RTRACE("  hSync_width: %d\n", rinfo->panel_info.hSync_width);
+				RTRACE("  vblank: %d\n", rinfo->panel_info.vblank);
+				RTRACE("  vOver_plus: %d\n", rinfo->panel_info.vOver_plus);
+				RTRACE("  vSync_width: %d\n", rinfo->panel_info.vSync_width);
+				RTRACE("  clock: %d\n", rinfo->panel_info.clock);
+			=09
+				return 1;
+			}
 		}
 	}
+
 	RTRACE("Didn't find panel in BIOS table !\n");
=20
 	return 0;
@@ -261,29 +302,34 @@
 	if (!rinfo->bios_seg)
 		return;
=20
-	offset =3D BIOS_IN16(rinfo->fp_bios_start + 0x50);
-	if (offset =3D=3D 0) {
-		printk(KERN_WARNING "radeonfb: No connector info table detected\n");
-		return;
-	}
-
-	/* Don't do much more at this point but displaying the data if
-	 * DEBUG is enabled
-	 */
-	chips =3D BIOS_IN8(offset++) >> 4;
-	RTRACE("%d chips in connector info\n", chips);
-	for (i =3D 0; i < chips; i++) {
-		tmp =3D BIOS_IN8(offset++);
-		connectors =3D tmp & 0x0f;
-		RTRACE(" - chip %d has %d connectors\n", tmp >> 4, connectors);
-		for (conn =3D 0; ; conn++) {
-			tmp =3D BIOS_IN16(offset);
-			if (tmp =3D=3D 0)
-				break;
-			offset +=3D 2;
-			type =3D (tmp >> 12) & 0x0f;
-			RTRACE("  * connector %d of type %d (%s) : %04x\n",
-			       conn, type, __conn_type_table[type], tmp);
+	if (rinfo->is_atom_bios) {
+		printk(KERN_WARNING "XXXX Write ATOM BIOS connector parse\n");
+	} else {
+	 =20
+		offset =3D BIOS_IN16(rinfo->fp_bios_start + 0x50);
+		if (offset =3D=3D 0) {
+			printk(KERN_WARNING "radeonfb: No connector info table detected\n");
+			return;
+		}
+	=09
+		/* Don't do much more at this point but displaying the data if
+		 * DEBUG is enabled
+		 */
+		chips =3D BIOS_IN8(offset++) >> 4;
+		RTRACE("%d chips in connector info\n", chips);
+		for (i =3D 0; i < chips; i++) {
+			tmp =3D BIOS_IN8(offset++);
+			connectors =3D tmp & 0x0f;
+			RTRACE(" - chip %d has %d connectors\n", tmp >> 4, connectors);
+			for (conn =3D 0; ; conn++) {
+				tmp =3D BIOS_IN16(offset);
+				if (tmp =3D=3D 0)
+					break;
+				offset +=3D 2;
+				type =3D (tmp >> 12) & 0x0f;
+				RTRACE("  * connector %d of type %d (%s) : %04x\n",
+				       conn, type, __conn_type_table[type], tmp);
+			}
 		}
 	}
 }
@@ -519,6 +565,8 @@
 		/*
 		 * Check for cards with reversed DACs or TMDS controllers using BIOS
 		 */
+		// XXXX What about atom_bios types?
+
 		if (rinfo->bios_seg &&
 		    (tmp =3D BIOS_IN16(rinfo->fp_bios_start + 0x50))) {
 			for (i =3D 1; i < 4; i++) {
diff -ur /tmp/linux-2.6.15/drivers/video/aty/radeonfb.h ./aty/radeonfb.h
--- /tmp/linux-2.6.15/drivers/video/aty/radeonfb.h	2006-01-03 14:30:15.0000=
00000 -0500
+++ ./aty/radeonfb.h	2006-01-03 11:30:51.000000000 -0500
@@ -298,6 +298,9 @@
 	void __iomem		*bios_seg;
 	int			fp_bios_start;
=20
+	int                     is_atom_bios;
+	int                     atom_data_start;
+
 	u32			pseudo_palette[17];
 	struct { u8 red, green, blue, pad; }
 				palette[256];

--opJtzjQTFsWo+cga--

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDuuIUPuLgii2759ARAi+pAKDr+X3g/xgyZKnemTqv5C9Sz+664gCgzPQI
pDc+yc+dqiaQd/L2FZr+G/U=
=hCEq
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
