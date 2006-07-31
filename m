From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 9/13] nvidiafb: Use generic DDC reading
Date: Tue, 01 Aug 2006 07:35:43 +0800
Message-ID: <44CE93CF.5040401@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7hOi-0003DY-3x for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:42:08 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7hOh-0004Mn-RI
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:42:08 -0700
Received: by py-out-1112.google.com with SMTP id d42so802545pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 31 Jul 2006 16:42:07 -0700 (PDT)
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

 drivers/video/Kconfig         |    1 +
 drivers/video/nvidia/nv_i2c.c |   45 +++--------------------------------------
 2 files changed, 4 insertions(+), 42 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3bacde1..736556a 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -701,6 +701,7 @@ config FB_NVIDIA
 	depends on FB && PCI
 	select I2C_ALGOBIT if FB_NVIDIA_I2C
 	select I2C if FB_NVIDIA_I2C
+	select FB_DDC if FB_NVIDIA_I2C
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index 19eef3a..e48de3c 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -160,51 +160,12 @@ void nvidia_delete_i2c_busses(struct nvi
 
 }
 
-static u8 *nvidia_do_probe_i2c_edid(struct nvidia_i2c_chan *chan)
-{
-	u8 start = 0x0;
-	struct i2c_msg msgs[] = {
-		{
-		 .addr = 0x50,
-		 .len = 1,
-		 .buf = &start,
-		 }, {
-		     .addr = 0x50,
-		     .flags = I2C_M_RD,
-		     .len = EDID_LENGTH,
-		     },
-	};
-	u8 *buf;
-
-	if (!chan->par)
-		return NULL;
-
-	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
-	if (!buf) {
-		dev_warn(&chan->par->pci_dev->dev, "Out of memory!\n");
-		return NULL;
-	}
-	msgs[1].buf = buf;
-
-	if (i2c_transfer(&chan->adapter, msgs, 2) == 2)
-		return buf;
-	dev_dbg(&chan->par->pci_dev->dev, "Unable to read EDID block.\n");
-	kfree(buf);
-	return NULL;
-}
-
 int nvidia_probe_i2c_connector(struct fb_info *info, int conn, u8 **out_edid)
 {
 	struct nvidia_par *par = info->par;
-	u8 *edid = NULL;
-	int i;
-
-	for (i = 0; i < 3; i++) {
-		/* Do the real work */
-		edid = nvidia_do_probe_i2c_edid(&par->chan[conn - 1]);
-		if (edid)
-			break;
-	}
+	u8 *edid;
+
+	edid = fb_ddc_read(&par->chan[conn - 1].adapter);
 
 	if (!edid && conn == 1) {
 		/* try to get from firmware */


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
