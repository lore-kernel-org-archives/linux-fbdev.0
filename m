From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH modedb.c] change the find_mode behaviour
Date: Wed, 10 Nov 2004 19:29:33 +0100
Message-ID: <200411101929.33195.alex.kern@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_N4lkBYuQHX9Pi5m"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRxDr-0008Q3-Ri
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 10:29:35 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CRxDq-0004mY-Um
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 10:29:35 -0800
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

--Boundary-00=_N4lkBYuQHX9Pi5m
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

let find_mode search for nearest refresh rate

Signed-off-by: Alexander Kern <alex.kern@gmx.de>


--Boundary-00=_N4lkBYuQHX9Pi5m
Content-Type: text/x-diff;
  charset="us-ascii";
  name="modedb_search_refresh_closest_to.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="modedb_search_refresh_closest_to.patch"

--- linux-2.6.head/drivers/video/modedb.c.orig	2004-11-09 19:06:54.000000000 +0100
+++ linux-2.6.head/drivers/video/modedb.c	2004-11-10 16:40:10.994799088 +0100
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

--Boundary-00=_N4lkBYuQHX9Pi5m--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
