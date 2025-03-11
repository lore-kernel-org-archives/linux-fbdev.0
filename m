Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62098224244;
	Tue, 11 Mar 2025 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692581; cv=none; b=EC4Kb0txDsb3BGMzmvCG2ZsAA/dja1vkLmp1yBe7ENw78qG7+hAKjlPZqeV/ozn8vd00FETqedBImGadqs9ViPiY3oHy1omAzh/zGBw9XuZHf9ZLztQjh6BkEi5X1H3x77Drp4bsL4/sqsrTZMszAd9yPogKoKEXkOpdGfaizOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692581; c=relaxed/simple;
	bh=2Uunz717wvS8b79e0qxuRNZ523ulToududHM8NfFZyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kvKl/pTPsyc87hC82pWBmmSMZWCnMZ4VBOSpEqZKcthFrVlNalbMo3TB2K1PhxCuH6cNRbt8RuPNzFPh2U44zFvLyUVLkgAymRFB7cIFkl9rsbEvZNS3LVZUXhsnQhdNXk4ZI/2j+omhvjJY3Ga63OuOgwpMNP43F/cMUD7YzmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f1qEfRNR; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f1qEfRNR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OpVqw
	PZqQYS/kR7eqAKdqdgZQ7qL42uA6b+mtlz2PfA=; b=f1qEfRNRtu41fPPfnoGcU
	VCEgNkY/t5NIUZGwxVCECKtQnNBEjuWTp1jJxJ4EzgYH3fB4xcoODhZ5oCjmqh/a
	HnU3i7tBZglBFU2hJRfT75V8a/jJwpVCr6vcNx//H//Ml8qQEo58tlBIHU2e7/3B
	Bk8ne+PCcVP8/cnVZBtJ3Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCH0Ct6HtBna0J3Rw--.58446S2;
	Tue, 11 Mar 2025 19:29:00 +0800 (CST)
From: oushixiong1025@163.com
To: Simona Vetter <simona@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 1/2] fbcon: Register sysfs groups through device_add_group
Date: Tue, 11 Mar 2025 19:28:55 +0800
Message-Id: <20250311112856.1020095-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH0Ct6HtBna0J3Rw--.58446S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFy7uF4fJFykZrWfXF1UWrg_yoW5KF4kpr
	4DJa4YgFW5G3ZrWw43uw4DZ3sxWwn2k34fJws5Kw1fKFn7A3sIqa48JFyjya4rtF97GF1f
	Ja4qyry8AFWxWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnID7UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXBgND2fQGIlhsAAAsx

From: Shixiong Ou <oushixiong@kylinos.cn>

Use device_add_group() to simplify creation and removal.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/core/fbcon.c | 48 +++++++++++++++-----------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 07d127110ca4..51c3e8a5a092 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3159,7 +3159,7 @@ static const struct consw fb_con = {
 	.con_debug_leave	= fbcon_debug_leave,
 };
 
-static ssize_t store_rotate(struct device *device,
+static ssize_t rotate_store(struct device *device,
 			    struct device_attribute *attr, const char *buf,
 			    size_t count)
 {
@@ -3181,7 +3181,7 @@ static ssize_t store_rotate(struct device *device,
 	return count;
 }
 
-static ssize_t store_rotate_all(struct device *device,
+static ssize_t rotate_all_store(struct device *device,
 				struct device_attribute *attr,const char *buf,
 				size_t count)
 {
@@ -3203,7 +3203,7 @@ static ssize_t store_rotate_all(struct device *device,
 	return count;
 }
 
-static ssize_t show_rotate(struct device *device,
+static ssize_t rotate_show(struct device *device,
 			   struct device_attribute *attr,char *buf)
 {
 	struct fb_info *info;
@@ -3222,7 +3222,7 @@ static ssize_t show_rotate(struct device *device,
 	return sysfs_emit(buf, "%d\n", rotate);
 }
 
-static ssize_t show_cursor_blink(struct device *device,
+static ssize_t cursor_blink_show(struct device *device,
 				 struct device_attribute *attr, char *buf)
 {
 	struct fb_info *info;
@@ -3247,7 +3247,7 @@ static ssize_t show_cursor_blink(struct device *device,
 	return sysfs_emit(buf, "%d\n", blink);
 }
 
-static ssize_t store_cursor_blink(struct device *device,
+static ssize_t cursor_blink_store(struct device *device,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
@@ -3281,32 +3281,30 @@ static ssize_t store_cursor_blink(struct device *device,
 	return count;
 }
 
-static struct device_attribute device_attrs[] = {
-	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
-	__ATTR(rotate_all, S_IWUSR, NULL, store_rotate_all),
-	__ATTR(cursor_blink, S_IRUGO|S_IWUSR, show_cursor_blink,
-	       store_cursor_blink),
+static DEVICE_ATTR_RW(rotate);
+static DEVICE_ATTR_WO(rotate_all);
+static DEVICE_ATTR_RW(cursor_blink);
+
+static struct attribute *fbcon_device_attrs[] = {
+	&dev_attr_rotate.attr,
+	&dev_attr_rotate_all.attr,
+	&dev_attr_cursor_blink.attr,
+	NULL,
+};
+
+static const struct attribute_group fbcon_device_attr_group = {
+	.attrs		= fbcon_device_attrs,
 };
 
 static int fbcon_init_device(void)
 {
-	int i, error = 0;
+	int ret;
 
 	fbcon_has_sysfs = 1;
 
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
+	ret = device_add_group(fbcon_device, &fbcon_device_attr_group);
+	if (ret)
 		fbcon_has_sysfs = 0;
-	}
 
 	return 0;
 }
@@ -3389,11 +3387,9 @@ void __init fb_console_init(void)
 
 static void __exit fbcon_deinit_device(void)
 {
-	int i;
 
 	if (fbcon_has_sysfs) {
-		for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
-			device_remove_file(fbcon_device, &device_attrs[i]);
+		device_remove_group(fb_info->dev, &fbcon_device_attr_group);
 
 		fbcon_has_sysfs = 0;
 	}
-- 
2.25.1

