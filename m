From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 2/7] sm501fb: RGB offsets are reversed
	in 16bpp modes
Date: Sun, 25 Nov 2007 22:01:27 +0200
Message-ID: <11960208923806-git-send-email-syrjala@sci.fi>
References: <1196020892591-git-send-email-syrjala@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwNff-0002Rp-PA for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 12:01:39 -0800
Received: from smtp5.pp.htv.fi ([213.243.153.39])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwNfd-0000ov-9r
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

The RGB offsets were reversed in 16bpp modes. Simply trying to reverse
the offsets when endianness differs is clearly the wrong thing to do but
that is an issue for another patch.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/video/sm501fb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index 5ddd0fa..ea05676 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -286,13 +286,13 @@ static int sm501fb_check_var(struct fb_var_screeninfo *var,
 
 	case 16:
 		if (sm->pdata->flags & SM501_FBPD_SWAP_FB_ENDIAN) {
-			var->red.offset		= 11;
-			var->green.offset	= 5;
-			var->blue.offset	= 0;
-		} else {
 			var->blue.offset	= 11;
 			var->green.offset	= 5;
 			var->red.offset		= 0;
+		} else {
+			var->red.offset		= 11;
+			var->green.offset	= 5;
+			var->blue.offset	= 0;
 		}
 
 		var->red.length		= 5;
-- 
1.5.2.5


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
