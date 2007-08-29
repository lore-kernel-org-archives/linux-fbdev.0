From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] fbdev: find mode with the
	highest/safest refresh rate in	fb_find_mode()
Date: Thu, 30 Aug 2007 00:41:16 +0200
Message-ID: <20070829224116.GA25106@spock.one.pl>
References: <20070718084102.GA22694@spock.one.pl>
	<20070718143803.GA5787@localhost.localdomain>
	<1184771895.4523.33.camel@daplas>
	<20070826190913.GA24286@spock.one.pl>
	<1188168573.4806.5.camel@daplas>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IQWEB-0001ah-Kx for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 29 Aug 2007 15:41:35 -0700
Received: from 110.47.78.83.cust.bluewin.ch ([83.78.47.110] helo=spock.one.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IQWEA-0000aO-Uy
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 29 Aug 2007 15:41:35 -0700
Content-Disposition: inline
In-Reply-To: <1188168573.4806.5.camel@daplas>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Currently, if the refresh rate is not specified, fb_find_mode() returns
the first known video mode with the requested resolution, which provides
no guarantees wrt the refresh rate.  Change this so that the mode with
the highest refresh rate is returned when the driver provides a custom
video mode database and the monitor limits, and a mode with the safe
60 Hz refresh rate otherwise.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 3741ad7..9598c46 100644
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
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
