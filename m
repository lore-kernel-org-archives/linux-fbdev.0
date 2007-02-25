From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH RESEND 3/9] nvidiafb: Bring back generic
	ddc reading
Date: Sun, 25 Feb 2007 18:16:06 +0800
Message-ID: <45E161E6.4000006@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLGat-00067R-2s for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 02:27:03 -0800
Received: from nz-out-0506.google.com ([64.233.162.226])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLGas-0001zz-45
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 02:27:02 -0800
Received: by nz-out-0506.google.com with SMTP id i11so1731052nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Feb 2007 02:27:01 -0800 (PST)
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

Make nvidiafb use fb_ddc_read().  This patch was submitted before but was
reverted due to problems in a non-x86 platform.  This includes a fix for that
where ddc reading is bypassed if there is no DDC bus (duh).

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/nvidia/nv_i2c.c |   44 ++---------------------------------------
 1 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index b858897..b91d404 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -70,8 +70,6 @@ static int nvidia_gpio_getscl(void *data
 	if (VGA_RD08(par->PCIO, 0x3d5) & 0x04)
 		val = 1;
 
-	val = VGA_RD08(par->PCIO, 0x3d5);
-
 	return val;
 }
 
@@ -159,51 +157,13 @@ void nvidia_delete_i2c_busses(struct nvi
 
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
 	u8 *edid = NULL;
-	int i;
 
-	for (i = 0; i < 3; i++) {
-		/* Do the real work */
-		edid = nvidia_do_probe_i2c_edid(&par->chan[conn - 1]);
-		if (edid)
-			break;
-	}
+	if (par->chan[conn - 1].par)
+		edid = fb_ddc_read(&par->chan[conn - 1].adapter);
 
 	if (!edid && conn == 1) {
 		/* try to get from firmware */


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
