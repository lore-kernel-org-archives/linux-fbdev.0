From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 24/33] sm501fb: update suspend and
	resume code
Date: Thu, 26 Jul 2007 20:29:23 +0800
Message-ID: <46A893A3.1070408@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2vZ-0001Ad-Dw for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:58:49 -0700
Received: from nz-out-0506.google.com ([64.233.162.226])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2vZ-0008TI-5C
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:58:49 -0700
Received: by nz-out-0506.google.com with SMTP id f1so1352216nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:58:48 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ben Dooks <ben-linux@fluff.org>

From: Ben Dooks <ben-linux@fluff.org>

The suspend and resume code is failing to restore the CRT control
register, thus causing the CRT data-path to get changed if the
SM501 experiences a reset over suspend.

Also move some of the debug messages to dev_dbg() level and ensure
that the suspend code does not try and restore anything it did not
manage to save.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/sm501fb.c |   35 +++++++++++++++++++++++++++++++----
 1 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index c86df12..fc0cdc8 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -62,6 +62,8 @@ struct sm501fb_info {
 	struct resource		*regs_res;	/* registers resource */
 	struct sm501_platdata_fb *pdata;	/* our platform data */
 
+	unsigned long		 pm_crt_ctrl;	/* pm: crt ctrl save */
+
 	int			 irq;
 	int			 swap_endian;	/* set to swap rgb=>bgr */
 	void __iomem		*regs;		/* remapped registers */
@@ -1687,9 +1689,11 @@ static int sm501fb_suspend_fb(struct sm5
 		goto err_nocursor;
 	}
 
+	dev_dbg(info->dev, "suspending screen to %p\n", par->store_fb);
+	dev_dbg(info->dev, "suspending cursor to %p\n", par->store_cursor);
+
 	memcpy_fromio(par->store_fb, par->screen.k_addr, par->screen.size);
 	memcpy_fromio(par->store_cursor, par->cursor.k_addr, par->cursor.size);
-
 	/* blank the relevant interface to ensure unit power minimised */
 	(par->ops.fb_blank)(FB_BLANK_POWERDOWN, fbi);
 
@@ -1697,9 +1701,9 @@ static int sm501fb_suspend_fb(struct sm5
 
  err_nocursor:
 	vfree(par->store_fb);
+	par->store_fb = NULL;
 
 	return -ENOMEM;
-
 }
 
 static void sm501fb_resume_fb(struct sm501fb_info *info,
@@ -1717,8 +1721,16 @@ static void sm501fb_resume_fb(struct sm5
 
 	/* restore the data */
 
-	memcpy_toio(par->screen.k_addr, par->store_fb, par->screen.size);
-	memcpy_toio(par->cursor.k_addr, par->store_cursor, par->cursor.size);
+	dev_dbg(info->dev, "restoring screen from %p\n", par->store_fb);
+	dev_dbg(info->dev, "restoring cursor from %p\n", par->store_cursor);
+
+	if (par->store_fb)
+		memcpy_toio(par->screen.k_addr, par->store_fb,
+			    par->screen.size);
+
+	if (par->store_cursor)
+		memcpy_toio(par->cursor.k_addr, par->store_cursor,
+			    par->cursor.size);
 
 	vfree(par->store_fb);
 	vfree(par->store_cursor);
@@ -1731,6 +1743,9 @@ static int sm501fb_suspend(struct platfo
 {
 	struct sm501fb_info *info = platform_get_drvdata(pdev);
 
+	/* store crt control to resume with */
+	info->pm_crt_ctrl = readl(info->regs + SM501_DC_CRT_CONTROL);
+
 	sm501fb_suspend_fb(info, HEAD_CRT);
 	sm501fb_suspend_fb(info, HEAD_PANEL);
 
@@ -1740,12 +1755,24 @@ static int sm501fb_suspend(struct platfo
 	return 0;
 }
 
+#define SM501_CRT_CTRL_SAVE (SM501_DC_CRT_CONTROL_TVP |        \
+			     SM501_DC_CRT_CONTROL_SEL)
+
+
 static int sm501fb_resume(struct platform_device *pdev)
 {
 	struct sm501fb_info *info = platform_get_drvdata(pdev);
+	unsigned long crt_ctrl;
 
 	sm501_unit_power(info->dev->parent, SM501_GATE_DISPLAY, 1);
 
+	/* restore the items we want to be saved for crt control */
+
+	crt_ctrl = readl(info->regs + SM501_DC_CRT_CONTROL);
+	crt_ctrl &= ~SM501_CRT_CTRL_SAVE;
+	crt_ctrl |= info->pm_crt_ctrl & SM501_CRT_CTRL_SAVE;
+	writel(crt_ctrl, info->regs + SM501_DC_CRT_CONTROL);
+
 	sm501fb_resume_fb(info, HEAD_CRT);
 	sm501fb_resume_fb(info, HEAD_PANEL);
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
