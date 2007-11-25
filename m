From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 1/7] sm501fb: Direct color visual does
	not work
Date: Sun, 25 Nov 2007 22:01:26 +0200
Message-ID: <11960208921231-git-send-email-syrjala@sci.fi>
References: <1196020892591-git-send-email-syrjala@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwNff-0002Ro-ON for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 12:01:39 -0800
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwNfd-00072D-9X
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

The sm501fb palette code clearly does not handle direct color
so change the driver to use true color visual for 16bpp.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/video/sm501fb.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index 1be95a6..5ddd0fa 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -397,7 +397,7 @@ static int sm501fb_set_par_common(struct fb_info *info,
 		break;
 
 	case 16:
-		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
 		break;
 
 	case 32:
@@ -613,6 +613,7 @@ static int sm501fb_set_par_crt(struct fb_info *info)
 
 	case 16:
 		control |= SM501_DC_CRT_CONTROL_16BPP;
+		sm501fb_setup_gamma(fbi, SM501_DC_CRT_PALETTE);
 		break;
 
 	case 32:
@@ -741,6 +742,7 @@ static int sm501fb_set_par_pnl(struct fb_info *info)
 
 	case 16:
 		control |= SM501_DC_PANEL_CONTROL_16BPP;
+		sm501fb_setup_gamma(fbi, SM501_DC_PANEL_PALETTE);
 		break;
 
 	case 32:
-- 
1.5.2.5


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
