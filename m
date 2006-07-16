From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 2.6.17-1] fbmon: add generic
 ddc	read functionality
Date: Sun, 16 Jul 2006 11:25:25 +0800
Message-ID: <44B9B1A5.4010003@gmail.com>
References: <CCAD6957-F582-48B5-AD3F-E93330489913@cecropia.com>
	<04D28BB4-A610-486B-B314-9D6D44E0B09B@cecropia.com>
	<44B8EA8E.3070808@gmail.com>
	<A05EFD86-EE99-4252-B99B-8E684905B0BB@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1xG7-0002qd-J5 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 20:25:31 -0700
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G1xG7-0004Q4-7y
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 20:25:31 -0700
Received: by py-out-1112.google.com with SMTP id c31so1817518pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 15 Jul 2006 20:25:30 -0700 (PDT)
In-Reply-To: <A05EFD86-EE99-4252-B99B-8E684905B0BB@cecropia.com>
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
To: Dennis Munsie <dmunsie@cecropia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Dennis Munsie wrote:
> I've attached both patches -- the fb-ddc-read.patch adds the generic ddc
> functionality, and the other patches the radeonfb driver to use the
> generic functionality instead.
> 
> There are other drivers that should be patched to use the generic
> functionality as well, but since I didn't have any other cards to test
> with, I just did the patch for the radeon (and intelfb as well, but
> that's not ready yet).
> 
> dennis
> 
> On Jul 15, 2006, at 9:15 AM, Antonino A. Daplas wrote:
> 
>> Dennis Munsie wrote:
>>> did anyone have any problems with this patch?  Just wondering if it
>>> was going to be flipped upstream or if I need to make some changes to
>>> it.

And here's the updated nvidiafb driver...

Tony

nvidiafb: Use generic DDC reading

Update driver to use generic DDC reading

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig         |    1 +
 drivers/video/nvidia/nv_i2c.c |   45 +++--------------------------------------
 2 files changed, 4 insertions(+), 42 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8846262..215ad28 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -699,6 +699,7 @@ config FB_NVIDIA
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
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
