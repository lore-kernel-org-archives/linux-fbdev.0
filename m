From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 8/8] vt: Add comment for
	unbind_con_driver()
Date: Thu, 31 May 2007 21:03:03 +0800
Message-ID: <465EC787.8030003@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtkQX-0001JD-OC for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:54 -0700
Received: from wx-out-0506.google.com ([66.249.82.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HtkQX-0001YJ-9p
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:53 -0700
Received: by wx-out-0506.google.com with SMTP id t15so151309wxc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 31 May 2007 06:10:52 -0700 (PDT)
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
Cc: Jesse Barnes <jesse.barnes@intel.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Jesse Barnes <jbarnes@virtuousgeek.org>

- add comment for unbind_con_driver().
- bind_con_driver() is made private again

Signed-off-by: Jesse Barnes <jesse.barnes@intel.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/char/vt.c       |   21 +++++++++++++++++++--
 include/linux/vt_kern.h |    2 --
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 2ea7759..86c3aef 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2861,7 +2861,8 @@ #include <linux/device.h>
 
 static struct class *vtconsole_class;
 
-int bind_con_driver(const struct consw *csw, int first, int last, int deflt)
+static int bind_con_driver(const struct consw *csw, int first, int last,
+			   int deflt)
 {
 	struct module *owner = csw->owner;
 	const char *desc = NULL;
@@ -2960,7 +2961,6 @@ err:
 	module_put(owner);
 	return retval;
 };
-EXPORT_SYMBOL(bind_con_driver);
 
 #ifdef CONFIG_VT_HW_CONSOLE_BINDING
 static int con_is_graphics(const struct consw *csw, int first, int last)
@@ -2979,6 +2979,23 @@ static int con_is_graphics(const struct 
 	return retval;
 }
 
+/**
+ * unbind_con_driver - unbind a console driver
+ * @csw: pointer to console driver to unregister
+ * @first: first in range of consoles that @csw should be unbound from
+ * @last: last in range of consoles that @csw should be unbound from
+ * @deflt: should next bound console driver be default after @csw is unbound?
+ *
+ * To unbind a driver from all possible consoles, pass 0 as @first and
+ * %MAX_NR_CONSOLES as @last.
+ *
+ * @deflt controls whether the console that ends up replacing @csw should be
+ * the default console.
+ *
+ * RETURNS:
+ * -ENODEV if @csw isn't a registered console driver or can't be unregistered
+ * or 0 on success.
+ */
 int unbind_con_driver(const struct consw *csw, int first, int last, int deflt)
 {
 	struct module *owner = csw->owner;
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index 0d034d8..699b7e9 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -75,8 +75,6 @@ int con_copy_unimap(struct vc_data *dst_
 int vt_waitactive(int vt);
 void change_console(struct vc_data *new_vc);
 void reset_vc(struct vc_data *vc);
-extern int bind_con_driver(const struct consw *csw, int first, int last,
-			   int deflt);
 extern int unbind_con_driver(const struct consw *csw, int first, int last,
 			     int deflt);
 





-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
