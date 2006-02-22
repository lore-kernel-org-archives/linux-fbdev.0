From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: [patch] [radeonfb] Radeon Mobility X700 (M26) and ATOM bios support
Date: Wed, 22 Feb 2006 17:19:16 -0500
Message-ID: <20060222221916.GB17359@shaftnet.org>
References: <20060103204404.GA23313@shaftnet.org> <1139952530.7903.31.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FC3tD-0003Sv-Sd
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Feb 2006 15:59:23 -0800
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86] helo=shaft.shaftnet.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FC3tC-0000ER-WB
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Feb 2006 15:59:24 -0800
Content-Disposition: inline
In-Reply-To: <1139952530.7903.31.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


--XMCwj5IQnwKtuyBG
Content-Type: multipart/mixed; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2006 at 08:28:49AM +1100, Benjamin Herrenschmidt wrote:
> What's the status of this patch ? Do you have a new version ? People are
> heving enough problems with recent cards to justify getting something in
> soon...

Sorry about the delay, but as you mentioned earlier, you know how those=20
higher-priority things are. =20

I've attached my current WIP.  It has no additional functionality over
the original patch, but it's rearranged to be quite a bit cleaner, using=20
function pointers for the atom/legacy bits. =20

I haven't tested this particular patch out, but it does compile.

The reversed DAC/TDMS detection and connector parsing stuff is still=20
unwritten for ATOM BIOSes.  I plan on digging into the X.Org sources=20
later tonight.

Of course other stuff like OpenFirmware could be integrated better, but=20
I'd rather leave that for people who can test things.

Let me know what you think.   It's against 2.6.15, FWIW.

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL
Quidquid latine dictum sit, altum viditur.

--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radeon-atom-bios2.diff"
Content-Transfer-Encoding: quoted-printable

diff -aur aty-2.6.15/ati_ids.h aty/ati_ids.h
--- aty-2.6.15/ati_ids.h	2006-02-22 16:12:58.000000000 -0500
+++ aty/ati_ids.h	2006-02-22 16:15:54.000000000 -0500
@@ -185,6 +185,8 @@
 #define PCI_CHIP_R423_UQ                0x5551
 #define PCI_CHIP_R423_UR                0x5552
 #define PCI_CHIP_R423_UT                0x5554
+#define PCI_CHIP_RV410_5652             0x5652
+#define PCI_CHIP_RV410_VS               0x5653
 #define PCI_CHIP_MACH64VT		0x5654
 #define PCI_CHIP_MACH64VU		0x5655
 #define PCI_CHIP_MACH64VV		0x5656
diff -aur aty-2.6.15/radeon_base.c aty/radeon_base.c
--- aty-2.6.15/radeon_base.c	2006-02-22 16:12:58.000000000 -0500
+++ aty/radeon_base.c	2006-02-22 16:59:03.000000000 -0500
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
@@ -593,6 +595,71 @@
 	return 0;
 }
=20
+static void __devinit radeon_get_pllinfo_legacy(struct radeonfb_info *rinf=
o)
+{
+	u16 pll_info_block;
+
+	pll_info_block =3D BIOS_IN16(rinfo->fp_bios_start + 0x30);
+=09
+	rinfo->pll.sclk		=3D BIOS_IN16(pll_info_block + 0x08);
+	rinfo->pll.mclk		=3D BIOS_IN16(pll_info_block + 0x0a);
+	rinfo->pll.ref_clk	=3D BIOS_IN16(pll_info_block + 0x0e);
+	rinfo->pll.ref_div	=3D BIOS_IN16(pll_info_block + 0x10);
+	rinfo->pll.ppll_min	=3D BIOS_IN32(pll_info_block + 0x12);
+	rinfo->pll.ppll_max	=3D BIOS_IN32(pll_info_block + 0x16);
+
+	printk(KERN_INFO "radeonfb: Retreived PLL infos from BIOS\n");
+}
+
+
+static void __devinit radeon_get_pllinfo_atom(struct radeonfb_info *rinfo)
+{
+	u16 pll_info_block;
+
+	pll_info_block =3D BIOS_IN16(rinfo->atom_data_start + 12);
+=09
+	rinfo->pll.sclk =3D BIOS_IN32(pll_info_block + 8);
+	rinfo->pll.mclk =3D BIOS_IN32(pll_info_block + 12);
+	rinfo->pll.ref_clk =3D BIOS_IN16(pll_info_block + 82);
+	rinfo->pll.ref_div =3D 0; /* Have to get it elsewhere */
+	rinfo->pll.ppll_min =3D BIOS_IN16(pll_info_block + 78);
+	rinfo->pll.ppll_max =3D BIOS_IN32(pll_info_block + 32);
+=09
+	if (rinfo->pll.sclk =3D=3D 0)  rinfo->pll.sclk =3D 20000;
+	if (rinfo->pll.mclk =3D=3D 0)  rinfo->pll.mclk =3D 20000;
+
+	printk(KERN_INFO "radeonfb: Retreived PLL infos from BIOS\n");
+}
+
+static void radeon_detect_bios_type(struct radeonfb_info *rinfo)
+{
+	  int tmp =3D rinfo->fp_bios_start + 4;
+
+	  if ((BIOS_IN8(tmp) =3D=3D 'A' &&
+	       BIOS_IN8(tmp+1) =3D=3D 'T' &&
+	       BIOS_IN8(tmp+2) =3D=3D 'O' &&
+	       BIOS_IN8(tmp+3) =3D=3D 'M') ||
+	      (BIOS_IN8(tmp) =3D=3D 'M' &&
+	       BIOS_IN8(tmp+1) =3D=3D 'O' &&
+	       BIOS_IN8(tmp+2) =3D=3D 'T' &&
+	       BIOS_IN8(tmp+3) =3D=3D 'A')) {
+		  rinfo->is_atom_bios =3D 1;
+
+		  rinfo->atom_data_start =3D BIOS_IN16(rinfo->fp_bios_start + 32);
+		  rinfo->radeon_get_pll_info =3D radeon_get_pllinfo_atom;
+		  rinfo->radeon_get_panel_info =3D radeon_get_panel_info_atom;
+		  printk(KERN_WARNING "XXXX Write ATOM BIOS connector parse\n");
+		  rinfo->radeon_parse_connector_info =3D NULL;
+		  printk("ATOM BIOS detected\n");
+	  } else {
+		  rinfo->is_atom_bios =3D 0;
+		  rinfo->radeon_get_pll_info =3D radeon_get_pllinfo_legacy;
+		  rinfo->radeon_get_panel_info =3D radeon_get_panel_info_legacy;
+		  rinfo->radeon_parse_connector_info =3D radeon_parse_connector_info_leg=
acy;
+		  printk("Legacy BIOS detected\n");
+	  }
+}
+
 /*
  * Retreive PLL infos by different means (BIOS, Open Firmware, register pr=
obing...)
  */
@@ -655,8 +722,6 @@
 		rinfo->pll.ref_clk =3D 2700;
 		break;
 	}
-	rinfo->pll.ref_div =3D INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK;
-
=20
 #ifdef CONFIG_PPC_OF
 	/*
@@ -673,17 +738,12 @@
 	 * and if yes, retreive them
 	 */
 	if (!force_measure_pll && rinfo->bios_seg) {
-		u16 pll_info_block =3D BIOS_IN16(rinfo->fp_bios_start + 0x30);
-
-		rinfo->pll.sclk		=3D BIOS_IN16(pll_info_block + 0x08);
-		rinfo->pll.mclk		=3D BIOS_IN16(pll_info_block + 0x0a);
-		rinfo->pll.ref_clk	=3D BIOS_IN16(pll_info_block + 0x0e);
-		rinfo->pll.ref_div	=3D BIOS_IN16(pll_info_block + 0x10);
-		rinfo->pll.ppll_min	=3D BIOS_IN32(pll_info_block + 0x12);
-		rinfo->pll.ppll_max	=3D BIOS_IN32(pll_info_block + 0x16);
-
-		printk(KERN_INFO "radeonfb: Retreived PLL infos from BIOS\n");
-		goto found;
+		if (rinfo->radeon_get_pll_info) {
+			rinfo->radeon_get_pll_info(rinfo);
+			goto found;
+		}
+		=09
+		printk(KERN_INFO "Unable to retrieve PLL info from BIOS\n");
 	}
=20
 	/*
@@ -701,6 +761,22 @@
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
@@ -2412,6 +2488,7 @@
 	 * We probably need to make sure this is the primary display,
 	 * but that is difficult without some arch support.
 	 */
+
 #ifdef CONFIG_X86
 	if (rinfo->bios_seg =3D=3D NULL)
 		radeon_find_mem_vbios(rinfo);
@@ -2423,6 +2500,9 @@
 	if (rinfo->bios_seg =3D=3D NULL && rinfo->is_mobility)
 		radeon_map_ROM(rinfo, pdev);
=20
+	/* Check BIOS Type */
+	radeon_detect_bios_type(rinfo);
+=09
 	/* Get informations about the board's PLL */
 	radeon_get_pllinfo(rinfo);
=20
diff -aur aty-2.6.15/radeon_monitor.c aty/radeon_monitor.c
--- aty-2.6.15/radeon_monitor.c	2006-02-22 16:12:58.000000000 -0500
+++ aty/radeon_monitor.c	2006-02-22 16:56:59.000000000 -0500
@@ -160,7 +160,51 @@
 #endif /* CONFIG_PPC_OF */
=20
=20
-static int __devinit radeon_get_panel_info_BIOS(struct radeonfb_info *rinf=
o)
+int __devinit radeon_get_panel_info_atom(struct radeonfb_info *rinfo)
+{
+	unsigned long tmp;
+
+	if (!rinfo->bios_seg)
+		return 0;
+
+	tmp =3D BIOS_IN16(rinfo->atom_data_start + 16);
+	if (!tmp) {
+		printk(KERN_ERR "radeonfb: Failed to detect DFP panel info using BIOS\n"=
);
+		rinfo->panel_info.pwr_delay =3D 200;
+		return 0;
+	}
+=09
+	rinfo->panel_info.xres =3D BIOS_IN16(tmp+6);
+	rinfo->panel_info.yres =3D BIOS_IN16(tmp+10);
+	printk("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
+	       rinfo->panel_info.xres, rinfo->panel_info.yres);
+	rinfo->panel_info.pwr_delay =3D BIOS_IN16(tmp+40);
+	RTRACE("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_del=
ay);
+	if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay <=
=3D 0)
+		rinfo->panel_info.pwr_delay =3D 2000;
+=09
+	/* No special divider combinations? */
+=09
+	rinfo->panel_info.hblank =3D BIOS_IN16(tmp+8);
+	rinfo->panel_info.hOver_plus =3D BIOS_IN16(tmp+14);
+	rinfo->panel_info.hSync_width =3D BIOS_IN16(tmp+16);
+	rinfo->panel_info.vblank =3D BIOS_IN16(tmp+12);
+	rinfo->panel_info.vOver_plus =3D BIOS_IN16(tmp+18);
+	rinfo->panel_info.vSync_width =3D BIOS_IN16(tmp+20);
+	rinfo->panel_info.clock =3D BIOS_IN16(tmp+4);
+=09
+	/* Assume high active syncs for now until ATI tells me more... maybe we
+	 * can probe register values here ?
+	 */
+	rinfo->panel_info.hAct_high =3D 1;
+	rinfo->panel_info.vAct_high =3D 1;
+	/* Mark panel infos valid */
+	rinfo->panel_info.valid =3D 1;
+=09
+	return 1;
+}
+
+int __devinit radeon_get_panel_info_legacy(struct radeonfb_info *rinfo)
 {
 	unsigned long tmp, tmp0;
 	char stmp[30];
@@ -174,7 +218,7 @@
 		rinfo->panel_info.pwr_delay =3D 200;
 		return 0;
 	}
-
+=09
 	for(i=3D0; i<24; i++)
 		stmp[i] =3D BIOS_IN8(tmp+i+1);
 	stmp[24] =3D 0;
@@ -182,13 +226,13 @@
 	rinfo->panel_info.xres =3D BIOS_IN16(tmp + 25);
 	rinfo->panel_info.yres =3D BIOS_IN16(tmp + 27);
 	printk("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
-		rinfo->panel_info.xres, rinfo->panel_info.yres);
-
+	       rinfo->panel_info.xres, rinfo->panel_info.yres);
+=09
 	rinfo->panel_info.pwr_delay =3D BIOS_IN16(tmp + 44);
 	RTRACE("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_del=
ay);
 	if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay <=
=3D 0)
 		rinfo->panel_info.pwr_delay =3D 2000;
-
+=09
 	/*
 	 * Some panels only work properly with some divider combinations
 	 */
@@ -203,6 +247,7 @@
 		RTRACE("post_divider =3D %x\n", rinfo->panel_info.post_divider);
 		RTRACE("fbk_divider =3D %x\n", rinfo->panel_info.fbk_divider);
 	}
+=09
 	RTRACE("Scanning BIOS table ...\n");
 	for(i=3D0; i<32; i++) {
 		tmp0 =3D BIOS_IN16(tmp+64+i*2);
@@ -226,7 +271,7 @@
 			rinfo->panel_info.vAct_high =3D 1;
 			/* Mark panel infos valid */
 			rinfo->panel_info.valid =3D 1;
-
+		=09
 			RTRACE("Found panel in BIOS table:\n");
 			RTRACE("  hblank: %d\n", rinfo->panel_info.hblank);
 			RTRACE("  hOver_plus: %d\n", rinfo->panel_info.hOver_plus);
@@ -235,10 +280,11 @@
 			RTRACE("  vOver_plus: %d\n", rinfo->panel_info.vOver_plus);
 			RTRACE("  vSync_width: %d\n", rinfo->panel_info.vSync_width);
 			RTRACE("  clock: %d\n", rinfo->panel_info.clock);
-			=09
+		=09
 			return 1;
 		}
 	}
+
 	RTRACE("Didn't find panel in BIOS table !\n");
=20
 	return 0;
@@ -248,7 +294,7 @@
  * doesn't quite work yet, but it's output is still useful for
  * debugging
  */
-static void __devinit radeon_parse_connector_info(struct radeonfb_info *ri=
nfo)
+void __devinit radeon_parse_connector_info_legacy(struct radeonfb_info *ri=
nfo)
 {
 	int offset, chips, connectors, tmp, i, conn, type;
=20
@@ -266,7 +312,7 @@
 		printk(KERN_WARNING "radeonfb: No connector info table detected\n");
 		return;
 	}
-
+=09
 	/* Don't do much more at this point but displaying the data if
 	 * DEBUG is enabled
 	 */
@@ -434,7 +480,9 @@
 #endif
 	int tmp, i;
=20
-	radeon_parse_connector_info(rinfo);
+	if (rinfo->radeon_parse_connector_info) {
+		rinfo->radeon_parse_connector_info(rinfo);
+	}
=20
 	if (radeon_parse_monitor_layout(rinfo, monitor_layout)) {
=20
@@ -519,6 +567,8 @@
 		/*
 		 * Check for cards with reversed DACs or TMDS controllers using BIOS
 		 */
+		// XXXX What about atom_bios types?
+
 		if (rinfo->bios_seg &&
 		    (tmp =3D BIOS_IN16(rinfo->fp_bios_start + 0x50))) {
 			for (i =3D 1; i < 4; i++) {
@@ -731,6 +781,7 @@
 {
 	struct fb_info * info =3D rinfo->info;
 	int has_default_mode =3D 0;
+	int found =3D 0;
=20
 	/*
 	 * Fill default var first
@@ -741,8 +792,12 @@
 	/*
 	 * First check out what BIOS has to say
 	 */
-	if (rinfo->mon1_type =3D=3D MT_LCD)
-		radeon_get_panel_info_BIOS(rinfo);
+	if (rinfo->mon1_type =3D=3D MT_LCD) {
+		if (rinfo->radeon_get_panel_info) {
+			rinfo->radeon_get_panel_info(rinfo);
+			// XXX Do we care about the return value?
+		}
+	}
=20
 	/*
 	 * Parse EDID detailed timings and deduce panel infos if any. Right now
diff -aur aty-2.6.15/radeonfb.h aty/radeonfb.h
--- aty-2.6.15/radeonfb.h	2006-02-22 16:12:58.000000000 -0500
+++ aty/radeonfb.h	2006-02-22 16:57:56.000000000 -0500
@@ -298,6 +298,16 @@
 	void __iomem		*bios_seg;
 	int			fp_bios_start;
=20
+	int                     is_atom_bios;
+	int                     atom_data_start;
+=09
+	void                    (*radeon_get_pll_info)(struct radeonfb_info *rinf=
o);
+	int                     (*radeon_get_panel_info)(struct radeonfb_info *ri=
nfo);
+	void                    (*radeon_parse_connector_info)(struct radeonfb_in=
fo *rinfo);
+
+
+
+
 	u32			pseudo_palette[17];
 	struct { u8 red, green, blue, pad; }
 				palette[256];
@@ -625,4 +635,10 @@
 extern void radeon_write_mode (struct radeonfb_info *rinfo, struct radeon_=
regs *mode,
 			       int reg_only);
=20
+/* Bios functions.  Fix this. */
+extern int __devinit radeon_get_panel_info_atom(struct radeonfb_info *rinf=
o);
+extern int __devinit radeon_get_panel_info_legacy(struct radeonfb_info *ri=
nfo);
+void __devinit radeon_parse_connector_info_legacy(struct radeonfb_info *ri=
nfo);
+
+
 #endif /* __RADEONFB_H__ */

--ftEhullJWpWg/VHq--

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFD/ONkPuLgii2759ARAqRiAKDGI20PJJFBxM2sth/ow7jeD5OoVwCgpzP/
cJXO9Fc/K7kxKrGOmHwkUDk=
=rqmk
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
