From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Console unregistration questions
Date: Thu, 26 Apr 2007 18:30:22 -0700
Message-ID: <200704261830.22238.jbarnes@virtuousgeek.org>
References: <200704241459.29297.jbarnes@virtuousgeek.org>
	<200704241646.34556.jbarnes@virtuousgeek.org>
	<1177463833.4829.20.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tIVMGWuWrim1gyv"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhFI4-0007jB-C6 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 18:30:28 -0700
Received: from outbound-mail-29.bluehost.com ([69.89.17.211])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HhFI3-0007hr-Ei
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 18:30:27 -0700
In-Reply-To: <1177463833.4829.20.camel@daplas>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Jakob Bornecrantz <wallbraker@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

--Boundary-00=_tIVMGWuWrim1gyv
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, April 24, 2007, Antonino A. Daplas wrote:
> Here's a test patch.  Basically, it checks if the driver is still mapped
> to the console, and if it is, unregister_framebuffer() will exit
> immediately.  As mentioned, it's untested, so let me know if there are
> problems.
>
> Note, the driver must also do its part, by checking if the driver is
> opened by something in userspace.

Here's a hacked up version of an unregistration patch.  It exports 
unbind_con_driver from vt.c and makes fbcon and fbmem use it when a driver 
goes away...

Thoughts?

Thanks,
Jesse

--Boundary-00=_tIVMGWuWrim1gyv
Content-Type: text/x-diff; charset="utf-8"; name="console-unregister.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="console-unregister.patch"

--- linux-2.6.21-rc4/drivers/video/fbmem.c	2007-03-15 17:20:01.000000000 -0700
+++ linux-2.6.21-rc4-modesetting/drivers/video/fbmem.c	2007-04-26 18:16:52.000000000 -0700
@@ -1349,6 +1349,8 @@
 	if (!registered_fb[i])
 		return -EINVAL;
 
+	event.info = fb_info;
+	fb_notifier_call_chain(FB_EVENT_FB_UNBIND, &event);
 	if (fb_info->pixmap.addr &&
 	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
--- linux-2.6.21-rc4/include/linux/fb.h	2007-03-15 17:20:01.000000000 -0700
+++ linux-2.6.21-rc4-modesetting/include/linux/fb.h	2007-04-26 17:33:07.000000000 -0700
@@ -525,6 +525,8 @@
 #define FB_EVENT_MODE_CHANGE_ALL	0x0B
 /*	A software display blank change occured */
 #define FB_EVENT_CONBLANK               0x0C
+/*      Unbind from the console if possible */
+#define FB_EVENT_FB_UNBIND              0x0E
 
 struct fb_event {
 	struct fb_info *info;
--- linux-2.6.21-rc4/include/linux/console.h	2007-03-15 17:20:01.000000000 -0700
+++ linux-2.6.21-rc4-modesetting/include/linux/console.h	2007-04-26 17:56:31.000000000 -0700
@@ -64,6 +64,7 @@
 extern const struct consw newport_con;	/* SGI Newport console  */
 extern const struct consw prom_con;	/* SPARC PROM console */
 
+int unbind_con_driver(const struct consw *csw, int first, int last, int deflt);
 int con_is_bound(const struct consw *csw);
 int register_con_driver(const struct consw *csw, int first, int last);
 int unregister_con_driver(const struct consw *csw);
--- linux-2.6.21-rc4/drivers/video/console/fbcon.c	2007-03-15 17:20:01.000000000 -0700
+++ linux-2.6.21-rc4-modesetting/drivers/video/console/fbcon.c	2007-04-26 18:15:49.000000000 -0700
@@ -563,8 +563,10 @@
 	for (i = first_fb_vc; i <= last_fb_vc; i++)
 		con2fb_map[i] = info_idx;
 
+	printk(KERN_ERR "calling take_over_console, return value: ");
 	err = take_over_console(&fb_con, first_fb_vc, last_fb_vc,
 				fbcon_is_default);
+	printk(KERN_ERR "%d\n", err);
 
 	if (err) {
 		for (i = first_fb_vc; i <= last_fb_vc; i++) {
@@ -2896,6 +2898,13 @@
 	return found;
 }
 
+static int fbcon_fb_unbind(int idx)
+{
+	unbind_con_driver(&fb_con, 0, MAX_NR_CONSOLES - 1, 0);
+
+	return 0;
+}
+
 static int fbcon_fb_unregistered(int idx)
 {
 	int i;
@@ -2933,6 +2942,7 @@
 {
 	int ret = 0, i;
 
+	printk(KERN_ERR "fbcon registration called\n");
 	if (info_idx == -1) {
 		for (i = first_fb_vc; i <= last_fb_vc; i++) {
 			if (con2fb_map_boot[i] == idx) {
@@ -2941,8 +2951,10 @@
 			}
 		}
 
-		if (info_idx != -1)
+		if (info_idx != -1) {
+			printk(KERN_ERR "fb taking over console\n");
 			ret = fbcon_takeover(1);
+		}
 	} else {
 		for (i = first_fb_vc; i <= last_fb_vc; i++) {
 			if (con2fb_map_boot[i] == idx &&
@@ -3036,6 +3048,9 @@
 		mode = event->data;
 		ret = fbcon_mode_deleted(info, mode);
 		break;
+	case FB_EVENT_FB_UNBIND:
+		ret = fbcon_fb_unbind(info->node);
+		break;
 	case FB_EVENT_FB_REGISTERED:
 		ret = fbcon_fb_registered(info->node);
 		break;
--- linux-2.6.21-rc4/drivers/char/vt.c	2007-03-15 17:20:01.000000000 -0700
+++ linux-2.6.21-rc4-modesetting/drivers/char/vt.c	2007-04-26 18:22:42.000000000 -0700
@@ -2832,8 +2832,24 @@
 	return retval;
 }
 
-static int unbind_con_driver(const struct consw *csw, int first, int last,
-			     int deflt)
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
+int unbind_con_driver(const struct consw *csw, int first, int last, int deflt)
 {
 	struct module *owner = csw->owner;
 	const struct consw *defcsw = NULL;
@@ -2918,6 +2934,7 @@
 	return retval;
 
 }
+EXPORT_SYMBOL(unbind_con_driver);
 
 static int vt_bind(struct con_driver *con)
 {

--Boundary-00=_tIVMGWuWrim1gyv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--Boundary-00=_tIVMGWuWrim1gyv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--Boundary-00=_tIVMGWuWrim1gyv--
