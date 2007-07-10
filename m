From: Ben Dooks <ben-linux@fluff.org>
Subject: SM501: update suspend and resume code
Date: Tue, 10 Jul 2007 09:59:52 +0100
Message-ID: <20070710085952.GA3515@fluff.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8Ba1-0000jH-LQ for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 02:00:21 -0700
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=aeryn.fluff.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I8BZz-0003OC-Qo
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 02:00:21 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

The suspend and resume code is failing to restore the CRT control
register, thus causing the CRT data-path to get changed if the
SM501 experiences a reset over suspend.

Also move some of the debug messages to dev_dbg() level and ensure
that the suspend code does not try and restore anything it did not
manage to save.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.21-quilt/drivers/video/sm501fb.c
===================================================================
--- linux-2.6.21-quilt.orig/drivers/video/sm501fb.c	2007-05-24 17:56:28.000000000 +0100
+++ linux-2.6.21-quilt/drivers/video/sm501fb.c	2007-05-29 11:11:58.000000000 +0100
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
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
