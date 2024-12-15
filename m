Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7162030A;
	Sun, 15 Dec 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734274524; cv=none; b=qM9IU3oiFgsJ0lHetcn8dyD5eaiKIxS4eAX5c5xy4Xa+DexF8e9u0zdn76dojquSNiJAMS6vdm9egP+aIPwjoCZyH2iy6ypqLUX7L9Rv7FPt2tupBfZ31TFtb98H9dAU4FwNKOXQA0g0oUcO1mN2fuVc7o/WiFWjK1AI4zhYIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734274524; c=relaxed/simple;
	bh=3xEK3Ew0UcjU13RC8Ahx24g141JMcVwvDiJkVvI7dDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rb3WB1sIYLxeOYA/Jo7krZivM8cGYdgj4B9m/Kfl6U0Hyo2eKdhsWqfCdJHZ/IJ+L7wBjBpaF2j4ZKnsZj2fwysiXVVftuCswGtGQBz85RIhC5v4ynriuXM5bel2jOZs1rjxkRBm3nDVE4Ds0Ewd0G5EKE6IMtLOcVrlV96Ki+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=FzB742mu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="FzB742mu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734274520;
	bh=3xEK3Ew0UcjU13RC8Ahx24g141JMcVwvDiJkVvI7dDs=;
	h=From:Date:Subject:To:Cc:From;
	b=FzB742mum+23K1hGje4QQ3N9tWEwlX6ynw+WpT3U3zPNNe73XNqgY5c20FDZuv4bf
	 dbSLz+hRT4QsEaASSKGa+YedyP9shnB7oKjtx4PN4QUJm69HQ2UmTLxT3kVJJwqcXi
	 ilB0WJ4cnQWimS+MhGx+O7yJLj6nokzPZd6R2BS0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 15:55:17 +0100
Subject: [PATCH] fbdev/udlfb: Use const 'struct bin_attribute' callback
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-sysfs-const-bin_attr-udlfb-v1-1-40e87ed71d1f@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANTtXmcC/x3MQQqDMBAAwK/Inl0wsRrsV0QkJhu7UGLJRmkR/
 97gcS5zglBiEnhWJyQ6WHiLBaquwL1sXAnZF4Nu9ENp1aH8JAi6LUrGheNsc064+3dY0Axm8CY
 0vnU9lOCTKPD3zsfpuv75GvhEbAAAAA==
X-Change-ID: 20241215-sysfs-const-bin_attr-udlfb-7979d7f0d3c6
To: Bernie Thompson <bernie@plugable.com>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734274518; l=1791;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3xEK3Ew0UcjU13RC8Ahx24g141JMcVwvDiJkVvI7dDs=;
 b=OFEzKBtvvZVB9v7+uzooOqyzatRSEGsUvJckrfTOe6OjpYLkZ9OxURvAH6NDn39sP7Vgta1xk
 Gl6VtB9HKewBDEPVuGtPg9kcUt6+PLVXb2mwWfqUbIhBbWSjhZxyQds
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now provides callback variants that explicitly take a
const pointer. Make use of it to match the attribute definition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/video/fbdev/udlfb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 71ac9e36f67c68aa7a54dce32323047a2a9a48bf..acadf0eb450c3d76c05fcb9cc7e7c3f6dd8f31ef 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1416,7 +1416,7 @@ static ssize_t metrics_cpu_kcycles_used_show(struct device *fbdev,
 
 static ssize_t edid_show(
 			struct file *filp,
-			struct kobject *kobj, struct bin_attribute *a,
+			struct kobject *kobj, const struct bin_attribute *a,
 			 char *buf, loff_t off, size_t count) {
 	struct device *fbdev = kobj_to_dev(kobj);
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
@@ -1438,7 +1438,7 @@ static ssize_t edid_show(
 
 static ssize_t edid_store(
 			struct file *filp,
-			struct kobject *kobj, struct bin_attribute *a,
+			struct kobject *kobj, const struct bin_attribute *a,
 			char *src, loff_t src_off, size_t src_size) {
 	struct device *fbdev = kobj_to_dev(kobj);
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
@@ -1482,8 +1482,8 @@ static const struct bin_attribute edid_attr = {
 	.attr.name = "edid",
 	.attr.mode = 0666,
 	.size = EDID_LENGTH,
-	.read = edid_show,
-	.write = edid_store
+	.read_new = edid_show,
+	.write_new = edid_store
 };
 
 static const struct device_attribute fb_device_attrs[] = {

---
base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
change-id: 20241215-sysfs-const-bin_attr-udlfb-7979d7f0d3c6

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

