From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb (2.6): Fix mem_refresh_rate for Mobility
Date: Fri, 7 May 2004 05:18:38 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040507021838.GB11715@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="i9LlY+UWpKt15+FH"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLuwk-000075-Az
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 19:18:42 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLuwj-0004pd-Oa
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 19:18:41 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id E5E621140398
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  7 May 2004 05:18:38 +0300 (EEST)
Content-Disposition: inline
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


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch fixes mem_refresh_rate for Mobility chips (they use XL/XC=20
values).

It also adds the missing Mobility PCI IDs and changes the chip name=20
strings to include the P/M vs. L classification for all chips.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atyfb-2.6-mobility_mem_refresh.patch"

diff -urN linux.orig/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux.orig/drivers/video/aty/atyfb_base.c	2004-05-07 04:29:11.279596432 +0300
+++ linux/drivers/video/aty/atyfb_base.c	2004-05-07 04:29:27.576118984 +0300
@@ -365,9 +365,9 @@
 	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, ATI_CHIP_264XL },
 
 	{ PCI_CHIP_MACH64LM, "3D RAGE Mobility P/M (Mach64 LM, AGP 2x)", 230, 83, 125, ATI_CHIP_MOBILITY },
-	{ PCI_CHIP_MACH64LN, "3D RAGE Mobility (Mach64 LN, AGP 2x)", 230, 83, 125, ATI_CHIP_MOBILITY },
-	{ PCI_CHIP_MACH64LR, "3D RAGE Mobility (Mach64 LR, PCI)", 230, 83, 125, ATI_CHIP_MOBILITY },
-	{ PCI_CHIP_MACH64LS, "3D RAGE Mobility (Mach64 LS, PCI)", 230, 83, 125, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LN, "3D RAGE Mobility L (Mach64 LN, AGP 2x)", 230, 83, 125, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LR, "3D RAGE Mobility P/M (Mach64 LR, PCI)", 230, 83, 125, ATI_CHIP_MOBILITY },
+	{ PCI_CHIP_MACH64LS, "3D RAGE Mobility L (Mach64 LS, PCI)", 230, 83, 125, ATI_CHIP_MOBILITY },
 #endif /* CONFIG_FB_ATY_CT */
 };
 
@@ -1993,7 +1993,7 @@
 	const int *refresh_tbl;
 	int i, size;
 
-	if (IS_XL(par->pci_id)) {
+	if (IS_XL(par->pci_id) || IS_MOBILITY(par->pci_id)) {
 		refresh_tbl = ragexl_tbl;
 		size = sizeof(ragexl_tbl)/sizeof(int);
 	} else {
diff -urN linux.orig/include/video/mach64.h linux/include/video/mach64.h
--- linux.orig/include/video/mach64.h	2004-05-07 04:29:11.280596280 +0300
+++ linux/include/video/mach64.h	2004-05-07 04:29:29.725792184 +0300
@@ -912,9 +912,14 @@
 #define GI_CHIP_ID	0x4749	/* RAGE PRO, BGA, PCI33 only */
 #define GP_CHIP_ID	0x4750	/* RAGE PRO, PQFP, PCI33, full 3D */
 #define GQ_CHIP_ID	0x4751	/* RAGE PRO, PQFP, PCI33, limited 3D */
-#define LM_CHIP_ID	0x4c4d	/* RAGE Mobility PCI */
+
+#define LM_CHIP_ID	0x4c4d	/* RAGE Mobility AGP, full function */
 #define LN_CHIP_ID	0x4c4e	/* RAGE Mobility AGP */
+#define LR_CHIP_ID	0x4c52	/* RAGE Mobility PCI, full function */
+#define LS_CHIP_ID	0x4c53	/* RAGE Mobility PCI */
 
+#define IS_MOBILITY(id) ((id)==LM_CHIP_ID || (id)==LN_CHIP_ID || \
+			 (id)==LR_CHIP_ID || (id)==LS_CHIP_ID)
 
 /* Mach64 major ASIC revisions */
 #define MACH64_ASIC_NEC_VT_A3		0x08

--i9LlY+UWpKt15+FH--


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
