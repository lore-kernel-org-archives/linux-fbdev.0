From: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
Subject: [PATCH] i810fb: Fix console switch regression
Date: Sun, 16 Mar 2008 19:42:24 +0100
Message-ID: <200803161942.24555.stefan.bauer@cs.tu-chemnitz.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jaxok-0006Dh-PM for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Mar 2008 11:42:46 -0700
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jaxoj-0002vR-Ct
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Mar 2008 11:42:46 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@pol.net>

From: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>

Commit eaa0ff15c30dc9799eb4d12660edb73aeb6d32c5 ("fix ! versus & precedence in 
various places") introduced a regression in console switching when using 
i810fb. Every 5th to 10th console switch causes 'pixel waste' - the same line 
of multi-colored pixels repeated over the whole screen.
This reverts eaa0ff1 for i810_main.c.

Signed-off-by: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
Cc: Antonino Daplas <adaplas@pol.net>

---
As I'm not subscribed to the LKML, please CC me, thanks.

--- linux-2.6/drivers/video/i810/i810_main.c.orig
+++ linux-2.6/drivers/video/i810/i810_main.c
@@ -1476,7 +1476,7 @@ static int i810fb_cursor(struct fb_info 
	struct i810fb_par *par = info->par;
	u8 __iomem *mmio = par->mmio_start_virtual;

-	if (!(par->dev_flags & LOCKUP))
+	if (!par->dev_flags & LOCKUP)
		return -ENXIO;

	if (cursor->image.width > 64 || cursor->image.height > 64)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
