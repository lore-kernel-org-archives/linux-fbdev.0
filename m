From: Ville Syrjala <syrjala@sci.fi>
Subject: [patch 1/3] atyfb: Increase SPLL delay
Date: Sat, 28 Apr 2007 21:17:14 +0300
Message-ID: <20070428181816.861058919@ob6000.korsu.shacknet.nu>
References: <20070428181713.086211486@ob6000.korsu.shacknet.nu>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1476645112=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhrV1-0007lo-0Q for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 11:18:23 -0700
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HhrUz-00032F-GF
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

--===============1476645112==
Content-Disposition: inline; filename=atyfb_increase_spll_delay.patch

Wait 5 ms instead of 500 us for the SPLL to lock. This matches the
recommendation in mach64 programmer's guide.

---
 drivers/video/aty/mach64_ct.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6.20.7/drivers/video/aty/mach64_ct.c
===================================================================
--- linux-2.6.20.7.orig/drivers/video/aty/mach64_ct.c
+++ linux-2.6.20.7/drivers/video/aty/mach64_ct.c
@@ -608,12 +608,10 @@ static void aty_resume_pll_ct(const stru
 		aty_st_pll_ct(SCLK_FB_DIV, pll->ct.sclk_fb_div, par);
 		aty_st_pll_ct(SPLL_CNTL2, pll->ct.spll_cntl2, par);
 		/*
-		 * The sclk has been started. However, I believe the first clock
-		 * ticks it generates are not very stable. Hope this primitive loop
-		 * helps for Rage Mobilities that sometimes crash when
-		 * we switch to sclk. (Daniel Mantione, 13-05-2003)
+		 * SCLK has been started. Wait for the PLL to lock. 5 ms
+		 * should be enough according to mach64 programmer's guide.
 		 */
-		udelay(500);
+		mdelay(5);
 	}
 
 	aty_st_pll_ct(PLL_REF_DIV, pll->ct.pll_ref_div, par);

-- 
Ville Syrj������l������
syrjala@sci.fi
http://www.sci.fi/~syrjala/


--===============1476645112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1476645112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1476645112==--
