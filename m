From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 6/9] fbdev: Do a symbol_put for each symbol_get in savagefb
Date: Tue, 21 Dec 2004 23:34:12 +0800
Message-ID: <20041221213659.8428D1A0273@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cgrh2-0007XF-8U
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:20 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cgrh1-0002Sk-S4
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:20 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 63A9912D2077
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Dec 2004 21:37:05 +0000 (UTC)
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

Do a symbol_put() for each symbol_get() in savagefb.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 savagefb-i2c.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -Nru a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
--- a/drivers/video/savage/savagefb-i2c.c	2004-11-17 18:15:21 +08:00
+++ b/drivers/video/savage/savagefb-i2c.c	2004-11-29 20:26:19 +08:00
@@ -163,12 +163,15 @@
 		udelay(20);
 
 		rc = add_bus(&chan->adapter);
+
 		if (rc == 0)
 			dev_dbg(&chan->par->pcidev->dev,
 				"I2C bus %s registered.\n", name);
 		else
 			dev_warn(&chan->par->pcidev->dev,
 				 "Failed to register I2C bus %s.\n", name);
+
+		symbol_put(i2c_bit_add_bus);
 	} else
 		chan->par = NULL;
 
@@ -212,8 +215,10 @@
 	int (*del_bus)(struct i2c_adapter *) =
 		symbol_get(i2c_bit_del_bus);
 
-	if (del_bus && par->chan.par)
+	if (del_bus && par->chan.par) {
 		del_bus(&par->chan.adapter);
+		symbol_put(i2c_bit_del_bus);
+	}
 
 	par->chan.par = NULL;
 }
@@ -239,6 +244,7 @@
 
 	if (transfer && chan->par) {
 		buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
+
 		if (buf) {
 			msgs[1].buf = buf;
 
@@ -249,6 +255,8 @@
 				buf = NULL;
 			}
 		}
+
+		symbol_put(i2c_transfer);
 	}
 
 	return buf;




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
