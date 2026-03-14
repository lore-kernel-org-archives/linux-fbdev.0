Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAA7259CB9;
	Sat, 14 Mar 2026 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489019; cv=none; b=Dq4IHxNx52kgxEhgfDLHex9mN2Zj8ygpVUfqs/SX/wqU+mmINFdQpzZ54ajboH2Cww3uXLUOQZkhrmligUR9RKdVPy/FfNZfLP1wY8GrBhkPjNqk1Vkn5FREgOaZKoRkwuX1iAHt3B+YIO6687iwzj0TDkk1PzCIpr5li73knvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489019; c=relaxed/simple;
	bh=9UfI7XEScUD1an9AAbJxgOc8Hl9VC7ZE8OBKZJGt0d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l0f6tLsfPCQbUhaFv42FZaTeXXBi9hrvViq79Zo4WK9b9w5t4PWNNfHbnntppZhi409aM/YkbGH8lFXhrgKu/ACclom+nNXG1GuN1RrbkRs0Ob1D7K2lXhrWBxe2Eo8A30znK3Wi5Zcfx/hwmfTlx+jdVI5vPvr6FwORPTlh5kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0hUuzZg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0hUuzZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6CFC19424;
	Sat, 14 Mar 2026 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773489019;
	bh=9UfI7XEScUD1an9AAbJxgOc8Hl9VC7ZE8OBKZJGt0d0=;
	h=From:To:Cc:Subject:Date:From;
	b=b0hUuzZg0mhG6gmdBzBk4Bt3tu38HnHPdhMP8Ytwm4Rja8VG27IlvoCAH+Wl6LwLJ
	 pnHKSwPJuYnE2Mfx3eT/WGkKVmaD0KdAw8gOPk7ztu3aMyTL7oLpD2Vt6N/vg9SpRM
	 dRB79KxPN/F/f8r6GtToUmYmglh4IeratX2Ht7OWC7/LQbE9+jJyIv/DVweqz4zVqT
	 b0UmLT6XAb45xBPGpQW+s8oKgGgRX5CcXRbxZV92bDhZfBknWxyA5WrnPptKdllOKX
	 GKA9+VZL5rX3jXjKVoggj4cgcRCcNJzJHH5c/F3I2xQ1ibn7zwxfuVOlX+UK+DXPIN
	 uuzeB9Ia0LyTw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
Subject: [PATCH v1] backlight: apple_bl: Convert to a platform driver
Date: Sat, 14 Mar 2026 12:50:11 +0100
Message-ID: <5084777.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the Apple Backlight ACPI driver to a
platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/video/backlight/apple_bl.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/apple_bl.c b/drivers/video/backlight/apple_bl.c
index aaa824437a2a..423513d68b5b 100644
--- a/drivers/video/backlight/apple_bl.c
+++ b/drivers/video/backlight/apple_bl.c
@@ -24,6 +24,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/atomic.h>
+#include <linux/platform_device.h>
 #include <acpi/video.h>
 
 static struct backlight_device *apple_backlight_device;
@@ -134,7 +135,7 @@ static const struct hw_data nvidia_chipset_data = {
 	.set_brightness = nvidia_chipset_set_brightness,
 };
 
-static int apple_bl_add(struct acpi_device *dev)
+static int apple_bl_probe(struct platform_device *pdev)
 {
 	struct backlight_properties props;
 	struct pci_dev *host;
@@ -193,7 +194,7 @@ static int apple_bl_add(struct acpi_device *dev)
 	return 0;
 }
 
-static void apple_bl_remove(struct acpi_device *dev)
+static void apple_bl_remove(struct platform_device *pdev)
 {
 	backlight_device_unregister(apple_backlight_device);
 
@@ -206,12 +207,12 @@ static const struct acpi_device_id apple_bl_ids[] = {
 	{"", 0},
 };
 
-static struct acpi_driver apple_bl_driver = {
-	.name = "Apple backlight",
-	.ids = apple_bl_ids,
-	.ops = {
-		.add = apple_bl_add,
-		.remove = apple_bl_remove,
+static struct platform_driver apple_bl_driver = {
+	.probe = apple_bl_probe,
+	.remove = apple_bl_remove,
+	.driver = {
+		.name = "Apple backlight",
+		.acpi_match_table = apple_bl_ids,
 	},
 };
 
@@ -224,12 +225,12 @@ static int __init apple_bl_init(void)
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		return -ENODEV;
 
-	return acpi_bus_register_driver(&apple_bl_driver);
+	return platform_driver_register(&apple_bl_driver);
 }
 
 static void __exit apple_bl_exit(void)
 {
-	acpi_bus_unregister_driver(&apple_bl_driver);
+	platform_driver_unregister(&apple_bl_driver);
 }
 
 module_init(apple_bl_init);
-- 
2.51.0




