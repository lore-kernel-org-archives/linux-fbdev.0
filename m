From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] newport_con: Fix resource acquisition
Date: Sun, 25 Jun 2006 20:03:59 +0800
Message-ID: <449E7BAF.9050900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuTM8-0001Yp-Ul for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 05:04:48 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FuTM8-0003np-J8
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 05:04:48 -0700
Received: by py-out-1112.google.com with SMTP id d42so1237327pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Jun 2006 05:04:48 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

newport_con can be compiled statically and assigned directly to conswitchp, or
it can be compiled as a module, in which case, it goes through the
take_over_console() pathway.

In the former, resource acquisition is done in newport_startup() and in the
latter, the resources are acquired in newport_console_init().

Fix so resources are properly acquired whatever pathway it goes through.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Andrew,

I reexamined the changes I made to the various console drivers to make
them work with dynamic VT binding. I discovered that newport_con can
be loaded in 2 ways, directly or via take_over_console().

The changes I made in vt-binding-make-newport_con-support-binding.patch
will work only if newport_con is compiled as a module.

You may choose to fold this with the above patch.

Tony

 drivers/video/console/newport_con.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index cc121dc..0304131 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -298,6 +298,12 @@ static const char *newport_startup(void)
 {
 	int i;
 
+	if (!sgi_gfxaddr)
+		return NULL;
+
+	if (!npregs)
+		npregs = (struct newport_regs *)/* ioremap cannot fail */
+			ioremap(sgi_gfxaddr, sizeof(struct newport_regs));
 	npregs->cset.config = NPORT_CFG_GD0;
 
 	if (newport_wait(npregs))
@@ -730,19 +736,21 @@ const struct consw newport_con = {
 	.con_save_screen  = DUMMY
 };
 
+#ifdef MODULE
 static int __init newport_console_init(void)
 {
 
 	if (!sgi_gfxaddr)
 		return NULL;
-	npregs = (struct newport_regs *)	/* ioremap cannot fail */
-		 ioremap(sgi_gfxaddr, sizeof(struct newport_regs));
+
+	if (!npregs)
+		npregs = (struct newport_regs *)/* ioremap cannot fail */
+			ioremap(sgi_gfxaddr, sizeof(struct newport_regs));
 
 	return take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
 }
 module_init(newport_console_init);
 
-#ifdef MODULE
 static void __exit newport_console_exit(void)
 {
 	give_up_console(&newport_con);


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
