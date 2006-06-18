From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/9] VT binding: Make newport_con
	support binding
Date: Sun, 18 Jun 2006 23:33:20 +0800
Message-ID: <44957240.2000405@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FrzVh-0001vD-AA for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 08:48:25 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FrzVh-0000XY-13
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 08:48:25 -0700
Received: by py-out-1112.google.com with SMTP id i49so1055622pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Jun 2006 08:48:24 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, tsbogend@alpha.franken.de

- move register ioremap from newport_startup() to newport_console_init()
- fonts are freed multiple times, do it only once

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/newport_con.c |   36 ++++++++++++++++++++++-------------
 1 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index e99fe30..cc121dc 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -51,6 +51,7 @@ static int topscan;
 static int xcurs_correction = 29;
 static int newport_xsize;
 static int newport_ysize;
+static int newport_has_init;
 
 static int newport_set_def_font(int unit, struct console_font *op);
 
@@ -283,15 +284,20 @@ #undef L
 		xcurs_correction = 21;
 }
 
+static void newport_exit(void)
+{
+	int i;
+
+	/* free memory used by user font */
+	for (i = 0; i < MAX_NR_CONSOLES; i++)
+		newport_set_def_font(i, NULL);
+}
+
 /* Can't be __init, take_over_console may call it later */
 static const char *newport_startup(void)
 {
 	int i;
 
-	if (!sgi_gfxaddr)
-		return NULL;
-	npregs = (struct newport_regs *)	/* ioremap cannot fail */
-		 ioremap(sgi_gfxaddr, sizeof(struct newport_regs));
 	npregs->cset.config = NPORT_CFG_GD0;
 
 	if (newport_wait(npregs))
@@ -307,11 +313,11 @@ static const char *newport_startup(void)
 	newport_reset();
 	newport_get_revisions();
 	newport_get_screensize();
+	newport_has_init = 1;
 
 	return "SGI Newport";
 
 out_unmap:
-	iounmap((void *)npregs);
 	return NULL;
 }
 
@@ -324,11 +330,10 @@ static void newport_init(struct vc_data 
 
 static void newport_deinit(struct vc_data *c)
 {
-	int i;
-
-	/* free memory used by user font */
-	for (i = 0; i < MAX_NR_CONSOLES; i++)
-		newport_set_def_font(i, NULL);
+	if (!con_is_bound(&newport_con) && newport_has_init) {
+		newport_exit();
+		newport_has_init = 0;
+	}
 }
 
 static void newport_clear(struct vc_data *vc, int sy, int sx, int height,
@@ -725,19 +730,24 @@ const struct consw newport_con = {
 	.con_save_screen  = DUMMY
 };
 
-#ifdef MODULE
 static int __init newport_console_init(void)
 {
+
+	if (!sgi_gfxaddr)
+		return NULL;
+	npregs = (struct newport_regs *)	/* ioremap cannot fail */
+		 ioremap(sgi_gfxaddr, sizeof(struct newport_regs));
+
 	return take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
 }
+module_init(newport_console_init);
 
+#ifdef MODULE
 static void __exit newport_console_exit(void)
 {
 	give_up_console(&newport_con);
 	iounmap((void *)npregs);
 }
-
-module_init(newport_console_init);
 module_exit(newport_console_exit);
 #endif
