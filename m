From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 19 Jul 2017 12:51:19 +0000
Subject: [PATCH] fbdev: uvesafb: remove DRIVER_ATTR() usage
Message-Id: <20170719125119.GB17776@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Januszewski <spock@gentoo.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

It's better to be explicit and use the DRIVER_ATTR_RW() macro when
defining a driver's sysfs file.  Bonus is this fixes up a checkpatch.pl
warning.

This is part of a series to drop DRIVER_ATTR() from the tree entirely.

Cc: Michal Januszewski <spock@gentoo.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/uvesafb.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1860,19 +1860,18 @@ static int uvesafb_setup(char *options)
 }
 #endif /* !MODULE */
 
-static ssize_t show_v86d(struct device_driver *dev, char *buf)
+static ssize_t v86d_show(struct device_driver *dev, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%s\n", v86d_path);
 }
 
-static ssize_t store_v86d(struct device_driver *dev, const char *buf,
+static ssize_t v86d_store(struct device_driver *dev, const char *buf,
 		size_t count)
 {
 	strncpy(v86d_path, buf, PATH_MAX);
 	return count;
 }
-
-static DRIVER_ATTR(v86d, S_IRUGO | S_IWUSR, show_v86d, store_v86d);
+static DRIVER_ATTR_RW(v86d);
 
 static int uvesafb_init(void)
 {
