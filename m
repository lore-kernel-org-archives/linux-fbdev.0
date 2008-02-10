From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] fbdev: make the best-fit section of
	fb_find_mode return	the closest matching mode
Date: Sun, 10 Feb 2008 19:46:13 +0100
Message-ID: <20080210184613.GA11006@spock.one.pl>
References: <20080127113115.GA17722@spock.one.pl>
	<20080127132510.b00017cb.krzysztof.h1@poczta.fm>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JOHCq-00087j-48 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Feb 2008 10:47:12 -0800
Received: from fk-out-0910.google.com ([209.85.128.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JOHCo-000246-4F
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Feb 2008 10:47:12 -0800
Received: by fk-out-0910.google.com with SMTP id 26so4273037fkx.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 10 Feb 2008 10:47:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080127132510.b00017cb.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Michal Januszewski <spock@gentoo.org>

Currently, if a perfect match in terms of resolution is not found,
fb_find_mode() only looks for a best-fit mode among modes with a
higher resolution than the one requested.  Thus, if the user
requests a resolution higher than the largest supported one, they
are dropped to the default mode (usually a low resolution one).

Change this behaviour so that all valid video modes are considered
when looking for a best-fit mode, while still preferring modes
with a higher resolution.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 08d0725..0b6a45f 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -522,7 +522,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 	int res_specified = 0, bpp_specified = 0, refresh_specified = 0;
 	unsigned int xres = 0, yres = 0, bpp = default_bpp, refresh = 0;
 	int yres_specified = 0, cvt = 0, rb = 0, interlace = 0, margins = 0;
-	u32 best, diff;
+	u32 best, diff, tdiff;
 
 	for (i = namelen-1; i >= 0; i--) {
 	    switch (name[i]) {
@@ -651,19 +651,27 @@ done:
 		return (refresh_specified) ? 2 : 1;
 	}
 
-	diff = xres + yres;
+	diff = 2 * (xres + yres);
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
+			tdiff = abs(db[i].xres - xres) +
+				abs(db[i].yres - yres);
+
+			/*
+			 * Penalize modes with resolutions smaller
+			 * than requested.
+			 */
+			if (xres > db[i].xres || yres > db[i].yres)
+				tdiff += xres + yres;
+
+			if (diff > tdiff) {
+				diff = tdiff;
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
