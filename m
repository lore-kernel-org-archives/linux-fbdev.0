From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/5] VT binding: Add sysfs support
Date: Fri, 09 Jun 2006 16:39:51 +0800
Message-ID: <448933D7.6040301@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Focac-0005J6-GB for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Jun 2006 01:43:34 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Focac-0002g3-65
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Jun 2006 01:43:34 -0700
Received: by py-out-1112.google.com with SMTP id x31so892948pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 09 Jun 2006 01:43:33 -0700 (PDT)
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

Add sysfs attributes for binding and unbinding VT console drivers. The
attributes are located in /sys/class/tty/console and are namely:

    A. backend - list registered drivers in the following format:

    "I C: Description"

    Where: I  = ID number of the driver
           C  = status of the driver which can be:

		S = system driver
		B = bound modular driver
		U = unbound modular driver

	   Description - text description of the driver

    B. bind - binds a driver to the console layer

       echo <ID> > /sys/class/tty/console/bind

    C. unbind - unbinds a driver from the console layer

       echo <ID> > /sys/class/tty/console/unbind

The tty layer does nothing to these attributes except create them and punt all
requests to the VT layer.

Signed-off-by: Antonino Daplas <pol.net>
---

 drivers/char/tty_io.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/tty.h   |   19 ++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletions(-)

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index a5730a6..e23d360 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -3231,6 +3231,47 @@ #ifdef CONFIG_VT
 static struct cdev vc0_cdev;
 #endif
 
+static ssize_t store_bind(struct class_device *class_device,
+			  const char *buf, size_t count)
+{
+	int index = simple_strtoul(buf, NULL, 0);
+
+	vt_bind(index);
+	return count;
+}
+
+static ssize_t store_unbind(struct class_device *class_device,
+			    const char *buf, size_t count)
+{
+	int index = simple_strtoul(buf, NULL, 0);
+
+	vt_unbind(index);
+	return count;
+}
+
+static ssize_t show_con_drivers(struct class_device *class_device, char *buf)
+{
+	return vt_show_drivers(buf);
+}
+
+static struct class_device_attribute class_device_attrs[] = {
+	__ATTR(bind,   S_IWUSR, NULL, store_bind),
+	__ATTR(unbind, S_IWUSR, NULL, store_unbind),
+	__ATTR(backend, S_IRUGO, show_con_drivers, NULL),
+};
+
+static struct class_device *console_class_device;
+
+static int console_init_class_device(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
+		class_device_create_file(console_class_device,
+					 &class_device_attrs[i]);
+	return 0;
+}
+
 /*
  * Ok, now we can initialize the rest of the tty devices and can count
  * on memory allocations, interrupts etc..
@@ -3249,7 +3290,17 @@ static int __init tty_init(void)
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
 		panic("Couldn't register /dev/console driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 1), S_IFCHR|S_IRUSR|S_IWUSR, "console");
-	class_device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
+	console_class_device = class_device_create(tty_class, NULL,
+						   MKDEV(TTYAUX_MAJOR, 1),
+						   NULL, "console");
+	if (IS_ERR(console_class_device)) {
+		printk(KERN_WARNING "Unable to create class device "
+		       "for console; errno = %ldn",
+		       PTR_ERR(console_class_device));
+		console_class_device = NULL;
+	} else
+		console_init_class_device();
+
 
 #ifdef CONFIG_UNIX98_PTYS
 	cdev_init(&ptmx_cdev, &ptmx_fops);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index cb35ca5..3edaa5d 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -347,6 +347,25 @@ extern void console_print(const char *);
 extern int vt_ioctl(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg);
 
+#ifdef CONFIG_VT
+extern int vt_bind(int index);
+extern int vt_unbind(int index);
+extern int vt_show_drivers(char *buf);
+#else
+static inline int vt_bind(int index)
+{
+	return 0;
+}
+static inline int vt_unbind(int index)
+{
+	return 0;
+}
+static inline int vt_show_drivers(char *buf)
+{
+	return 0;
+}
+#endif
+
 static inline dev_t tty_devnum(struct tty_struct *tty)
 {
 	return MKDEV(tty->driver->major, tty->driver->minor_start) + tty->index;
