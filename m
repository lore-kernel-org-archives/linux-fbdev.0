From: akpm@osdl.org
Subject: [patch 04/25] video: Get the default mode from
	the right database
Date: Wed, 01 Nov 2006 21:50:19 -0800
Message-ID: <200611020550.kA25oKGS002291@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVUQ-0007gP-T8 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:51:46 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVUQ-0007bF-KO
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:51:46 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org, jordan.crouse@amd.com, geert@linux-m68k.org, adaplas@pol.net

From: Jordan Crouse <jordan.crouse@amd.com>

If no default mode is specified, it should be grabbed from the supplied
database, not the default one.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/modedb.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff -puN drivers/video/modedb.c~video-get-the-default-mode-from-the-right-database drivers/video/modedb.c
--- a/drivers/video/modedb.c~video-get-the-default-mode-from-the-right-database
+++ a/drivers/video/modedb.c
@@ -505,8 +505,11 @@ int fb_find_mode(struct fb_var_screeninf
 	db = modedb;
 	dbsize = ARRAY_SIZE(modedb);
     }
-    if (!default_mode)
+    if (!default_mode && db != modedb)
+	default_mode = &db[0];
+    else
 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
+
     if (!default_bpp)
 	default_bpp = 8;
 
_

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
