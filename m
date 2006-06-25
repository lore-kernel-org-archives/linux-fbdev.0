From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] vt: Fix module ref counting
Date: Sun, 25 Jun 2006 18:04:45 +0800
Message-ID: <449E5FBD.2030309@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuRaM-00067F-Hh for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 03:11:22 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FuRaL-0002vC-73
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 03:11:22 -0700
Received: by py-out-1112.google.com with SMTP id s49so1239693pyc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Jun 2006 03:11:20 -0700 (PDT)
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

Unbinding a console driver does not set the module ref count to zero. This is
due to the following:

1. vgacon may point the default console driver pointer (conswitchp) to
dummycon, so when a module_put(conswitchp->owner) is done, it decrements
the ref count of dummycon, not fbcon.

2. Pass a unique minor number (con_driver->node) to class_device_create(),
otherwise, class_device_destroy() may get confused.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/char/vt.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index bd667d9..714d95f 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2873,8 +2873,15 @@ static int unbind_con_driver(const struc
 	}
 
 	if (!con_is_bound(defcsw)) {
+		const struct consw *defconsw = conswitchp;
+
 		defcsw->con_startup();
 		con_back->flag |= CON_DRIVER_FLAG_INIT;
+		/*
+		 * vgacon may change the default driver to point
+		 * to dummycon, we restore it here...
+		 */
+		conswitchp = defconsw;
 	}
 
 	if (!con_is_bound(csw))
@@ -3131,8 +3138,8 @@ int register_con_driver(const struct con
 		goto err;
 
 	con_driver->class_dev = class_device_create(vtconsole_class, NULL,
-						    MKDEV(0, 0), NULL,
-						    "vtcon%i",
+						    MKDEV(0, con_driver->node),
+						    NULL, "vtcon%i",
 						    con_driver->node);
 
 	if (IS_ERR(con_driver->class_dev)) {
@@ -3177,7 +3184,8 @@ int unregister_con_driver(const struct c
 		if (con_driver->con == csw &&
 		    con_driver->flag & CON_DRIVER_FLAG_MODULE) {
 			vtconsole_deinit_class_device(con_driver);
-			class_device_destroy(vtconsole_class, MKDEV(0, 0));
+			class_device_destroy(vtconsole_class,
+					     MKDEV(0, con_driver->node));
 			con_driver->con = NULL;
 			con_driver->desc = NULL;
 			con_driver->class_dev = NULL;
@@ -3241,7 +3249,7 @@ static int __init vtconsole_class_init(v
 		if (con->con && !con->class_dev) {
 			con->class_dev =
 				class_device_create(vtconsole_class, NULL,
-						    MKDEV(0, 0), NULL,
+						    MKDEV(0, con->node), NULL,
 						    "vtcon%i", con->node);
 
 			if (IS_ERR(con->class_dev)) {


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
