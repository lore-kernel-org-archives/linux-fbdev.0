From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/7] atyfb: Halve XCLK with Mobility and
	32bit memory
Date: Sun, 29 Apr 2007 11:51:50 +0800
Message-ID: <46341656.9040308@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hi0UE-0003i6-S1 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:54:11 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hi0UD-000446-AK
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:54:10 -0700
Received: by py-out-1112.google.com with SMTP id a29so1108343pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 28 Apr 2007 20:54:09 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Ville Syrjala <syrjala@sci.fi>

Laptops with Rage Mobility and 32bit memory interface seem to require
halved XCLK to operate correctly.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/aty/atyfb_base.c |    3 +++
 include/video/mach64.h         |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 617dc0c..f594b9c 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2377,6 +2377,9 @@ #ifdef CONFIG_FB_ATY_CT
 		/* for many chips, the mclk is 67 MHz for SDRAM, 63 MHz otherwise */
 		if (par->pll_limits.mclk == 67 && par->ram_type < SDRAM)
 			par->pll_limits.mclk = 63;
+		/* Mobility + 32bit memory interface need halved XCLK. */
+		if (M64_HAS(MOBIL_BUS) && par->ram_type == SDRAM32)
+			par->pll_limits.xclk = (par->pll_limits.xclk + 1) >> 1;
 	}
 #endif
 
diff --git a/include/video/mach64.h b/include/video/mach64.h
index 09a7f4a..a8332e5 100644
--- a/include/video/mach64.h
+++ b/include/video/mach64.h
@@ -885,6 +885,7 @@ #define PSEUDO_EDO		3
 #define SDRAM			4
 #define SGRAM			5
 #define WRAM			6
+#define SDRAM32			6
 
 #define DAC_INTERNAL		0x00
 #define DAC_IBMRGB514		0x01


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
