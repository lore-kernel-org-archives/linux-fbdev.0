From: Ben Dooks <ben-linux@fluff.org>
Subject: ILI9320: Ensure resource cleanup on exit.
Date: Tue, 24 Jun 2008 19:23:35 +0100
Message-ID: <20080624182334.934251023@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KBDBE-0000tK-68 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Jun 2008 11:23:48 -0700
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KBDBC-0000Hg-O3
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Jun 2008 11:23:48 -0700
Content-Disposition: inline; filename=simtec/simtec-ili9320-fixes.patch
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
To: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net
Cc: Ben Dooks <ben-linux@fluff.org>

Ensure we free our 'struct ili9320' on exit or error.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-rc7-quilt1/drivers/video/backlight/ili9320.c
===================================================================
--- linux-2.6.26-rc7-quilt1.orig/drivers/video/backlight/ili9320.c	2008-06-24 12:58:38.000000000 +0100
+++ linux-2.6.26-rc7-quilt1/drivers/video/backlight/ili9320.c	2008-06-24 14:33:30.000000000 +0100
@@ -259,18 +259,19 @@ int __devinit ili9320_probe_spi(struct s
 	lcd_device_unregister(lcd);
 
  err_free:
-	kfree(lcd);
+	kfree(ili);
+
 	return ret;
 }
 
 EXPORT_SYMBOL_GPL(ili9320_probe_spi);
 
-int __devexit ili9320_remove(struct ili9320 *lcd)
+int __devexit ili9320_remove(struct ili9320 *ili)
 {
-	ili9320_power(lcd, FB_BLANK_POWERDOWN);
+	ili9320_power(ili, FB_BLANK_POWERDOWN);
 
-	lcd_device_unregister(lcd->lcd);
-	kfree(lcd);
+	lcd_device_unregister(ili->lcd);
+	kfree(ili);
 
 	return 0;
 }

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
