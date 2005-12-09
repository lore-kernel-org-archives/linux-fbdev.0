From: syrjala@sci.fi
Subject: [PATCH 08/10] atyfb: Rage XL/XC cleanup
Date: Fri,  9 Dec 2005 02:44:28 +0200 (EET)
Message-ID: <20051209004428.595512B9@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkWNI-0004vl-8e
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 16:44:36 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkWNG-0002So-SD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 16:44:36 -0800
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

Clean up Rage XL/XC chip descriptions.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
---

 atyfb_base.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff -urpN linux-7/drivers/video/aty/atyfb_base.c linux-8/drivers/video/aty=
/atyfb_base.c
--- linux-7/drivers/video/aty/atyfb_base.c	2005-12-09 02:55:42.000000000 +0=
200
+++ linux-8/drivers/video/aty/atyfb_base.c	2005-12-09 02:56:32.000000000 +0=
200
@@ -409,12 +409,12 @@ static struct {
 	{ PCI_CHIP_MACH64LP, "3D RAGE LT PRO (Mach64 LP, PCI)", 230, 100, 100, 13=
5, ATI_CHIP_264LTPRO },
 	{ PCI_CHIP_MACH64LQ, "3D RAGE LT PRO (Mach64 LQ, PCI)", 230, 100, 100, 13=
5, ATI_CHIP_264LTPRO },
=20
-	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP)", 230, 83, 63, 135, ATI=
_CHIP_264XL },
-	{ PCI_CHIP_MACH64GN, "3D RAGE XL (Mach64 GN, AGP)", 230, 83, 63, 135, ATI=
_CHIP_264XL },
-	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66/BGA)", 230, 83, 63, 1=
35, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 230, 83, 63, 13=
5, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GL, "3D RAGE XL (Mach64 GL, PCI)", 230, 83, 63, 135, ATI=
_CHIP_264XL },
-	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, 135, ATI=
_CHIP_264XL },
+	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP 2x)", 230, 83, 63, 135, =
ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GN, "3D RAGE XC (Mach64 GN, AGP 2x)", 230, 83, 63, 135, =
ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66)", 230, 83, 63, 135, =
ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GL, "3D RAGE XC (Mach64 GL, PCI-66)", 230, 83, 63, 135, =
ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33)", 230, 83, 63, 135, =
ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GS, "3D RAGE XC (Mach64 GS, PCI-33)", 230, 83, 63, 135, =
ATI_CHIP_264XL },
=20
 	{ PCI_CHIP_MACH64LM, "3D RAGE Mobility P/M (Mach64 LM, AGP 2x)", 230, 83,=
 125, 135, ATI_CHIP_MOBILITY },
 	{ PCI_CHIP_MACH64LN, "3D RAGE Mobility L (Mach64 LN, AGP 2x)", 230, 83, 1=
25, 135, ATI_CHIP_MOBILITY },



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
