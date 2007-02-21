From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-users] atyfb - system hangs at
 bootup prior to enabling framebuffer console -- linux 2.6.18 (fwd)
Date: Wed, 21 Feb 2007 21:44:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702212143180.20620@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1831524198-554861201-1172094242=:20620"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJzGJ-0007tv-4p for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 13:44:31 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HJzGG-0007o9-1l
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 13:44:30 -0800
Content-ID: <Pine.LNX.4.64.0702212144170.20620@pentafluge.infradead.org>
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
Cc: Ville Syrjala <syrjala@sci.fi>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1831524198-554861201-1172094242=:20620
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-ID: <Pine.LNX.4.64.0702212144171.20620@pentafluge.infradead.org>
Content-Transfer-Encoding: quoted-printable


Andrew please apply.

Acked-By: James Simmons <jsimmons@infradead.org>

---------- Forwarded message ----------
Date: Sat, 17 Feb 2007 15:19:12 +0200
From: Ville Syrj=E4l=E4 <syrjala@sci.fi>
Reply-To: linux-fbdev-users@lists.sourceforge.net
To: linux-fbdev-users@lists.sourceforge.net
Subject: Re: [Linux-fbdev-users] atyfb - system hangs at bootup prior to
    enabling framebuffer console -- linux 2.6.18

On Fri, Feb 16, 2007 at 06:37:31PM -0500, cga2000 wrote:
> More than 50% of the time my laptop hangs when booting with=20
>=20
> ... video=3Datyfb:1400x1050.
>=20
> I have seen similar occurrences reported here and there with recent 2.6
> kernels but nothing very clear as to whether this is a known problem or
> whether a patch or workaround has already been provided.

I was just able to reproduce the problem by switching from drivers/ide=20
to libata. In my case the laptop would hang on every boot. Apparently=20
using libata changed the timing enough to trigger the bug.

Try this patch:

---
 drivers/video/aty/mach64_ct.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: linux-2.6.20/drivers/video/aty/mach64_ct.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/drivers/video/aty/mach64_ct.c
+++ linux-2.6.20/drivers/video/aty/mach64_ct.c
@@ -598,7 +598,6 @@ static void aty_resume_pll_ct(const stru
 	struct atyfb_par *par =3D info->par;
=20
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
+		 * The sclk has been started. Wait for the PLL to lock. 5 ms
+		 * should be enough according to mach64 programmers guide.
 		 */
-		for (i=3D0;i<=3D0x1ffff;i++);
+		mdelay(5);
 	}
=20
 	aty_st_pll_ct(PLL_REF_DIV, pll->ct.pll_ref_div, par);
--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
_______________________________________________
Linux-fbdev-users mailing list
Linux-fbdev-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users
---1831524198-554861201-1172094242=:20620
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
---1831524198-554861201-1172094242=:20620
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---1831524198-554861201-1172094242=:20620--
