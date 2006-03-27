From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/7] pxafb: Minor driver fixes
Date: Mon, 27 Mar 2006 21:05:56 +0800
Message-ID: <4427E334.4050802@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNrXn-0002eC-Ba
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:14:03 -0800
Received: from xproxy.gmail.com ([66.249.82.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FNrXm-0007zZ-I9
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:14:03 -0800
Received: by xproxy.gmail.com with SMTP id t4so937073wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 27 Mar 2006 05:14:02 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Richard Purdie <rpurdie@rpsys.net>

From: Richard Purdie <rpurdie@rpsys.net>

Fixes for the pxafb driver:

* Return -EINVAL for resolutions that are too large as per framebuffer
driver policy.
* Increase the error timeout for disabling the LCD controller. The
current timeout is sometimes too short on the Sharp Zaurus Cxx00
hardware and an extra delay in an error path shouldn't pose any problems.
* Fix a dev reference which causes a compile error when DEBUG is
defined.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/pxafb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 53ad61f..809fc5e 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -232,9 +232,9 @@ static int pxafb_check_var(struct fb_var
 	if (var->yres < MIN_YRES)
 		var->yres = MIN_YRES;
 	if (var->xres > fbi->max_xres)
-		var->xres = fbi->max_xres;
+		return -EINVAL;
 	if (var->yres > fbi->max_yres)
-		var->yres = fbi->max_yres;
+		return -EINVAL;
 	var->xres_virtual =
 		max(var->xres_virtual, var->xres);
 	var->yres_virtual =
@@ -781,7 +781,7 @@ static void pxafb_disable_controller(str
 	LCCR0 &= ~LCCR0_LDM;	/* Enable LCD Disable Done Interrupt */
 	LCCR0 |= LCCR0_DIS;	/* Disable LCD Controller */
 
-	schedule_timeout(20 * HZ / 1000);
+	schedule_timeout(200 * HZ / 1000);
 	remove_wait_queue(&fbi->ctrlr_wait, &wait);
 
 	/* disable LCD controller clock */
@@ -1274,7 +1274,7 @@ int __init pxafb_probe(struct platform_d
 	struct pxafb_mach_info *inf;
 	int ret;
 
-	dev_dbg(dev, "pxafb_probe\n");
+	dev_dbg(&dev->dev, "pxafb_probe\n");
 
 	inf = dev->dev.platform_data;
 	ret = -ENOMEM;



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
