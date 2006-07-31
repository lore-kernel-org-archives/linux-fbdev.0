From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 10/13] rivafb: Use generic DDC reading
Date: Tue, 01 Aug 2006 07:36:34 +0800
Message-ID: <44CE9402.7090608@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7hOq-0003Ds-Gh for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:42:16 -0700
Received: from ug-out-1314.google.com ([66.249.92.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7hOp-0004hN-UL
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:42:16 -0700
Received: by ug-out-1314.google.com with SMTP id s2so1008066uge
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 31 Jul 2006 16:42:12 -0700 (PDT)
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

Update driver to use generic DDC reading

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig           |    1 +
 drivers/video/riva/rivafb-i2c.c |   44 ++-------------------------------------
 2 files changed, 3 insertions(+), 42 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 736556a..a838924 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -740,6 +740,7 @@ config FB_RIVA
 	depends on FB && PCI
 	select I2C_ALGOBIT if FB_RIVA_I2C
 	select I2C if FB_RIVA_I2C
+	select FB_DDC if FB_RIVA_I2C
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/video/riva/rivafb-i2c.c b/drivers/video/riva/rivafb-i2c.c
index 9751c37..c15b259 100644
--- a/drivers/video/riva/rivafb-i2c.c
+++ b/drivers/video/riva/rivafb-i2c.c
@@ -25,8 +25,6 @@ #include <asm/io.h>
 #include "rivafb.h"
 #include "../edid.h"
 
-#define RIVA_DDC 	0x50
-
 static void riva_gpio_setscl(void* data, int state)
 {
 	struct riva_i2c_chan 	*chan = data;
@@ -158,50 +156,12 @@ void riva_delete_i2c_busses(struct riva_
 	par->chan[2].par = NULL;
 }
 
-static u8 *riva_do_probe_i2c_edid(struct riva_i2c_chan *chan)
-{
-	u8 start = 0x0;
-	struct i2c_msg msgs[] = {
-		{
-			.addr	= RIVA_DDC,
-			.len	= 1,
-			.buf	= &start,
-		}, {
-			.addr	= RIVA_DDC,
-			.flags	= I2C_M_RD,
-			.len	= EDID_LENGTH,
-		},
-	};
-	u8 *buf;
-
-	if (!chan->par)
-		return NULL;
-
-	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
-	if (!buf) {
-		dev_warn(&chan->par->pdev->dev, "Out of memory!\n");
-		return NULL;
-	}
-	msgs[1].buf = buf;
-
-	if (i2c_transfer(&chan->adapter, msgs, 2) == 2)
-		return buf;
-	dev_dbg(&chan->par->pdev->dev, "Unable to read EDID block.\n");
-	kfree(buf);
-	return NULL;
-}
-
 int riva_probe_i2c_connector(struct riva_par *par, int conn, u8 **out_edid)
 {
 	u8 *edid = NULL;
-	int i;
 
-	for (i = 0; i < 3; i++) {
-		/* Do the real work */
-		edid = riva_do_probe_i2c_edid(&par->chan[conn-1]);
-		if (edid)
-			break;
-	}
+	edid = fb_ddc_read(&par->chan[conn-1].adapter);
+
 	if (out_edid)
 		*out_edid = edid;
 	if (!edid)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
