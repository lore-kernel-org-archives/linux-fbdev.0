From: syrjala@sci.fi
Subject: [PATCH 5/8] atyfb: Rage XL/XC cleanup
Date: Thu, 17 Mar 2005 08:31:04 +0200 (EET)
Message-ID: <20050317063104.A0FE47A@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBoXD-0006Fn-9G
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 22:31:07 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBoXB-00049T-Ja
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 22:31:07 -0800
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
Content-Type: text; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: alex.kern@gmx.de

Clean up 3D Rage XL/XC chip descriptions.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 atyfb_base.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff -urN linux/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux/drivers/video/aty/atyfb_base.c	2005-03-17 04:08:40.000000000 +0200
+++ linux/drivers/video/aty/atyfb_base.c	2005-03-17 04:08:45.000000000 +0200
@@ -409,12 +409,12 @@
 	{ PCI_CHIP_MACH64LP, "3D RAGE LT PRO (Mach64 LP, PCI)", 230, 100, 100, 135, ATI_CHIP_264LTPRO },
 	{ PCI_CHIP_MACH64LQ, "3D RAGE LT PRO (Mach64 LQ, PCI)", 230, 100, 100, 135, ATI_CHIP_264LTPRO },
 
-	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP)", 230, 83, 63, 135, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GN, "3D RAGE XL (Mach64 GN, AGP)", 230, 83, 63, 135, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66/BGA)", 230, 83, 63, 135, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 230, 83, 63, 135, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GL, "3D RAGE XL (Mach64 GL, PCI)", 230, 83, 63, 135, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, 135, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP 2x)", 230, 83, 63, 135, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GN, "3D RAGE XC (Mach64 GN, AGP 2x)", 230, 83, 63, 135, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66)", 230, 83, 63, 135, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GL, "3D RAGE XC (Mach64 GL, PCI-66)", 230, 83, 63, 135, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33)", 230, 83, 63, 135, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GS, "3D RAGE XC (Mach64 GS, PCI-33)", 230, 83, 63, 135, ATI_CHIP_264XL },
 
 	{ PCI_CHIP_MACH64LM, "3D RAGE Mobility P/M (Mach64 LM, AGP 2x)", 230, 83, 125, 135, ATI_CHIP_MOBILITY },
 	{ PCI_CHIP_MACH64LN, "3D RAGE Mobility L (Mach64 LN, AGP 2x)", 230, 83, 125, 135, ATI_CHIP_MOBILITY },



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
