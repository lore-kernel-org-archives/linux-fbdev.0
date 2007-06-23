From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH 1/4] fbdev: make fb_find_mode look for a
	mode with the	highest refresh rate
Date: Sat, 23 Jun 2007 12:50:46 +0200
Message-ID: <20070623105046.GB12623@spock.one.pl>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I23Cc-0005ft-Ae for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Jun 2007 03:50:50 -0700
Received: from ipn26-148.piekary.net ([83.238.26.148])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I23Cb-0004AV-V0
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Jun 2007 03:50:50 -0700
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
Cc: linux-kernel@vger.kernel.org

If the refresh rate hasn't been explicitly specified, fd_find_mode
currently returns the first mode with the requested resolution. Change
it so that it returns a mode with the requested resolution and the
highest refresh rate.

Also export fb_destroy_modelist, which is used in uvesafb.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
drivers/video/modedb.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 3741ad7..98ee77b 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -606,16 +606,18 @@ done:
 	DPRINTK("Trying specified video mode%s %ix%i\n",
 	    refresh_specified ? "" : " (ignoring refresh rate)", xres, yres);
 
+	if (!refresh_specified)
+		refresh = 200;
 	diff = refresh;
 	best = -1;
 	for (i = 0; i < dbsize; i++) {
 		if (name_matches(db[i], name, namelen) ||
 		    (res_specified && res_matches(db[i], xres, yres))) {
 			if(!fb_try_mode(var, info, &db[i], bpp)) {
-				if(!refresh_specified || db[i].refresh == refresh)
+				if (refresh_specified && db[i].refresh == refresh)
 					return 1;
 				else {
-					if(diff > abs(db[i].refresh - refresh)) {
+					if (diff > abs(db[i].refresh - refresh)) {
 						diff = abs(db[i].refresh - refresh);
 						best = i;
 					}
@@ -938,6 +940,7 @@ void fb_destroy_modelist(struct list_head *head)
 		kfree(pos);
 	}
 }
+EXPORT_SYMBOL_GPL(fb_destroy_modelist);
 
 /**
  * fb_videomode_to_modelist: convert mode array to mode list



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
