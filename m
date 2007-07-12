From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] disable logo at boot
Date: Thu, 12 Jul 2007 13:37:45 -0700
Message-ID: <20070712133745.2ede18c5.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I95ML-00078Y-1i for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 13:33:59 -0700
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1I95MK-0005K1-Oz
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 13:33:56 -0700
Received: from midway.site ([71.117.236.25]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jul 2007 13:33:51 -0700
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
Cc: adaplas@gmail.com

From: Randy Dunlap <rdunlap@xenotime.net>

Add logo.nologo kernel boot option to disable the logo in order
to provide more screen space for kernel messages; especially
useful when debugging and screen space is more critical.

newport_con driver changes are untested.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/kernel-parameters.txt |    5 +++++
 drivers/video/console/newport_con.c |   20 ++++++++++++++------
 drivers/video/logo/logo.c           |    6 ++++++
 3 files changed, 25 insertions(+), 6 deletions(-)

--- linux-2.6.22.orig/Documentation/kernel-parameters.txt
+++ linux-2.6.22/Documentation/kernel-parameters.txt
@@ -900,6 +900,11 @@ and is between 256 and 4096 characters. 
 			n must be a power of two.  The default size
 			is set in the kernel config file.
 
+	logo.nologo	[FB] Disables display of the built-in Linux logo.
+			This may be used to provide more screen space for
+			kernel log messages and is useful when debugging
+			kernel boot problems.
+
 	lp=0		[LP]	Specify parallel ports to use, e.g,
 	lp=port[,port...]	lp=none,parport0 (lp0 not configured, lp1 uses
 	lp=reset		first parallel port). 'lp=0' disables the
--- linux-2.6.22.orig/drivers/video/logo/logo.c
+++ linux-2.6.22/drivers/video/logo/logo.c
@@ -34,11 +34,17 @@ extern const struct linux_logo logo_supe
 extern const struct linux_logo logo_superh_clut224;
 extern const struct linux_logo logo_m32r_clut224;
 
+int nologo;
+module_param(nologo, bool, 0);
+MODULE_PARM_DESC(nologo, "Disables startup logo");
 
 const struct linux_logo *fb_find_logo(int depth)
 {
 	const struct linux_logo *logo = NULL;
 
+	if (nologo)
+		return NULL;
+
 	if (depth >= 1) {
 #ifdef CONFIG_LOGO_LINUX_MONO
 		/* Generic Linux logo */
--- linux-2.6.22.orig/drivers/video/console/newport_con.c
+++ linux-2.6.22/drivers/video/console/newport_con.c
@@ -98,14 +98,19 @@ static inline void newport_init_cmap(voi
 	}
 }
 
-static void newport_show_logo(void)
+static struct linux_logo * newport_show_logo(void)
 {
 #ifdef CONFIG_LOGO_SGI_CLUT224
 	const struct linux_logo *logo = fb_find_logo(8);
-	const unsigned char *clut = logo->clut;
-	const unsigned char *data = logo->data;
+	const unsigned char *clut;
+	const unsigned char *data;
 	unsigned long i;
 
+	if (!logo)
+		return NULL;
+	*clut = logo->clut;
+	*data = logo->data;
+
 	for (i = 0; i < logo->clutsize; i++) {
 		newport_bfwait(npregs);
 		newport_cmap_setaddr(npregs, i + 0x20);
@@ -123,6 +128,8 @@ static void newport_show_logo(void)
 
 	for (i = 0; i < logo->width*logo->height; i++)
 		npregs->go.hostrw0 = *data++ << 24;
+
+	return logo;
 #endif /* CONFIG_LOGO_SGI_CLUT224 */
 }
 
@@ -465,9 +472,10 @@ static int newport_switch(struct vc_data
 	npregs->cset.topscan = 0x3ff;
 
 	if (!logo_drawn) {
-		newport_show_logo();
-		logo_drawn = 1;
-		logo_active = 1;
+		if (newport_show_logo()) {
+			logo_drawn = 1;
+			logo_active = 1;
+		}
 	}
 
 	return 1;

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
