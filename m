From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 05/17] fbcon: logo: disable logo at boot
Date: Sat, 29 Sep 2007 09:29:01 +0800
Message-ID: <46FDAA5D.6030500@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbSNI-000842-G9 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:48:12 -0700
Received: from wa-out-1112.google.com ([209.85.146.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbSNH-0003FN-5U
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:48:12 -0700
Received: by wa-out-1112.google.com with SMTP id k22so5642791waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 19:48:10 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Randy Dunlap <rdunlap@xenotime.net>

Add logo.nologo kernel boot option to disable the logo in order
to provide more screen space for kernel messages; especially
useful when debugging and screen space is more critical.

newport_con driver changes are untested.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 Documentation/kernel-parameters.txt |    5 +++++
 drivers/video/console/newport_con.c |   20 ++++++++++++++------
 drivers/video/logo/logo.c           |    7 +++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index d9040cf..e29377a 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -954,6 +954,11 @@ and is between 256 and 4096 characters. 
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
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index dda0586..cb328c0 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
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
@@ -123,6 +128,8 @@ #ifdef CONFIG_LOGO_SGI_CLUT224
 
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
diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 8952721..80f8ffd 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -34,6 +34,10 @@ extern const struct linux_logo logo_supe
 extern const struct linux_logo logo_superh_clut224;
 extern const struct linux_logo logo_m32r_clut224;
 
+int nologo;
+module_param(nologo, bool, 0);
+MODULE_PARM_DESC(nologo, "Disables startup logo");
+
 /* logo's are marked __initdata. Use __init_refok to tell
  * modpost that it is intended that this function uses data
  * marked __initdata.
@@ -42,6 +46,9 @@ const struct linux_logo * __init_refok f
 {
 	const struct linux_logo *logo = NULL;
 
+	if (nologo)
+		return NULL;
+
 	if (depth >= 1) {
 #ifdef CONFIG_LOGO_LINUX_MONO
 		/* Generic Linux logo */



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
