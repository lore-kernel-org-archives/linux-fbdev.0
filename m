From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 8/8] fbdev: Change the find_mode behavior
Date: Thu, 11 Nov 2004 10:15:46 +0800
Message-ID: <20041111022526.D3B201A025D@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CS4eZ-000548-Cr
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:25:39 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CS4eY-0006oM-Mr
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:25:39 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 06B929D766B
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 11 Nov 2004 02:25:31 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>
Cc: Alexander Kern <alex.kern@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

let find_mode search for nearest refresh rate

Signed-off-by: Alexander Kern <alex.kern@gmx.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 modedb.c |   43 +++++++++++++++++++++++++++++++------------
 1 files changed, 31 insertions(+), 12 deletions(-)

diff -Nru a/drivers/video/modedb.c b/drivers/video/modedb.c
--- a/drivers/video/modedb.c	2004-10-19 20:21:56 +08:00
+++ b/drivers/video/modedb.c	2004-11-11 09:56:51 +08:00
@@ -24,7 +24,7 @@
     ((v).xres == (x) && (v).yres == (y))
 
 #ifdef DEBUG
-#define DPRINTK(fmt, args...)	printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
+#define DPRINTK(fmt, args...)	printk("modedb %s: " fmt, __FUNCTION__ , ## args)
 #else
 #define DPRINTK(fmt, args...)
 #endif
@@ -474,7 +474,7 @@
 		 const struct fb_videomode *default_mode,
 		 unsigned int default_bpp)
 {
-    int i, j;
+    int i;
 
     /* Set up defaults */
     if (!db) {
@@ -493,7 +493,7 @@
 	int res_specified = 0, bpp_specified = 0, refresh_specified = 0;
 	unsigned int xres = 0, yres = 0, bpp = default_bpp, refresh = 0;
 	int yres_specified = 0;
-	u32 best = -1, diff = -1;
+	u32 best, diff;
 
 	for (i = namelen-1; i >= 0; i--) {
 	    switch (name[i]) {
@@ -532,16 +532,35 @@
 	    res_specified = 1;
 	}
 done:
-	for (i = refresh_specified; i >= 0; i--) {
-	    DPRINTK("Trying specified video mode%s %ix%i\n",
-		    i ? "" : " (ignoring refresh rate)", xres, yres);
-	    for (j = 0; j < dbsize; j++)
-		if ((name_matches(db[j], name, namelen) ||
-		     (res_specified && res_matches(db[j], xres, yres))) &&
-		    (!i || db[j].refresh == refresh) &&
-		    !fb_try_mode(var, info, &db[j], bpp))
-		    return 2-i;
+	DPRINTK("Trying specified video mode%s %ix%i\n",
+	    refresh_specified ? "" : " (ignoring refresh rate)", xres, yres);
+
+	diff = refresh;
+	best = -1;
+	for (i = 0; i < dbsize; i++) {
+		if ((name_matches(db[i], name, namelen) &&
+			!fb_try_mode(var, info, &db[i], bpp)))
+			return 1;
+		if (res_specified && res_matches(db[i], xres, yres)) {
+			if(!fb_try_mode(var, info, &db[i], bpp)) {
+				if(!refresh_specified || db[i].refresh == refresh)
+					return 1;
+				else {
+					if(diff > abs(db[i].refresh - refresh)) {
+						diff = abs(db[i].refresh - refresh);
+						best = i;
+					}
+				}
+			}
+		}
+	}
+	if (best != -1) {
+		fb_try_mode(var, info, &db[best], bpp);
+		return 2;
 	}
+
+	diff = xres + yres;
+	best = -1;
 	DPRINTK("Trying best-fit modes\n");
 	for (i = 0; i < dbsize; i++) {
 	    if (xres <= db[i].xres && yres <= db[i].yres) {




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
