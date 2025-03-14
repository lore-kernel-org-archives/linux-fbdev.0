Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB1A13633F;
	Fri, 14 Mar 2025 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932655; cv=none; b=ImX/gouHyHR3M8sKGorgvNtaXm2VVEd8YQrlFWWUK1pir9+5xP9W+rd6bTiZtPMwPfueN15uoiNQ35RsDEXGkamAaWuXxTCTsRSiBxvT06Fqd7qAH9E8h20ZfmwyFyHkbIW/LeyGLEA/By6797PgwsV70lm35VI5evpjjtZiC0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932655; c=relaxed/simple;
	bh=eI3Zi2O3auHkAWMS+FhVcslK0rzQo/XlbeCKPvJWGL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BsUBR85opV33ZhVAVRnL4Nop1/YS03+iM4g0RRmxJPqKe4ANIt8vd6xrq85NlN8cX/vX8rgZAfYyFQTthVFJCSPWhjAyt7l1FW2oAE/bnqWmsLGizUuFrV5pOW3tJ8hbq3H8vvK4lcvtSyQTk2LqzsoWqzvNG5USTuAUXbW6gt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TEg6QFXq; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TEg6QFXq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RRnkf
	MTBSRRXPXJIg5gqXaJXUBODgkV4NaNBWUvqcgA=; b=TEg6QFXqutLMtiLGuK7yT
	kRuhOHW6YDoVoIIBeeiTwKqwUFiZxFYV60npH6EhgjBZhKNYeQdhqroCHlDJcPhb
	VWZSACFyiyCWf2qd+PZk9yjldkf0TgnMDeACyHPr2yDD7InwHC0dXZ5Fp067auxm
	WaoaZYjl176145rK9k6kvE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCXX9wnyNNn+8z4Kw--.41638S2;
	Fri, 14 Mar 2025 14:09:45 +0800 (CST)
From: oushixiong1025@163.com
To: Simona Vetter <simona@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH v2] fbcon: Use static attribute groups for sysfs entries
Date: Fri, 14 Mar 2025 14:09:41 +0800
Message-Id: <20250314060941.160048-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCXX9wnyNNn+8z4Kw--.41638S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF1fArW7Gw43tF43Kw4rXwb_yoWrtF17pr
	4UtayYgF45G3ZxWw45Zw4DZwnxWwn7C34fXr48Kw1SgF97ArZIqa48JFyjyayfJrZ7GF1r
	Aa4Dtry8AF4xur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn4SrUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbBYwEQD2fTx4YNHAAAsZ

From: Shixiong Ou <oushixiong@kylinos.cn>

Using device_create_with_groups() to simplify creation and removal.
Same as commit 1083a7be4504 ("tty: Use static attribute groups for
sysfs entries").

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/core/fbcon.c | 69 +++++++++-----------------------
 1 file changed, 19 insertions(+), 50 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 07d127110ca4..1d792bd11063 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -160,7 +160,6 @@ static int info_idx = -1;
 
 /* console rotation */
 static int initial_rotation = -1;
-static int fbcon_has_sysfs;
 static int margin_color;
 
 static const struct consw fb_con;
@@ -3159,7 +3158,7 @@ static const struct consw fb_con = {
 	.con_debug_leave	= fbcon_debug_leave,
 };
 
-static ssize_t store_rotate(struct device *device,
+static ssize_t rotate_store(struct device *device,
 			    struct device_attribute *attr, const char *buf,
 			    size_t count)
 {
@@ -3181,7 +3180,7 @@ static ssize_t store_rotate(struct device *device,
 	return count;
 }
 
-static ssize_t store_rotate_all(struct device *device,
+static ssize_t rotate_all_store(struct device *device,
 				struct device_attribute *attr,const char *buf,
 				size_t count)
 {
@@ -3203,7 +3202,7 @@ static ssize_t store_rotate_all(struct device *device,
 	return count;
 }
 
-static ssize_t show_rotate(struct device *device,
+static ssize_t rotate_show(struct device *device,
 			   struct device_attribute *attr,char *buf)
 {
 	struct fb_info *info;
@@ -3222,7 +3221,7 @@ static ssize_t show_rotate(struct device *device,
 	return sysfs_emit(buf, "%d\n", rotate);
 }
 
-static ssize_t show_cursor_blink(struct device *device,
+static ssize_t cursor_blink_show(struct device *device,
 				 struct device_attribute *attr, char *buf)
 {
 	struct fb_info *info;
@@ -3247,7 +3246,7 @@ static ssize_t show_cursor_blink(struct device *device,
 	return sysfs_emit(buf, "%d\n", blink);
 }
 
-static ssize_t store_cursor_blink(struct device *device,
+static ssize_t cursor_blink_store(struct device *device,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
@@ -3281,35 +3280,18 @@ static ssize_t store_cursor_blink(struct device *device,
 	return count;
 }
 
-static struct device_attribute device_attrs[] = {
-	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
-	__ATTR(rotate_all, S_IWUSR, NULL, store_rotate_all),
-	__ATTR(cursor_blink, S_IRUGO|S_IWUSR, show_cursor_blink,
-	       store_cursor_blink),
-};
-
-static int fbcon_init_device(void)
-{
-	int i, error = 0;
+static DEVICE_ATTR_RW(rotate);
+static DEVICE_ATTR_WO(rotate_all);
+static DEVICE_ATTR_RW(cursor_blink);
 
-	fbcon_has_sysfs = 1;
-
-	for (i = 0; i < ARRAY_SIZE(device_attrs); i++) {
-		error = device_create_file(fbcon_device, &device_attrs[i]);
-
-		if (error)
-			break;
-	}
-
-	if (error) {
-		while (--i >= 0)
-			device_remove_file(fbcon_device, &device_attrs[i]);
-
-		fbcon_has_sysfs = 0;
-	}
+static struct attribute *fbcon_device_attrs[] = {
+	&dev_attr_rotate.attr,
+	&dev_attr_rotate_all.attr,
+	&dev_attr_cursor_blink.attr,
+	NULL
+};
 
-	return 0;
-}
+ATTRIBUTE_GROUPS(fbcon_device);
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
 static void fbcon_register_existing_fbs(struct work_struct *work)
@@ -3367,16 +3349,16 @@ void __init fb_console_init(void)
 	int i;
 
 	console_lock();
-	fbcon_device = device_create(fb_class, NULL, MKDEV(0, 0), NULL,
-				     "fbcon");
+	fbcon_device = device_create_with_groups(fb_class, NULL,
+						 MKDEV(0, 0), NULL,
+						 fbcon_device_groups, "fbcon");
 
 	if (IS_ERR(fbcon_device)) {
 		printk(KERN_WARNING "Unable to create device "
 		       "for fbcon; errno = %ld\n",
 		       PTR_ERR(fbcon_device));
 		fbcon_device = NULL;
-	} else
-		fbcon_init_device();
+	}
 
 	for (i = 0; i < MAX_NR_CONSOLES; i++)
 		con2fb_map[i] = -1;
@@ -3387,18 +3369,6 @@ void __init fb_console_init(void)
 
 #ifdef MODULE
 
-static void __exit fbcon_deinit_device(void)
-{
-	int i;
-
-	if (fbcon_has_sysfs) {
-		for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
-			device_remove_file(fbcon_device, &device_attrs[i]);
-
-		fbcon_has_sysfs = 0;
-	}
-}
-
 void __exit fb_console_exit(void)
 {
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
@@ -3411,7 +3381,6 @@ void __exit fb_console_exit(void)
 #endif
 
 	console_lock();
-	fbcon_deinit_device();
 	device_destroy(fb_class, MKDEV(0, 0));
 
 	do_unregister_con_driver(&fb_con);
-- 
2.25.1

