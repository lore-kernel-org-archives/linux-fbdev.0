From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 05/15] ps3fb: Remove useless debug
	checks in ps3fb_shutdown()
Date: Fri,  8 May 2009 16:01:14 +0200
Message-ID: <1241791284-11490-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1241791284-11490-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@sonycom.com>) id 1M2Qdu-0005PT-3d
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 May 2009 14:01:38 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 1b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1M2Qdn-0007SX-Om
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 May 2009 14:01:33 +0000
In-Reply-To: <1241791284-11490-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
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
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index e00c1df..ce0f873 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -1247,7 +1247,6 @@ err:
 
 static int ps3fb_shutdown(struct ps3_system_bus_device *dev)
 {
-	int status;
 	struct fb_info *info = dev->core.driver_data;
 
 	dev_dbg(&dev->core, " -> %s:%d\n", __func__, __LINE__);
@@ -1271,17 +1270,8 @@ static int ps3fb_shutdown(struct ps3_system_bus_device *dev)
 		info = dev->core.driver_data = NULL;
 	}
 	iounmap((u8 __force __iomem *)ps3fb.dinfo);
-
-	status = lv1_gpu_context_free(ps3fb.context_handle);
-	if (status)
-		dev_dbg(&dev->core, "lv1_gpu_context_free failed: %d\n",
-			status);
-
-	status = lv1_gpu_memory_free(ps3fb.memory_handle);
-	if (status)
-		dev_dbg(&dev->core, "lv1_gpu_memory_free failed: %d\n",
-			status);
-
+	lv1_gpu_context_free(ps3fb.context_handle);
+	lv1_gpu_memory_free(ps3fb.memory_handle);
 	ps3_close_hv_device(dev);
 	dev_dbg(&dev->core, " <- %s:%d\n", __func__, __LINE__);
 
-- 
1.6.2.4


------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
