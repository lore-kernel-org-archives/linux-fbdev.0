From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/7] atyfb: Increase SPLL delay
Date: Sun, 29 Apr 2007 11:50:15 +0800
Message-ID: <463415F7.6090006@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hi0Tv-0003c0-Ui for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:53:57 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hi0Tv-000446-69
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:53:51 -0700
Received: by py-out-1112.google.com with SMTP id a29so1108343pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 28 Apr 2007 20:53:50 -0700 (PDT)
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

Wait 5 ms instead of 500 us for the SPLL to lock. This matches the
recommendation in mach64 programmer's guide.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/aty/mach64_ct.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/aty/mach64_ct.c b/drivers/video/aty/mach64_ct.c
index 1fdcfdb..cc9e977 100644
--- a/drivers/video/aty/mach64_ct.c
+++ b/drivers/video/aty/mach64_ct.c
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


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
