From: Ben Dooks <ben-linux@fluff.org>
Subject: BACKLIGHT: Give platform_lcd the same name as
	the platform device.
Date: Mon, 28 Jul 2008 23:52:47 +0100
Message-ID: <20080728225247.700174853@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KNbaO-0005dM-LY for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 Jul 2008 15:53:00 -0700
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KNbaN-0006bz-AR
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 Jul 2008 15:53:00 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-platlcd-unique-name.patch
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

When registering an platform_lcd, use the name of the platform
device specified in case there are more than one platform_lcd
backlights registered.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-quilt4/drivers/video/backlight/platform_lcd.c
===================================================================
--- linux-2.6.26-quilt4.orig/drivers/video/backlight/platform_lcd.c	2008-07-28 10:48:01.000000000 +0100
+++ linux-2.6.26-quilt4/drivers/video/backlight/platform_lcd.c	2008-07-28 10:48:29.000000000 +0100
@@ -96,7 +96,7 @@ static int __devinit platform_lcd_probe(
 
 	plcd->us = dev;
 	plcd->pdata = pdata;
-	plcd->lcd = lcd_device_register("platform-lcd", dev,
+	plcd->lcd = lcd_device_register(dev_name(dev), dev,
 					plcd, &platform_lcd_ops);
 	if (IS_ERR(plcd->lcd)) {
 		dev_err(dev, "cannot register lcd device\n");

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
