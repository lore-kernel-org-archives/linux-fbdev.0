From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 21/24] i810fb: The pseudo_palette is
	only 16 elements long
Date: Sat, 02 Jun 2007 18:13:40 +0800
Message-ID: <466142D4.9030102@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQl9-0000VX-3w for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:22:59 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQl7-0001zh-PF
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:22:59 -0700
Received: by py-out-1112.google.com with SMTP id u77so1509718pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:22:54 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The pseudo_palette is only 16 elements long.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/i810/i810.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/i810/i810.h b/drivers/video/i810/i810.h
index 889e4ea..328ae6c 100644
--- a/drivers/video/i810/i810.h
+++ b/drivers/video/i810/i810.h
@@ -266,7 +266,7 @@ struct i810fb_par {
 	struct i810fb_i2c_chan   chan[3];
 	struct mutex		 open_lock;
 	unsigned int		 use_count;
-	u32 pseudo_palette[17];
+	u32 pseudo_palette[16];
 	unsigned long mmio_start_phys;
 	u8 __iomem *mmio_start_virtual;
 	u8 *edid;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
