From: Ben Dooks <ben-linux@fluff.org>
Subject: BACKLIGHT: Ensure platform_lcd on by default
Date: Tue, 29 Jul 2008 00:10:47 +0100
Message-ID: <20080728231047.095841888@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KNbrk-0007Pn-Ub for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 Jul 2008 16:10:57 -0700
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KNbri-0004ME-Gx
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 Jul 2008 16:10:56 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-platlcd-onbydefault.patch
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

It seems that we need to ensure that the lcd is powered
up at start, otherwise we do not see a display.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-quilt4/drivers/video/backlight/platform_lcd.c
===================================================================
--- linux-2.6.26-quilt4.orig/drivers/video/backlight/platform_lcd.c	2008-07-28 23:57:53.000000000 +0100
+++ linux-2.6.26-quilt4/drivers/video/backlight/platform_lcd.c	2008-07-29 00:01:50.000000000 +0100
@@ -101,6 +101,8 @@ static int __devinit platform_lcd_probe(
 	}
 
 	platform_set_drvdata(pdev, plcd);
+	platform_lcd_set_power(plcd->lcd, FB_BLANK_NORMAL);
+
 	return 0;
 
  err_mem:

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
