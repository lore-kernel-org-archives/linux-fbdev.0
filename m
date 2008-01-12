From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] uvesafb: small cleanups
Date: Fri, 11 Jan 2008 17:04:15 -0800
Message-ID: <20080111170415.41e2120c.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JDUnR-0001r9-R2 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Jan 2008 17:04:25 -0800
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JDUnR-0001EG-Fb
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Jan 2008 17:04:25 -0800
Received: from midway.site ([71.245.106.199]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 11 Jan 2008 17:04:15 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net, spock@gentoo.org
Cc: akpm <akpm@linux-foundation.org>, samr <sam@ravnborg.org>, adaplas@gmail.com

From: Randy Dunlap <randy.dunlap@oracle.com>

Some cleanups in uvesafb:
- The custom module_param() get/set functions don't need to be inlined
  since it is referred to via a pointer in a struct.
- don't end a #define with a ';'
- remove one of the single quote marks in "''ypan'"

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/uvesafb.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.24-rc7-git1.orig/drivers/video/uvesafb.c
+++ linux-2.6.24-rc7-git1/drivers/video/uvesafb.c
@@ -2003,12 +2003,12 @@ static void __devexit uvesafb_exit(void)
 
 module_exit(uvesafb_exit);
 
-static inline int param_get_scroll(char *buffer, struct kernel_param *kp)
+static int param_get_scroll(char *buffer, struct kernel_param *kp)
 {
 	return 0;
 }
 
-static inline int param_set_scroll(const char *val, struct kernel_param *kp)
+static int param_set_scroll(const char *val, struct kernel_param *kp)
 {
 	ypan = 0;
 
@@ -2022,11 +2022,11 @@ static inline int param_set_scroll(const
 	return 0;
 }
 
-#define param_check_scroll(name, p) __param_check(name, p, void);
+#define param_check_scroll(name, p) __param_check(name, p, void)
 
 module_param_named(scroll, ypan, scroll, 0);
 MODULE_PARM_DESC(scroll,
-	"Scrolling mode, set to 'redraw', ''ypan' or 'ywrap'");
+	"Scrolling mode, set to 'redraw', 'ypan', or 'ywrap'");
 module_param_named(vgapal, pmi_setpal, invbool, 0);
 MODULE_PARM_DESC(vgapal, "Set palette using VGA registers");
 module_param_named(pmipal, pmi_setpal, bool, 0);
---
~Randy

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
