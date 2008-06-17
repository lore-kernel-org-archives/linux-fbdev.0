From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] radeonfb: Revert "Fix radeon DDC
	regression"
Date: Tue, 17 Jun 2008 14:50:40 +0200
Message-ID: <20080617145040.55c5c088@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K8aeL-0008Cj-V6 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jun 2008 05:51:02 -0700
Received: from zone0.gcu-squad.org ([212.85.147.21]
	helo=services.gcu-squad.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K8aeL-0005f5-Iy
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jun 2008 05:51:01 -0700
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
To: Antonino Daplas <adaplas@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net

The bug was in fb_ddc and was fixed by commit
b64d70825abbf706bbe80be1b11b09514b71f45e (fb_ddc: fix DDC lines quirk)
so the workaround in radeonfb can be removed now.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Antonino, can you please push this upstream? Thanks.

 drivers/video/aty/radeon_i2c.c |    4 ----
 1 file changed, 4 deletions(-)

--- linux-2.6.26-rc5.orig/drivers/video/aty/radeon_i2c.c	2008-06-06 08:43:51.000000000 +0200
+++ linux-2.6.26-rc5/drivers/video/aty/radeon_i2c.c	2008-06-06 09:28:50.000000000 +0200
@@ -139,12 +139,8 @@ void radeon_delete_i2c_busses(struct rad
 int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn,
 			       u8 **out_edid)
 {
-	u32 reg = rinfo->i2c[conn-1].ddc_reg;
 	u8 *edid;
 
-	OUTREG(reg, INREG(reg) &
-			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));
-
 	edid = fb_ddc_read(&rinfo->i2c[conn-1].adapter);
 
 	if (out_edid)


-- 
Jean Delvare

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
