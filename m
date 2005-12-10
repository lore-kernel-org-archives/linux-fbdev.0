From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 17/18] atyfb: LT/LG cleanup
Date: Sat, 10 Dec 2005 14:14:44 +0800
Message-ID: <439A7254.2020500@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky6W-0002sd-Sv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:21:08 -0800
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky6W-000560-FB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:21:08 -0800
Received: by zproxy.gmail.com with SMTP id z3so1046564nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:21:07 -0800 (PST)
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

Clean up LT and LG chip descriptions.

"Mach64 LG" is called 3D Rage LT in the specs and ATI press releases.

"Mach64 LT" is unclear. XFree86 driver doesn't know this chip at all.
Windows display.inf calls it just "mach64 LT" and it uses the same
driver as VT-A/GT-A and older chips. VT-B/GT-B and better use another
driver and all of those chips have a more descriptive name in the
display.inf file. That makes me think this chip is not a 3D Rage chip.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/atyfb_base.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_bas=
e.c
index 36c6449..d9c9074 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -349,6 +349,7 @@ static unsigned long phys_guiregbase[FB_
 #define ATI_CHIP_264VT3    (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M6=
4F_GTB_DSP | M64F_SDRAM_MAGIC_PLL)
 #define ATI_CHIP_264VT4    (M64F_VT | M64F_INTEGRATED               | M6=
4F_GTB_DSP)
=20
+/* FIXME what is this chip? */
 #define ATI_CHIP_264LT     (M64F_GT | M64F_INTEGRATED               | M6=
4F_GTB_DSP)
=20
 /* make sets shorter */
@@ -381,15 +382,16 @@ static struct {
 	{ PCI_CHIP_MACH64CT, "ATI264CT (Mach64 CT)", 135, 60, 60, 0, ATI_CHIP_2=
64CT },
 	{ PCI_CHIP_MACH64ET, "ATI264ET (Mach64 ET)", 135, 60, 60, 0, ATI_CHIP_2=
64ET },
=20
+	/* FIXME what is this chip? */
+	{ PCI_CHIP_MACH64LT, "ATI264LT (Mach64 LT)", 135, 63, 63, 0, ATI_CHIP_2=
64LT },
+
 	{ PCI_CHIP_MACH64VT, "ATI264VT (Mach64 VT)", 170, 67, 67, 80, ATI_CHIP_=
264VT },
 	{ PCI_CHIP_MACH64GT, "3D RAGE (Mach64 GT)", 135, 63, 63, 80, ATI_CHIP_2=
64GT },
=20
 	{ PCI_CHIP_MACH64VU, "ATI264VT3 (Mach64 VU)", 200, 67, 67, 80, ATI_CHIP=
_264VT3 },
 	{ PCI_CHIP_MACH64GU, "3D RAGE II+ (Mach64 GU)", 200, 67, 67, 100, ATI_C=
HIP_264GTB },
=20
-	{ PCI_CHIP_MACH64LT, "3D RAGE LT (Mach64 LT)", 135, 63, 63, 0, ATI_CHIP=
_264LT },
-	 /* FIXME chipset maybe ATI_CHIP_264LTPRO ? */
-	{ PCI_CHIP_MACH64LG, "3D RAGE LT-G (Mach64 LG)", 230, 63, 63, 100, ATI_=
CHIP_264LTG | M64F_LT_LCD_REGS | M64F_G3_PB_1024x768 },
+	{ PCI_CHIP_MACH64LG, "3D RAGE LT (Mach64 LG)", 230, 63, 63, 100, ATI_CH=
IP_264LTG | M64F_LT_LCD_REGS | M64F_G3_PB_1024x768 },
=20
 	{ PCI_CHIP_MACH64VV, "ATI264VT4 (Mach64 VV)", 230, 83, 83, 100, ATI_CHI=
P_264VT4 },
=20




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
