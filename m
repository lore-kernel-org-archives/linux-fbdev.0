From: John Zielinski <grim@undead.cc>
Subject: [PATCH] Small vesa modedb fix
Date: Sun, 23 May 2004 17:11:20 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40B11378.8070003@undead.cc>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080301080005000602010802"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BS0Fl-0005uy-3j
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 14:11:29 -0700
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BS0Fk-0002eO-Li
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 14:11:28 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080301080005000602010802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Noticed a typo in modedb.c.

John


--------------080301080005000602010802
Content-Type: text/plain;
 name="modedb_vesa_1920x1440-75_fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modedb_vesa_1920x1440-75_fix"

diff -urNX dontdiff linux-2.6.6/drivers/video/modedb.c linux/drivers/video/modedb.c
--- linux-2.6.6/drivers/video/modedb.c	2004-05-09 22:32:29.000000000 -0400
+++ linux/drivers/video/modedb.c	2004-05-23 17:14:21.000000000 -0400
@@ -371,7 +371,7 @@
 	{ NULL, 60, 1920, 1440, 4273, 344, 128, 56, 1, 200, 3,
 	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
 	/* 33 1920x1440-75 VESA */
-	{ NULL, 60, 1920, 1440, 3367, 352, 144, 56, 1, 224, 3,
+	{ NULL, 75, 1920, 1440, 3367, 352, 144, 56, 1, 224, 3,
 	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
 };
 

--------------080301080005000602010802--



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
