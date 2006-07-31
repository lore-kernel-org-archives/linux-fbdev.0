From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 12/13] savagefb: Use generic DDC reading
Date: Tue, 01 Aug 2006 07:39:02 +0800
Message-ID: <44CE9496.90804@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7hOv-0003E7-U4 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:42:22 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7hOv-0004Mn-Je
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:42:21 -0700
Received: by py-out-1112.google.com with SMTP id d42so802545pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 31 Jul 2006 16:42:21 -0700 (PDT)
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

 drivers/video/Kconfig               |    1 +
 drivers/video/savage/savagefb-i2c.c |   46 ++---------------------------------
 2 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 115d00d..efc6912 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1146,6 +1146,7 @@ config FB_SAVAGE
 	depends on FB && PCI && EXPERIMENTAL
 	select I2C_ALGOBIT if FB_SAVAGE_I2C
 	select I2C if FB_SAVAGE_I2C
+	select FB_DDC if FB_SAVAGE_I2C
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
index e83befd..5646c17 100644
--- a/drivers/video/savage/savagefb-i2c.c
+++ b/drivers/video/savage/savagefb-i2c.c
@@ -214,52 +214,12 @@ void savagefb_delete_i2c_busses(struct f
 	par->chan.par = NULL;
 }
 
-static u8 *savage_do_probe_i2c_edid(struct savagefb_i2c_chan *chan)
-{
-	u8 start = 0x0;
-	struct i2c_msg msgs[] = {
-		{
-			.addr	= SAVAGE_DDC,
-			.len	= 1,
-			.buf	= &start,
-		}, {
-			.addr	= SAVAGE_DDC,
-			.flags	= I2C_M_RD,
-			.len	= EDID_LENGTH,
-		},
-	};
-	u8 *buf = NULL;
-
-	if (chan->par) {
-		buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
-
-		if (buf) {
-			msgs[1].buf = buf;
-
-			if (i2c_transfer(&chan->adapter, msgs, 2) != 2) {
-				dev_dbg(&chan->par->pcidev->dev,
-					"Unable to read EDID block.\n");
-				kfree(buf);
-				buf = NULL;
-			}
-		}
-	}
-
-	return buf;
-}
-
 int savagefb_probe_i2c_connector(struct fb_info *info, u8 **out_edid)
 {
 	struct savagefb_par *par = info->par;
-	u8 *edid = NULL;
-	int i;
-
-	for (i = 0; i < 3; i++) {
-		/* Do the real work */
-		edid = savage_do_probe_i2c_edid(&par->chan);
-		if (edid)
-			break;
-	}
+	u8 *edid;
+
+	edid = fb_ddc_read(&par->chan.adapter);
 
 	if (!edid) {
 		/* try to get from firmware */


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
