From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] softcursor fix for PM
Date: Tue, 10 Feb 2004 21:38:59 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1076409539.866.9.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqVII-0003vo-UQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 02:39:06 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AqVIP-0002JB-9j
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 02:39:13 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

diff -urN fbdev-2.5/drivers/video/softcursor.c linuxppc-2.5-benh/drivers/video/softcursor.c
--- fbdev-2.5/drivers/video/softcursor.c	2004-02-10 21:15:18.000000000 +1100
+++ linuxppc-2.5-benh/drivers/video/softcursor.c	2004-02-10 21:06:24.000000000 +1100
@@ -62,7 +62,10 @@
 
 	if (cursor->set & FB_CUR_SETSHAPE)
 		fb_load_cursor_image(info);
-		
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return 0;
+
 	if (!cursor->enable || (info->cursor.enable && (cursor->set & FB_CUR_SETPOS))) {
 		if (needsync && info->fbops->fb_sync) {
 			info->fbops->fb_sync(info);




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
