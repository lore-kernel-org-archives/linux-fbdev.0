From: Ben Dooks <ben-linux@fluff.org>
Subject: BACKLIGHT: Add MODULE_ALIAS() to pwm_backlight
	driver
Date: Tue, 29 Jul 2008 11:48:02 +0100
Message-ID: <20080729104802.209446976@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KNmkW-00016d-Gu for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 03:48:12 -0700
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KNmkW-0000or-5P
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 03:48:12 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-backlight-module-alias.patch
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
Cc: Ben Dooks <ben-linux@fluff.org>, Russell King <rmk@arm.linux.org.uk>

Add the missing MODULE_ALIAS() to the pwm_backlight driver.

CC: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-quilt4/drivers/video/backlight/pwm_bl.c
===================================================================
--- linux-2.6.26-quilt4.orig/drivers/video/backlight/pwm_bl.c	2008-07-29 11:41:08.000000000 +0100
+++ linux-2.6.26-quilt4/drivers/video/backlight/pwm_bl.c	2008-07-29 11:41:29.000000000 +0100
@@ -187,3 +187,5 @@ module_exit(pwm_backlight_exit);
 
 MODULE_DESCRIPTION("PWM based Backlight Driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pwm-backlight");
+

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
