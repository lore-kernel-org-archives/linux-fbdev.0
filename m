From: syrjala@sci.fi
Subject: [PATCH 09/10] atyfb: VT/GT cleanup
Date: Fri,  9 Dec 2005 02:44:28 +0200 (EET)
Message-ID: <20051209004428.7B0712BA@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkWNK-0004wP-I9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 16:44:38 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkWNJ-0004rn-1Z
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 16:44:38 -0800
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
MIME-Version: 1.0
Content-Type: text; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: alex.kern@gmx.de
Cc: linux-fbdev-devel@lists.sourceforge.net

Clean up VT and GT chip descriptions.

All B revision VT chips are called 264VT3. Verified from pictures of the=20
chips as the specs are a bit unlear in this.

GT revision B1 is Rage II, B2 is Rage II+. Specs and chip pictures seem=20
to agree.

VT revision A4 is 264VT2. Revision A3 is probably a plain 264VT.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
---

 atyfb_base.c |   62 +++++++++++++++++++++++++++++++++++++++---------------=
-----
 1 file changed, 41 insertions(+), 21 deletions(-)

diff -urpN linux-8/drivers/video/aty/atyfb_base.c linux-9/drivers/video/aty=
/atyfb_base.c
--- linux-8/drivers/video/aty/atyfb_base.c	2005-12-09 02:56:32.000000000 +0=
200
+++ linux-9/drivers/video/aty/atyfb_base.c	2005-12-09 02:57:12.000000000 +0=
200
@@ -380,11 +380,12 @@ static struct {
 #ifdef CONFIG_FB_ATY_CT
 	{ PCI_CHIP_MACH64CT, "ATI264CT (Mach64 CT)", 135, 60, 60, 0, ATI_CHIP_264=
CT },
 	{ PCI_CHIP_MACH64ET, "ATI264ET (Mach64 ET)", 135, 60, 60, 0, ATI_CHIP_264=
ET },
-	{ PCI_CHIP_MACH64VT, "ATI264VT? (Mach64 VT)", 170, 67, 67, 80, ATI_CHIP_2=
64VT },
+
+	{ PCI_CHIP_MACH64VT, "ATI264VT (Mach64 VT)", 170, 67, 67, 80, ATI_CHIP_26=
4VT },
 	{ PCI_CHIP_MACH64GT, "3D RAGE (Mach64 GT)", 135, 63, 63, 80, ATI_CHIP_264=
GT },
-	/* FIXME { ...ATI_264GU, maybe ATI_CHIP_264GTDVD }, */
-	{ PCI_CHIP_MACH64GU, "3D RAGE II+ (Mach64 GTB)", 200, 67, 67, 100, ATI_CH=
IP_264GTB  },
-	{ PCI_CHIP_MACH64VU, "ATI264VTB (Mach64 VU)", 200, 67, 67, 80, ATI_CHIP_2=
64VT3 },
+
+	{ PCI_CHIP_MACH64VU, "ATI264VT3 (Mach64 VU)", 200, 67, 67, 80, ATI_CHIP_2=
64VT3 },
+	{ PCI_CHIP_MACH64GU, "3D RAGE II+ (Mach64 GU)", 200, 67, 67, 100, ATI_CHI=
P_264GTB },
=20
 	{ PCI_CHIP_MACH64LT, "3D RAGE LT (Mach64 LT)", 135, 63, 63, 0, ATI_CHIP_2=
64LT },
 	 /* FIXME chipset maybe ATI_CHIP_264LTPRO ? */
@@ -460,44 +461,63 @@ static int __devinit correct_chipset(str
 #endif
 #ifdef CONFIG_FB_ATY_CT
 	case PCI_CHIP_MACH64VT:
-		rev &=3D 0xc7;
-		if(rev =3D=3D 0x00) {
-			name =3D "ATI264VTA3 (Mach64 VT)";
-			par->pll_limits.pll_max =3D 170;
-			par->pll_limits.mclk =3D 67;
-			par->pll_limits.xclk =3D 67;
-			par->pll_limits.ecp_max =3D 80;
-			par->features =3D ATI_CHIP_264VT;
-		} else if(rev =3D=3D 0x40) {
-			name =3D "ATI264VTA4 (Mach64 VT)";
+		switch (rev & 0x07) {
+		case 0x00:
+			switch (rev & 0xc0) {
+			case 0x00:
+				name =3D "ATI264VT (A3) (Mach64 VT)";
+				par->pll_limits.pll_max =3D 170;
+				par->pll_limits.mclk =3D 67;
+				par->pll_limits.xclk =3D 67;
+				par->pll_limits.ecp_max =3D 80;
+				par->features =3D ATI_CHIP_264VT;
+				break;
+			case 0x40:
+				name =3D "ATI264VT2 (A4) (Mach64 VT)";
+				par->pll_limits.pll_max =3D 200;
+				par->pll_limits.mclk =3D 67;
+				par->pll_limits.xclk =3D 67;
+				par->pll_limits.ecp_max =3D 80;
+				par->features =3D ATI_CHIP_264VT | M64F_MAGIC_POSTDIV;
+				break;
+			}
+			break;
+		case 0x01:
+			name =3D "ATI264VT3 (B1) (Mach64 VT)";
 			par->pll_limits.pll_max =3D 200;
 			par->pll_limits.mclk =3D 67;
 			par->pll_limits.xclk =3D 67;
 			par->pll_limits.ecp_max =3D 80;
-			par->features =3D ATI_CHIP_264VT | M64F_MAGIC_POSTDIV;
-		} else {
-			name =3D "ATI264VTB (Mach64 VT)";
+			par->features =3D ATI_CHIP_264VTB;
+			break;
+		case 0x02:
+			name =3D "ATI264VT3 (B2) (Mach64 VT)";
 			par->pll_limits.pll_max =3D 200;
 			par->pll_limits.mclk =3D 67;
 			par->pll_limits.xclk =3D 67;
 			par->pll_limits.ecp_max =3D 80;
-			par->features =3D ATI_CHIP_264VTB;
+			par->features =3D ATI_CHIP_264VT3;
+			break;
 		}
 		break;
 	case PCI_CHIP_MACH64GT:
-		rev &=3D 0x07;
-		if(rev =3D=3D 0x01) {
+		switch (rev & 0x07) {
+		case 0x01:
+			name =3D "3D RAGE II (Mach64 GT)";
 			par->pll_limits.pll_max =3D 170;
 			par->pll_limits.mclk =3D 67;
 			par->pll_limits.xclk =3D 67;
 			par->pll_limits.ecp_max =3D 80;
 			par->features =3D ATI_CHIP_264GTB;
-		} else if(rev =3D=3D 0x02) {
+			break;
+		case 0x02:
+			name =3D "3D RAGE II+ (Mach64 GT)";
 			par->pll_limits.pll_max =3D 200;
 			par->pll_limits.mclk =3D 67;
 			par->pll_limits.xclk =3D 67;
 			par->pll_limits.ecp_max =3D 100;
 			par->features =3D ATI_CHIP_264GTB;
+			break;
 		}
 		break;
 #endif



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
