From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/9] vt:  Delay the update of the visible console
Date: Thu, 04 May 2006 20:33:21 +0800
Message-ID: <4459F491.9050409@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fbd5s-0007rT-BO
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:38:08 -0700
Received: from wx-out-0102.google.com ([66.249.82.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fbd5s-0002Pa-3M
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:38:08 -0700
Received: by wx-out-0102.google.com with SMTP id h26so310349wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 04 May 2006 05:38:07 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, David Hollister <david.hollister@amd.com>, Jordan Crouse <jordan.crouse@amd.com>

From: David Hollister <david.hollister@amd.com>

This patch delays the update of the visible framebuffer console until
all other consoles have been initialized in order to avoid losing
information.  This only seems to be a problem with modules, not with
built-in drivers.

Signed-off-by: David Hollister <david.hollister@amd.com>
Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/char/vt.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 78e0bd2..5251c0c 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2663,7 +2663,7 @@ int __init vty_init(void)
 
 int take_over_console(const struct consw *csw, int first, int last, int deflt)
 {
-	int i, j = -1;
+	int i, j = -1, k = -1;
 	const char *desc;
 	struct module *owner;
 
@@ -2699,8 +2699,11 @@ int take_over_console(const struct consw
 			continue;
 
 		j = i;
-		if (CON_IS_VISIBLE(vc))
+		if (CON_IS_VISIBLE(vc)) {
+			k = i;
 			save_screen(vc);
+		}
+
 		old_was_color = vc->vc_can_do_color;
 		vc->vc_sw->con_deinit(vc);
 		vc->vc_origin = (unsigned long)vc->vc_screenbuf;
@@ -2716,18 +2719,23 @@ int take_over_console(const struct consw
 		 */
 		if (old_was_color != vc->vc_can_do_color)
 			clear_buffer_attributes(vc);
-
-		if (CON_IS_VISIBLE(vc))
-			update_screen(vc);
 	}
+
 	printk("Console: switching ");
 	if (!deflt)
 		printk("consoles %d-%d ", first+1, last+1);
-	if (j >= 0)
+	if (j >= 0) {
+		struct vc_data *vc = vc_cons[j].d;
+
 		printk("to %s %s %dx%d\n",
-		       vc_cons[j].d->vc_can_do_color ? "colour" : "mono",
-		       desc, vc_cons[j].d->vc_cols, vc_cons[j].d->vc_rows);
-	else
+		       vc->vc_can_do_color ? "colour" : "mono",
+		       desc, vc->vc_cols, vc->vc_rows);
+
+		if (k >= 0) {
+			vc = vc_cons[k].d;
+			update_screen(vc);
+		}
+	} else
 		printk("to %s\n", desc);
 
 	release_console_sem();



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
