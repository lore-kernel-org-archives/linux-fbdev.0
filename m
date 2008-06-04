From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH] fbdev: width and height are unsigned
Date: Wed,  4 Jun 2008 12:14:19 +0300
Message-ID: <1212570865-31419-1-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3p4j-0008Hu-Pc for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:33 -0700
Received: from smtp5.pp.htv.fi ([213.243.153.39])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3p4i-000168-9Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:33 -0700
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
Cc: akpm@linux-foundation.org, Ville Syrjala <syrjala@sci.fi>, adaplas@gmail.com

The width and height members of fb_var_screeninfo are __u32. The code
initializes them to -1 which seems wrong, and 0 seems like an equally
good default value.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/video/fbmon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 052e180..6a0aa18 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -879,7 +879,7 @@ int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 		if (edid_is_timing_block(block)) {
 			var->xres = var->xres_virtual = H_ACTIVE;
 			var->yres = var->yres_virtual = V_ACTIVE;
-			var->height = var->width = -1;
+			var->height = var->width = 0;
 			var->right_margin = H_SYNC_OFFSET;
 			var->left_margin = (H_ACTIVE + H_BLANKING) -
 				(H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH);
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
