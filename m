From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/9] VT binding: Make VT binding a
	Kconfig option
Date: Sun, 18 Jun 2006 23:24:22 +0800
Message-ID: <44957026.2020405@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FrzVG-0001pS-AD for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 08:47:58 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FrzVD-0000XY-V3
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 08:47:58 -0700
Received: by py-out-1112.google.com with SMTP id i49so1055622pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Jun 2006 08:47:55 -0700 (PDT)
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
Cc: Greg KH <gregkh@suse.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

To enable this feature, CONFIG_VT_HW_CONSOLE_BINDING must be set to 'y'. This
feature will default to 'n' to minimize users accidentally corrupting their
virtual terminals.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/char/Kconfig |   17 +++++++++++++++++
 drivers/char/vt.c    |   43 +++++++++++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 29afe21..336aa31 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -62,6 +62,23 @@ config HW_CONSOLE
 	depends on VT && !S390 && !UML
 	default y
 
+config VT_HW_CONSOLE_BINDING
+       bool "Support for binding and unbinding console drivers"
+       depends on HW_CONSOLE
+       default n
+       ---help---
+         The virtual terminal is the device that interacts with the physical
+         terminal through console drivers. On these systems, at least one
+         console driver is loaded. In other configurations, additional console
+         drivers may be enabled, such as the framebuffer console. If more than
+         1 console driver is enabled, setting this to 'y' will allow you to
+         select the console driver that will serve as the backend for the
+         virtual terminals.
+
+	 See <file:Documentation/console/console.txt> for more
+	 information. For framebuffer console users, please refer to
+	 <file:Documentation/fb/fbcon.txt>.
+
 config SERIAL_NONSTANDARD
 	bool "Non-standard serial port support"
 	---help---
diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index d0cc421..1d98151 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2691,22 +2691,6 @@ #include <linux/device.h>
 
 static struct class *vtconsole_class;
 
-static int con_is_graphics(const struct consw *csw, int first, int last)
-{
-	int i, retval = 0;
-
-	for (i = first; i <= last; i++) {
-		struct vc_data *vc = vc_cons[i].d;
-
-		if (vc && vc->vc_mode == KD_GRAPHICS) {
-			retval = 1;
-			break;
-		}
-	}
-
-	return retval;
-}
-
 static int bind_con_driver(const struct consw *csw, int first, int last,
 			   int deflt)
 {
@@ -2808,6 +2792,23 @@ err:
 	return retval;
 };
 
+#ifdef CONFIG_VT_HW_CONSOLE_BINDING
+static int con_is_graphics(const struct consw *csw, int first, int last)
+{
+	int i, retval = 0;
+
+	for (i = first; i <= last; i++) {
+		struct vc_data *vc = vc_cons[i].d;
+
+		if (vc && vc->vc_mode == KD_GRAPHICS) {
+			retval = 1;
+			break;
+		}
+	}
+
+	return retval;
+}
+
 static int unbind_con_driver(const struct consw *csw, int first, int last,
 			     int deflt)
 {
@@ -2977,6 +2978,16 @@ static int vt_unbind(struct con_driver *
 err:
 	return 0;
 }
+#else
+static inline int vt_bind(struct con_driver *con)
+{
+	return 0;
+}
+static inline int vt_unbind(struct con_driver *con)
+{
+	return 0;
+}
+#endif /* CONFIG_VT_HW_CONSOLE_BINDING */
 
 static ssize_t store_bind(struct class_device *class_device,
 			  const char *buf, size_t count)
