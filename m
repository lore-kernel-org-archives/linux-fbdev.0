From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 15/18] atyfb: Rage XL/XC cleanup
Date: Sat, 10 Dec 2005 14:13:34 +0800
Message-ID: <439A720E.2010504@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky6B-0002rq-FV
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:20:47 -0800
Received: from zproxy.gmail.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky6A-0004wu-5s
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:20:47 -0800
Received: by zproxy.gmail.com with SMTP id k1so1082358nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:20:45 -0800 (PST)
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
Content-Type: text/plain; charset="iso-8859-1"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>

From: Ville Syrj=E4l=E4 <syrjala@sci.fi>

Clean up Rage XL/XC chip descriptions.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/atyfb_base.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_bas=
e.c
index c4a953c..52b8b36 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -409,12 +409,12 @@ static struct {
 	{ PCI_CHIP_MACH64LP, "3D RAGE LT PRO (Mach64 LP, PCI)", 230, 100, 100, =
135, ATI_CHIP_264LTPRO },
 	{ PCI_CHIP_MACH64LQ, "3D RAGE LT PRO (Mach64 LQ, PCI)", 230, 100, 100, =
135, ATI_CHIP_264LTPRO },
=20
-	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP)", 230, 83, 63, 135, A=
TI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GN, "3D RAGE XL (Mach64 GN, AGP)", 230, 83, 63, 135, A=
TI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66/BGA)", 230, 83, 63,=
 135, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 230, 83, 63, =
135, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GL, "3D RAGE XL (Mach64 GL, PCI)", 230, 83, 63, 135, A=
TI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, 135, A=
TI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP 2x)", 230, 83, 63, 135=
, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GN, "3D RAGE XC (Mach64 GN, AGP 2x)", 230, 83, 63, 135=
, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66)", 230, 83, 63, 135=
, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GL, "3D RAGE XC (Mach64 GL, PCI-66)", 230, 83, 63, 135=
, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33)", 230, 83, 63, 135=
, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GS, "3D RAGE XC (Mach64 GS, PCI-33)", 230, 83, 63, 135=
, ATI_CHIP_264XL },
=20
 	{ PCI_CHIP_MACH64LM, "3D RAGE Mobility P/M (Mach64 LM, AGP 2x)", 230, 8=
3, 125, 135, ATI_CHIP_MOBILITY },
 	{ PCI_CHIP_MACH64LN, "3D RAGE Mobility L (Mach64 LN, AGP 2x)", 230, 83,=
 125, 135, ATI_CHIP_MOBILITY },




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
