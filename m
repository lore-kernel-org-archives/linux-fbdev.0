From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/10] nvidiafb: Fix i2c error handling
Date: Sun, 6 Mar 2005 08:16:43 +0800
Message-ID: <200503060816.43987.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7jU3-00072o-Od
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:18:59 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D7jU3-0002Vw-7p
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:18:59 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id B1C551493452
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  6 Mar 2005 00:18:49 +0000 (UTC)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

  Fixed error handling in rivafb-i2c.c if bus registration fails.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 nv_i2c.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

diff -Nru a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
--- a/drivers/video/nvidia/nv_i2c.c	2005-03-05 00:35:05 +08:00
+++ b/drivers/video/nvidia/nv_i2c.c	2005-03-05 00:45:44 +08:00
@@ -119,9 +119,12 @@
 	if (rc == 0)
 		dev_dbg(&chan->par->pci_dev->dev,
 			"I2C bus %s registered.\n", name);
-	else
+	else {
 		dev_warn(&chan->par->pci_dev->dev,
 			 "Failed to register I2C bus %s.\n", name);
+		chan->par = NULL;
+	}
+
 	return rc;
 }
 
@@ -174,6 +177,9 @@
 		     },
 	};
 	u8 *buf;
+
+	if (!chan->par)
+		return NULL;
 
 	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
 	if (!buf) {




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
