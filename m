From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 4/7] sm501fb: Fix timing limits
Date: Sun, 25 Nov 2007 22:01:29 +0200
Message-ID: <11960208932561-git-send-email-syrjala@sci.fi>
References: <1196020892591-git-send-email-syrjala@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwNfg-0002S3-Av for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 12:01:40 -0800
Received: from smtp4.pp.htv.fi ([213.243.153.38])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwNfd-0000oy-Rh
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 12:01:40 -0800
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

Vertical sync height register can only hold 6 bits. Fix the hsync start
test to use > instead of >=. Also add a few clarifying comments.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/video/sm501fb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index 66e2ae9..c92a255 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -237,12 +237,14 @@ static int sm501fb_check_var(struct fb_var_screeninfo *var,
 
 	/* check we can fit these values into the registers */
 
-	if (var->hsync_len > 255 || var->vsync_len > 255)
+	if (var->hsync_len > 255 || var->vsync_len > 63)
 		return -EINVAL;
 
-	if ((var->xres + var->right_margin) >= 4096)
+	/* hdisplay end and hsync start */
+	if ((var->xres + var->right_margin) > 4096)
 		return -EINVAL;
 
+	/* vdisplay end and vsync start */
 	if ((var->yres + var->lower_margin) > 2048)
 		return -EINVAL;
 
-- 
1.5.2.5


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
