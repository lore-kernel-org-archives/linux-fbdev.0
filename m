From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] [drivers/video/i810/i810_main.c] add
	parentheses
Date: Sat, 02 Feb 2008 20:56:42 +0100
Message-ID: <47A4CAFA.606@tiscali.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JLOTr-0002sk-VE for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Feb 2008 11:56:52 -0800
Received: from smtp-out3.tiscali.nl ([195.241.79.178])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JLOTq-0007V4-L3
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Feb 2008 11:56:51 -0800
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
To: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net
Cc: lkml <linux-kernel@vger.kernel.org>

'!' has a higher priority than '&': bitanding has no effect.

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 1a7d778..1d13dd0 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -1476,7 +1476,7 @@ static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	struct i810fb_par *par = info->par;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 
-	if (!par->dev_flags & LOCKUP)
+	if (!(par->dev_flags & LOCKUP))
 		return -ENXIO;
 
 	if (cursor->image.width > 64 || cursor->image.height > 64)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
