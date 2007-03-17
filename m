From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb: Increase SPLL delay
Date: Sat, 17 Mar 2007 22:25:10 +0200
Message-ID: <20070317202510.GA10189@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HSfSq-0003ok-0h for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Mar 2007 13:25:20 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HSfSo-0003oF-Hm
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Mar 2007 13:25:19 -0700
Content-Disposition: inline
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
Cc: alex.kern@gmx.de, adaplas@gmail.com

Wait 5 ms instead of 500 us for the SPLL to lock. This matches the
recommendation in mach64 programmer's guide.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>

---
 drivers/video/aty/mach64_ct.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6.20.3/drivers/video/aty/mach64_ct.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.3.orig/drivers/video/aty/mach64_ct.c
+++ linux-2.6.20.3/drivers/video/aty/mach64_ct.c
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
 =

 	aty_st_pll_ct(PLL_REF_DIV, pll->ct.pll_ref_div, par);
-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
