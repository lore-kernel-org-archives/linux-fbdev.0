From: Ben Dooks <ben-linux@fluff.org>
Subject: LCD: fix oops if driver only interested in
	.set_power
Date: Tue, 18 Nov 2008 18:31:10 +0000
Message-ID: <20081118183110.081968757@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ben@fluff.org.uk>) id 1L2VM4-0007o9-CH
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Nov 2008 18:31:16 +0000
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L2VM1-0003Ta-OV
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Nov 2008 18:31:16 +0000
Content-Disposition: inline; filename=add-null-setmode.patch
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Ben Dooks <ben-linux@fluff.org>

The LCD driver core calls LCD drivers when either the blanking state
or the display mode has changed, but does not make any check to see
if the called driver has a .set_mode method.

This means if a driver only has a .set_power method then the system
will OOPS on changing mode (and with the console semaphore held so
you cannot easily see the problem).

Fix the problem by ensuring that either callback is valid before use.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Index: linux.git/drivers/video/backlight/lcd.c
===================================================================
--- linux.git.orig/drivers/video/backlight/lcd.c	2008-11-18 15:07:37.000000000 +0000
+++ linux.git/drivers/video/backlight/lcd.c	2008-11-18 15:08:18.000000000 +0000
@@ -42,10 +42,13 @@ static int fb_notifier_callback(struct n
 
 	mutex_lock(&ld->ops_lock);
 	if (!ld->ops->check_fb || ld->ops->check_fb(ld, evdata->info)) {
-		if (event == FB_EVENT_BLANK)
-			ld->ops->set_power(ld, *(int *)evdata->data);
-		else
-			ld->ops->set_mode(ld, evdata->data);
+		if (event == FB_EVENT_BLANK) {
+			if (ld->ops->set_power)
+				ld->ops->set_power(ld, *(int *)evdata->data);
+		} else {
+			if (ld->ops->set_mode)
+				ld->ops->set_mode(ld, evdata->data);
+		}
 	}
 	mutex_unlock(&ld->ops_lock);
 	return 0;

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
