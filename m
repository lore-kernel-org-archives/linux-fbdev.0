From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/15] fbdev: Convert MODULE_PARM to module_param in intelfb
Date: Fri, 29 Oct 2004 09:58:15 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.15912.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM2B-0005uo-Fl
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:58:31 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM2A-0001Mk-Vk
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:58:31 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 4B4749698CA
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:58:24 +0000 (UTC)
Content-Disposition: inline
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Sylvain Meyer <sylvain.meyer@ifrance.com>

fbdev: Convert MODULE_PARM to module_param in intelfb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 intelfb.h    |    6 +++---
 intelfbdrv.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -Nru a/drivers/video/intelfb/intelfb.h b/drivers/video/intelfb/intelfb.h
--- a/drivers/video/intelfb/intelfb.h	2004-10-23 23:13:14 +08:00
+++ b/drivers/video/intelfb/intelfb.h	2004-10-28 20:56:42 +08:00
@@ -97,12 +97,12 @@
 /* module parameters */
 #define INTELFB_INT_PARAM(name, default, desc)				\
 	static int name = default;					\
-	MODULE_PARM(name, "i");					        \
+	module_param(name, int, default);			        \
 	MODULE_PARM_DESC(name, desc);
 
 #define INTELFB_STR_PARAM(name, default, desc)				\
-	static const char *name = default;				\
-	MODULE_PARM(name, "s");				                \
+	static char *name = (char *) default;				\
+	module_param(name, charp, default);		                \
 	MODULE_PARM_DESC(name, desc);
 
 /* misc macros */
diff -Nru a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c	2004-10-23 23:13:14 +08:00
+++ b/drivers/video/intelfb/intelfbdrv.c	2004-10-28 20:56:42 +08:00
@@ -197,7 +197,7 @@
 INTELFB_INT_PARAM(idonly, 0,
 		  "Just identify without doing anything else (debug)");
 INTELFB_INT_PARAM(bailearly, 0, "Bail out early, depending on value (debug)");
-INTELFB_STR_PARAM(mode, NULL,
+INTELFB_STR_PARAM(mode, 0,
 		  "Initial video mode \"<xres>x<yres>[-<depth>][@<refresh>]\"");
 /***************************************************************
  *                     modules entry points                    *




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
