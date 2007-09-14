From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 01/12] fbdev: find mode with the
 highest/safest refresh rate in fb_find_mode()
Date: Sat, 15 Sep 2007 07:55:44 +0800
Message-ID: <46EB1F80.1060505@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWLEO-0007gK-0p for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:09:52 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWLEN-0003jU-Ev
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:09:51 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3286302rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Sep 2007 17:09:51 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Januszewski <spock@gentoo.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Michal Januszewski <spock@gentoo.org>

Currently, if the refresh rate is not specified, fb_find_mode() returns
the first known video mode with the requested resolution, which provides
no guarantees wrt the refresh rate.  Change this so that the mode with
the highest refresh rate is returned when the driver provides a custom
video mode database and the monitor limits, and a mode with the safe
60 Hz refresh rate otherwise.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/modedb.c |   41 +++++++++++++++++++++++++++++------------
 1 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index f7f9c08..03b06aa 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -606,26 +606,43 @@ done:
 	DPRINTK("Trying specified video mode%s %ix%i\n",
 	    refresh_specified ? "" : " (ignoring refresh rate)", xres, yres);
 
-	diff = refresh;
+	if (!refresh_specified) {
+		/*
+		 * If the caller has provided a custom mode database and a
+		 * valid monspecs structure, we look for the mode with the
+		 * highest refresh rate.  Otherwise we play it safe it and
+		 * try to find a mode with a refresh rate closest to the
+		 * standard 60 Hz.
+		 */
+		if (db != modedb &&
+		    info->monspecs.vfmin && info->monspecs.vfmax &&
+		    info->monspecs.hfmin && info->monspecs.hfmax &&
+		    info->monspecs.dclkmax) {
+			refresh = 1000;
+		} else {
+			refresh = 60;
+		}
+	}
+
+	diff = -1;
 	best = -1;
 	for (i = 0; i < dbsize; i++) {
-		if (name_matches(db[i], name, namelen) ||
-		    (res_specified && res_matches(db[i], xres, yres))) {
-			if(!fb_try_mode(var, info, &db[i], bpp)) {
-				if(!refresh_specified || db[i].refresh == refresh)
-					return 1;
-				else {
-					if(diff > abs(db[i].refresh - refresh)) {
-						diff = abs(db[i].refresh - refresh);
-						best = i;
-					}
+		if ((name_matches(db[i], name, namelen) ||
+		    (res_specified && res_matches(db[i], xres, yres))) &&
+		    !fb_try_mode(var, info, &db[i], bpp)) {
+			if (refresh_specified && db[i].refresh == refresh) {
+				return 1;
+			} else {
+				if (abs(db[i].refresh - refresh) < diff) {
+					diff = abs(db[i].refresh - refresh);
+					best = i;
 				}
 			}
 		}
 	}
 	if (best != -1) {
 		fb_try_mode(var, info, &db[best], bpp);
-		return 2;
+		return (refresh_specified) ? 2 : 1;
 	}
 
 	diff = xres + yres;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
