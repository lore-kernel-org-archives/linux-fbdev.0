From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 2/3] drivers/video: use dev_get_drvdata
Date: Sun, 17 May 2009 11:29:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0905171128430.20440@pc-004.diku.dk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757086AbZEQJ3k@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

Eliminate direct accesses to the driver_data field.
cf 82ab13b26f15f49be45f15ccc96bfa0b81dfd015

The semantic patch that makes this change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
struct device *dev;
expression E;
type T;
@@

- dev->driver_data = (T)E
+ dev_set_drvdata(dev, E)

@@
struct device *dev;
type T;
@@

- (T)dev->driver_data
+ dev_get_drvdata(dev)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/video/omap/omapfb_main.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff -u -p a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -1250,7 +1250,7 @@ static struct fb_ops omapfb_ops = {
 static ssize_t omapfb_show_caps_num(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct omapfb_device *fbdev = (struct omapfb_device *)dev->driver_data;
+	struct omapfb_device *fbdev = dev_get_drvdata(dev);
 	int plane;
 	size_t size;
 	struct omapfb_caps caps;
@@ -1270,7 +1270,7 @@ static ssize_t omapfb_show_caps_num(stru
 static ssize_t omapfb_show_caps_text(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	struct omapfb_device *fbdev = (struct omapfb_device *)dev->driver_data;
+	struct omapfb_device *fbdev = dev_get_drvdata(dev);
 	int i;
 	struct omapfb_caps caps;
 	int plane;
@@ -1317,7 +1317,7 @@ static DEVICE_ATTR(caps_text, 0444, omap
 static ssize_t omapfb_show_panel_name(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
-	struct omapfb_device *fbdev = (struct omapfb_device *)dev->driver_data;
+	struct omapfb_device *fbdev = dev_get_drvdata(dev);
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", fbdev->panel->name);
 }
@@ -1326,7 +1326,7 @@ static ssize_t omapfb_show_bklight_level
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct omapfb_device *fbdev = (struct omapfb_device *)dev->driver_data;
+	struct omapfb_device *fbdev = dev_get_drvdata(dev);
 	int r;
 
 	if (fbdev->panel->get_bklight_level) {
@@ -1341,7 +1341,7 @@ static ssize_t omapfb_store_bklight_leve
 					  struct device_attribute *attr,
 					  const char *buf, size_t size)
 {
-	struct omapfb_device *fbdev = (struct omapfb_device *)dev->driver_data;
+	struct omapfb_device *fbdev = dev_get_drvdata(dev);
 	int r;
 
 	if (fbdev->panel->set_bklight_level) {
@@ -1360,7 +1360,7 @@ static ssize_t omapfb_store_bklight_leve
 static ssize_t omapfb_show_bklight_max(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
-	struct omapfb_device *fbdev = (struct omapfb_device *)dev->driver_data;
+	struct omapfb_device *fbdev = dev_get_drvdata(dev);
 	int r;
 
 	if (fbdev->panel->get_bklight_level) {
@@ -1393,7 +1393,7 @@ static struct attribute_group panel_attr
 static ssize_t omapfb_show_ctrl_name(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	struct omapfb_device *fbdev = (struct omapfb_device *)dev->driver_data;
+	struct omapfb_device *fbdev = dev_get_drvdata(dev);
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", fbdev->ctrl->name);
 }
