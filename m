Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26521D3F2;
	Thu,  4 Dec 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764858928; cv=none; b=Nuq/dSWU6k+An0WD/UbqxUfgwFKWeHlxAmxAMBCzNeswvDsEMQlvN27jTWg9c65u9PuSG61REBVI35mH8T4i/X+dbca+PscJqoSdmGcyYaFgUdq/N6ZlRoDwjTKzP6vlmpjNr5JeWdVU34Vjv1vfOvsc6RtwSzn7YBXa8KByJBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764858928; c=relaxed/simple;
	bh=jPeKXp5utHWCmJ034LIIEEaXgu0uiG6IuPhf7HjwWdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TfOhJuUfbktccZiEm/bgBqUqjvdoc80+/UADbjf2JAW58UMDLVx/2NAesl/wDF45nd9vy2GrW9uFVZrULIw0tCZcqFGw41v090ofBbJmTvvHsiiebDicM4mkoZgLSFGGlykwC4ucFJfSec5SfTV6jpIsbWczZGjFNJwuq4EtRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSXpnxh4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSXpnxh4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A5A2C116C6;
	Thu,  4 Dec 2025 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764858928;
	bh=jPeKXp5utHWCmJ034LIIEEaXgu0uiG6IuPhf7HjwWdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VSXpnxh410YNDq/GX8Gi3oyoJzhK0vc446t3WUFgciw3U5ygIXj27BDKZEICX8EU3
	 wAZ/9Y15GCAC7r3I5Qwz9OwyyuztEWqfD7f18ZYq17JoGb6vjqyKAULkdsnXr+hnBi
	 rzy65SZ+NL1vg/TzDjwFKflhEGQvjcNAT4xXc+Gv9kHKoyJdWOxdHtqNwZQ1OdzpFc
	 +FQ4obAB04hNUgP1mKf7yPVEtJ9Tj1kls0YT3LNCAXJUA1VEjUZVkUx1To9Ytg4maa
	 kQ9LCNeJIceiskwEpe5ZQjJdpd2Foll3FBpfVXAGB3QXCPYH8Eoxe3XXgkCYgpAYP4
	 ODVgMg2P64umw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B91DD206AC;
	Thu,  4 Dec 2025 14:35:28 +0000 (UTC)
From: Petri Karhula via B4 Relay <devnull+petri.karhula.novatron.fi@kernel.org>
Date: Thu, 04 Dec 2025 14:35:26 +0000
Subject: [PATCH v5 1/2] backlight: Add Congatec Board Controller (CGBC)
 backlight support
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-cgbc-backlight-v5-1-26f1be6a69c3@novatron.fi>
References: <20251204-cgbc-backlight-v5-0-26f1be6a69c3@novatron.fi>
In-Reply-To: <20251204-cgbc-backlight-v5-0-26f1be6a69c3@novatron.fi>
To: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, Petri Karhula <petri.karhula@novatron.fi>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764858927; l=7500;
 i=petri.karhula@novatron.fi; s=20251118; h=from:subject:message-id;
 bh=jPPzAj6k7o9cTUnE2JsI/iT2OWREzjVZAUPlsVbfUts=;
 b=Bk0GBhg7OudctdI8gFrYdiTWOjRc7a9wytfDUaHg4BndpHgXN6k/j1dsRbw4RnirqGTOQzCAH
 1kp4ToYeZfBBj7sBvwFOVuKhEW2Kn+WZmOUlOb6xt66z5SZ9C+KUYFM
X-Developer-Key: i=petri.karhula@novatron.fi; a=ed25519;
 pk=LRYJ99jPPsHJwdJEPkqlmzAMqo6oyw7I421aHEfDp7o=
X-Endpoint-Received: by B4 Relay for petri.karhula@novatron.fi/20251118
 with auth_id=567
X-Original-From: Petri Karhula <petri.karhula@novatron.fi>
Reply-To: petri.karhula@novatron.fi

From: Petri Karhula <petri.karhula@novatron.fi>

This driver provides backlight brightness control through the Linux
backlight subsystem. It communicates with the board controller to
adjust LCD backlight using PWM signals. Communication is done
through Congatec Board Controller core driver.

Signed-off-by: Petri Karhula <petri.karhula@novatron.fi>
---
 drivers/video/backlight/Kconfig   |  11 +++
 drivers/video/backlight/Makefile  |   1 +
 drivers/video/backlight/cgbc_bl.c | 180 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index d9374d208cee..702f3b8ed036 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -249,6 +249,17 @@ config BACKLIGHT_PWM
 	  If you have a LCD backlight adjustable by PWM, say Y to enable
 	  this driver.
 
+config BACKLIGHT_CGBC
+	tristate "Congatec Board Controller (CGBC) backlight support"
+	depends on MFD_CGBC && X86
+	help
+	  Say Y here to enable support for LCD backlight control on Congatec
+	  x86-based boards via the CGBC (Congatec Board Controller).
+
+	  This driver provides backlight brightness control through the Linux
+	  backlight subsystem. It communicates with the board controller to
+	  adjust LCD backlight using PWM signals.
+
 config BACKLIGHT_DA903X
 	tristate "Backlight Driver for DA9030/DA9034 using WLED"
 	depends on PMIC_DA903X
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index dfbb169bf6ea..0169fd8873ed 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_BACKLIGHT_APPLE_DWI)	+= apple_dwi_bl.o
 obj-$(CONFIG_BACKLIGHT_AS3711)		+= as3711_bl.o
 obj-$(CONFIG_BACKLIGHT_BD6107)		+= bd6107.o
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE)	+= backlight.o
+obj-$(CONFIG_BACKLIGHT_CGBC)		+= cgbc_bl.o
 obj-$(CONFIG_BACKLIGHT_DA903X)		+= da903x_bl.o
 obj-$(CONFIG_BACKLIGHT_DA9052)		+= da9052_bl.o
 obj-$(CONFIG_BACKLIGHT_EP93XX)		+= ep93xx_bl.o
diff --git a/drivers/video/backlight/cgbc_bl.c b/drivers/video/backlight/cgbc_bl.c
new file mode 100644
index 000000000000..ab27e14338a8
--- /dev/null
+++ b/drivers/video/backlight/cgbc_bl.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Congatec Board Controller (CGBC) Backlight Driver
+ *
+ * This driver provides backlight control for LCD displays connected to
+ * Congatec boards via the CGBC (Congatec Board Controller). It integrates
+ * with the Linux backlight subsystem and communicates with hardware through
+ * the cgbc-core module.
+ *
+ * Copyright (C) 2025 Novatron Oy
+ *
+ * Author: Petri Karhula <petri.karhula@novatron.fi>
+ */
+
+#include <linux/backlight.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/mfd/cgbc.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define BLT_PWM_DUTY_MASK          GENMASK(6, 0)
+
+/* CGBC command for PWM brightness control*/
+#define CGBC_CMD_BLT0_PWM          0x75
+
+#define CGBC_BL_MAX_BRIGHTNESS     100
+
+/**
+ * CGBC backlight driver data
+ * @dev: Pointer to the platform device
+ * @cgbc: Pointer to the parent CGBC device data
+ * @current_brightness: Current brightness level (0-100)
+ */
+struct cgbc_bl_data {
+	struct device *dev;
+	struct cgbc_device_data *cgbc;
+	unsigned int current_brightness;
+};
+
+static int cgbc_bl_read_brightness(struct cgbc_bl_data *bl_data)
+{
+	u8 cmd_buf[4] = { CGBC_CMD_BLT0_PWM };
+	u8 reply_buf[3];
+	int ret;
+
+	ret = cgbc_command(bl_data->cgbc, cmd_buf, sizeof(cmd_buf),
+			   reply_buf, sizeof(reply_buf), NULL);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Get only PWM duty factor percentage,
+	 * ignore polarity inversion bit (bit 7)
+	 */
+	bl_data->current_brightness = FIELD_GET(BLT_PWM_DUTY_MASK, reply_buf[0]);
+
+	return 0;
+}
+
+static int cgbc_bl_update_status(struct backlight_device *bl)
+{
+	struct cgbc_bl_data *bl_data = bl_get_data(bl);
+	u8 cmd_buf[4] = { CGBC_CMD_BLT0_PWM };
+	u8 reply_buf[3];
+	u8 brightness;
+	int ret;
+
+	brightness = backlight_get_brightness(bl);
+
+	if (brightness != bl_data->current_brightness) {
+		/* Read the current values */
+		ret = cgbc_command(bl_data->cgbc, cmd_buf, sizeof(cmd_buf), reply_buf,
+				   sizeof(reply_buf), NULL);
+		if (ret < 0) {
+			dev_err(bl_data->dev, "Failed to read PWM settings: %d\n", ret);
+			return ret;
+		}
+
+		/*
+		 * Prepare command buffer for writing new settings. Only 2nd byte is changed
+		 * to set new brightness (PWM duty cycle %). Other values (polarity, frequency)
+		 * are preserved from the read values.
+		 */
+		cmd_buf[1] = (reply_buf[0] & ~BLT_PWM_DUTY_MASK) |
+			FIELD_PREP(BLT_PWM_DUTY_MASK, brightness);
+		cmd_buf[2] = reply_buf[1];
+		cmd_buf[3] = reply_buf[2];
+
+		ret = cgbc_command(bl_data->cgbc, cmd_buf, sizeof(cmd_buf), reply_buf,
+				   sizeof(reply_buf), NULL);
+		if (ret < 0) {
+			dev_err(bl_data->dev, "Failed to set brightness: %d\n", ret);
+			return ret;
+		}
+
+		bl_data->current_brightness = reply_buf[0] & BLT_PWM_DUTY_MASK;
+
+		/* Verify the setting was applied correctly */
+		if (bl_data->current_brightness != brightness) {
+			dev_err(bl_data->dev,
+				"Brightness setting verification failed (got %u, expected %u)\n",
+				bl_data->current_brightness, (unsigned int)brightness);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int cgbc_bl_get_brightness(struct backlight_device *bl)
+{
+	struct cgbc_bl_data *bl_data = bl_get_data(bl);
+	int ret;
+
+	ret = cgbc_bl_read_brightness(bl_data);
+	if (ret < 0) {
+		dev_err(bl_data->dev, "Failed to read brightness: %d\n", ret);
+		return ret;
+	}
+
+	return bl_data->current_brightness;
+}
+
+static const struct backlight_ops cgbc_bl_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.update_status = cgbc_bl_update_status,
+	.get_brightness = cgbc_bl_get_brightness,
+};
+
+static int cgbc_bl_probe(struct platform_device *pdev)
+{
+	struct cgbc_device_data *cgbc = dev_get_drvdata(pdev->dev.parent);
+	struct backlight_properties props = { };
+	struct backlight_device *bl_dev;
+	struct cgbc_bl_data *bl_data;
+	int ret;
+
+	bl_data = devm_kzalloc(&pdev->dev, sizeof(*bl_data), GFP_KERNEL);
+	if (!bl_data)
+		return -ENOMEM;
+
+	bl_data->dev = &pdev->dev;
+	bl_data->cgbc = cgbc;
+
+	ret = cgbc_bl_read_brightness(bl_data);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to read initial brightness\n");
+
+	props.type = BACKLIGHT_PLATFORM;
+	props.max_brightness = CGBC_BL_MAX_BRIGHTNESS;
+	props.brightness = bl_data->current_brightness;
+	props.scale = BACKLIGHT_SCALE_LINEAR;
+
+	bl_dev = devm_backlight_device_register(&pdev->dev, "cgbc-backlight",
+						&pdev->dev, bl_data,
+						&cgbc_bl_ops, &props);
+	if (IS_ERR(bl_dev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(bl_dev),
+			     "Failed to register backlight device\n");
+
+	platform_set_drvdata(pdev, bl_data);
+
+	return 0;
+}
+
+static struct platform_driver cgbc_bl_driver = {
+	.driver = {
+		.name = "cgbc-backlight",
+	},
+	.probe = cgbc_bl_probe,
+};
+
+module_platform_driver(cgbc_bl_driver);
+
+MODULE_AUTHOR("Petri Karhula <petri.karhula@novatron.fi>");
+MODULE_DESCRIPTION("Congatec Board Controller (CGBC) Backlight Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:cgbc-backlight");

-- 
2.34.1


