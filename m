From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 7/7] lxfb: disable suspend VT switch by
	default
Date: Thu, 27 Mar 2008 20:11:15 -0400
Message-ID: <20080327201115.04dacac5@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jf2B0-0002hJ-EA for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Mar 2008 17:10:34 -0700
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jf2Az-0001Qe-3G
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Mar 2008 17:10:34 -0700
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jordan.crouse@amd.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com, info-linux@geode.amd.com


By default disable VT switch, but allow it to be overridden via the
'vt_switch' module arg.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 Documentation/fb/lxfb.txt       |    2 ++
 drivers/video/geode/lxfb_core.c |    7 +++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/fb/lxfb.txt b/Documentation/fb/lxfb.txt
index dc501da..379d9c6 100644
--- a/Documentation/fb/lxfb.txt
+++ b/Documentation/fb/lxfb.txt
@@ -45,6 +45,8 @@ Accepted options:
 mode_option	- specify the video mode.  Of the form
 		  <x>x<y>[-<bpp>][@<refresh>]
 vram		- size of video ram (normally auto-detected)
+vt_switch	- enable vt switching during suspend/resume.  The vt
+		  switch is slow, but harmless.
 
 --
 Andres Salomon <dilinger@debian.org>
diff --git a/drivers/video/geode/lxfb_core.c b/drivers/video/geode/lxfb_core.c
index d0502a5..e290981 100644
--- a/drivers/video/geode/lxfb_core.c
+++ b/drivers/video/geode/lxfb_core.c
@@ -17,6 +17,7 @@
 #include <linux/console.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/init.h>
@@ -28,6 +29,7 @@
 static char *mode_option;
 static int noclear, nopanel, nocrt;
 static int vram;
+static int vt_switch;
 
 /* Most of these modes are sorted in ascending order, but
  * since the first entry in this table is the "default" mode,
@@ -526,6 +528,8 @@ static int __init lxfb_probe(struct pci_dev *pdev,
 	lxfb_check_var(&info->var, info);
 	lxfb_set_par(info);
 
+	pm_set_vt_switch(vt_switch);
+
 	if (register_framebuffer(info) < 0) {
 		ret = -EINVAL;
 		goto err;
@@ -653,5 +657,8 @@ MODULE_PARM_DESC(mode_option, "video mode (<x>x<y>[-<bpp>][@<refr>])");
 module_param(vram, int, 0);
 MODULE_PARM_DESC(vram, "video memory size");
 
+module_param(vt_switch, int, 0);
+MODULE_PARM_DESC(vt_switch, "enable VT switch during suspend/resume");
+
 MODULE_DESCRIPTION("Framebuffer driver for the AMD Geode LX");
 MODULE_LICENSE("GPL");
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
