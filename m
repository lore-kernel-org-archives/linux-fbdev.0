From: Stuffed Crust <pizza@shaftnet.org>
Subject: [patch] [radeonfb] Radeon M26 and ATOM bios support (take 4)
Date: Thu, 23 Feb 2006 17:36:19 -0500
Message-ID: <20060223223619.GA14458@shaftnet.org>
References: <20060103204404.GA23313@shaftnet.org> <1139952530.7903.31.camel@localhost.localdomain> <20060222221916.GB17359@shaftnet.org> <20060223060939.GA27224@shaftnet.org> <1140677458.8264.24.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCP4k-0003hY-UU
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 14:36:42 -0800
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86] helo=shaft.shaftnet.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FCP4i-0001jL-JY
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 14:36:43 -0800
Content-Disposition: inline
In-Reply-To: <1140677458.8264.24.camel@localhost.localdomain>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


--ctP54qlpMx3WjD+/
Content-Type: multipart/mixed; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2006 at 05:50:58PM +1100, Benjamin Herrenschmidt wrote:
> >From your comments, you sound on the right track. I haven't had time to
> review the patches yet but I'll do asap, I'm very happy somebody is
> tackling those issues :)

Fourth pass.  This patch supercedes the previous, and adds:

 * ATOM BIOS support for connector detection
 * TMDS parsing for both ATOM and Legacy BIOSes. =20
 * Additional PCI IDs forall known M26 variants
 * Default PLL clocks for R420 family

I've tested this patch out on my laptop's ATOM X700/M26/RV410, and on a
dualhead Legacy 7500/RV200 add-in card.  All heads, tables, etc were
detected properly.=20
=20
It doesn't do anything with this new connector data other than=20
to report it.  Integrating this stuff with the existing monitor detection
logic comes next, using the rinfo->connectors table instead of the=20
rinfo->mon[12]_type stuff.   (at the very least, we shouldn't look for=20
something plugged into a non-existant head...)

And of course, OpenFirmware integration, and doing something with the=20
TMDS PLL information.=20

I'm unsure how to best to proceed from here, so this patch is it until=20
I get some more directed feedback. =20

Signed-Off-By:  Solomon Peachy <pizza@shaftnet.org>

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL
Quidquid latine dictum sit, altum viditur.

--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radeon-atom-4.diff"
Content-Transfer-Encoding: quoted-printable

diff -aur aty-2.6.15/ati_ids.h aty/ati_ids.h
--- aty-2.6.15/ati_ids.h	2006-02-22 23:28:14.000000000 -0500
+++ aty/ati_ids.h	2006-02-23 15:32:21.000000000 -0500
@@ -185,6 +185,10 @@
 #define PCI_CHIP_R423_UQ                0x5551
 #define PCI_CHIP_R423_UR                0x5552
 #define PCI_CHIP_R423_UT                0x5554
+#define PCI_CHIP_RV410_564B             0x564A
+#define PCI_CHIP_RV410_564A             0x564B
+#define PCI_CHIP_RV410_5652             0x5652
+#define PCI_CHIP_RV410_VS               0x5653
 #define PCI_CHIP_MACH64VT		0x5654
 #define PCI_CHIP_MACH64VU		0x5655
 #define PCI_CHIP_MACH64VV		0x5656
Only in aty-2.6.15: radeon-atom-bios2.diff
Only in aty-2.6.15: radeon_atom_bios.diff
diff -aur aty-2.6.15/radeon_base.c aty/radeon_base.c
--- aty-2.6.15/radeon_base.c	2006-02-22 23:28:14.000000000 -0500
+++ aty/radeon_base.c	2006-02-23 15:41:35.000000000 -0500
@@ -214,6 +214,10 @@
 	CHIP_DEF(PCI_CHIP_R420_JL,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JM,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JN,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_564A,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_564B,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_5652,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VS,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
 	CHIP_DEF(PCI_CHIP_R420_JP,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UH,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UI,	R420,	CHIP_HAS_CRTC2),
@@ -342,7 +346,7 @@
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
@@ -428,7 +432,7 @@
  * Read XTAL (ref clock), SCLK and MCLK from Open Firmware device
  * tree. Hopefully, ATI OF driver is kind enough to fill these
  */
-static int __devinit radeon_read_xtal_OF (struct radeonfb_info *rinfo)
+static int __devinit radeon_get_pll_info_openfirmware (struct radeonfb_inf=
o *rinfo)
 {
 	struct device_node *dp =3D rinfo->of_node;
 	u32 *val;
@@ -451,6 +455,7 @@
 	if (val && *val)
 		rinfo->pll.mclk =3D (*val) / 10;
=20
+	printk(KERN_INFO "radeonfb: Retreived PLL infos from Open Firmware\n");
        	return 0;
 }
 #endif /* CONFIG_PPC_OF */
@@ -593,10 +598,90 @@
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
+	  rinfo->get_lvds_info =3D NULL;
+	  rinfo->get_conn_info =3D NULL;
+	  printk("radeonfb:  Using OpenFirmware tables\n");
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
+		  rinfo->radeon_get_lvds_info =3D radeon_get_lvds_info_atom;
+		  rinfo->radeon_get_conn_info =3D radeon_get_conn_info_atom;
+		  rinfo->radeon_get_tmds_info =3D radeon_get_tmds_info_atom;
+		  printk("radeonfb:  Using ATOM BIOS tables\n");
+	  } else {
+		  rinfo->is_atom_bios =3D 0;
+		  rinfo->radeon_get_pll_info =3D radeon_get_pll_info_legacy;
+		  rinfo->radeon_get_lvds_info =3D radeon_get_lvds_info_legacy;
+		  rinfo->radeon_get_conn_info =3D radeon_get_conn_info_legacy;
+		  rinfo->radeon_get_tmds_info =3D radeon_get_tmds_info_legacy;
+		  printk("radeonfb:  Using Legacy BIOS tables\n");
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
@@ -648,46 +733,30 @@
 	case PCI_DEVICE_ID_ATI_RADEON_QF:
 	case PCI_DEVICE_ID_ATI_RADEON_QG:
 	default:
-		rinfo->pll.ppll_max =3D 35000;
-		rinfo->pll.ppll_min =3D 12000;
+		if (rinfo->family =3D=3D CHIP_FAMILY_R420) {
+			rinfo->pll.ppll_max =3D 50000;
+			rinfo->pll.ppll_min =3D 20000;
+		} else {
+			rinfo->pll.ppll_max =3D 35000;
+			rinfo->pll.ppll_min =3D 12000;
+		}
 		rinfo->pll.mclk =3D 16600;
 		rinfo->pll.sclk =3D 16600;
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
@@ -701,6 +770,22 @@
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
@@ -2412,6 +2497,7 @@
 	 * We probably need to make sure this is the primary display,
 	 * but that is difficult without some arch support.
 	 */
+
 #ifdef CONFIG_X86
 	if (rinfo->bios_seg =3D=3D NULL)
 		radeon_find_mem_vbios(rinfo);
@@ -2423,8 +2509,17 @@
 	if (rinfo->bios_seg =3D=3D NULL && rinfo->is_mobility)
 		radeon_map_ROM(rinfo, pdev);
=20
+	/* Check BIOS Type */
+	radeon_detect_bios_type(rinfo);
+=09
 	/* Get informations about the board's PLL */
-	radeon_get_pllinfo(rinfo);
+	radeon_get_pll_info(rinfo);
+
+	/* Get informations about internal TMDS controller if any */
+	radeon_get_tmds_info(rinfo);
+
+	/* Get infos about connectors */
+	radeon_get_conn_info(rinfo);
=20
 #ifdef CONFIG_FB_RADEON_I2C
 	/* Register I2C bus */
diff -aur aty-2.6.15/radeon_monitor.c aty/radeon_monitor.c
--- aty-2.6.15/radeon_monitor.c	2006-02-22 23:28:14.000000000 -0500
+++ aty/radeon_monitor.c	2006-02-23 15:06:41.000000000 -0500
@@ -1,6 +1,29 @@
 #include "radeonfb.h"
 #include "../edid.h"
=20
+/*
+ * TMDS PLL configuration table, taken from X.org
+ */
+static const struct radeon_tmds_pll_info default_tmds_pll[CHIP_FAMILY_LAST=
][4] =3D
+{
+    {{0, 0}, {0, 0}, {0, 0}, {0, 0}},				/*CHIP_FAMILY_UNKNOW*/
+    {{0, 0}, {0, 0}, {0, 0}, {0, 0}},				/*CHIP_FAMILY_LEGACY*/
+    {{12000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_R=
ADEON*/
+    {{12000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_R=
V100*/
+    {{0, 0}, {0, 0}, {0, 0}, {0, 0}},				/*CHIP_FAMILY_RS100*/
+    {{15000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_R=
V200*/
+    {{12000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_R=
S200*/
+    {{15000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_R=
200*/
+    {{15500, 0x81b}, {0xffffffff, 0x83f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_R=
V250*/
+    {{0, 0}, {0, 0}, {0, 0}, {0, 0}},				/*CHIP_FAMILY_RS300*/
+    {{13000, 0x400f4}, {15000, 0x400f7}, {0xffffffff, 0x400f7/*0x40111*/},=
 {0, 0}},	/*CHIP_FAMILY_RV280*/
+    {{0xffffffff, 0xb01cb}, {0, 0}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R300*/
+    {{0xffffffff, 0xb01cb}, {0, 0}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R350*/
+    {{15000, 0xb0155}, {0xffffffff, 0xb01cb}, {0, 0}, {0, 0}},	/*CHIP_FAMI=
LY_RV350*/
+    {{15000, 0xb0155}, {0xffffffff, 0xb01cb}, {0, 0}, {0, 0}},	/*CHIP_FAMI=
LY_RV380*/
+    {{0xffffffff, 0xb01cb}, {0, 0}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R420*/
+};
+
 static struct fb_var_screeninfo radeonfb_default_var =3D {
 	.xres		=3D 640,
 	.yres		=3D 480,
@@ -160,21 +183,65 @@
 #endif /* CONFIG_PPC_OF */
=20
=20
-static int __devinit radeon_get_panel_info_BIOS(struct radeonfb_info *rinf=
o)
+int __devinit radeon_get_lvds_info_atom(struct radeonfb_info *rinfo)
+{
+	unsigned long tmp;
+
+	if (!rinfo->bios_seg)
+		return -ENODEV;
+
+	tmp =3D BIOS_IN16(rinfo->atom_data_start + 16);
+	if (!tmp) {
+		printk(KERN_ERR "radeonfb: No LVDS panel info in BIOS\n");
+		rinfo->panel_info.pwr_delay =3D 200;
+		return -ENODEV;
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
+	return 0;
+}
+
+int __devinit radeon_get_lvds_info_legacy(struct radeonfb_info *rinfo)
 {
 	unsigned long tmp, tmp0;
 	char stmp[30];
 	int i;
=20
 	if (!rinfo->bios_seg)
-		return 0;
+		return -ENODEV;
=20
 	if (!(tmp =3D BIOS_IN16(rinfo->fp_bios_start + 0x40))) {
-		printk(KERN_ERR "radeonfb: Failed to detect DFP panel info using BIOS\n"=
);
+		printk(KERN_ERR "radeonfb: No LVDS panel info in BIOS\n");
 		rinfo->panel_info.pwr_delay =3D 200;
-		return 0;
+		return -ENODEV;
 	}
-
+=09
 	for(i=3D0; i<24; i++)
 		stmp[i] =3D BIOS_IN8(tmp+i+1);
 	stmp[24] =3D 0;
@@ -182,13 +249,13 @@
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
@@ -203,6 +270,7 @@
 		RTRACE("post_divider =3D %x\n", rinfo->panel_info.post_divider);
 		RTRACE("fbk_divider =3D %x\n", rinfo->panel_info.fbk_divider);
 	}
+=09
 	RTRACE("Scanning BIOS table ...\n");
 	for(i=3D0; i<32; i++) {
 		tmp0 =3D BIOS_IN16(tmp+64+i*2);
@@ -226,7 +294,7 @@
 			rinfo->panel_info.vAct_high =3D 1;
 			/* Mark panel infos valid */
 			rinfo->panel_info.valid =3D 1;
-
+		=09
 			RTRACE("Found panel in BIOS table:\n");
 			RTRACE("  hblank: %d\n", rinfo->panel_info.hblank);
 			RTRACE("  hOver_plus: %d\n", rinfo->panel_info.hOver_plus);
@@ -235,57 +303,507 @@
 			RTRACE("  vOver_plus: %d\n", rinfo->panel_info.vOver_plus);
 			RTRACE("  vSync_width: %d\n", rinfo->panel_info.vSync_width);
 			RTRACE("  clock: %d\n", rinfo->panel_info.clock);
-			=09
-			return 1;
+		=09
+			return 0;
 		}
 	}
+
 	RTRACE("Didn't find panel in BIOS table !\n");
=20
+	return -ENODEV;
+}
+
+/*
+ * Get informations about TMDS controllers and their setup at
+ * different operating frequencies
+ */
+void __devinit radeon_get_tmds_info(struct radeonfb_info *rinfo)
+{
+	int i;
+
+	/* Get default TMDS infos for this chip */
+	for (i=3D0; i<4; i++) {
+		rinfo->tmds_pll[i].value =3D
+			default_tmds_pll[rinfo->family][i].value;
+		rinfo->tmds_pll[i].freq =3D
+			default_tmds_pll[rinfo->family][i].freq;
+	}
+
+	/* Get whatever the firmware provides */
+	if (rinfo->radeon_get_tmds_info) {
+		rinfo->radeon_get_tmds_info(rinfo);
+		// XXX Do we care about the return value?
+	}
+}
+
+int __devinit radeon_get_tmds_info_legacy(struct radeonfb_info *rinfo)
+{
+	int offset, i, n, rev;
+
+	offset =3D BIOS_IN16(rinfo->fp_bios_start + 0x34);
+	if (offset =3D=3D 0)
+		return -ENODEV;
+
+	rev =3D BIOS_IN8(offset);
+	printk(KERN_INFO "DFP table revision: %d\n", rev);
+
+	switch(rev) {
+	case 3:
+		n =3D BIOS_IN8(offset + 5) + 1;
+		if (n > 4)
+			n =3D 4;
+		for (i =3D 0; i < n; i++) {
+			/* Looks bogus ... but that's what is in X.org */
+			rinfo->tmds_pll[i].value =3D
+				BIOS_IN32(offset+i*10+0x08);
+			rinfo->tmds_pll[i].freq =3D
+				BIOS_IN16(offset+i*10+0x10);
+		}
+		return 0;
+
+	/* revision 4 has some problem as it appears in RV280,
+	 * comment it off for now, use default instead
+	 */
+#if 0
+	case 4:
+		stride =3D 0;
+		n =3D BIOS_IN8(offset  5) + 1;
+		if (n > 4)
+			n =3D 4;
+		for (i =3D 0; i < n; i++) {
+			rinfo->tmds_pll[i].value =3D
+				BIOS_IN32(tmp+stride+0x08);
+			rinfo->tmds_pll[i].freq =3D
+				BIOS_IN16(tmp+stride+0x10);
+			if (i =3D=3D 0)
+				stride +=3D 10;
+			else
+				stride +=3D 6;
+		}
+		return 0;
+#endif
+	}
+	return -ENODEV;
+}
+
+int __devinit radeon_get_tmds_info_atom(struct radeonfb_info *rinfo)
+{
+	int offset, i, maxfreq;
+
+	offset =3D BIOS_IN16(rinfo->atom_data_start + 18);
+	if (offset =3D=3D 0)
+		return -ENODEV;
+
+	maxfreq =3D BIOS_IN16(offset + 4);
+
+	for (i =3D 0; i < 4; i++) {
+		rinfo->tmds_pll[i].freq =3D BIOS_IN16(offset+i*6+6);
+		/* This assumes each field in TMDS_PLL has 6 bit as
+		 * in R300/R420
+		 */
+		rinfo->tmds_pll[i].value =3D
+			((BIOS_IN8(offset+i*6+8) & 0x3f) |
+			 ((BIOS_IN8(offset+i*6+10) & 0x3f)<<6) |
+			 ((BIOS_IN8(offset+i*6+9) & 0xf)<<12) |
+			 ((BIOS_IN8(offset+i*6+11) & 0xf)<<16));
+		printk(KERN_INFO "TMDS PLL from BIOS: %ld %x\n",
+			   rinfo->tmds_pll[i].freq, rinfo->tmds_pll[i].value);
+
+		if (maxfreq =3D=3D rinfo->tmds_pll[i].freq) {
+		    rinfo->tmds_pll[i].freq =3D 0xffffffff;
+		    break;
+		}
+	}
 	return 0;
 }
=20
-/* Try to extract the connector informations from the BIOS. This
- * doesn't quite work yet, but it's output is still useful for
- * debugging
+
+/*
+ * Get informations about the various connectors on this card. This is
+ * the most prone to fail function as various firmwares tend to say
+ * crap or not give any info at all. The Open Firmware version is just
+ * a table of known cards for now for example. We'll probably need some
+ * additional module params to force different settings in case of
+ * misdetection here.
+ *
+ * This doesn _not_ try actual probing of whatever is plugged on those
+ * various connectors. This will be done later. We do store whatever
+ * probing info the firmware gives us though
  */
-static void __devinit radeon_parse_connector_info(struct radeonfb_info *ri=
nfo)
+void __devinit radeon_get_conn_info(struct radeonfb_info *rinfo)
 {
-	int offset, chips, connectors, tmp, i, conn, type;
+	int i;
=20
-	static char* __conn_type_table[16] =3D {
-		"NONE", "Proprietary", "CRT", "DVI-I", "DVI-D", "Unknown", "Unknown",
-		"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown",
-		"Unknown", "Unknown", "Unknown"
+	const char *conn_type_name[] =3D {
+		"NONE", "VGA", "DVI-I", "DVI-D", "DVI-A", "S-Video",
+		"Composite Video", "Internal Panel", "Digital",
+		"Unsupported", "Proprietary"
+	};
+	const char *mon_type_name[] =3D {
+		"None", "CRT", "LVDS Flat panel",
+		"DVI Flat panel", "Composite TV", "S-Video TV"
 	};
=20
-	if (!rinfo->bios_seg)
-		return;
+	/* Clear table */
+	for (i =3D 0; i < RADEON_MAX_CONNECTORS; i++) {
+		rinfo->connectors[i].conn_type	=3D conn_none;
+		rinfo->connectors[i].ddc_type	=3D ddc_none;
+		rinfo->connectors[i].dac_type	=3D dac_unknown;
+		rinfo->connectors[i].tmds_type	=3D tmds_unknown;
+		rinfo->connectors[i].mon_type	=3D MT_UNKNOWN;
+	}
=20
-	offset =3D BIOS_IN16(rinfo->fp_bios_start + 0x50);
-	if (offset =3D=3D 0) {
-		printk(KERN_WARNING "radeonfb: No connector info table detected\n");
-		return;
+	/* Try to obtain infos from firmware */
+	if (rinfo->radeon_get_conn_info) {
+		if (!rinfo->radeon_get_conn_info(rinfo)) {
+			goto found;
+		}
+	}
+
+	printk(KERN_INFO "radeonfb: No connector infos, using defaults...\n");
+
+	/* Here, we use defaults that are common enough ... we hope
+	 * For a mobility chip, we assume LVDS is on primary
+	 */
+	if (rinfo->is_mobility) {
+		rinfo->connectors[0].conn_type	=3D conn_lvds;
+		rinfo->connectors[0].ddc_type	=3D ddc_dvi;
+		rinfo->connectors[0].dac_type	=3D dac_primary;
+		rinfo->connectors[0].tmds_type	=3D tmds_unknown;
+		rinfo->connectors[0].mon_type	=3D MT_UNKNOWN;
+
+		rinfo->connectors[1].conn_type	=3D conn_dvi_d;
+		rinfo->connectors[1].ddc_type	=3D ddc_vga;
+		rinfo->connectors[1].dac_type	=3D dac_primary;
+		rinfo->connectors[1].tmds_type	=3D tmds_internal;
+		rinfo->connectors[1].mon_type	=3D MT_UNKNOWN;
+
+		rinfo->connectors[2].conn_type	=3D conn_stv;
+		rinfo->connectors[2].ddc_type	=3D ddc_none;
+		rinfo->connectors[2].dac_type	=3D dac_tvdac;
+		rinfo->connectors[2].tmds_type	=3D tmds_unknown;
+		rinfo->connectors[2].mon_type	=3D MT_UNKNOWN;
+	} else {
+		rinfo->connectors[0].conn_type	=3D conn_dvi_d;
+		rinfo->connectors[0].ddc_type	=3D ddc_dvi;
+		rinfo->connectors[0].dac_type	=3D dac_tvdac;
+		rinfo->connectors[0].tmds_type	=3D tmds_internal;
+		rinfo->connectors[0].mon_type	=3D MT_UNKNOWN;
+
+		rinfo->connectors[1].conn_type	=3D conn_vga;
+		rinfo->connectors[1].ddc_type	=3D ddc_vga;
+		rinfo->connectors[1].dac_type	=3D dac_primary;
+		rinfo->connectors[1].tmds_type	=3D tmds_external;
+		rinfo->connectors[1].mon_type	=3D MT_UNKNOWN;
+	}
+
+ found:
+	/* Now, we do additional fixups */
+
+	/* RS300 has only one DAC, force TV-DAC on VGA port */
+	if (rinfo->family =3D=3D CHIP_FAMILY_RS300) {
+		for (i =3D 0; i < RADEON_MAX_CONNECTORS; i++) {
+			if (rinfo->connectors[i].conn_type =3D=3D conn_vga)
+				rinfo->connectors[i].dac_type =3D dac_tvdac;
+			else if (rinfo->connectors[i].dac_type !=3D dac_unknown)
+				rinfo->connectors[i].dac_type =3D dac_primary;
+		}
 	}
=20
-	/* Don't do much more at this point but displaying the data if
-	 * DEBUG is enabled
+	/* Single head chips all use primary DAC */
+	if (!rinfo->has_CRTC2)
+		rinfo->connectors[0].dac_type =3D dac_primary;
+
+	for (i =3D 0; i < RADEON_MAX_CONNECTORS; i++) {
+		if (rinfo->connectors[i].conn_type =3D=3D conn_none)
+			continue;
+		printk(KERN_INFO " * Connector %d is %s. Monitor: %s\n", i,
+		       conn_type_name[rinfo->connectors[i].conn_type],		      =20
+			rinfo->connectors[i].mon_type =3D=3D MT_UNKNOWN  ?
+				"Not Probed" :=20
+				mon_type_name[rinfo->connectors[i].mon_type]);
+		printk(KERN_INFO "   ddc port: %d, dac: %d, tmds: %d\n",
+		       rinfo->connectors[i].ddc_type,
+		       rinfo->connectors[i].dac_type,
+		       rinfo->connectors[i].tmds_type);
+	}
+	return;
+ }
+
+
+int __devinit radeon_get_conn_info_atom(struct radeonfb_info *rinfo)
+{
+	int i, j, offset, valids;
+	int ids[RADEON_MAX_CONNECTORS];
+	u16 portinfo, tmp0;
+	int conn_index =3D 0;
+	int conn_add =3D 2;
+	int idx =3D 0;
+	int ddc_type, dac_type, conn_type, tmds_type, port_id;
+	int connector_found =3D 0;
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
 	 */
-	chips =3D BIOS_IN8(offset++) >> 4;
-	RTRACE("%d chips in connector info\n", chips);
-	for (i =3D 0; i < chips; i++) {
-		tmp =3D BIOS_IN8(offset++);
-		connectors =3D tmp & 0x0f;
-		RTRACE(" - chip %d has %d connectors\n", tmp >> 4, connectors);
-		for (conn =3D 0; ; conn++) {
-			tmp =3D BIOS_IN16(offset);
-			if (tmp =3D=3D 0)
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
+		port_id =3D (portinfo >> 8) & 0xf;
+		ddc_type =3D ddc_none;
+
+		if ((tmp0 =3D BIOS_IN16(rinfo->atom_data_start + 24))) {
+			switch(BIOS_IN16(tmp0 + 4 + (27 * port_id)) * 4) {
+			case GPIO_MONID:
+				ddc_type =3D ddc_monid;
+				break;
+			case GPIO_DVI_DDC:
+				ddc_type =3D ddc_dvi;
+				break;
+			case GPIO_VGA_DDC:
+				ddc_type =3D ddc_vga;
 				break;
-			offset +=3D 2;
-			type =3D (tmp >> 12) & 0x0f;
-			RTRACE("  * connector %d of type %d (%s) : %04x\n",
-			       conn, type, __conn_type_table[type], tmp);
+			case GPIO_CRT2_DDC:
+				ddc_type =3D ddc_crt2;
+				break;
+			default:
+				ddc_type =3D ddc_none;
+				break;
+			}
+		}
+
+		if (i =3D=3D 3)
+			tmds_type =3D tmds_internal;
+		else if (i =3D=3D 7)
+			tmds_type =3D tmds_external;
+		else
+			tmds_type =3D tmds_unknown;
+
+		RTRACE("index %d port %d conn %d dac %d ddc %d tmds %d\n", i, port_id, c=
onn_type, dac_type, ddc_type, tmds_type);
+	=09
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
+			if (rinfo->connectors[j].ddc_type =3D=3D dac_unknown)
+				rinfo->connectors[j].ddc_type =3D dac_type;
+			continue;
+		}
+
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
+		rinfo->connectors[idx].tmds_type =3D tmds_type;
+		rinfo->connectors[idx].dac_type =3D dac_type;
+		rinfo->connectors[idx].ddc_type =3D ddc_type;
+		rinfo->connectors[idx].conn_type =3D conn_type;
+
+		/* increment connector_found for primary connectors only */
+		if (idx < 2)
+			connector_found +=3D (idx + 1);
+	}
+
+	if (connector_found =3D=3D 0)
+		return -ENODEV;
+
+	return 0;
+}
+
+/* Try to extract the connector informations from the BIOS. This
+ * doesn't quite work yet, but it's output is still useful for
+ * debugging
+ */
+int __devinit radeon_get_conn_info_legacy(struct radeonfb_info *rinfo)
+{
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
+	};
+
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
+
+	offset =3D BIOS_IN16(rinfo->fp_bios_start + 0x50);
+	if (offset =3D=3D 0)
+		return -ENODEV;
+
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
+		}
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
 		}
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
@@ -434,8 +952,6 @@
 #endif
 	int tmp, i;
=20
-	radeon_parse_connector_info(rinfo);
-
 	if (radeon_parse_monitor_layout(rinfo, monitor_layout)) {
=20
 		/*
@@ -445,7 +961,7 @@
 		 * a layout for each card ?
 		 */
=20
-		RTRACE("Using specified monitor layout: %s", monitor_layout);
+		RTRACE("Using specified monitor layout: %s\n", monitor_layout);
 #ifdef CONFIG_FB_RADEON_I2C
 		if (!ignore_edid) {
 			if (rinfo->mon1_type !=3D MT_NONE)
@@ -519,7 +1035,8 @@
 		/*
 		 * Check for cards with reversed DACs or TMDS controllers using BIOS
 		 */
-		if (rinfo->bios_seg &&
+
+		if (rinfo->bios_seg && !rinfo->is_atom_bios &&
 		    (tmp =3D BIOS_IN16(rinfo->fp_bios_start + 0x50))) {
 			for (i =3D 1; i < 4; i++) {
 				unsigned int tmp0;
@@ -663,7 +1180,7 @@
 		rinfo->panel_info.post_divider =3D (ppll_divn >> 16) & 0x7;
 		rinfo->panel_info.use_bios_dividers =3D 1;
=20
-		printk(KERN_DEBUG "radeonfb: Using Firmware dividers 0x%08x "
+		printk(KERN_INFO "Using Firmware dividers 0x%08x "
 		       "from PPLL %d\n",
 		       rinfo->panel_info.fbk_divider |
 		       (rinfo->panel_info.post_divider << 16),
@@ -741,8 +1258,12 @@
 	/*
 	 * First check out what BIOS has to say
 	 */
-	if (rinfo->mon1_type =3D=3D MT_LCD)
-		radeon_get_panel_info_BIOS(rinfo);
+	if (rinfo->mon1_type =3D=3D MT_LCD) {
+		if (rinfo->radeon_get_lvds_info) {
+			rinfo->radeon_get_lvds_info(rinfo);
+			// XXX Do we care about the return value?
+		}
+	}
=20
 	/*
 	 * Parse EDID detailed timings and deduce panel infos if any. Right now
diff -aur aty-2.6.15/radeonfb.h aty/radeonfb.h
--- aty-2.6.15/radeonfb.h	2006-02-22 23:28:14.000000000 -0500
+++ aty/radeonfb.h	2006-02-23 15:00:24.000000000 -0500
@@ -91,7 +91,8 @@
 /*
  * Monitor types
  */
-enum radeon_montype {
+enum radeon_mon_type {
+	MT_UNKNOWN =3D -1,
 	MT_NONE =3D 0,
 	MT_CRT,		/* CRT */
 	MT_LCD,		/* LCD */
@@ -103,8 +104,8 @@
 /*
  * DDC i2c ports
  */
-enum ddc_type {
-	ddc_none,
+enum radeon_ddc_type {
+	ddc_none =3D 0,
 	ddc_monid,
 	ddc_dvi,
 	ddc_vga,
@@ -114,14 +115,69 @@
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
@@ -129,11 +185,19 @@
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
@@ -298,6 +362,18 @@
 	void __iomem		*bios_seg;
 	int			fp_bios_start;
=20
+	int                     is_atom_bios;
+	int                     atom_data_start;
+=09
+	/* BIOS Functions */
+	int                     (*radeon_get_pll_info)(struct radeonfb_info *rinf=
o);
+	int                     (*radeon_get_lvds_info)(struct radeonfb_info *rin=
fo);
+	int                     (*radeon_get_conn_info)(struct radeonfb_info *rin=
fo);
+	int                     (*radeon_get_tmds_info)(struct radeonfb_info *rin=
fo);
+
+	/* Connector infos */
+	struct radeon_connector		connectors[RADEON_MAX_CONNECTORS];
+
 	u32			pseudo_palette[17];
 	struct { u8 red, green, blue, pad; }
 				palette[256];
@@ -319,6 +395,8 @@
 	int			reversed_DAC;
 	int			reversed_TMDS;
 	struct panel_info	panel_info;
+	struct radeon_tmds_pll_info	tmds_pll[4];
+
 	int			mon1_type;
 	u8			*mon1_EDID;
 	struct fb_videomode	*mon1_modedb;
@@ -625,4 +703,14 @@
 extern void radeon_write_mode (struct radeonfb_info *rinfo, struct radeon_=
regs *mode,
 			       int reg_only);
=20
+/* Bios functions.  Fix this. */
+extern void __devinit radeon_get_conn_info(struct radeonfb_info *rinfo);
+extern void __devinit radeon_get_tmds_info(struct radeonfb_info *rinfo);
+
+extern int __devinit radeon_get_lvds_info_atom(struct radeonfb_info *rinfo=
);
+extern int __devinit radeon_get_lvds_info_legacy(struct radeonfb_info *rin=
fo);
+extern int __devinit radeon_get_conn_info_atom(struct radeonfb_info *rinfo=
);
+extern int __devinit radeon_get_conn_info_legacy(struct radeonfb_info *rin=
fo);
+extern int __devinit radeon_get_tmds_info_legacy(struct radeonfb_info *rin=
fo);
+extern int __devinit radeon_get_tmds_info_atom(struct radeonfb_info *rinfo=
);
 #endif /* __RADEONFB_H__ */
Only in aty-2.6.15: radeonfb.ko

--kORqDWCi7qDJ0mEj--

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFD/jjjPuLgii2759ARAkqoAJ9aCytYhdT74IEcF2nc3pxkY7yCXQCg2SU6
4r6RRxEWv1/p6FGkm6kYx1k=
=C9fp
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
