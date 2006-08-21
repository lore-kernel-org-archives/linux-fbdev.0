From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/5] vt: proper prototypes for some
	console functions
Date: Mon, 21 Aug 2006 18:54:19 +0800
Message-ID: <1156157659.6254.29.camel@daplas.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GF7QY-0001IV-He for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Aug 2006 03:54:42 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GF7QY-0004ga-7V
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Aug 2006 03:54:42 -0700
Received: by py-out-1112.google.com with SMTP id x31so2248314pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 21 Aug 2006 03:54:41 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Adrian Bunk <bunk@stusta.de>

From: Adrian Bunk <bunk@stusta.de>

This patch adds proper prototypes to header files for three console init
functions used on drivers/char/vt.c

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/char/vt.c          |    8 --------
 include/linux/console.h    |    3 +++
 include/linux/consolemap.h |    1 +
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index e122d16..0037682 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -139,14 +139,6 @@ #define DEFAULT_BELL_DURATION	(HZ/8)
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
diff --git a/include/linux/console.h b/include/linux/console.h
index 76a1807..7d04202 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -129,6 +129,9 @@ static inline void suspend_console(void)
 static inline void resume_console(void) {}
 #endif /* CONFIG_DISABLE_CONSOLE_SUSPEND */
 
+int mda_console_init(void);
+void prom_con_init(void);
+
 /* Some debug stub to catch some of the obvious races in the VT code */
 #if 1
 #define WARN_CONSOLE_UNLOCKED()	WARN_ON(!is_console_locked() && !oops_in_progress)
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index 65842ef..82c9a1f 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -13,3 +13,4 @@ struct vc_data;
 extern unsigned char inverse_translate(struct vc_data *conp, int glyph);
 extern unsigned short *set_translate(int m, struct vc_data *vc);
 extern int conv_uni_to_pc(struct vc_data *conp, long ucs);
+void console_map_init(void);



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
