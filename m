From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: [patch] [radeonfb] Radeon Mobility X700 (M26) and ATOM bios support
Date: Thu, 23 Feb 2006 01:09:39 -0500
Message-ID: <20060223060939.GA27224@shaftnet.org>
References: <20060103204404.GA23313@shaftnet.org> <1139952530.7903.31.camel@localhost.localdomain> <20060222221916.GB17359@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FC9fs-0001fI-QT
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Feb 2006 22:10:00 -0800
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86] helo=shaft.shaftnet.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FC9fq-0006xo-RS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Feb 2006 22:10:00 -0800
Content-Disposition: inline
In-Reply-To: <20060222221916.GB17359@shaftnet.org>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net


--8P1HSweYDcXXzwPJ
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2006 at 05:19:16PM -0500, Stuffed Crust wrote:
> On Wed, Feb 15, 2006 at 08:28:49AM +1100, Benjamin Herrenschmidt wrote:
> > What's the status of this patch ? Do you have a new version ? People are
> > heving enough problems with recent cards to justify getting something in
> > soon...
>=20
> Sorry about the delay, but as you mentioned earlier, you know how those=
=20
> higher-priority things are. =20
>=20
> I've attached my current WIP.  It has no additional functionality over
> the original patch, but it's rearranged to be quite a bit cleaner, using=
=20
> function pointers for the atom/legacy bits. =20
>=20
> I haven't tested this particular patch out, but it does compile.
>=20
> The reversed DAC/TDMS detection and connector parsing stuff is still=20
> unwritten for ATOM BIOSes.  I plan on digging into the X.Org sources=20
> later tonight.

And to follow up to myself, here is a third patch.  I've started=20
incorporating bits and pieces from the "oooold" non-working rewrite=20
that you sent me for inspiration.  Changes from last patch:

 * Naming cleanups
 * Merge the OpenFirmware PLL detection into the function pointer mess.
 * Merge the oooold patch's legacy bios connector parsing code, As the=20
   original stuff didn't really do anything anyway, I don't see the harm. =
=20
 * Merge the ooold patch's atom bios connector parsing code, but it still=
=20
   doesn't work yet.  It's late and my eyes hurt.

The good news is that I'm typing this using this patch on my Radeon=20
M26 (mmm.. 1680x1050!), but the bad news is that I don't know if the=20
legacy BIOS code works, especially the connector parsing stuff.

Let me know if I'm going down the right path.  The RadeonFB driver is=20
pretty complicated, so I'm trying to take baby steps as I figure more=20
of it out.

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL
Quidquid latine dictum sit, altum viditur.

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radeon-atom-3.diff"
Content-Transfer-Encoding: quoted-printable

diff -aur aty-2.6.15/ati_ids.h aty/ati_ids.h
--- aty-2.6.15/ati_ids.h	2006-02-22 23:28:14.000000000 -0500
+++ aty/ati_ids.h	2006-02-22 23:28:38.000000000 -0500
@@ -185,6 +185,8 @@
 #define PCI_CHIP_R423_UQ                0x5551
 #define PCI_CHIP_R423_UR                0x5552
 #define PCI_CHIP_R423_UT                0x5554
+#define PCI_CHIP_RV410_5652             0x5652
+#define PCI_CHIP_RV410_VS               0x5653
 #define PCI_CHIP_MACH64VT		0x5654
 #define PCI_CHIP_MACH64VU		0x5655
 #define PCI_CHIP_MACH64VV		0x5656
Only in aty-2.6.15: radeon-atom-bios2.diff
Only in aty-2.6.15: radeon_atom_bios.diff
diff -aur aty-2.6.15/radeon_base.c aty/radeon_base.c
--- aty-2.6.15/radeon_base.c	2006-02-22 23:28:14.000000000 -0500
+++ aty/radeon_base.c	2006-02-23 00:22:42.000000000 -0500
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
@@ -428,7 +430,7 @@
  * Read XTAL (ref clock), SCLK and MCLK from Open Firmware device
  * tree. Hopefully, ATI OF driver is kind enough to fill these
  */
-static int __devinit radeon_read_xtal_OF (struct radeonfb_info *rinfo)
+static int __devinit radeon_get_pll_info_openfirmware (struct radeonfb_inf=
o *rinfo)
 {
 	struct device_node *dp =3D rinfo->of_node;
 	u32 *val;
@@ -451,6 +453,7 @@
 	if (val && *val)
 		rinfo->pll.mclk =3D (*val) / 10;
=20
+	printk(KERN_INFO "radeonfb: Retreived PLL infos from Open Firmware\n");
        	return 0;
 }
 #endif /* CONFIG_PPC_OF */
@@ -593,10 +596,87 @@
 	return 0;
 }
=20
+static int __devinit radeon_get_pll_info_legacy(struct radeonfb_info *rinf=
o)
+{
+	u16 pll_info_block;
+
+	if (!rinfo->bios_seg)
+		return -EINVAL;
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
+	printk(KERN_INFO "radeonfb: Retreived PLL infos from Legacy BIOS\n");
+	return 0;
+}
+
+
+static int __devinit radeon_get_pll_info_atom(struct radeonfb_info *rinfo)
+{
+	u16 pll_info_block;
+
+	if (!rinfo->bios_seg)
+		return -EINVAL;
+
+	pll_info_block =3D BIOS_IN16(rinfo->atom_data_start + 12);
+=09
+	rinfo->pll.sclk =3D BIOS_IN32(pll_info_block + 8);
+	rinfo->pll.mclk =3D BIOS_IN32(pll_info_block + 12);
+	rinfo->pll.ref_clk =3D BIOS_IN16(pll_info_block + 82);
+	rinfo->pll.ref_div =3D 0; /* Have to get it elsewhere */
+	rinfo->pll.ppll_min =3D BIOS_IN16(pll_info_block + 78);
+	rinfo->pll.ppll_max =3D BIOS_IN32(pll_info_block + 32);
+
+	printk(KERN_INFO "radeonfb: Retreived PLL infos from ATOM BIOS\n");
+	return 0;
+}
+
+static void radeon_detect_bios_type(struct radeonfb_info *rinfo)
+{
+#ifdef CONFIG_PPC_OF
+	  rinfo->is_atom_bios =3D 0;
+	  rinfo->get_pll_info =3D radeon_get_pll_info_openfirmware;
+	  rinfo->get_panel_info =3D NULL;
+	  rinfo->parse_connector_info =3D NULL;
+#else
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
+		  rinfo->radeon_get_pll_info =3D radeon_get_pll_info_atom;
+		  rinfo->radeon_get_panel_info =3D radeon_get_panel_info_atom;
+		  rinfo->radeon_parse_connector_info =3D radeon_parse_connector_info_ato=
m;
+		  printk("ATOM BIOS detected\n");
+	  } else {
+		  rinfo->is_atom_bios =3D 0;
+		  rinfo->radeon_get_pll_info =3D radeon_get_pll_info_legacy;
+		  rinfo->radeon_get_panel_info =3D radeon_get_panel_info_legacy;
+		  rinfo->radeon_parse_connector_info =3D radeon_parse_connector_info_leg=
acy;
+		  printk("Legacy BIOS detected\n");
+	  }
+#endif  /* CONFIG_PPC_OF */
+
+}
+
 /*
  * Retreive PLL infos by different means (BIOS, Open Firmware, register pr=
obing...)
  */
-static void __devinit radeon_get_pllinfo(struct radeonfb_info *rinfo)
+static void __devinit radeon_get_pll_info(struct radeonfb_info *rinfo)
 {
 	/*
 	 * In the case nothing works, these are defaults; they are mostly
@@ -655,39 +735,18 @@
 		rinfo->pll.ref_clk =3D 2700;
 		break;
 	}
-	rinfo->pll.ref_div =3D INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK;
-
-
-#ifdef CONFIG_PPC_OF
-	/*
-	 * Retreive PLL infos from Open Firmware first
-	 */
-       	if (!force_measure_pll && radeon_read_xtal_OF(rinfo) =3D=3D 0) {
-       		printk(KERN_INFO "radeonfb: Retreived PLL infos from Open Firmwar=
e\n");
-		goto found;
-	}
-#endif /* CONFIG_PPC_OF */
=20
 	/*
-	 * Check out if we have an X86 which gave us some PLL informations
-	 * and if yes, retreive them
+	 * If we have a way to retrieve the PLL information, do so.
 	 */
-	if (!force_measure_pll && rinfo->bios_seg) {
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
+	if (!force_measure_pll && rinfo->radeon_get_pll_info) {
+		if (!rinfo->radeon_get_pll_info(rinfo)) {
+			goto found;
+		}
 	}
=20
 	/*
-	 * We didn't get PLL parameters from either OF or BIOS, we try to
+	 * If we don't get the PLL parameters handed to us, we try to
 	 * probe them
 	 */
 	if (radeon_probe_pll_params(rinfo) =3D=3D 0) {
@@ -701,6 +760,22 @@
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
@@ -2412,6 +2487,7 @@
 	 * We probably need to make sure this is the primary display,
 	 * but that is difficult without some arch support.
 	 */
+
 #ifdef CONFIG_X86
 	if (rinfo->bios_seg =3D=3D NULL)
 		radeon_find_mem_vbios(rinfo);
@@ -2423,8 +2499,11 @@
 	if (rinfo->bios_seg =3D=3D NULL && rinfo->is_mobility)
 		radeon_map_ROM(rinfo, pdev);
=20
+	/* Check BIOS Type */
+	radeon_detect_bios_type(rinfo);
+=09
 	/* Get informations about the board's PLL */
-	radeon_get_pllinfo(rinfo);
+	radeon_get_pll_info(rinfo);
=20
 #ifdef CONFIG_FB_RADEON_I2C
 	/* Register I2C bus */
diff -aur aty-2.6.15/radeon_monitor.c aty/radeon_monitor.c
--- aty-2.6.15/radeon_monitor.c	2006-02-22 23:28:14.000000000 -0500
+++ aty/radeon_monitor.c	2006-02-23 00:43:15.000000000 -0500
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
@@ -235,57 +280,314 @@
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
 }
=20
+int __devinit radeon_parse_connector_info_atom(struct radeonfb_info *rinfo)
+{
+#if 0
+	int i, j, offset, valids;
+	int crtc =3D 0, ids[RADEON_MAX_CONNECTORS];
+	u16 portinfo;
+	int additional =3D 2;
+	int ddc_type, dac_type, conn_type, tmds_type, port_id;
+=09
+	offset =3D BIOS_IN16(rinfo->atom_data_start + 22);
+	if (offset =3D=3D 0)
+		return -ENODEV;
+
+	/* Again, I slightly modified X.org algorithm. I assign "primary" outputs
+	 * to entries 0 and 1, and anything else goes after 2.
+	 *
+	 * Also, I keep an array of all port IDs matching connectors[] array,
+	 * unlike X which limits itself to "crtc"'s
+	 */
+	for (i =3D 0; i < RADEON_MAX_CONNECTORS; i++)
+		ids[i] =3D -1;
+
+	valids =3D BIOS_IN16(offset + 4);
+	for (i =3D 0; i < 8; i++) {
+		if (!(valids & (1 << i)))
+			continue;
+		portinfo =3D BIOS_IN16(offset + 6 + i*2);
+
+		conn_type =3D (portinfo >> 4) & 0xf;
+		dac_type =3D (portinfo & 0xf) - 1;
+		// XXX ddc_type =3D
+		if (i =3D=3D 3)
+			tmds_type =3D tmds_internal;
+		else if (i =3D=3D 7)
+			tmds_type =3D tmds_external;
+		else
+			tmds_type =3D tmds_unknown;
+		port_id =3D (portinfo >> 8) & 0xf;
+
+		/* Ok, now we have the port ID, look for an existing port
+		 * already using this ID
+		 */
+		for (j =3D 0; j < RADEON_MAX_CONNECTORS; j++) {
+			if (port_id !=3D ids[j])
+				continue;
+			/* Gotcha, just "update" values */
+			if (tmds_type !=3D tmds_unknown)
+				rinfo->connectors[j].tmds_type =3D tmds_type;
+			if (rinfo->connectors[j].dac_type =3D=3D dac_unknown)
+				rinfo->connectors[j].dac_type =3D dac_type;
+			goto next;
+		}
+	=09
+		if (crtc < 2) {
+			/* FIXME: ignore TV here */
+			if ((i=3D=3D2) || (i=3D=3D6)) continue;
+
+			if (crtc =3D=3D 1) {
+			    /* sharing same port with id[0] */
+			    if (((portinfo>>8) & 0xf) =3D=3D ids[0]) {
+				if (i =3D=3D 3)
+				    pRADEONEnt->PortInfo[0].TMDSType =3D TMDS_INT;
+				else if (i =3D=3D 7)
+				    pRADEONEnt->PortInfo[0].TMDSType =3D TMDS_EXT;
+
+				if (pRADEONEnt->PortInfo[0].DACType =3D=3D DAC_UNKNOWN)
+				    pRADEONEnt->PortInfo[0].DACType =3D (portinfo & 0xf) - 1;
+				continue;
+			    }
+			}
+
+			id[crtc] =3D (portinfo>>8) & 0xf;
+			pRADEONEnt->PortInfo[crtc].DACType =3D (portinfo & 0xf) - 1;
+			pRADEONEnt->PortInfo[crtc].ConnectorType =3D (portinfo>>4) & 0xf;
+			if (i =3D=3D 3)
+			    pRADEONEnt->PortInfo[crtc].TMDSType =3D TMDS_INT;
+			else if (i =3D=3D 7)
+			    pRADEONEnt->PortInfo[crtc].TMDSType =3D TMDS_EXT;
+
+			if((tmp0 =3D RADEON_BIOS16 (info->MasterDataStart + 24)) && id[crtc]) {
+			    switch (RADEON_BIOS16 (tmp0 + 4 + 27 * id[crtc]) * 4)
+			    {
+			    case RADEON_GPIO_MONID:
+				pRADEONEnt->PortInfo[crtc].DDCType =3D DDC_MONID;
+				break;
+			    case RADEON_GPIO_DVI_DDC:
+				pRADEONEnt->PortInfo[crtc].DDCType =3D DDC_DVI;
+				break;
+			    case RADEON_GPIO_VGA_DDC:
+				pRADEONEnt->PortInfo[crtc].DDCType =3D DDC_VGA;
+				break;
+			    case RADEON_GPIO_CRT2_DDC:
+				pRADEONEnt->PortInfo[crtc].DDCType =3D DDC_CRT2;
+				break;
+			    default:
+				pRADEONEnt->PortInfo[crtc].DDCType =3D DDC_NONE;
+				break;
+			    }
+
+			} else {
+			    pRADEONEnt->PortInfo[crtc].DDCType =3D DDC_NONE;
+			}
+			crtc++;
+		    } else {
+			/* we have already had two CRTCs assigned. the rest may share the same
+			 * port with the existing connector, fill in them accordingly.
+			 */
+			for (j=3D0; j<2; j++) {
+				if (((portinfo>>8) & 0xf) =3D=3D id[j]) {
+					if (i =3D=3D 3)
+						pRADEONEnt->PortInfo[j].TMDSType =3D TMDS_INT;
+					else if (i =3D=3D 7)
+						pRADEONEnt->PortInfo[j].TMDSType =3D TMDS_EXT;
+				=09
+					if (pRADEONEnt->PortInfo[j].DACType =3D=3D DAC_UNKNOWN)
+						pRADEONEnt->PortInfo[j].DACType =3D (portinfo & 0xf) - 1;
+				}
+			}
+		}
+	}
+=09
+
+	for (i=3D0; i<2; i++) {
+		xf86DrvMsg(pScrn->scrnIndex, X_INFO, "Port%d: DDCType-%d, DACType-%d, TM=
DSType-%d, ConnectorType-%d\n",
+			   i, pRADEONEnt->PortInfo[i].DDCType, pRADEONEnt->PortInfo[i].DACType,
+			   pRADEONEnt->PortInfo[i].TMDSType, pRADEONEnt->PortInfo[i].ConnectorT=
ype);
+	}
+
+#else
+	return -1;
+#endif
+}
+
 /* Try to extract the connector informations from the BIOS. This
  * doesn't quite work yet, but it's output is still useful for
  * debugging
  */
-static void __devinit radeon_parse_connector_info(struct radeonfb_info *ri=
nfo)
+int __devinit radeon_parse_connector_info_legacy(struct radeonfb_info *rin=
fo)
 {
-	int offset, chips, connectors, tmp, i, conn, type;
-
-	static char* __conn_type_table[16] =3D {
-		"NONE", "Proprietary", "CRT", "DVI-I", "DVI-D", "Unknown", "Unknown",
-		"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown",
-		"Unknown", "Unknown", "Unknown"
+	int offset, i, entry, tmp;
+	int ddc_type, dac_type, conn_type, tmds_type;
+	int conn_index =3D 0;
+	int conn_add =3D 2;
+	int idx =3D 0;
+
+	/* Convert legacy to real connector types */
+	const enum radeon_conn_type legacy_conn_to_type[] =3D {
+		conn_none,
+		conn_proprietary,
+		conn_vga,
+		conn_dvi_i,
+		conn_dvi_d,
+		conn_ctv,
+		conn_stv,
+		conn_unsupported,
 	};
=20
-	if (!rinfo->bios_seg)
-		return;
+	/* Some laptops only have one connector (VGA) listed in the connector
+	 * table, we need to add LVDS in as a non-DDC display.
+	 * Note, we can't assume the listed VGA will be filled in PortInfo[0],
+	 * when walking through connector table. connector_found has following
+	 * meaning:
+	 * 0 -- nothing found,
+	 * 1 -- only connectors[0] filled,
+	 * 2 -- only connectors[1] filled,
+	 * 3 -- both are filled.
+	 *
+	 * Note: I modified X.org algorithm to add additional entries if any
+	 * after the second table slot. Those entries do not affect the value
+	 * of connector_found. --BenH.
+	 */
+	int connector_found =3D 0;
=20
 	offset =3D BIOS_IN16(rinfo->fp_bios_start + 0x50);
-	if (offset =3D=3D 0) {
-		printk(KERN_WARNING "radeonfb: No connector info table detected\n");
-		return;
-	}
+	if (offset =3D=3D 0)
+		return -ENODEV;
=20
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
+	for (i =3D 1; i < 4; i++) {
+		entry =3D offset + i*2;
+
+		/* End of table */
+		if (!BIOS_IN8(entry) && i > 1)
+			break;
+
+		/* Read table entry, check connector type */
+		tmp =3D BIOS_IN16(entry);
+		conn_type =3D (tmp >> 12) & 0xf;
+		if (conn_type =3D=3D legacy_conn_none)
+			continue;
+		ddc_type =3D (tmp >> 8) & 0xf;
+		dac_type =3D (tmp & 0x01) ? dac_tvdac : dac_primary;
+		tmds_type =3D (tmp & 0x10) ? tmds_external : tmds_internal;
+
+		/* same connector */
+		if (connector_found > 0) {
+			if (rinfo->connectors[conn_index].ddc_type =3D=3D ddc_type)
+				continue;
 		}
+
+		/* sanity checks */
+		if (ddc_type > ddc_crt2)
+			ddc_type =3D ddc_none;
+		if (conn_type > legacy_conn_unsupported)
+			conn_type =3D legacy_conn_unsupported;
+		if (conn_type !=3D legacy_conn_dvi_d &&
+		    conn_type !=3D legacy_conn_dvi_i &&
+		    tmds_type =3D=3D tmds_internal)
+			tmds_type=3D tmds_unknown;
+
+		/* convert connector type */
+		conn_type =3D legacy_conn_to_type[conn_type];
+
+		/* internal DDC_DVI port will get assigned to connector[0], or
+		 * if there is no DDC_DVI (like in some IGPs).
+		 */
+		conn_index =3D (ddc_type =3D=3D ddc_dvi || conn_index =3D=3D 1) ? 0 : 1;
+
+		/* if the port is a TV port, or both connectors are already
+		 * assigned, assign it after further in the table
+		 */
+		if (conn_type =3D=3D conn_ctv || conn_type =3D=3D conn_stv ||
+		    (rinfo->connectors[0].conn_type !=3D conn_none &&
+		     rinfo->connectors[1].conn_type))
+			idx =3D conn_add++;
+		else
+			idx =3D conn_index;
+
+		/* if table full, exit */
+		if (idx >=3D RADEON_MAX_CONNECTORS) {
+			printk(KERN_WARNING "radeonfb: Connector table full !\n");
+			break;
+		}
+		rinfo->connectors[idx].conn_type	=3D conn_type;
+		rinfo->connectors[idx].ddc_type		=3D ddc_type;
+		rinfo->connectors[idx].dac_type		=3D dac_type;
+		rinfo->connectors[idx].tmds_type	=3D tmds_type;
+
+		/* increment connector_found for primary connectors only */
+		if (idx < 2)
+			connector_found +=3D (idx + 1);
+	}
+
+	if (rinfo->is_mobility) {
+	    /* For the cases where only one VGA connector is found,
+	     * we assume LVDS is not listed in the connector table,
+	     * add it in here as the first port.
+	     *
+	     * TODO: Check what's up with laptops that have a DVI output
+	     * and no LVDS entry in the table. I suspect some thinkpads
+	     * may play trick with us here... We may want to check the
+	     * presence of a panel via LVDS_GEN_CNTL to be sure...
+	     */
+	    if ((connector_found < 3) &&
+		(rinfo->connectors[idx].conn_type =3D=3D conn_vga)) {
+		    if (connector_found =3D=3D 1) {
+			    memcpy(&rinfo->connectors[1],
+				   &rinfo->connectors[0],
+				   sizeof(struct radeon_connector));
+		    }
+		    /* Fixme: TV DAC is probably elsewhere ... */
+		    rinfo->connectors[0].dac_type =3D dac_tvdac;
+		    rinfo->connectors[0].tmds_type =3D tmds_unknown;
+		    rinfo->connectors[0].ddc_type =3D ddc_none;
+		    rinfo->connectors[0].conn_type =3D conn_proprietary;
+
+		    printk(KERN_WARNING "radeonfb: LVDS port is not in connector table, =
added in.\n");
+		    if (connector_found =3D=3D 0)
+			    connector_found =3D 1;
+		    else
+			    connector_found =3D 3;
+	    }
+
+	    /* Check for LCD DDC info table */
+	    if ((offset =3D BIOS_IN16(rinfo->fp_bios_start + 0x42))) {
+		    if ((tmp =3D BIOS_IN16(offset + 0x15))) {
+			    if ((ddc_type =3D BIOS_IN8(tmp+2) & 0x07)) {
+				    rinfo->connectors[0].ddc_type =3D ddc_type;
+				    printk(KERN_WARNING "radeonfb: LCD DDC Info Table found, "
+						"forcing primary port to %d\n",
+						ddc_type);
+			    }
+		    }
+	    }
+	} else if (connector_found =3D=3D 2) {
+		memcpy(&rinfo->connectors[0], &rinfo->connectors[1],
+			sizeof (struct radeon_connector));
+		rinfo->connectors[1].dac_type =3D dac_unknown;
+		rinfo->connectors[1].tmds_type =3D tmds_unknown;
+		rinfo->connectors[1].ddc_type =3D ddc_none;
+		rinfo->connectors[1].conn_type =3D conn_none;
+		connector_found =3D 1;
 	}
+
+	if (connector_found =3D=3D 0)
+		return -ENODEV;
+
+	/* External TMDS Table, not used now */
+	return 0;
 }
=20
=20
@@ -434,7 +736,9 @@
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
@@ -519,7 +823,8 @@
 		/*
 		 * Check for cards with reversed DACs or TMDS controllers using BIOS
 		 */
-		if (rinfo->bios_seg &&
+
+		if (rinfo->bios_seg && !rinfo->is_atom_bios &&
 		    (tmp =3D BIOS_IN16(rinfo->fp_bios_start + 0x50))) {
 			for (i =3D 1; i < 4; i++) {
 				unsigned int tmp0;
@@ -741,8 +1046,12 @@
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
--- aty-2.6.15/radeonfb.h	2006-02-22 23:28:14.000000000 -0500
+++ aty/radeonfb.h	2006-02-23 00:42:59.000000000 -0500
@@ -91,7 +91,7 @@
 /*
  * Monitor types
  */
-enum radeon_montype {
+enum radeon_mon_type {
 	MT_NONE =3D 0,
 	MT_CRT,		/* CRT */
 	MT_LCD,		/* LCD */
@@ -103,7 +103,7 @@
 /*
  * DDC i2c ports
  */
-enum ddc_type {
+enum radeon_ddc_type {
 	ddc_none,
 	ddc_monid,
 	ddc_dvi,
@@ -114,14 +114,69 @@
 /*
  * Connector types
  */
-enum conn_type {
-	conn_none,
-	conn_proprietary,
-	conn_crt,
-	conn_DVI_I,
-	conn_DVI_D,
+enum radeon_legacy_conn_type {
+	legacy_conn_none =3D 0,
+	legacy_conn_proprietary,
+	legacy_conn_crt,
+	legacy_conn_dvi_i,
+	legacy_conn_dvi_d,
+	legacy_conn_ctv,
+	legacy_conn_stv,
+	legacy_conn_unsupported,
 };
=20
+enum radeon_conn_type {
+	conn_none =3D 0,
+	conn_vga,
+	conn_dvi_i,
+	conn_dvi_d,
+	conn_dvi_a,
+	conn_stv,
+	conn_ctv,
+	conn_lvds,
+	conn_digital,
+	conn_unsupported,
+	conn_proprietary
+};
+
+/*
+ * DAC types
+ */
+enum radeon_dac_type {
+	dac_unknown =3D -1,
+	dac_primary =3D 0,
+	dac_tvdac =3D 1,
+};
+
+/*
+ * TMDS types
+ */
+enum radeon_tmds_type {
+	tmds_unknown =3D -1,
+	tmds_internal =3D 0,
+	tmds_external =3D 1,
+};
+
+/*
+ * Each connector gets this structure associated with it,
+ * containing infos about the connector wiring and about
+ * whatever has been detected on it
+ */
+struct radeon_connector {
+	enum radeon_conn_type	conn_type;
+	enum radeon_ddc_type	ddc_type;
+	enum radeon_dac_type	dac_type;
+	enum radeon_tmds_type	tmds_type;
+	enum radeon_mon_type	mon_type;
+	u8			*edid;
+	struct fb_videomode	*modedb;
+	unsigned int		modedb_size;
+};
+
+/*
+ * Currently, the driver deals with at most 4 connectors
+ */
+#define RADEON_MAX_CONNECTORS	4
=20
 /*
  * PLL infos
@@ -129,11 +184,19 @@
 struct pll_info {
 	int ppll_max;
 	int ppll_min;
-	int sclk, mclk;
+	int sclk;
+	int mclk;
 	int ref_div;
 	int ref_clk;
 };
=20
+/*
+ * TMDS PLL infos
+ */
+struct radeon_tmds_pll_info {
+	long	freq;
+	u32	value;
+};
=20
 /*
  * This structure contains the various registers manipulated by this
@@ -298,6 +361,18 @@
 	void __iomem		*bios_seg;
 	int			fp_bios_start;
=20
+	int                     is_atom_bios;
+	int                     atom_data_start;
+=09
+	int                     (*radeon_get_pll_info)(struct radeonfb_info *rinf=
o);
+	int                     (*radeon_get_panel_info)(struct radeonfb_info *ri=
nfo);
+	int                     (*radeon_parse_connector_info)(struct radeonfb_in=
fo *rinfo);
+
+
+	/* Connector infos */
+	int				conn_count;
+	struct radeon_connector		connectors[RADEON_MAX_CONNECTORS];
+
 	u32			pseudo_palette[17];
 	struct { u8 red, green, blue, pad; }
 				palette[256];
@@ -625,4 +700,11 @@
 extern void radeon_write_mode (struct radeonfb_info *rinfo, struct radeon_=
regs *mode,
 			       int reg_only);
=20
+/* Bios functions.  Fix this. */
+extern int __devinit radeon_get_panel_info_atom(struct radeonfb_info *rinf=
o);
+extern int __devinit radeon_get_panel_info_legacy(struct radeonfb_info *ri=
nfo);
+int __devinit radeon_parse_connector_info_legacy(struct radeonfb_info *rin=
fo);
+int __devinit radeon_parse_connector_info_atom(struct radeonfb_info *rinfo=
);
+
+
 #endif /* __RADEONFB_H__ */

--GvXjxJ+pjyke8COw--

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFD/VGjPuLgii2759ARAhh1AKCDG+pRRT9irmxBvPQNLyAER29mggCeOvdR
L2Ou/de6aZ5Ys+ZrOgX9WJA=
=VA3P
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
