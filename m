From: David Vrabel <dvrabel@arcom.com>
Subject: [patch] allow fb_find_mode() w/ default db from modules
Date: Thu, 10 Feb 2005 16:25:18 +0000
Message-ID: <420B8AEE.5090500@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzH8G-0000WG-9C
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Feb 2005 08:25:32 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CzH8B-0004KF-Pp
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Feb 2005 08:25:32 -0800
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
To: linux-fbdev-devel list <linux-fbdev-devel@lists.sourceforge.net>

Remove the __init from modedb in modedb.c so it can be used from modules
as the default db in fb_find_mode().

Signed-off-by: David Vrabel

Index: linux-2.6-i386/drivers/video/modedb.c
===================================================================
--- linux-2.6-i386.orig/drivers/video/modedb.c	2005-02-10
15:54:58.682358203 +0000
+++ linux-2.6-i386/drivers/video/modedb.c	2005-02-10 15:57:29.956725460
+0000
@@ -39,7 +39,7 @@

 #define DEFAULT_MODEDB_INDEX	0

-static const __init struct fb_videomode modedb[] = {
+static const struct fb_videomode modedb[] = {
     {
 	/* 640x400 @ 70 Hz, 31.5 kHz hsync */
 	NULL, 70, 640, 400, 39721, 40, 24, 39, 9, 96, 2,
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
