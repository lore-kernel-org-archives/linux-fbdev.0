From: domen@coderock.org
Subject: [patch 8/9] tridentfb: Clean up printk()'s in drivers/video/tridentfb.c
Date: Sun, 06 Mar 2005 11:36:34 +0100
Message-ID: <20050306103634.BE6C51F23F@trashy.coderock.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7t7x-0001hC-An
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 02:36:49 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D7t7w-0003an-O8
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 02:36:49 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, domen@coderock.org, james4765@cwazy.co.uk, james4765@gmail.com


This patch adds KERN_ constants to all of the printk()'s that need them in
drivers/video/tridentfb.c - resent after correcting one improper KERN_ constant.

Signed-off-by: James Nelson <james4765@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/video/tridentfb.c |    2 +-
 kj-domen/include/video/trident.h   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/video/tridentfb.c~printk-drivers_video_tridentfb drivers/video/tridentfb.c
--- kj/drivers/video/tridentfb.c~printk-drivers_video_tridentfb	2005-03-05 16:13:03.000000000 +0100
+++ kj-domen/drivers/video/tridentfb.c	2005-03-05 16:13:03.000000000 +0100
@@ -1163,7 +1163,7 @@ static int __devinit trident_pci_probe(s
 	fb_info.var = default_var;
 	fb_info.device = &dev->dev;
 	if (register_framebuffer(&fb_info) < 0) {
-		output("Could not register Trident framebuffer\n");
+		printk(KERN_ERR "tridentfb: could not register Trident framebuffer\n");
 		return -EINVAL;
 	}
 	output("fb%d: %s frame buffer device %dx%d-%dbpp\n",
diff -puN include/video/trident.h~printk-drivers_video_tridentfb include/video/trident.h
--- kj/include/video/trident.h~printk-drivers_video_tridentfb	2005-03-05 16:13:03.000000000 +0100
+++ kj-domen/include/video/trident.h	2005-03-05 16:13:03.000000000 +0100
@@ -9,7 +9,7 @@
 #define debug(f,a...)
 #endif
 
-#define output(f, a...) printk("tridentfb: " f, ## a)
+#define output(f, a...) pr_info("tridentfb: " f, ## a)
 
 #define Kb	(1024)
 #define Mb	(Kb*Kb)
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
