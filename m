From: Frans Pop <elendil@planet.nl>
Subject: [VIDEO] vfb: only enable if explicitly
	requested when compiled in
Date: Sun, 1 Jun 2008 14:54:22 +0200
Message-ID: <200806011454.23123.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2n51-0000lE-PV for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Jun 2008 05:54:35 -0700
Received: from hpsmtp-eml18.kpnxchange.com ([213.75.38.118])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2n4z-0001Pp-A0
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Jun 2008 05:54:35 -0700
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@gmail.com>

From: Frans Pop <elendil@planet.nl>

The Kconfig help for the vfb driver says:
   Do NOT enable it for normal systems! To protect the innocent, it
   has to be enabled explicitly at boot time using the kernel option
   `video=vfb:'.
    
This change lets the code match the description.
    
Support for vfb:disable is kept for backwards compatibility; vfb:off
works because it is tested at a higher level.
    
Signed-off-by: Frans Pop <elendil@planet.nl>
CC: Antonino A. Daplas <adaplas@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>

---
Note: any undefined option (e.g. vfb:enable) will also enable this driver.

The relevant code has been unchanged since before the migration to
git (2.6.12).

This patch fixes bugzilla #9310 and was the root cause behind
http://lkml.org/lkml/2008/5/31/220.

My confusion stemmed from the fact that I was still assuming that the
Kconfig help would be correct (even though Antonino had already
determined it was not: http://lkml.org/lkml/2007/10/14/25, but somehow
my brain never parsed that).


diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index 072638a..51e935f 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -443,19 +443,29 @@ static int vfb_mmap(struct fb_info *info,
 }
 
 #ifndef MODULE
+/*
+ * The virtual framebuffer driver is only enabled if explicitly
+ * requested by passing 'video=vfb:' (or any actual options).
+ */
 static int __init vfb_setup(char *options)
 {
 	char *this_opt;
 
-	vfb_enable = 1;
+	vfb_enable = 0;
 
-	if (!options || !*options)
+	if (!options)
+		return 1;
+
+	vfb_enable = 1;
+
+	if (!*options)
 		return 1;
 
 	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt)
 			continue;
-		if (!strncmp(this_opt, "disable", 7))
+		/* Test disable for backwards compatibility */
+		if (!strcmp(this_opt, "disable"))
 			vfb_enable = 0;
 	}
 	return 1;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
