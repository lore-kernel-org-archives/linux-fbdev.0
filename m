From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 3/7] sm501fb: Set transp.offset to 0 in
	8bpp and 16bpp modes
Date: Sun, 25 Nov 2007 22:01:28 +0200
Message-ID: <1196020893266-git-send-email-syrjala@sci.fi>
References: <1196020892591-git-send-email-syrjala@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwNff-0002Rv-Sn for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 12:01:39 -0800
Received: from smtp4.pp.htv.fi ([213.243.153.38])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwNfd-0000ow-DK
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 12:01:39 -0800
In-Reply-To: <1196020892591-git-send-email-syrjala@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: ben@simtec.co.uk, vince@simtec.co.uk, Ville Syrjala <syrjala@sci.fi>

Even though it may not be strictly necessary transp.offset
should probably be 0 when alpha channel is not available.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/video/sm501fb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index ea05676..66e2ae9 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -281,6 +281,7 @@ static int sm501fb_check_var(struct fb_var_screeninfo *var,
 		var->blue.length	= var->bits_per_pixel;
 		var->blue.offset	= 0;
 		var->transp.length	= 0;
+		var->transp.offset	= 0;
 
 		break;
 
@@ -294,6 +295,7 @@ static int sm501fb_check_var(struct fb_var_screeninfo *var,
 			var->green.offset	= 5;
 			var->blue.offset	= 0;
 		}
+		var->transp.offset	= 0;
 
 		var->red.length		= 5;
 		var->green.length	= 6;
-- 
1.5.2.5


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
