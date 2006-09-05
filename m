From: Stuffed Crust <pizza@shaftnet.org>
Subject: radeonfb: Add ATOM BIOS parsing (rebased patch)
Date: Tue, 5 Sep 2006 11:37:13 -0400
Message-ID: <20060905153713.GA22789@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0513624422=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GKeNN-0002yr-OA for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Sep 2006 10:06:17 -0700
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]
	helo=shaft.shaftnet.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GKeNL-0003oD-Cw
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Sep 2006 10:06:17 -0700
Received: from shaft.shaftnet.org (localhost [127.0.0.1])
	by shaft.shaftnet.org (8.13.1/8.13.1) with ESMTP id k85FbD0b023803
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 5 Sep 2006 11:37:13 -0400
Received: (from pizza@localhost)
	by shaft.shaftnet.org (8.13.1/8.13.1/Submit) id k85FbDRO023802
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 5 Sep 2006 11:37:13 -0400
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net


--===============0513624422==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline


--HeFlAV5LIbMFYYuh
Content-Type: multipart/mixed; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-Off-By:  Solomon Peachy <pizza@shaftnet.org>

This is my old radeon-atom-5 patch rediffed against 2.6.17.x

Changes vs 2.6.17.x:

 * ATOM BIOS support for newer Radeon cards
 * Clean method of detecting and handling disparate BIOS types
 * Radeon RV410/M26/M26GL (aka Mobility X700/FireGL5000) card IDs
 * Default PLL clocks for R420 and variants
 * Handle bogus PLL divider with sane default.
 * All new connector/head detection code that uses bios/firmware
   defaults whenever possible.

=2E..

A while back I posted a patch that added full ATOM BIOS parsing for
newer radeon boards.  It also re-jiggered multi head detection to be
considerably more sane (=3D=3D actually work), and generally modularized
most of the "get data X from BIOS/firmware/etc" code.=20

I was working under BenH's direction, but he apparently got swamped a
while back and this fell through the cracks.  I'm re-posting this in an
attempt to get the ball rolling again, as several people have contacted=20
me directly to ask about this code getting merged.

I don't have the means (hardware &| bug reports/feedback) to develop it
further.  IIRC the memmap fixes for r300/r400 haven't been integrated
into the mainline either, so you may get some random lockups -- but that
is beyond the scope of this patch.

Aanyone who has a radeon card and is feeling brave, please give this a
whirl.  If you are specifying a monitor layout, try it without the
layout string and things should JustWork(tm).

This patch also adds PCI IDs for the X700/M26 series.  It tests fine on=20
the M26 (ATOM) in my laptop and the 7500AGP (Legacy) card in my workstation.

See also kernel bugzilla # 6215:

	http://bugzilla.kernel.org/show_bug.cgi?id=3D6215

I'll rebase it against 2.6.18-rcX (if necessary) after I migrate to=20
2.6.18-rcX on my development boxen.

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.          ICQ: 1318344


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radeonfb-atom-2.6.17-v5.diff"
Content-Transfer-Encoding: quoted-printable

diff -Naur aty-2.6.17/ati_ids.h aty-2.6.17-patched/ati_ids.h
--- aty-2.6.17/ati_ids.h	2006-09-05 10:15:55.000000000 -0400
+++ aty-2.6.17-patched/ati_ids.h	2006-09-05 10:34:51.000000000 -0400
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
diff -Naur aty-2.6.17/radeon_base.c aty-2.6.17-patched/radeon_base.c
--- aty-2.6.17/radeon_base.c	2006-09-05 10:15:55.000000000 -0400
+++ aty-2.6.17-patched/radeon_base.c	2006-09-05 10:34:51.000000000 -0400
@@ -3,6 +3,7 @@
  *
  *	framebuffer driver for ATI Radeon chipset video boards
  *
+ *	Copyright 2006	Solomon Peachy <pizza@shaftnet.org>
  *	Copyright 2003	Ben. Herrenschmidt <benh@kernel.crashing.org>
  *	Copyright 2000	Ani Joshi <ajoshi@kernel.crashing.org>
  *
@@ -50,7 +51,7 @@
  */
=20
=20
-#define RADEON_VERSION	"0.2.0"
+#define RADEON_VERSION	"0.3.0"
=20
 #include <linux/config.h>
 #include <linux/module.h>
@@ -214,6 +215,10 @@
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
@@ -265,6 +270,7 @@
 static int default_dynclk =3D -2;
 static int nomodeset =3D 0;
 static int ignore_edid =3D 0;
+static int ignore_conntable =3D 0;
 static int mirror =3D 0;
 static int panel_yres =3D 0;
 static int force_dfp =3D 0;
@@ -342,7 +348,7 @@
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
@@ -428,7 +434,7 @@
  * Read XTAL (ref clock), SCLK and MCLK from Open Firmware device
  * tree. Hopefully, ATI OF driver is kind enough to fill these
  */
-static int __devinit radeon_read_xtal_OF (struct radeonfb_info *rinfo)
+static int __devinit radeon_get_pll_info_openfirmware (struct radeonfb_inf=
o *rinfo)
 {
 	struct device_node *dp =3D rinfo->of_node;
 	u32 *val;
@@ -451,6 +457,7 @@
 	if (val && *val)
 		rinfo->pll.mclk =3D (*val) / 10;
=20
+	printk(KERN_INFO "radeonfb: Retrieved PLL infos from Open Firmware\n");
        	return 0;
 }
 #endif /* CONFIG_PPC_OF */
@@ -593,10 +600,88 @@
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
+	printk(KERN_INFO "radeonfb: Retrieved PLL infos from Legacy BIOS\n");
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
+	printk(KERN_INFO "radeonfb: Retrieved PLL infos from ATOM BIOS\n");
+	return 0;
+}
+
+static void radeon_detect_bios_type(struct radeonfb_info *rinfo)
+{
+#ifdef CONFIG_PPC_OF
+	  rinfo->is_atom_bios =3D 0;
+	  rinfo->get_pll_info =3D radeon_get_pll_info_openfirmware;
+	  rinfo->get_lvds_info =3D radeon_get_lvds_info_openfirmware;
+	  rinfo->radeon_get_tmds_info =3D NULL;
+	  rinfo->get_conn_info =3D radeon_get_conn_info_openfirmware;
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
+	  } else {
+		  rinfo->is_atom_bios =3D 0;
+		  rinfo->radeon_get_pll_info =3D radeon_get_pll_info_legacy;
+		  rinfo->radeon_get_lvds_info =3D radeon_get_lvds_info_legacy;
+		  rinfo->radeon_get_conn_info =3D radeon_get_conn_info_legacy;
+		  rinfo->radeon_get_tmds_info =3D radeon_get_tmds_info_legacy;
+	  }
+#endif  /* CONFIG_PPC_OF */
+
+}
+
 /*
  * Retrieve PLL infos by different means (BIOS, Open Firmware, register pr=
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
-	 * Retrieve PLL infos from Open Firmware first
-	 */
-       	if (!force_measure_pll && radeon_read_xtal_OF(rinfo) =3D=3D 0) {
-       		printk(KERN_INFO "radeonfb: Retrieved PLL infos from Open Firmwar=
e\n");
-		goto found;
-	}
-#endif /* CONFIG_PPC_OF */
=20
 	/*
-	 * Check out if we have an X86 which gave us some PLL informations
-	 * and if yes, retrieve them
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
-		printk(KERN_INFO "radeonfb: Retrieved PLL infos from BIOS\n");
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
 	 * Some methods fail to retrieve SCLK and MCLK values, we apply default
 	 * settings in this case (200Mhz). If that really happne often, we could
@@ -941,6 +1026,7 @@
         u32 val;
 	u32 tmp_pix_clks;
 	int unblank =3D 0;
+	int i;
=20
 	if (rinfo->lock_blank)
 		return 0;
@@ -970,78 +1056,80 @@
         }
 	OUTREG(CRTC_EXT_CNTL, val);
=20
+	for (i =3D 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
+		if (i =3D=3D -1) continue;
=20
-	switch (rinfo->mon1_type) {
-	case MT_DFP:
-		if (unblank)
-			OUTREGP(FP_GEN_CNTL, (FP_FPON | FP_TMDS_EN),
-				~(FP_FPON | FP_TMDS_EN));
-		else {
-			if (mode_switch || blank =3D=3D FB_BLANK_NORMAL)
-				break;
-			OUTREGP(FP_GEN_CNTL, 0, ~(FP_FPON | FP_TMDS_EN));
-		}
+		switch (rinfo->connectors[rinfo->heads[i]].mon_type) {
+		case MT_DFP:
+			if (unblank)
+				OUTREGP(FP_GEN_CNTL, (FP_FPON | FP_TMDS_EN),
+					~(FP_FPON | FP_TMDS_EN));
+			else {
+				if (mode_switch || blank =3D=3D FB_BLANK_NORMAL)
+					break;
+				OUTREGP(FP_GEN_CNTL, 0, ~(FP_FPON | FP_TMDS_EN));
+			}
 		break;
-	case MT_LCD:
-		del_timer_sync(&rinfo->lvds_timer);
-		val =3D INREG(LVDS_GEN_CNTL);
-		if (unblank) {
-			u32 target_val =3D (val & ~LVDS_DISPLAY_DIS) | LVDS_BLON | LVDS_ON
-				| LVDS_EN | (rinfo->init_state.lvds_gen_cntl
-					     & (LVDS_DIGON | LVDS_BL_MOD_EN));
-			if ((val ^ target_val) =3D=3D LVDS_DISPLAY_DIS)
-				OUTREG(LVDS_GEN_CNTL, target_val);
-			else if ((val ^ target_val) !=3D 0) {
-				OUTREG(LVDS_GEN_CNTL, target_val
-				       & ~(LVDS_ON | LVDS_BL_MOD_EN));
-				rinfo->init_state.lvds_gen_cntl &=3D ~LVDS_STATE_MASK;
-				rinfo->init_state.lvds_gen_cntl |=3D
-					target_val & LVDS_STATE_MASK;
-				if (mode_switch) {
-					radeon_msleep(rinfo->panel_info.pwr_delay);
+		case MT_LCD:
+			del_timer_sync(&rinfo->lvds_timer);
+			val =3D INREG(LVDS_GEN_CNTL);
+			if (unblank) {
+				u32 target_val =3D (val & ~LVDS_DISPLAY_DIS) | LVDS_BLON | LVDS_ON
+					| LVDS_EN | (rinfo->init_state.lvds_gen_cntl
+						     & (LVDS_DIGON | LVDS_BL_MOD_EN));
+				if ((val ^ target_val) =3D=3D LVDS_DISPLAY_DIS)
 					OUTREG(LVDS_GEN_CNTL, target_val);
+				else if ((val ^ target_val) !=3D 0) {
+					OUTREG(LVDS_GEN_CNTL, target_val
+					       & ~(LVDS_ON | LVDS_BL_MOD_EN));
+					rinfo->init_state.lvds_gen_cntl &=3D ~LVDS_STATE_MASK;
+					rinfo->init_state.lvds_gen_cntl |=3D
+						target_val & LVDS_STATE_MASK;
+					if (mode_switch) {
+						radeon_msleep(rinfo->panel_info.pwr_delay);
+						OUTREG(LVDS_GEN_CNTL, target_val);
+					} else {
+						rinfo->pending_lvds_gen_cntl =3D target_val;
+						mod_timer(&rinfo->lvds_timer,
+							  jiffies +
+							  msecs_to_jiffies(rinfo->panel_info.pwr_delay));
+					}
 				}
-				else {
-					rinfo->pending_lvds_gen_cntl =3D target_val;
-					mod_timer(&rinfo->lvds_timer,
-					   jiffies +
-					   msecs_to_jiffies(rinfo->panel_info.pwr_delay));
-				}
+			} else {
+				val |=3D LVDS_DISPLAY_DIS;
+				OUTREG(LVDS_GEN_CNTL, val);
+			=09
+				/* We don't do a full switch-off on a simple mode switch */
+				if (mode_switch || blank =3D=3D FB_BLANK_NORMAL)
+					break;
+			=09
+				/* Asic bug, when turning off LVDS_ON, we have to make sure
+				 * RADEON_PIXCLK_LVDS_ALWAYS_ON bit is off
+				 */
+				tmp_pix_clks =3D INPLL(PIXCLKS_CNTL);
+				if (rinfo->is_mobility || rinfo->is_IGP)
+					OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
+				val &=3D ~(LVDS_BL_MOD_EN);
+				OUTREG(LVDS_GEN_CNTL, val);
+				udelay(100);
+				val &=3D ~(LVDS_ON | LVDS_EN);
+				OUTREG(LVDS_GEN_CNTL, val);
+				val &=3D ~LVDS_DIGON;
+				rinfo->pending_lvds_gen_cntl =3D val;
+				mod_timer(&rinfo->lvds_timer,
+					  jiffies +
+					  msecs_to_jiffies(rinfo->panel_info.pwr_delay));
+				rinfo->init_state.lvds_gen_cntl &=3D ~LVDS_STATE_MASK;
+				rinfo->init_state.lvds_gen_cntl |=3D val & LVDS_STATE_MASK;
+				if (rinfo->is_mobility || rinfo->is_IGP)
+					OUTPLL(PIXCLKS_CNTL, tmp_pix_clks);
 			}
-		} else {
-			val |=3D LVDS_DISPLAY_DIS;
-			OUTREG(LVDS_GEN_CNTL, val);
-
-			/* We don't do a full switch-off on a simple mode switch */
-			if (mode_switch || blank =3D=3D FB_BLANK_NORMAL)
-				break;
-
-			/* Asic bug, when turning off LVDS_ON, we have to make sure
-			 * RADEON_PIXCLK_LVDS_ALWAYS_ON bit is off
-			 */
-			tmp_pix_clks =3D INPLL(PIXCLKS_CNTL);
-			if (rinfo->is_mobility || rinfo->is_IGP)
-				OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
-			val &=3D ~(LVDS_BL_MOD_EN);
-			OUTREG(LVDS_GEN_CNTL, val);
-			udelay(100);
-			val &=3D ~(LVDS_ON | LVDS_EN);
-			OUTREG(LVDS_GEN_CNTL, val);
-			val &=3D ~LVDS_DIGON;
-			rinfo->pending_lvds_gen_cntl =3D val;
-			mod_timer(&rinfo->lvds_timer,
-				  jiffies +
-				  msecs_to_jiffies(rinfo->panel_info.pwr_delay));
-			rinfo->init_state.lvds_gen_cntl &=3D ~LVDS_STATE_MASK;
-			rinfo->init_state.lvds_gen_cntl |=3D val & LVDS_STATE_MASK;
-			if (rinfo->is_mobility || rinfo->is_IGP)
-				OUTPLL(PIXCLKS_CNTL, tmp_pix_clks);
+			break;
+		case MT_CRT:
+			// todo: powerdown DAC
+		default:
+			break;
 		}
-		break;
-	case MT_CRT:
-		// todo: powerdown DAC
-	default:
-		break;
 	}
=20
 	/* let fbcon do a soft blank for us */
@@ -1942,7 +2030,7 @@
 	u32 lvds_gen_cntl, tmpPixclksCntl;
 	int* conv_table;
=20
-	if (rinfo->mon1_type !=3D MT_LCD)
+	if (PRIMARY_MONITOR(rinfo) !=3D MT_LCD)
 		return 0;
=20
 	/* Pardon me for that hack... maybe some day we can figure
@@ -2230,7 +2318,7 @@
         struct fb_info *info =3D pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo =3D info->par;
=20
-	return radeon_show_one_edid(buf, off, count, rinfo->mon1_EDID);
+	return radeon_show_one_edid(buf, off, count, rinfo->connectors[rinfo->hea=
ds[0]].edid);
 }
=20
=20
@@ -2241,7 +2329,27 @@
         struct fb_info *info =3D pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo =3D info->par;
=20
-	return radeon_show_one_edid(buf, off, count, rinfo->mon2_EDID);
+	return radeon_show_one_edid(buf, off, count, rinfo->connectors[rinfo->hea=
ds[1]].edid);
+}
+
+static ssize_t radeon_show_edid3(struct kobject *kobj, char *buf, loff_t o=
ff, size_t count)
+{
+	struct device *dev =3D container_of(kobj, struct device, kobj);
+	struct pci_dev *pdev =3D to_pci_dev(dev);
+        struct fb_info *info =3D pci_get_drvdata(pdev);
+        struct radeonfb_info *rinfo =3D info->par;
+
+	return radeon_show_one_edid(buf, off, count, rinfo->connectors[rinfo->hea=
ds[2]].edid);
+}
+
+static ssize_t radeon_show_edid4(struct kobject *kobj, char *buf, loff_t o=
ff, size_t count)
+{
+	struct device *dev =3D container_of(kobj, struct device, kobj);
+	struct pci_dev *pdev =3D to_pci_dev(dev);
+        struct fb_info *info =3D pci_get_drvdata(pdev);
+        struct radeonfb_info *rinfo =3D info->par;
+
+	return radeon_show_one_edid(buf, off, count, rinfo->connectors[rinfo->hea=
ds[3]].edid);
 }
=20
 static struct bin_attribute edid1_attr =3D {
@@ -2264,6 +2372,25 @@
 	.read	=3D radeon_show_edid2,
 };
=20
+static struct bin_attribute edid3_attr =3D {
+	.attr   =3D {
+		.name	=3D "edid3",
+		.owner	=3D THIS_MODULE,
+		.mode	=3D 0444,
+	},
+	.size	=3D EDID_LENGTH,
+	.read	=3D radeon_show_edid3,
+};
+
+static struct bin_attribute edid4_attr =3D {
+	.attr   =3D {
+		.name	=3D "edid4",
+		.owner	=3D THIS_MODULE,
+		.mode	=3D 0444,
+	},
+	.size	=3D EDID_LENGTH,
+	.read	=3D radeon_show_edid4,
+};
=20
 static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
@@ -2271,6 +2398,7 @@
 	struct fb_info *info;
 	struct radeonfb_info *rinfo;
 	int ret;
+	int i;
=20
 	RTRACE("radeonfb_pci_register BEGIN\n");
 =09
@@ -2412,6 +2540,7 @@
 	 * We probably need to make sure this is the primary display,
 	 * but that is difficult without some arch support.
 	 */
+
 #ifdef CONFIG_X86
 	if (rinfo->bios_seg =3D=3D NULL)
 		radeon_find_mem_vbios(rinfo);
@@ -2423,14 +2552,23 @@
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
=20
 #ifdef CONFIG_FB_RADEON_I2C
 	/* Register I2C bus */
 	radeon_create_i2c_busses(rinfo);
 #endif
=20
+	/* Get infos about connectors -- need I2C here! */
+	radeon_get_conn_info(rinfo, ignore_conntable);
+
 	/* set all the vital stuff */
 	radeon_set_fbinfo (rinfo);
=20
@@ -2441,10 +2579,15 @@
 	radeon_check_modes(rinfo, mode_option);
=20
 	/* Register some sysfs stuff (should be done better) */
-	if (rinfo->mon1_EDID)
+=09
+	if ((rinfo->heads[0] !=3D -1) && rinfo->connectors[rinfo->heads[0]].edid)
 		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
-	if (rinfo->mon2_EDID)
+	if ((rinfo->heads[1] !=3D -1) && rinfo->connectors[rinfo->heads[1]].edid)
 		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
+	if ((rinfo->heads[2] !=3D -1) && rinfo->connectors[rinfo->heads[2]].edid)
+		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid3_attr);
+	if ((rinfo->heads[3] !=3D -1) && rinfo->connectors[rinfo->heads[3]].edid)
+		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid4_attr);
=20
 	/* save current mode regs before we switch into the new one
 	 * so we can restore this upon __exit
@@ -2478,7 +2621,7 @@
 #endif
=20
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if (rinfo->mon1_type =3D=3D MT_LCD) {
+	if (PRIMARY_MONITOR(rinfo) =3D=3D MT_LCD) {
 		register_backlight_controller(&radeon_backlight_controller,
 					      rinfo, "ati");
 		register_backlight_controller(&radeon_backlight_controller,
@@ -2496,10 +2639,12 @@
 err_unmap_fb:
 	iounmap(rinfo->fb_base);
 err_unmap_rom:
-	kfree(rinfo->mon1_EDID);
-	kfree(rinfo->mon2_EDID);
-	if (rinfo->mon1_modedb)
-		fb_destroy_modedb(rinfo->mon1_modedb);
+	for (i =3D 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
+		kfree(rinfo->connectors[i].edid);
+		if (rinfo->connectors[i].modedb)
+			fb_destroy_modedb(rinfo->connectors[i].modedb);
+	}
+
 	fb_dealloc_cmap(&info->cmap);
 #ifdef CONFIG_FB_RADEON_I2C
 	radeon_delete_i2c_busses(rinfo);
@@ -2525,16 +2670,21 @@
 {
         struct fb_info *info =3D pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo =3D info->par;
-=20
+	int i;
+
         if (!rinfo)
                 return;
 =20
 	radeonfb_pm_exit(rinfo);
=20
-	if (rinfo->mon1_EDID)
+	if ((rinfo->heads[0] !=3D -1) && rinfo->connectors[rinfo->heads[0]].edid)
 		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
-	if (rinfo->mon2_EDID)
+	if ((rinfo->heads[1] !=3D -1) && rinfo->connectors[rinfo->heads[1]].edid)
 		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
+	if ((rinfo->heads[2] !=3D -1) && rinfo->connectors[rinfo->heads[2]].edid)
+		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid3_attr);
+	if ((rinfo->heads[3] !=3D -1) && rinfo->connectors[rinfo->heads[3]].edid)
+		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid4_attr);
=20
 #if 0
 	/* restore original state
@@ -2561,10 +2711,11 @@
 	pci_release_region(pdev, 2);
 	pci_release_region(pdev, 0);
=20
-	kfree(rinfo->mon1_EDID);
-	kfree(rinfo->mon2_EDID);
-	if (rinfo->mon1_modedb)
-		fb_destroy_modedb(rinfo->mon1_modedb);
+	for (i =3D 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
+		kfree(rinfo->connectors[i].edid);
+		if (rinfo->connectors[i].modedb)
+			fb_destroy_modedb(rinfo->connectors[i].modedb);
+	}
 #ifdef CONFIG_FB_RADEON_I2C
 	radeon_delete_i2c_busses(rinfo);
 #endif       =20
@@ -2615,6 +2766,8 @@
 			force_measure_pll =3D 1;
 		} else if (!strncmp(this_opt, "ignore_edid", 11)) {
 			ignore_edid =3D 1;
+		} else if (!strncmp(this_opt, "ignore_conntable", 16)) {
+			ignore_conntable =3D 1;
 		} else
 			mode_option =3D this_opt;
 	}
@@ -2658,6 +2811,8 @@
 MODULE_PARM_DESC(force_dfp, "bool: force display to dfp");
 module_param(ignore_edid, bool, 0);
 MODULE_PARM_DESC(ignore_edid, "bool: Ignore EDID data when doing DDC probe=
");
+module_param(ignore_conntable, bool, 0);
+MODULE_PARM_DESC(ignore_conntable, "bool: Ignore BIOS Connector table");
 module_param(monitor_layout, charp, 0);
 MODULE_PARM_DESC(monitor_layout, "Specify monitor mapping (like XFree86)");
 module_param(force_measure_pll, bool, 0);
diff -Naur aty-2.6.17/radeon_i2c.c aty-2.6.17-patched/radeon_i2c.c
--- aty-2.6.17/radeon_i2c.c	2006-09-05 10:15:55.000000000 -0400
+++ aty-2.6.17-patched/radeon_i2c.c	2006-09-05 10:34:51.000000000 -0400
@@ -170,13 +170,27 @@
 	return NULL;
 }
=20
-
-int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 *=
*out_edid)
+/* Returns 1 if probe unsuccessful. */
+int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, struct radeon_=
connector *conn)
 {
-	u32 reg =3D rinfo->i2c[conn-1].ddc_reg;
+	u32 reg;
 	u8 *edid =3D NULL;
+	int mon_type =3D MT_NONE;
+
 	int i, j;
=20
+	if (!conn)
+		return 1;
+
+	if (rinfo->is_mobility && (conn->ddc_type =3D=3D ddc_none) &&
+		(INREG(LVDS_GEN_CNTL) & LVDS_ON)) {
+			RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn->ddc_type=
);
+			mon_type =3D MT_LCD;
+			goto done;
+	}
+
+	reg =3D rinfo->i2c[conn->ddc_type].ddc_reg;
+
 	OUTREG(reg, INREG(reg) &=20
 			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));
=20
@@ -212,7 +226,7 @@
 		msleep(15);
=20
 		/* Do the real work */
-		edid =3D radeon_do_probe_i2c_edid(&rinfo->i2c[conn-1]);
+		edid =3D radeon_do_probe_i2c_edid(&rinfo->i2c[conn->ddc_type]);
=20
 		OUTREG(reg, INREG(reg) |=20
 				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
@@ -236,30 +250,32 @@
 		if (edid)
 			break;
 	}
+
 	/* Release the DDC lines when done or the Apple Cinema HD display
 	 * will switch off
 	 */
 	OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN | VGA_DDC_DATA_OUT_EN));
 	(void)INREG(reg);
=20
-	if (out_edid)
-		*out_edid =3D edid;
 	if (!edid) {
-		RTRACE("radeonfb: I2C (port %d) ... not found\n", conn);
-		return MT_NONE;
+		RTRACE("radeonfb: I2C (port %d) ... not found\n", conn->ddc_type);
+		mon_type =3D MT_NONE;
+		goto done;
 	}
-	if (edid[0x14] & 0x80) {
-		/* Fix detection using BIOS tables */
-		if (rinfo->is_mobility /*&& conn =3D=3D ddc_dvi*/ &&
-		    (INREG(LVDS_GEN_CNTL) & LVDS_ON)) {
-			RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn);
-			return MT_LCD;
-		} else {
-			RTRACE("radeonfb: I2C (port %d) ... found TMDS panel\n", conn);
-			return MT_DFP;
-		}
+
+	if ((edid[0x14] & 0x80) && (conn->ddc_type =3D=3D ddc_dvi)) {
+		RTRACE("radeonfb: I2C (port %d) ... found TMDS panel\n", conn->ddc_type);
+		mon_type =3D MT_DFP;
+		goto done;
 	}
-       	RTRACE("radeonfb: I2C (port %d) ... found CRT display\n", conn);
-	return MT_CRT;
+
+       	RTRACE("radeonfb: I2C (port %d) ... found CRT display\n", conn->dd=
c_type);
+	mon_type =3D MT_CRT;
+
+ done:
+	conn->edid =3D edid;
+	conn->mon_type =3D mon_type;
+
+	return (mon_type =3D=3D MT_NONE);
 }
=20
diff -Naur aty-2.6.17/radeon_monitor.c aty-2.6.17-patched/radeon_monitor.c
--- aty-2.6.17/radeon_monitor.c	2006-09-05 10:15:55.000000000 -0400
+++ aty-2.6.17-patched/radeon_monitor.c	2006-09-05 10:34:51.000000000 -0400
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
@@ -23,35 +46,6 @@
 	.vmode		=3D FB_VMODE_NONINTERLACED
 };
=20
-static char *radeon_get_mon_name(int type)
-{
-	char *pret =3D NULL;
-
-	switch (type) {
-		case MT_NONE:
-			pret =3D "no";
-			break;
-		case MT_CRT:
-			pret =3D "CRT";
-			break;
-		case MT_DFP:
-			pret =3D "DFP";
-			break;
-		case MT_LCD:
-			pret =3D "LCD";
-			break;
-		case MT_CTV:
-			pret =3D "CTV";
-			break;
-		case MT_STV:
-			pret =3D "STV";
-			break;
-	}
-
-	return pret;
-}
-
-
 #ifdef CONFIG_PPC_OF
 /*
  * Try to find monitor informations & EDID data out of the Open Firmware
@@ -59,7 +53,8 @@
  * models with broken OF probing by hard-coding known EDIDs for some Mac
  * laptops internal LVDS panel. (XXX: not done yet)
  */
-static int __devinit radeon_parse_montype_prop(struct device_node *dp, u8 =
**out_EDID,
+static int __devinit radeon_parse_montype_prop(struct device_node *dp,
+					       struct radeon_connector *conn,=20
 					       int hdno)
 {
         static char *propnames[] =3D { "DFP,EDID", "LCD,EDID", "EDID",
@@ -67,25 +62,30 @@
 	u8 *pedid =3D NULL;
 	u8 *pmt =3D NULL;
 	u8 *tmp;
-        int i, mt =3D MT_NONE; =20
+        int i; =20
 =09
 	RTRACE("analyzing OF properties...\n");
 	pmt =3D (u8 *)get_property(dp, "display-type", NULL);
 	if (!pmt)
-		return MT_NONE;
+		return 1;
 	RTRACE("display-type: %s\n", pmt);
-	/* OF says "LCD" for DFP as well, we discriminate from the caller of this
-	 * function
-	 */
-	if (!strcmp(pmt, "LCD") || !strcmp(pmt, "DFP"))
-		mt =3D MT_DFP;
-	else if (!strcmp(pmt, "CRT"))
-		mt =3D MT_CRT;
-	else {
+	if (!strcmp(pmt, "LCD") || !strcmp(pmt, "DFP")) {
+		/* OF says "LCD" for DFP as well.*/
+		if (rinfo->is_mobility) {
+			conn->mon_type =3D MT_LCD;
+			/* Maybe check for LVDS_GEN_CNTL here ? I need to check out
+			 * what OF does when booting with lid closed
+			 */
+		} else{
+			conn->mon_type =3D MT_DFP;
+		}
+	} else if (!strcmp(pmt, "CRT")) {
+		conn->mon_type =3D MT_CRT;
+	} else {
 		if (strcmp(pmt, "NONE") !=3D 0)
 			printk(KERN_WARNING "radeonfb: Unknown OF display-type: %s\n",
 			       pmt);
-		return MT_NONE;
+		return 1;
 	}
=20
 	for (i =3D 0; propnames[i] !=3D NULL; ++i) {
@@ -102,26 +102,41 @@
 	if (pedid =3D=3D NULL && dp->parent && (hdno =3D=3D 0))
 		pedid =3D get_property(dp->parent, "EDID", NULL);
 	if (pedid =3D=3D NULL)
-		return mt;
+		return 1;
=20
 	tmp =3D (u8 *)kmalloc(EDID_LENGTH, GFP_KERNEL);
-	if (!tmp)
-		return mt;
-	memcpy(tmp, pedid, EDID_LENGTH);
-	*out_EDID =3D tmp;
-	return mt;
+	if (tmp) {
+		memcpy(tmp, pedid, EDID_LENGTH);
+	}
+
+	conn->edid =3D tmp;
+
+	{
+		int found_tmds =3D 0;
+		int found_crt =3D 0;
+		int ddc_type =3D ddc_none;
+		// XXX what about reversed DAC/TMDS??
+		radeon_fill_conn(conn, conn->mon_type, ddc_type, &found_crt, &found_tmds=
);
+	}
+
+	return 0;
 }
=20
-static int __devinit radeon_probe_OF_head(struct radeonfb_info *rinfo, int=
 head_no,
-					  u8 **out_EDID)
+/* return a 1 on error */
+static int __devinit radeon_probe_OF_head(struct radeonfb_info *rinfo, int=
 head_no)
+
 {
+	struct radeon_connector *conn;
         struct device_node *dp;
+	u8 *out_EDID;
=20
 	RTRACE("radeon_probe_OF_head\n");
=20
+	conn =3D rinfo->connectors[head_no];
+
         dp =3D rinfo->of_node;
-        while (dp =3D=3D NULL)
-		return MT_NONE;
+        if (dp =3D=3D NULL)=20
+		return 1;
=20
 	if (rinfo->has_CRTC2) {
 		char *pname;
@@ -129,52 +144,94 @@
=20
 		dp =3D dp->child;
 		do {
-			if (!dp)
-				return MT_NONE;
+			if (!dp)=20
+				return 1;
+
 			pname =3D (char *)get_property(dp, "name", NULL);
-			if (!pname)
-				return MT_NONE;
+			if (!pname)=20
+				return 1;
+
 			len =3D strlen(pname);
 			RTRACE("head: %s (letter: %c, head_no: %d)\n",
 			       pname, pname[len-1], head_no);
 			if (pname[len-1] =3D=3D 'A' && head_no =3D=3D 0) {
-				int mt =3D radeon_parse_montype_prop(dp, out_EDID, 0);
-				/* Maybe check for LVDS_GEN_CNTL here ? I need to check out
-				 * what OF does when booting with lid closed
-				 */
-				if (mt =3D=3D MT_DFP && rinfo->is_mobility)
-					mt =3D MT_LCD;
-				return mt;
-			} else if (pname[len-1] =3D=3D 'B' && head_no =3D=3D 1)
-				return radeon_parse_montype_prop(dp, out_EDID, 1);
+				return radeon_parse_montype_prop(dp, conn, 0);
+			} else if (pname[len-1] =3D=3D 'B' && head_no =3D=3D 1) {
+				return radeon_parse_montype_prop(dp, conn, 1);
+			}
 			second =3D 1;
 			dp =3D dp->sibling;
 		} while(!second);
 	} else {
-		if (head_no > 0)
-			return MT_NONE;
-		return radeon_parse_montype_prop(dp, out_EDID, -1);
+		if (head_no > 0) {
+			return 1;
+		}
+		return radeon_parse_montype_prop(dp, conn, -1);
 	}
-        return MT_NONE;
+	return 1;
 }
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
@@ -182,13 +239,13 @@
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
@@ -203,6 +260,7 @@
 		RTRACE("post_divider =3D %x\n", rinfo->panel_info.post_divider);
 		RTRACE("fbk_divider =3D %x\n", rinfo->panel_info.fbk_divider);
 	}
+=09
 	RTRACE("Scanning BIOS table ...\n");
 	for(i=3D0; i<32; i++) {
 		tmp0 =3D BIOS_IN16(tmp+64+i*2);
@@ -226,7 +284,7 @@
 			rinfo->panel_info.vAct_high =3D 1;
 			/* Mark panel infos valid */
 			rinfo->panel_info.valid =3D 1;
-
+		=09
 			RTRACE("Found panel in BIOS table:\n");
 			RTRACE("  hblank: %d\n", rinfo->panel_info.hblank);
 			RTRACE("  hOver_plus: %d\n", rinfo->panel_info.hOver_plus);
@@ -235,12 +293,427 @@
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
+	return 0;
+}
+
+
+static const char *conn_type_name[] =3D {
+	"NONE", "VGA", "DVI-I", "DVI-D", "DVI-A", "S-Video",
+	"Composite Video", "Internal Panel", "Digital",
+	"Unsupported", "Proprietary"
+};
+
+static const char *mon_type_name[] =3D {
+	"None", "CRT", "LVDS Flat panel",
+	"DVI Flat panel", "Composite TV", "S-Video TV"
+};
+
+static void __devinit radeon_fill_conn(struct radeon_connector *conn, int =
mon_type, int ddc_type, int *found_tmds, int *found_crt)=20
+{
+	conn->mon_type =3D mon_type;
+	conn->ddc_type =3D ddc_type;
+
+	// XXX what about reversed DAC/TMDS??
+
+	switch(mon_type) {
+	case MT_CRT:
+		conn->conn_type =3D conn_vga;
+		conn->tmds_type =3D tmds_unknown;
+		conn->dac_type =3D (*found_crt) ? dac_tvdac: dac_primary;
+		if (ddc_type =3D=3D ddc_none) conn->ddc_type =3D (*found_crt) ? ddc_crt2=
 : ddc_vga;
+		*found_crt =3D 1;
+		break;
+	case MT_DFP:
+		conn->conn_type =3D conn_dvi_i;
+		conn->tmds_type =3D (*found_tmds) ? tmds_external: tmds_internal;
+		conn->dac_type =3D dac_unknown;
+		if (ddc_type =3D=3D ddc_none) conn->ddc_type =3D ddc_dvi;
+		*found_tmds =3D 1;
+		break;
+	case MT_LCD:
+		conn->conn_type =3D conn_lvds;
+		conn->tmds_type =3D tmds_unknown;
+		conn->dac_type =3D dac_unknown;
+		if (ddc_type =3D=3D ddc_none) conn->ddc_type =3D ddc_none; //heh
+		break;
+	case MT_CTV:
+		conn->conn_type =3D conn_ctv;
+		conn->tmds_type =3D tmds_unknown;
+		conn->dac_type =3D dac_tvdac;
+		if (ddc_type =3D=3D ddc_none) conn->ddc_type =3D ddc_vga; // XXX ddc_crt=
2?
+		break;
+	case MT_STV:
+		conn->conn_type =3D conn_stv;
+		conn->tmds_type =3D tmds_unknown;
+		conn->dac_type =3D dac_tvdac;
+		if (ddc_type =3D=3D ddc_none) conn->ddc_type =3D ddc_vga; // XXX ddc_crt=
2?
+		break;
+	case MT_UNKNOWN:
+	case MT_NONE:
+		conn->conn_type =3D conn_none;
+		conn->tmds_type =3D tmds_unknown;
+		conn->mon_type =3D MT_NONE;
+		conn->ddc_type =3D ddc_none;
+		conn->dac_type =3D dac_unknown;
+		break;
+	default:
+		break;
+	}
+	// leaves conn_digital, conn_unsupported, conn_propritetary
+}
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
+ */
+void __devinit radeon_get_conn_info(struct radeonfb_info *rinfo, int ignor=
e_conntable)
+{
+	int i;
+
+	/* Clear table */
+	for (i =3D 0; i < RADEON_MAX_CONNECTORS; i++) {
+		rinfo->connectors[i].conn_type	=3D conn_none;
+		rinfo->connectors[i].ddc_type	=3D ddc_none;
+		rinfo->connectors[i].dac_type	=3D dac_unknown;
+		rinfo->connectors[i].tmds_type	=3D tmds_unknown;
+		rinfo->connectors[i].mon_type	=3D MT_UNKNOWN;
+		rinfo->connectors[i].head       =3D -1;
+		rinfo->heads[i] =3D -1;
+	}
+	rinfo->num_heads =3D 0;
+
+	if (ignore_conntable) {=09
+#if defined(CONFIG_FB_RADEON_I2C)
+		struct radeon_connector conn;
+		int idx =3D 0;
+		int found_tmds =3D 0;
+		int found_crt =3D 0;
+
+		// XXX what about reversed DAC/TMDS??
+
+		for (i =3D 0; i < 4; i++) {
+			conn.ddc_type =3D i;
+			if (!radeon_probe_i2c_connector(rinfo, &conn)) {
+
+				radeon_fill_conn(&rinfo->connectors[idx++], conn.mon_type, conn.ddc_ty=
pe, &found_tmds, &found_crt);=20
+			}
+		}
+
+		/* If we failed to probe something.. */
+		if (idx)=20
+			goto found;
+#endif /* CONFIG_FB_RADEON_I2C */
+	} else {
+		/* Try to obtain infos from firmware */
+		if (rinfo->radeon_get_conn_info) {
+			if (!rinfo->radeon_get_conn_info(rinfo)) {
+				goto found;
+			}
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
+		rinfo->connectors[1].tmds_type	=3D tmds_unknown;
+		rinfo->connectors[1].mon_type	=3D MT_UNKNOWN;
+	=09
+		if (rinfo->has_CRTC2) {
+			rinfo->connectors[1].conn_type	=3D conn_vga;
+			rinfo->connectors[1].ddc_type	=3D ddc_crt2;
+			rinfo->connectors[1].dac_type	=3D dac_tvdac;
+			rinfo->connectors[1].tmds_type	=3D tmds_unknown;
+			rinfo->connectors[1].mon_type	=3D MT_UNKNOWN;
+		}
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
+	}
+
+	/* Single head chips all use primary DAC */
+	if (!rinfo->has_CRTC2)
+		rinfo->connectors[0].dac_type =3D dac_primary;
+
+	return;
+ }
+
+#ifdef CONFIG_PPC_OF
+int __devinit radeon_get_conn_info_openfirmware(struct radeonfb_info *rinf=
o)
+{
+	int i;
+	int not_found =3D 1;
+
+	for(i =3D 0 ; < 2 ; i++) {  /* Only two heads for OF! */
+		if (!radeon_probe_OF_head(rinfo, i)) found =3D 0;
+	}
+	return found;
+}
+#endif /* CONFIG_PPC_OF */
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
+				break;
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
 	return 0;
 }
=20
@@ -248,44 +721,167 @@
  * doesn't quite work yet, but it's output is still useful for
  * debugging
  */
-static void __devinit radeon_parse_connector_info(struct radeonfb_info *ri=
nfo)
+int __devinit radeon_get_conn_info_legacy(struct radeonfb_info *rinfo)
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
@@ -362,6 +958,50 @@
     return connected ? MT_CRT : MT_NONE;
 }
=20
+/* Find if the desired connector and monitor are compatible */
+static int __devinit radeon_conn_monitor_compatible(int mon_type, int conn=
_type)=20
+{
+	switch(mon_type) {
+	case MT_CRT:
+		return ((conn_type =3D=3D conn_vga) || (conn_type =3D=3D conn_dvi_a));
+	case MT_DFP:
+		return ((conn_type =3D=3D conn_dvi_i) || (conn_type =3D=3D conn_dvi_d));
+	case MT_LCD:
+		return (conn_type =3D=3D conn_lvds);
+	case MT_CTV:
+		return (conn_type =3D=3D conn_ctv);
+	case MT_STV:
+		return (conn_type =3D=3D conn_stv);
+	case MT_UNKNOWN:
+	case MT_NONE:
+	default:
+		return 0;
+	}
+	// leaves conn_digital, conn_unsupported, conn_propritetary
+}
+
+/* Find a suitable connector for this display type */
+static int __devinit radeon_find_connector_for_mon(struct radeonfb_info *r=
info, int mon_type)
+{
+	int i;
+=09
+	if (mon_type <=3D MT_NONE) return 0;
+=09
+	for (i =3D 0; i < RADEON_MAX_CONNECTORS ; i++) {
+		if (radeon_conn_monitor_compatible(mon_type, rinfo->connectors[i].conn_t=
ype) &&=20
+		    (rinfo->connectors[i].mon_type <=3D MT_NONE)) {
+			rinfo->connectors[i].mon_type =3D mon_type;
+			rinfo->connectors[i].head =3D rinfo->num_heads;
+			rinfo->heads[rinfo->num_heads] =3D i;
+			rinfo->num_heads++;
+			return 0;
+		}
+	}
+
+	printk(KERN_INFO "radeonfb: couldn't find a connector for monitor %d\n", =
mon_type);
+	return -1;
+}
+
 /*
  * Parse the "monitor_layout" string if any. This code is mostly
  * copied from XFree's radeon driver
@@ -407,19 +1047,20 @@
 		s1[i] =3D 0;
 		s2[0] =3D 0;
 	}
+
 	if (strcmp(s1, "CRT") =3D=3D 0)
-		rinfo->mon1_type =3D MT_CRT;
+		radeon_find_connector_for_mon(rinfo, MT_CRT);
 	else if (strcmp(s1, "TMDS") =3D=3D 0)
-		rinfo->mon1_type =3D MT_DFP;
+		radeon_find_connector_for_mon(rinfo, MT_DFP);
 	else if (strcmp(s1, "LVDS") =3D=3D 0)
-		rinfo->mon1_type =3D MT_LCD;
+		radeon_find_connector_for_mon(rinfo, MT_LCD);
=20
 	if (strcmp(s2, "CRT") =3D=3D 0)
-		rinfo->mon2_type =3D MT_CRT;
+		radeon_find_connector_for_mon(rinfo, MT_CRT);
 	else if (strcmp(s2, "TMDS") =3D=3D 0)
-		rinfo->mon2_type =3D MT_DFP;
+		radeon_find_connector_for_mon(rinfo, MT_DFP);
 	else if (strcmp(s2, "LVDS") =3D=3D 0)
-		rinfo->mon2_type =3D MT_LCD;
+		radeon_find_connector_for_mon(rinfo, MT_LCD);
=20
 	return 1;
 }
@@ -433,12 +1074,7 @@
 void __devinit radeon_probe_screens(struct radeonfb_info *rinfo,
 				    const char *monitor_layout, int ignore_edid)
 {
-#ifdef CONFIG_FB_RADEON_I2C
-	int ddc_crt2_used =3D 0;=09
-#endif
-	int tmp, i;
-
-	radeon_parse_connector_info(rinfo);
+	int i;
=20
 	if (radeon_parse_monitor_layout(rinfo, monitor_layout)) {
=20
@@ -449,30 +1085,33 @@
 		 * a layout for each card ?
 		 */
=20
-		RTRACE("Using specified monitor layout: %s", monitor_layout);
+		RTRACE("Using specified monitor layout: %s\n", monitor_layout);
 #ifdef CONFIG_FB_RADEON_I2C
 		if (!ignore_edid) {
-			if (rinfo->mon1_type !=3D MT_NONE)
-				if (!radeon_probe_i2c_connector(rinfo, ddc_dvi, &rinfo->mon1_EDID)) {
-					radeon_probe_i2c_connector(rinfo, ddc_crt2, &rinfo->mon1_EDID);
-					ddc_crt2_used =3D 1;
+			int mon_type;
+
+			/* If the DDC detection fails,=20
+			   we still want to use the user's specified layout! */
+			mon_type =3D PRIMARY_MONITOR(rinfo);
+
+			if (PRIMARY_MONITOR(rinfo) > MT_NONE)
+				if (radeon_probe_i2c_connector(rinfo, &PRIMARY_HEAD(rinfo)))
+					PRIMARY_MONITOR(rinfo) =3D mon_type;
+			if (SECONDARY_HEAD_PRESENT(rinfo)) {
+				mon_type =3D SECONDARY_MONITOR(rinfo);
+				if (SECONDARY_MONITOR(rinfo) > MT_NONE) {
+					if (radeon_probe_i2c_connector(rinfo, &SECONDARY_HEAD(rinfo))) {
+						rinfo->connectors[rinfo->heads[1]].mon_type =3D mon_type;
+					}
 				}
-			if (rinfo->mon2_type !=3D MT_NONE)
-				if (!radeon_probe_i2c_connector(rinfo, ddc_vga, &rinfo->mon2_EDID) &&
-				    !ddc_crt2_used)
-					radeon_probe_i2c_connector(rinfo, ddc_crt2, &rinfo->mon2_EDID);
+			}
 		}
 #endif /* CONFIG_FB_RADEON_I2C */
-		if (rinfo->mon1_type =3D=3D MT_NONE) {
-			if (rinfo->mon2_type !=3D MT_NONE) {
-				rinfo->mon1_type =3D rinfo->mon2_type;
-				rinfo->mon1_EDID =3D rinfo->mon2_EDID;
-			} else {
-				rinfo->mon1_type =3D MT_CRT;
-				printk(KERN_INFO "radeonfb: No valid monitor, assuming CRT on first po=
rt\n");
-			}
-			rinfo->mon2_type =3D MT_NONE;
-			rinfo->mon2_EDID =3D NULL;
+	=09
+		/* If the user specified a bogus monitor layout... */
+		if (PRIMARY_MONITOR(rinfo) <=3D MT_NONE) {
+			radeon_find_connector_for_mon(rinfo, MT_CRT);
+			printk(KERN_INFO "radeonfb: No valid monitor, assuming CRT on first por=
t\n");
 		}
 	} else {
 		/*
@@ -481,182 +1120,100 @@
 	=09
 		RTRACE("Starting monitor auto detection...\n");
=20
-#if DEBUG && defined(CONFIG_FB_RADEON_I2C)
-		{
-			u8 *EDIDs[4] =3D { NULL, NULL, NULL, NULL };
-			int mon_types[4] =3D {MT_NONE, MT_NONE, MT_NONE, MT_NONE};
-			int i;
-
-			for (i =3D 0; i < 4; i++)
-				mon_types[i] =3D radeon_probe_i2c_connector(rinfo,
-									  i+1, &EDIDs[i]);
-		}
-#endif /* DEBUG */
 		/*
 		 * Old single head cards
 		 */
 		if (!rinfo->has_CRTC2) {
-#ifdef CONFIG_PPC_OF
-			if (rinfo->mon1_type =3D=3D MT_NONE)
-				rinfo->mon1_type =3D radeon_probe_OF_head(rinfo, 0,
-									&rinfo->mon1_EDID);
-#endif /* CONFIG_PPC_OF */
 #ifdef CONFIG_FB_RADEON_I2C
-			if (rinfo->mon1_type =3D=3D MT_NONE)
-				rinfo->mon1_type =3D
-					radeon_probe_i2c_connector(rinfo, ddc_dvi,
-								   &rinfo->mon1_EDID);
-			if (rinfo->mon1_type =3D=3D MT_NONE)
-				rinfo->mon1_type =3D
-					radeon_probe_i2c_connector(rinfo, ddc_vga,
-								   &rinfo->mon1_EDID);
-			if (rinfo->mon1_type =3D=3D MT_NONE)
-				rinfo->mon1_type =3D
-					radeon_probe_i2c_connector(rinfo, ddc_crt2,
-								   &rinfo->mon1_EDID);=09
-#endif /* CONFIG_FB_RADEON_I2C */
-			if (rinfo->mon1_type =3D=3D MT_NONE)
-				rinfo->mon1_type =3D MT_CRT;
-			goto bail;
-		}
-
-		/*
-		 * Check for cards with reversed DACs or TMDS controllers using BIOS
-		 */
-		if (rinfo->bios_seg &&
-		    (tmp =3D BIOS_IN16(rinfo->fp_bios_start + 0x50))) {
-			for (i =3D 1; i < 4; i++) {
-				unsigned int tmp0;
-
-				if (!BIOS_IN8(tmp + i*2) && i > 1)
-					break;
-				tmp0 =3D BIOS_IN16(tmp + i*2);
-				if ((!(tmp0 & 0x01)) && (((tmp0 >> 8) & 0x0f) =3D=3D ddc_dvi)) {
-					rinfo->reversed_DAC =3D 1;
-					printk(KERN_INFO "radeonfb: Reversed DACs detected\n");
-				}
-				if ((((tmp0 >> 8) & 0x0f) =3D=3D ddc_dvi) && ((tmp0 >> 4) & 0x01)) {
-					rinfo->reversed_TMDS =3D 1;
-					printk(KERN_INFO "radeonfb: Reversed TMDS detected\n");
+			/* Probe each connector */
+			for(i =3D 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
+				if (PRIMARY_MONITOR(rinfo) > MT_NONE) break;  /* only one head */
+				if (!radeon_probe_i2c_connector(rinfo, &rinfo->connectors[i])) {
+					rinfo->heads[rinfo->num_heads] =3D i;
+					rinfo->connectors[i].head =3D rinfo->num_heads++;
 				}
 			}
+#endif /* CONFIG_FB_RADEON_I2C */
+			if (PRIMARY_MONITOR(rinfo) <=3D MT_NONE) {
+				radeon_find_connector_for_mon(rinfo, MT_CRT);
+			}
+			goto bail;
 		}
=20
-		/*
-		 * Probe primary head (DVI or laptop internal panel)
-		 */
-#ifdef CONFIG_PPC_OF
-		if (rinfo->mon1_type =3D=3D MT_NONE)
-			rinfo->mon1_type =3D radeon_probe_OF_head(rinfo, 0,
-								&rinfo->mon1_EDID);
-#endif /* CONFIG_PPC_OF */
+		/* Probe heads */
 #ifdef CONFIG_FB_RADEON_I2C
-		if (rinfo->mon1_type =3D=3D MT_NONE)
-			rinfo->mon1_type =3D radeon_probe_i2c_connector(rinfo, ddc_dvi,
-								      &rinfo->mon1_EDID);
-		if (rinfo->mon1_type =3D=3D MT_NONE) {
-			rinfo->mon1_type =3D radeon_probe_i2c_connector(rinfo, ddc_crt2,
-								      &rinfo->mon1_EDID);
-			if (rinfo->mon1_type !=3D MT_NONE)
-				ddc_crt2_used =3D 1;
+		/* Probe each connector in turn. */
+		for(i =3D 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
+			if (rinfo->connectors[i].mon_type > MT_NONE) continue; /* Don't probe "=
detected" stuff again */
+			if (!radeon_probe_i2c_connector(rinfo, &rinfo->connectors[i])) {
+				rinfo->heads[rinfo->num_heads] =3D i;
+				rinfo->connectors[i].head =3D rinfo->num_heads++;
+			}
 		}
+=09
 #endif /* CONFIG_FB_RADEON_I2C */
-		if (rinfo->mon1_type =3D=3D MT_NONE && rinfo->is_mobility &&
+
+		/* mobility chips are usually LCDs */
+		if ((PRIMARY_MONITOR(rinfo) <=3D MT_NONE) && rinfo->is_mobility &&
 		    ((rinfo->bios_seg && (INREG(BIOS_4_SCRATCH) & 4))
 		     || (INREG(LVDS_GEN_CNTL) & LVDS_ON))) {
-			rinfo->mon1_type =3D MT_LCD;
-			printk("Non-DDC laptop panel detected\n");
+			radeon_find_connector_for_mon(rinfo, MT_LCD);
+			printk(KERN_INFO "Non-DDC laptop panel detected\n");
 		}
-		if (rinfo->mon1_type =3D=3D MT_NONE)
-			rinfo->mon1_type =3D radeon_crt_is_connected(rinfo, rinfo->reversed_DAC=
);
=20
-		/*
-		 * Probe secondary head (mostly VGA, can be DVI)
-		 */
-#ifdef CONFIG_PPC_OF
-		if (rinfo->mon2_type =3D=3D MT_NONE)
-			rinfo->mon2_type =3D radeon_probe_OF_head(rinfo, 1,
-								&rinfo->mon2_EDID);
-#endif /* CONFIG_PPC_OF */
-#ifdef CONFIG_FB_RADEON_I2C
-		if (rinfo->mon2_type =3D=3D MT_NONE)
-			rinfo->mon2_type =3D radeon_probe_i2c_connector(rinfo, ddc_vga,
-								      &rinfo->mon2_EDID);
-		if (rinfo->mon2_type =3D=3D MT_NONE && !ddc_crt2_used)
-			rinfo->mon2_type =3D radeon_probe_i2c_connector(rinfo, ddc_crt2,
-								      &rinfo->mon2_EDID);
-#endif /* CONFIG_FB_RADEON_I2C */
-		if (rinfo->mon2_type =3D=3D MT_NONE)
-			rinfo->mon2_type =3D radeon_crt_is_connected(rinfo, !rinfo->reversed_DA=
C);
+		/* Probe for monitors on the primary and secondary crtc heads */
+		if (PRIMARY_MONITOR(rinfo) <=3D MT_NONE) {
+			radeon_find_connector_for_mon(rinfo, radeon_crt_is_connected(rinfo, 1));
+		}
=20
-		/*
-		 * If we only detected port 2, we swap them, if none detected,
-		 * assume CRT (maybe fallback to old BIOS_SCRATCH stuff ? or look
-		 * at FP registers ?)
-		 */
-		if (rinfo->mon1_type =3D=3D MT_NONE) {
-			if (rinfo->mon2_type !=3D MT_NONE) {
-				rinfo->mon1_type =3D rinfo->mon2_type;
-				rinfo->mon1_EDID =3D rinfo->mon2_EDID;
-			} else
-				rinfo->mon1_type =3D MT_CRT;
-			rinfo->mon2_type =3D MT_NONE;
-			rinfo->mon2_EDID =3D NULL;
+		/* If we still haven't found anything, just force it to be on the CRT.. =
*/
+		if (PRIMARY_MONITOR(rinfo) <=3D MT_NONE) {
+			radeon_find_connector_for_mon(rinfo, MT_CRT);
 		}
=20
-		/*
-		 * Deal with reversed TMDS
-		 */
-		if (rinfo->reversed_TMDS) {
-			/* Always keep internal TMDS as primary head */
-			if (rinfo->mon1_type =3D=3D MT_DFP || rinfo->mon2_type =3D=3D MT_DFP) {
-				int tmp_type =3D rinfo->mon1_type;
-				u8 *tmp_EDID =3D rinfo->mon1_EDID;
-				rinfo->mon1_type =3D rinfo->mon2_type;
-				rinfo->mon1_EDID =3D rinfo->mon2_EDID;
-				rinfo->mon2_type =3D tmp_type;
-				rinfo->mon2_EDID =3D tmp_EDID;
-				if (rinfo->mon1_type =3D=3D MT_CRT || rinfo->mon2_type =3D=3D MT_CRT)
-					rinfo->reversed_DAC ^=3D 1;
-			}
+		/* Always keep internal TMDS as primary head */
+		if (SECONDARY_HEAD_PRESENT(rinfo) && (SECONDARY_HEAD(rinfo).tmds_type =
=3D=3D tmds_internal) && (SECONDARY_MONITOR(rinfo) =3D=3D MT_DFP)) {
+			int head =3D rinfo->heads[0];
+			rinfo->heads[0] =3D rinfo->heads[1];
+			rinfo->heads[1] =3D head;
 		}
 	}
-	if (ignore_edid) {
-		kfree(rinfo->mon1_EDID);
-		rinfo->mon1_EDID =3D NULL;
-		kfree(rinfo->mon2_EDID);
-		rinfo->mon2_EDID =3D NULL;
-	}
+bail:
=20
- bail:
-	printk(KERN_INFO "radeonfb: Monitor 1 type %s found\n",
-	       radeon_get_mon_name(rinfo->mon1_type));
-	if (rinfo->mon1_EDID)
-		printk(KERN_INFO "radeonfb: EDID probed\n");
-	if (!rinfo->has_CRTC2)
-		return;
-	printk(KERN_INFO "radeonfb: Monitor 2 type %s found\n",
-	       radeon_get_mon_name(rinfo->mon2_type));
-	if (rinfo->mon2_EDID)
-		printk(KERN_INFO "radeonfb: EDID probed\n");
+	/* Dump out the heads we've found so far */
+	for (i =3D 0; i < RADEON_MAX_CONNECTORS; i++) {
+	=09
+		if (rinfo->connectors[i].conn_type =3D=3D conn_none)
+			continue;
+		printk(KERN_INFO " * Connector %d is %s. Head %d, Monitor: %s ", i+1,
+		       conn_type_name[rinfo->connectors[i].conn_type],
+		       rinfo->connectors[i].head,
+		       rinfo->connectors[i].mon_type =3D=3D MT_UNKNOWN  ?
+		         "Not Probed Yet" :=20
+		         mon_type_name[rinfo->connectors[i].mon_type]);
+		if (rinfo->connectors[i].edid) {
+			printk("EDID probed\n");
+		} else {
+			printk("\n");
+		}
+		printk(KERN_INFO "   ddc port: %d, dac: %d, tmds: %d\n",
+		       rinfo->connectors[i].ddc_type,
+		       rinfo->connectors[i].dac_type,
+		       rinfo->connectors[i].tmds_type);
+	}
 }
=20
=20
-/*
- * This functions applyes any arch/model/machine specific fixups
- * to the panel info. It may eventually alter EDID block as
- * well or whatever is specific to a given model and not probed
- * properly by the default code
- */
-static void radeon_fixup_panel_info(struct radeonfb_info *rinfo)
-{
 #ifdef CONFIG_PPC_OF
+int __devinit radeon_get_lvds_info_openfirmware(struct radeonfb_info *rinf=
o)
+{
+
 	/*
 	 * LCD Flat panels should use fixed dividers, we enfore that on
 	 * PPC only for now...
 	 */
-	if (!rinfo->panel_info.use_bios_dividers && rinfo->mon1_type =3D=3D MT_LCD
-	    && rinfo->is_mobility) {
+	If (!rinfo->panel_info.use_bios_dividers && (PRIMARY_MONITOR(rinfo) =3D=
=3D MT_LCD) &&
+	    rinfo->is_mobility) {
 		int ppll_div_sel;
 		u32 ppll_divn;
 		ppll_div_sel =3D INREG8(CLOCK_CNTL_INDEX + 1) & 0x3;
@@ -667,15 +1224,16 @@
 		rinfo->panel_info.post_divider =3D (ppll_divn >> 16) & 0x7;
 		rinfo->panel_info.use_bios_dividers =3D 1;
=20
-		printk(KERN_DEBUG "radeonfb: Using Firmware dividers 0x%08x "
+		printk(KERN_INFO "Using Firmware dividers 0x%08x "
 		       "from PPLL %d\n",
 		       rinfo->panel_info.fbk_divider |
 		       (rinfo->panel_info.post_divider << 16),
 		       ppll_div_sel);
+		return 0;
 	}
-#endif /* CONFIG_PPC_OF */
+	return 1;
 }
-
+#endif /* CONFIG_PPC_OF */
=20
 /*
  * Fill up panel infos from a mode definition, either returned by the EDID
@@ -745,19 +1303,24 @@
 	/*
 	 * First check out what BIOS has to say
 	 */
-	if (rinfo->mon1_type =3D=3D MT_LCD)
-		radeon_get_panel_info_BIOS(rinfo);
+	if (PRIMARY_MONITOR(rinfo) =3D=3D MT_LCD) {
+		if (rinfo->radeon_get_lvds_info) {
+			rinfo->radeon_get_lvds_info(rinfo);
+			// XXX Do we care about the return value?
+		}
+	}
=20
 	/*
 	 * Parse EDID detailed timings and deduce panel infos if any. Right now
 	 * we only deal with first entry returned by parse_EDID, we may do better
 	 * some day...
 	 */
-	if (!rinfo->panel_info.use_bios_dividers && rinfo->mon1_type !=3D MT_CRT
-	    && rinfo->mon1_EDID) {
+	if (!rinfo->panel_info.use_bios_dividers &&=20
+	    (PRIMARY_MONITOR(rinfo) !=3D MT_CRT) &&
+	    PRIMARY_HEAD(rinfo).edid) {
 		struct fb_var_screeninfo var;
 		RTRACE("Parsing EDID data for panel info\n");
-		if (fb_parse_edid(rinfo->mon1_EDID, &var) =3D=3D 0) {
+		if (fb_parse_edid(PRIMARY_HEAD(rinfo).edid, &var) =3D=3D 0) {
 			if (var.xres >=3D rinfo->panel_info.xres &&
 			    var.yres >=3D rinfo->panel_info.yres)
 				radeon_var_to_panel_info(rinfo, &var);
@@ -765,15 +1328,10 @@
 	}
=20
 	/*
-	 * Do any additional platform/arch fixups to the panel infos
-	 */
-	radeon_fixup_panel_info(rinfo);
-
-	/*
 	 * If we have some valid panel infos, we setup the default mode based on
 	 * those
 	 */
-	if (rinfo->mon1_type !=3D MT_CRT && rinfo->panel_info.valid) {
+	if ((PRIMARY_MONITOR(rinfo) !=3D MT_CRT) && rinfo->panel_info.valid) {
 		struct fb_var_screeninfo *var =3D &info->var;
=20
 		RTRACE("Setting up default mode based on panel info\n");
@@ -804,13 +1362,13 @@
 	/*
 	 * Now build modedb from EDID
 	 */
-	if (rinfo->mon1_EDID) {
-		fb_edid_to_monspecs(rinfo->mon1_EDID, &info->monspecs);
+	if (PRIMARY_HEAD(rinfo).edid) {
+		fb_edid_to_monspecs(PRIMARY_HEAD(rinfo).edid, &info->monspecs);
 		fb_videomode_to_modelist(info->monspecs.modedb,
 					 info->monspecs.modedb_len,
 					 &info->modelist);
-		rinfo->mon1_modedb =3D info->monspecs.modedb;
-		rinfo->mon1_dbsize =3D info->monspecs.modedb_len;
+		PRIMARY_HEAD(rinfo).modedb =3D info->monspecs.modedb;
+		PRIMARY_HEAD(rinfo).modedb_size =3D info->monspecs.modedb_len;
 	}
=20
 =09
@@ -819,7 +1377,7 @@
 	 * we try to read it from card), we try to pick a default mode
 	 * and create some panel infos. Whatever...
 	 */
-	if (rinfo->mon1_type !=3D MT_CRT && !rinfo->panel_info.valid) {
+	if ((PRIMARY_MONITOR(rinfo) !=3D MT_CRT) && !rinfo->panel_info.valid) {
 		struct fb_videomode	*modedb;
 		int			dbsize;
 		char			modename[32];
@@ -833,18 +1391,18 @@
 		}
 		if (rinfo->panel_info.xres =3D=3D 0 || rinfo->panel_info.yres =3D=3D 0) {
 			printk(KERN_WARNING "radeonfb: Can't find panel size, going back to CRT=
\n");
-			rinfo->mon1_type =3D MT_CRT;
+			radeon_find_connector_for_mon(rinfo, MT_CRT);
 			goto pickup_default;
 		}
 		printk(KERN_WARNING "radeonfb: Assuming panel size %dx%d\n",
 		       rinfo->panel_info.xres, rinfo->panel_info.yres);
-		modedb =3D rinfo->mon1_modedb;
-		dbsize =3D rinfo->mon1_dbsize;
+		modedb =3D PRIMARY_HEAD(rinfo).modedb;
+		dbsize =3D PRIMARY_HEAD(rinfo).modedb_size;
 		snprintf(modename, 31, "%dx%d", rinfo->panel_info.xres, rinfo->panel_inf=
o.yres);
 		if (fb_find_mode(&info->var, info, modename,
 				 modedb, dbsize, NULL, 8) =3D=3D 0) {
 			printk(KERN_WARNING "radeonfb: Can't find mode for panel size, going ba=
ck to CRT\n");
-			rinfo->mon1_type =3D MT_CRT;
+			radeon_find_connector_for_mon(rinfo, MT_CRT);
 			goto pickup_default;
 		}
 		has_default_mode =3D 1;
@@ -947,14 +1505,14 @@
 	memcpy(dest, src, sizeof(struct fb_var_screeninfo));
=20
 	/* Check if we have a modedb built from EDID */
-	if (rinfo->mon1_modedb) {
-		db =3D rinfo->mon1_modedb;
-		dbsize =3D rinfo->mon1_dbsize;
+	if (PRIMARY_HEAD(rinfo).modedb) {
+		db =3D PRIMARY_HEAD(rinfo).modedb;
+		dbsize =3D PRIMARY_HEAD(rinfo).modedb_size;
 		native_db =3D 1;
 	}
=20
 	/* Check if we have a scaler allowing any fancy mode */
-	has_rmx =3D rinfo->mon1_type =3D=3D MT_LCD || rinfo->mon1_type =3D=3D MT_=
DFP;
+	has_rmx =3D (PRIMARY_MONITOR(rinfo) =3D=3D MT_LCD) || (PRIMARY_MONITOR(ri=
nfo) =3D=3D MT_DFP);
=20
 	/* If we have a scaler and are passed FB_ACTIVATE_TEST or
 	 * FB_ACTIVATE_NOW, just do basic checking and return if the
@@ -967,7 +1525,7 @@
 		 * 640x480-60, but I assume userland knows what it's doing here
 		 * (though I may be proven wrong...)
 		 */
-		if (has_rmx =3D=3D 0 && rinfo->mon1_modedb)
+		if (has_rmx =3D=3D 0 && PRIMARY_HEAD(rinfo).modedb)
 			if (fb_validate_mode((struct fb_var_screeninfo *)src, rinfo->info))
 				return -EINVAL;
 		return 0;
diff -Naur aty-2.6.17/radeonfb.h aty-2.6.17-patched/radeonfb.h
--- aty-2.6.17/radeonfb.h	2006-09-05 10:15:55.000000000 -0400
+++ aty-2.6.17-patched/radeonfb.h	2006-09-05 10:34:51.000000000 -0400
@@ -87,11 +87,50 @@
 	CHIP_ERRATA_PLL_DELAY		=3D 0x00000004,
 };
=20
+/*
+ * DDC i2c ports
+ */
+enum radeon_ddc_type {
+	ddc_none =3D -1,
+	ddc_monid =3D 0,
+	ddc_dvi,
+	ddc_vga,
+	ddc_crt2,
+};
+
+/*
+ * Connector types
+ */
+enum radeon_legacy_conn_type {
+	legacy_conn_none =3D 0,
+	legacy_conn_proprietary,
+	legacy_conn_crt,
+	legacy_conn_dvi_i,
+	legacy_conn_dvi_d,
+	legacy_conn_ctv,
+	legacy_conn_stv,
+	legacy_conn_unsupported,
+};
+
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
+	conn_proprietary,
+};
=20
 /*
  * Monitor types
  */
-enum radeon_montype {
+enum radeon_mon_type {
+	MT_UNKNOWN =3D -1,
 	MT_NONE =3D 0,
 	MT_CRT,		/* CRT */
 	MT_LCD,		/* LCD */
@@ -101,27 +140,45 @@
 };
=20
 /*
- * DDC i2c ports
+ * DAC types
  */
-enum ddc_type {
-	ddc_none,
-	ddc_monid,
-	ddc_dvi,
-	ddc_vga,
-	ddc_crt2,
+enum radeon_dac_type {
+	dac_unknown =3D -1,
+	dac_primary =3D 0,
+	dac_tvdac =3D 1,
 };
=20
 /*
- * Connector types
+ * TMDS types
  */
-enum conn_type {
-	conn_none,
-	conn_proprietary,
-	conn_crt,
-	conn_DVI_I,
-	conn_DVI_D,
+enum radeon_tmds_type {
+	tmds_unknown =3D -1,
+	tmds_internal =3D 0,
+	tmds_external =3D 1,
 };
=20
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
+
+	int head;
+};
+
+/*
+ * Currently, the driver deals with at most 4 connectors
+ */
+#define RADEON_MAX_CONNECTORS	4
=20
 /*
  * PLL infos
@@ -129,11 +186,19 @@
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
@@ -298,6 +363,20 @@
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
+	int                     heads[RADEON_MAX_CONNECTORS];  // index into conn=
ectors.
+	int                     num_heads;  // number of heads.
+
 	u32			pseudo_palette[17];
 	struct { u8 red, green, blue, pad; }
 				palette[256];
@@ -316,15 +395,8 @@
 	int			has_CRTC2;
 	int			is_mobility;
 	int			is_IGP;
-	int			reversed_DAC;
-	int			reversed_TMDS;
 	struct panel_info	panel_info;
-	int			mon1_type;
-	u8			*mon1_EDID;
-	struct fb_videomode	*mon1_modedb;
-	int			mon1_dbsize;
-	int			mon2_type;
-	u8		        *mon2_EDID;
+	struct radeon_tmds_pll_info	tmds_pll[4];
=20
 	u32			dp_gui_master_cntl;
=20
@@ -356,8 +428,13 @@
 };
=20
=20
-#define PRIMARY_MONITOR(rinfo)	(rinfo->mon1_type)
+#define PRIMARY_HEAD(rinfo)      (rinfo->connectors[rinfo->heads[0]])
+#define SECONDARY_HEAD(rinfo)    (rinfo->connectors[rinfo->heads[1]])
+
+#define SECONDARY_HEAD_PRESENT(rinfo) (rinfo->heads[1] !=3D -1)
=20
+#define PRIMARY_MONITOR(rinfo)	 (rinfo->connectors[rinfo->heads[0]].mon_ty=
pe)
+#define SECONDARY_MONITOR(rinfo) ((SECONDARY_HEAD_PRESENT(rinfo) ? (rinfo-=
>connectors[rinfo->heads[1]].mon_type) : MT_NONE))
=20
 /*
  * Debugging stuffs
@@ -596,7 +673,7 @@
 /* I2C Functions */
 extern void radeon_create_i2c_busses(struct radeonfb_info *rinfo);
 extern void radeon_delete_i2c_busses(struct radeonfb_info *rinfo);
-extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int con=
n, u8 **out_edid);
+extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, struct =
radeon_connector *conn);
=20
 /* PM Functions */
 extern int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state);
@@ -625,4 +702,18 @@
 extern void radeon_write_mode (struct radeonfb_info *rinfo, struct radeon_=
regs *mode,
 			       int reg_only);
=20
+/* Bios functions.  Fix this. */
+extern void __devinit radeon_get_conn_info(struct radeonfb_info *rinfo, in=
t ignore_conntable);
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
+#ifdef CONFIG_PPC_OF
+extern int __devinit radeon_get_lvds_info_openfirmware(struct radeonfb_inf=
o *rinfo);
+extern int __devinit radeon_get_conn_info_openfirmware(struct radeonfb_inf=
o *rinfo);
+#endif
 #endif /* __RADEONFB_H__ */

--4zI0WCX1RcnW9Hbu--

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFE/ZmpPuLgii2759ARAsNtAJ9wcBKF3XSXDXAj67/HnZotK+R3DgCg50sM
Tn4wVVdciaKA1WFK5ddxAT0=
=xK5J
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--


--===============0513624422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0513624422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0513624422==--
