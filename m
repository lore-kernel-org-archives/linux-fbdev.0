From: Ville Syrjala <syrjala@sci.fi>
Subject: [patch 2/3] atyfb: Reorganize clock init
Date: Sat, 28 Apr 2007 21:17:15 +0300
Message-ID: <20070428181817.770768679@ob6000.korsu.shacknet.nu>
References: <20070428181713.086211486@ob6000.korsu.shacknet.nu>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============0899965035=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhrV0-0007lj-Iw for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 11:18:22 -0700
Received: from smtp4.pp.htv.fi ([213.243.153.38])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HhrUz-0004jS-W1
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

--===============0899965035==
Content-Disposition: inline; filename=atyfb_reorganize_clock_init.patch

Reorganize atyfb clock init code so command line clock overrides are
effective for all chips. The old code would silently ignore some of the
command line clock overrides with some chips.

---
 drivers/video/aty/atyfb_base.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

Index: linux-2.6.20.7/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.20.7.orig/drivers/video/aty/atyfb_base.c
+++ linux-2.6.20.7/drivers/video/aty/atyfb_base.c
@@ -2352,20 +2352,6 @@ static int __devinit aty_init(struct fb_
 		par->pll_limits.xclk = 53;
 	}
 #endif
-	if (pll)
-		par->pll_limits.pll_max = pll;
-	if (mclk)
-		par->pll_limits.mclk = mclk;
-	if (xclk)
-		par->pll_limits.xclk = xclk;
-
-	aty_calc_mem_refresh(par, par->pll_limits.xclk);
-	par->pll_per = 1000000/par->pll_limits.pll_max;
-	par->mclk_per = 1000000/par->pll_limits.mclk;
-	par->xclk_per = 1000000/par->pll_limits.xclk;
-
-	par->ref_clk_per = 1000000000000ULL / 14318180;
-	xtal = "14.31818";
 
 #ifdef CONFIG_FB_ATY_GX
 	if (!M64_HAS(INTEGRATED)) {
@@ -2445,7 +2431,25 @@ static int __devinit aty_init(struct fb_
 		if (par->pll_limits.mclk == 67 && par->ram_type < SDRAM)
 			par->pll_limits.mclk = 63;
 	}
+#endif
 
+	/* Allow command line to override clocks. */
+	if (pll)
+		par->pll_limits.pll_max = pll;
+	if (mclk)
+		par->pll_limits.mclk = mclk;
+	if (xclk)
+		par->pll_limits.xclk = xclk;
+
+	aty_calc_mem_refresh(par, par->pll_limits.xclk);
+	par->pll_per = 1000000/par->pll_limits.pll_max;
+	par->mclk_per = 1000000/par->pll_limits.mclk;
+	par->xclk_per = 1000000/par->pll_limits.xclk;
+
+	par->ref_clk_per = 1000000000000ULL / 14318180;
+	xtal = "14.31818";
+
+#ifdef CONFIG_FB_ATY_CT
 	if (M64_HAS(GTB_DSP)) {
 		u8 pll_ref_div = aty_ld_pll_ct(PLL_REF_DIV, par);
 

-- 
Ville Syrj������l������
syrjala@sci.fi
http://www.sci.fi/~syrjala/


--===============0899965035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0899965035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0899965035==--
