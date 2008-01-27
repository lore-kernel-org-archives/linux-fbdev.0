From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] fbdev: make the best-fit section of
	fb_find_mode return	the closest matching mode
Date: Sun, 27 Jan 2008 12:31:16 +0100
Message-ID: <20080127113115.GA17722@spock.one.pl>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JJ5jg-0005wz-Be for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 Jan 2008 03:31:40 -0800
Received: from fg-out-1718.google.com ([72.14.220.153])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JJ5jd-0000ny-I3
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 Jan 2008 03:31:40 -0800
Received: by fg-out-1718.google.com with SMTP id d23so1274186fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 27 Jan 2008 03:31:36 -0800 (PST)
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

From: Michal Januszewski <spock@gentoo.org>

Currently, if a perfect match in terms of resolution is not found,
fb_find_mode() only looks for a best-fit mode among modes with a
higher resolution than the one requested.  Thus, if the user
requests a resolution higher than the largest supported one, they
are dropped to the default mode (usually a low resolution one).

Change this behaviour so that the true closest match in terms
of the city-block metric is returned.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 08d0725..bc29ef3 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -655,15 +655,15 @@ done:
 	best = -1;
 	DPRINTK("Trying best-fit modes\n");
 	for (i = 0; i < dbsize; i++) {
-	    if (xres <= db[i].xres && yres <= db[i].yres) {
 		DPRINTK("Trying %ix%i\n", db[i].xres, db[i].yres);
 		if (!fb_try_mode(var, info, &db[i], bpp)) {
-		    if (diff > (db[i].xres - xres) + (db[i].yres - yres)) {
-			diff = (db[i].xres - xres) + (db[i].yres - yres);
-			best = i;
-		    }
+			if (diff > abs(db[i].xres - xres) +
+				   abs(db[i].yres - yres)) {
+				diff = abs(db[i].xres - xres) +
+				       abs(db[i].yres - yres);
+				best = i;
+			}
 		}
-	    }
 	}
 	if (best != -1) {
 	    fb_try_mode(var, info, &db[best], bpp);


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
