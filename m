From: Ben Dooks <ben@simtec.co.uk>
Subject: [PATCH 1/4] FRAMEBUFFER: Fix cfbfillrect for
	non-zero colours.
Date: Mon, 23 Nov 2009 16:01:25 +0000
Message-ID: <20091123160144.804049553@fluff.org.uk>
References: <20091123160124.403392586@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ben@fluff.org.uk>) id 1NCbMn-0004Mq-Bz
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Nov 2009 16:02:17 +0000
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NCbMh-0003MB-0n
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Nov 2009 16:02:17 +0000
Content-Disposition: inline; filename=simtec/ready/cfbrectfill-colorfix.patch
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: krzysztof.h1@wp.p, akpm@linux-foundation.org
Cc: dilinger@debian.org, Vincent Sanders <vince@simtec.co.uk>, lethal@linux-sh.org, linux-fbdev-devel@lists.sourceforge.net, Simtec Linux Team <linux@simtec.co.uk>

From: Vincent Sanders <vince@simtec.co.uk>

The cfbfillrect routine was incorrectly using the palette to lookup true and
direct colours, but using indexed colours directly. This was simply the
inversion of the sense of an 'if' statement. This patch fixes that so that
colours other than black work properly for cfbfillrect.

Signed-off-by: Vincent Sanders <vince@simtec.co.uk>
Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>

---
 drivers/video/cfbfillrect.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/video/cfbfillrect.c
===================================================================
--- a/drivers/video/cfbfillrect.c	2009-05-10 14:11:19.000000000 +0100
+++ b/drivers/video/cfbfillrect.c	2009-05-10 14:16:33.000000000 +0100
@@ -289,9 +289,9 @@ void cfb_fillrect(struct fb_info *p, con
 
 	if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
 	    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
-		fg = ((u32 *) (p->pseudo_palette))[rect->color];
-	else
 		fg = rect->color;
+	else
+		fg = ((u32 *) (p->pseudo_palette))[rect->color];
 
 	pat = pixel_to_pat(bpp, fg);
 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
