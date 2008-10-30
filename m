From: Tuomas Kulve <tuomas.kulve@movial.com>
Subject: Patch to enable omapfb scaling
Date: Thu, 30 Oct 2008 10:25:04 +0200
Message-ID: <49096F60.3070300@movial.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070003020503010905010807"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tuomas.kulve@movial.com>) id 1KvTHU-0000Qq-MF
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 30 Oct 2008 08:53:28 +0000
Received: from smtp.movial.fi ([62.236.91.34])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KvTHK-0002TO-OV
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 30 Oct 2008 08:53:28 +0000
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id C4D52C80D4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 30 Oct 2008 10:25:04 +0200 (EET)
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new,
	port 10026) with ESMTP id ehL4Om7905AK
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 30 Oct 2008 10:25:04 +0200 (EET)
Received: from [172.17.49.56] (sd056.hel.movial.fi [172.17.49.56])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id A45EFC8051
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 30 Oct 2008 10:25:04 +0200 (EET)
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

This is a multi-part message in MIME format.
--------------070003020503010905010807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


Hi

The attached patch enables omapfb scaling. Tested on omap3 based
beagleboard with 2.6.27-omap1 kernel from linux-omap kernel tree.

The "if" is a leftover from this commit in linux-omap tree:
4139f42ea612e0ff53a4df41428040f777d0422c


Thanks,
-- 
Tuomas Kulve, Movial Creative Technologies Inc.
Porkkalankatu 13J, FI-00180 Helsinki
Fax +358 9 8567 6401, Tel +358 9 8567 6400
www.movial.com

--------------070003020503010905010807
Content-Type: text/x-patch;
	name*0="0001-Removed-old-contradictory-leftover-if-that-prevent.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0001-Removed-old-contradictory-leftover-if-that-prevent.patc";
	filename*1="h"

From 886ddb31a1192fc324f1bc092766c918c5fd22fb Mon Sep 17 00:00:00 2001
From: Tuomas Kulve <tuomas.kulve@movial.com>
Date: Wed, 29 Oct 2008 10:54:06 +0200
Subject: [PATCH] Removed old contradictory leftover 'if' that prevents video scaling.

---
 drivers/video/omap/dispc.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 1e6e035..68bc887 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -583,9 +583,6 @@ static int omap_dispc_set_scale(int plane,
 	if ((unsigned)plane > OMAPFB_PLANE_NUM)
 		return -ENODEV;
 
-	if (out_width != orig_width || out_height != orig_height)
-		return -EINVAL;
-
 	enable_lcd_clocks(1);
 	if (orig_width < out_width) {
 		/*
-- 
1.5.6.5



--------------070003020503010905010807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------070003020503010905010807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------070003020503010905010807--
