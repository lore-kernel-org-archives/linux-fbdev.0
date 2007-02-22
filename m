From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb: Replace busy loop with mdelay()
Date: Thu, 22 Feb 2007 02:20:33 +0200
Message-ID: <20070222002033.GA26166@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK1hc-0006dA-7Q for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 16:20:53 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HK1hZ-0008Ds-MJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 16:20:52 -0800
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
Cc: akpm@osdl.org, alex.kern@gmx.de, jsimmons@infradead.org, stable@kernel.org, adaplas@gmail.com

Replace a busy loop with mdelay() in atyfb clock setup code. This fixes
boot hangs several people have experienced.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

This patch was already forwareded by James to some of you, but here it =

is with the proper changelog, signed-off-by line, and a language fix in =

the comment part. Also Cc:d stable@kernel.org as this seems like -stable =

material to me.

 drivers/video/aty/mach64_ct.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: linux-2.6.20.1/drivers/video/aty/mach64_ct.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.1.orig/drivers/video/aty/mach64_ct.c
+++ linux-2.6.20.1/drivers/video/aty/mach64_ct.c
@@ -598,7 +598,6 @@ static void aty_resume_pll_ct(const stru
 	struct atyfb_par *par =3D info->par;
 =

 	if (par->mclk_per !=3D par->xclk_per) {
-		int i;
 		/*
 		* This disables the sclk, crashes the computer as reported:
 		* aty_st_pll_ct(SPLL_CNTL2, 3, info);
@@ -609,12 +608,10 @@ static void aty_resume_pll_ct(const stru
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
-		for (i=3D0;i<=3D0x1ffff;i++);
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
