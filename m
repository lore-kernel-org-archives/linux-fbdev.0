From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/7] fbdev: Make fb_find_mode() return failure if modular
Date: Thu, 17 Feb 2005 20:47:00 +0800
Message-ID: <200502172045.16677.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1l66-0000l9-GY
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 04:49:34 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D1l65-0008NP-2C
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 04:49:34 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 31414E224B5
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 12:49:27 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

A few drivers call fb_find_mode() even if compiled as a module.  If the
modedb parameter is NULL, the function will use default modedb array which
is marked __init. This will cause a crash.  To avoid this, check if the
driver is compiled as a module, and if it is, fail.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 modedb.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -Nru a/drivers/video/modedb.c b/drivers/video/modedb.c
--- a/drivers/video/modedb.c	2005-02-17 19:29:47 +08:00
+++ b/drivers/video/modedb.c	2005-02-15 22:54:57 +08:00
@@ -474,11 +474,15 @@
 {
     int i;
 
+    if (!db && (info->flags & FBINFO_MODULE))
+	return 0;
+
     /* Set up defaults */
     if (!db) {
 	db = modedb;
 	dbsize = sizeof(modedb)/sizeof(*modedb);
     }
+
     if (!default_mode)
 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
     if (!default_bpp)




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
