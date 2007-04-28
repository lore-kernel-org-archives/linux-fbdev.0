From: Ville Syrjala <syrjala@sci.fi>
Subject: [patch 3/3] atyfb: Halve XCLK with Mobility and
	32bit memory
Date: Sat, 28 Apr 2007 21:17:16 +0300
Message-ID: <20070428181818.683056217@ob6000.korsu.shacknet.nu>
References: <20070428181713.086211486@ob6000.korsu.shacknet.nu>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1614978221=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhrV0-0007le-7v for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 11:18:22 -0700
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HhrUy-0004jj-HU
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 11:18:22 -0700
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
Cc: adaplas@gmail.com

--===============1614978221==
Content-Disposition: inline;
	filename=atyfb_halve_xclk_with_mobility_and_32bit_memory.patch

Laptops with Rage Mobility and 32bit memory interface seem to require
halved XCLK to operate correctly.

---
 drivers/video/aty/atyfb_base.c |    3 +++
 include/video/mach64.h         |    1 +
 2 files changed, 4 insertions(+)

Index: linux-2.6.20.7/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.20.7.orig/drivers/video/aty/atyfb_base.c
+++ linux-2.6.20.7/drivers/video/aty/atyfb_base.c
@@ -2430,6 +2430,9 @@ static int __devinit aty_init(struct fb_
 		/* for many chips, the mclk is 67 MHz for SDRAM, 63 MHz otherwise */
 		if (par->pll_limits.mclk == 67 && par->ram_type < SDRAM)
 			par->pll_limits.mclk = 63;
+		/* Mobility + 32bit memory interface need halved XCLK. */
+		if (M64_HAS(MOBIL_BUS) && par->ram_type == SDRAM32)
+			par->pll_limits.xclk = (par->pll_limits.xclk + 1) >> 1;
 	}
 #endif
 
Index: linux-2.6.20.7/include/video/mach64.h
===================================================================
--- linux-2.6.20.7.orig/include/video/mach64.h
+++ linux-2.6.20.7/include/video/mach64.h
@@ -885,6 +885,7 @@
 #define SDRAM			4
 #define SGRAM			5
 #define WRAM			6
+#define SDRAM32			6
 
 #define DAC_INTERNAL		0x00
 #define DAC_IBMRGB514		0x01

-- 
Ville Syrj������l������
syrjala@sci.fi
http://www.sci.fi/~syrjala/


--===============1614978221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1614978221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1614978221==--
