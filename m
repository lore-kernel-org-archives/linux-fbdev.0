From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 22/33] ps3: ps3fb - Use
	ps3_system_bus_[gs]et_drvdata() instead of direct access
Date: Wed, 10 Jun 2009 16:38:57 +0200
Message-ID: <1244644748-24211-23-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-17-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-18-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-19-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-21-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-22-git-send-email-Geert.Uytterhoeven@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@sonycom.com>) id 1MEOyW-00053p-R9
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Jun 2009 14:40:24 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 29vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MEOxW-0005qi-4e
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Jun 2009 14:40:24 +0000
In-Reply-To: <1244644748-24211-22-git-send-email-Geert.Uytterhoeven@sonycom.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net
---
 drivers/video/ps3fb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 1baa1c9..c0af638 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -1166,7 +1166,7 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 	if (retval < 0)
 		goto err_fb_dealloc;
 
-	dev->core.driver_data = info;
+	ps3_system_bus_set_drvdata(dev, info);
 
 	dev_info(info->device, "%s %s, using %u KiB of video memory\n",
 		 dev_driver_string(info->dev), dev_name(info->dev),
@@ -1211,7 +1211,7 @@ err:
 
 static int ps3fb_shutdown(struct ps3_system_bus_device *dev)
 {
-	struct fb_info *info = dev->core.driver_data;
+	struct fb_info *info = ps3_system_bus_get_drvdata(dev);
 	u64 xdr_lpar = ps3_mm_phys_to_lpar(__pa(ps3fb_videomemory.address));
 
 	dev_dbg(&dev->core, " -> %s:%d\n", __func__, __LINE__);
@@ -1232,7 +1232,7 @@ static int ps3fb_shutdown(struct ps3_system_bus_device *dev)
 		unregister_framebuffer(info);
 		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
-		info = dev->core.driver_data = NULL;
+		ps3_system_bus_set_drvdata(dev, NULL);
 	}
 	iounmap((u8 __force __iomem *)ps3fb.dinfo);
 	lv1_gpu_fb_close(ps3fb.context_handle);
-- 
1.6.2.4


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
