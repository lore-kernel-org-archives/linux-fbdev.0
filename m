From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/5] tridentfb: Clean up printk()'s
Date: Tue, 15 Mar 2005 07:06:06 +0800
Message-ID: <200503150706.06567.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAyfS-0007uL-Fj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 15:08:10 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAyfR-0003nV-1f
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 15:08:10 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D6DC8FA576D
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Mar 2005 23:07:54 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, c.lucas@ifrance.com, domen@coderock.org

  This patch adds KERN_ constants to all of the printk()'s that need them in
  drivers/video/tridentfb.c

Signed-off-by: James Nelson <james4765@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/tridentfb.c |    2 +-
 include/video/trident.h   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c	2005-03-05 23:12:56 +08:00
+++ b/drivers/video/tridentfb.c	2005-03-05 23:13:03 +08:00
@@ -1163,7 +1163,7 @@
 	fb_info.var = default_var;
 	fb_info.device = &dev->dev;
 	if (register_framebuffer(&fb_info) < 0) {
-		output("Could not register Trident framebuffer\n");
+		printk(KERN_ERR "tridentfb: could not register Trident framebuffer\n");
 		return -EINVAL;
 	}
 	output("fb%d: %s frame buffer device %dx%d-%dbpp\n",
diff -Nru a/include/video/trident.h b/include/video/trident.h
--- a/include/video/trident.h	2005-03-13 00:57:39 +08:00
+++ b/include/video/trident.h	2005-03-05 23:13:03 +08:00
@@ -9,7 +9,7 @@
 #define debug(f,a...)
 #endif
 
-#define output(f, a...) printk("tridentfb: " f, ## a)
+#define output(f, a...) pr_info("tridentfb: " f, ## a)
 
 #define Kb	(1024)
 #define Mb	(Kb*Kb)




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
