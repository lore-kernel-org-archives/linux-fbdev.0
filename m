From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] proper prototypes for some console
	functions
Date: Mon, 21 Aug 2006 12:44:05 +0200
Message-ID: <20060821104405.GI11651@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GF7GO-0000KP-3P for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Aug 2006 03:44:12 -0700
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GF7GM-0002Cp-Fx
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Aug 2006 03:44:12 -0700
Content-Disposition: inline
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
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch adds proper prototypes to header files for three console init 
functions used on drivers/char/vt.c

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/vt.c          |    8 --------
 include/linux/console.h    |    3 +++
 include/linux/consolemap.h |    1 +
 3 files changed, 4 insertions(+), 8 deletions(-)

--- linux-2.6.18-rc4-mm1/include/linux/consolemap.h.old	2006-08-14 00:30:56.000000000 +0200
+++ linux-2.6.18-rc4-mm1/include/linux/consolemap.h	2006-08-14 00:31:10.000000000 +0200
@@ -13,3 +13,4 @@
 extern unsigned char inverse_translate(struct vc_data *conp, int glyph);
 extern unsigned short *set_translate(int m, struct vc_data *vc);
 extern int conv_uni_to_pc(struct vc_data *conp, long ucs);
+void console_map_init(void);
--- linux-2.6.18-rc4-mm1/include/linux/console.h.old	2006-08-14 00:31:33.000000000 +0200
+++ linux-2.6.18-rc4-mm1/include/linux/console.h	2006-08-14 00:32:42.000000000 +0200
@@ -124,6 +124,9 @@
 extern void suspend_console(void);
 extern void resume_console(void);
 
+int mda_console_init(void);
+void prom_con_init(void);
+
 /* Some debug stub to catch some of the obvious races in the VT code */
 #if 1
 #define WARN_CONSOLE_UNLOCKED()	WARN_ON(!is_console_locked() && !oops_in_progress)
--- linux-2.6.18-rc4-mm1/drivers/char/vt.c.old	2006-08-14 00:29:47.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/char/vt.c	2006-08-14 00:30:01.000000000 +0200
@@ -139,14 +139,6 @@
 extern void vcs_make_sysfs(struct tty_struct *tty);
 extern void vcs_remove_sysfs(struct tty_struct *tty);
 
-extern void console_map_init(void);
-#ifdef CONFIG_PROM_CONSOLE
-extern void prom_con_init(void);
-#endif
-#ifdef CONFIG_MDA_CONSOLE
-extern int mda_console_init(void);
-#endif
-
 struct vc vc_cons [MAX_NR_CONSOLES];
 
 #ifndef VT_SINGLE_DRIVER


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
