From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/7] atyfb: Reorganize clock init
Date: Sun, 29 Apr 2007 11:51:14 +0800
Message-ID: <46341632.7060306@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hi0U4-0003cd-Mu for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:54:00 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hi0U4-000446-ER
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:54:00 -0700
Received: by py-out-1112.google.com with SMTP id a29so1108343pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 28 Apr 2007 20:54:00 -0700 (PDT)
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

Reorganize atyfb clock init code so command line clock overrides are
effective for all chips. The old code would silently ignore some of the
command line clock overrides with some chips.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/aty/atyfb_base.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index e330480..617dc0c 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2297,20 +2297,6 @@ #ifdef CONFIG_PPC_PMAC
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
@@ -2392,7 +2378,25 @@ #ifdef CONFIG_FB_ATY_CT
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
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
