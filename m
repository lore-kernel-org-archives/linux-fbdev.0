Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAAE42DFF1
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Jan 2026 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913459; cv=none; b=GBirSQ5LRh4ecEW5WQtKwCeXa0JUNJ+MoXr6AsD+HG1sqnaFDLzyQcdc3HgSym1vgv8lig0+VMQYb8dmr1mAuKPEmoHhYBm/tKahiBt08VEmUemJWGdTNF6+RGr7LXVzmsKo8od+Wc1UJnIqv8sQcvMlctprC11YfXxfxJttrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913459; c=relaxed/simple;
	bh=wBaSoSs4KKPmkdnBbVJ5VE0QtVfyigKXSTnVZqKJ2eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRxbitTKzNzEaHFJoeVpy+I2AWT6k+79DyNeZwPxP98kJsfw1yxsPc+kw7gz7YcIbq27OHhtJzMw1cc+pVssJNsvrDDMcc0N9pHpT+OnubK1Cxh21aPhl8O+bTuNE6tunjh1bFD6ewW8Mhb3ZLFEyIDzeAJ5zA5ru2pMyV+t4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmVqMRh7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmVqMRh7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0a95200e8so34629465ad.0
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Jan 2026 04:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768913457; x=1769518257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LroXmq9J3VVORG7m8L/kGtxBgy95TWF72WU3KxUKLtI=;
        b=kmVqMRh72Z60zhUkUYNVVeacAqTKAHaAjF0av00kQCpVIhwQ347S9De5LAtrBCWeVu
         qxxDzdq1U+Ge1MmJJsxvgLdI/BDmRXk1QBbiMj7PY2Jd7In1g+6SzzesT5QKmv0l+eaV
         CxTz6JXMrdj9rzUzeuSCfcI/k5xb00ULWBme3a/Z3QjGB+nMabhn3wRsZBytqOSndHhT
         f6CNURMn7oTbtm1fD5G+wXgLYLgfHOSA6KUaX3P6kcGbNhESxYWjurAsDI3DClprKxV4
         LwTAXo3PPPTGrIqpTt1okiFHAL9g5Zo8HsP1mbOSwN7G1sBO3G8FtDlcNvtrfbIyIAVI
         QH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768913457; x=1769518257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LroXmq9J3VVORG7m8L/kGtxBgy95TWF72WU3KxUKLtI=;
        b=EsSJbL0lTKEA88QPNCz1BRGIAkTHExoxnGnlwKYv/KkZoaWFBcxH8brnoUCElK3/GO
         hYhGZMJ6HWTWNzEY2n1xPQ+yECexd0ho0g9pkGpQ9+c0JJaIUUkOAkMM8oQKHYVrwv9R
         wZndiBg5wtS/ex4GBZKPUjfwjnFIc5xUYSylsuwNNYHF1iSSSz7G/F+t16v/9qh5Q8+7
         ioL+oIOWucBddqmcJa5kVO1K6XFeIipSQrVaotMpX8zU8CZv9vaG+spDkEHo8vO8oNL2
         2KRmSkTwOD+RP2goIPAp4LHzjMbT6hyHj1UCOrCeCRmtXPG9EWr41vYV0nSHc+/OhXzU
         TGVA==
X-Forwarded-Encrypted: i=1; AJvYcCVkmbyUNOHHqcWbKjVbjUxLATMwKy5AEMw3ShwSy4kEWqIQT4a2W5SGNKh0dObfGOlpfaf8KOu9mCllmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4Nw3243GWXBJItNU6wmIELE+SHwfUCNw2ptFaOztVGvwCqeZ
	KjePa34dt1jpHebLhkvqQvO5t8tsE+hoT5e+uPo7yIpmFOOzarD9x9E3
X-Gm-Gg: AZuq6aIVM2wY+XdWCzF4x0HAY9L4NvwaAWr1TwFDUrECTfXljfI2NLqCNgLD0nxFm7e
	HALNYiAOrCBG5SHagwlpQkrYy4Hw2cScmslO8iBRJ9eeGCPb0cboQ5pJRekLiBVUGEjgCMFJMPZ
	Y6QYrum4ZpfPyKgs1Q88FvQw0NjsJa0W+SL5HYRY16kbIOJiZnv6XDRZ3S00o4K4tbQDIZxDo0L
	BiBrXqio81oS0dJ/LGuzcAXaHxNykxYddPnIcYqP+I5pHXt4fhhn1NfynAozYcP19cEDArtc0vl
	gQeC4MieyvTjgRwm4lGHz90qg1Fj64CWjvv8EsfCOxW/BlqvSzSzHoXHFOyog8OBqHSACxthMqy
	O+nCpT3AO5lqlmsQyXUbGr861uJwy74JjOvrcFGjpMhjs39XwsXjSYcSjBtxeUOuRVy0ZbQzF3F
	bpxvg/DlLkzhvP/qOyqncbz8BaMG0bhKoJPM7c
X-Received: by 2002:a17:903:2ec5:b0:2a0:8859:3722 with SMTP id d9443c01a7336-2a769ae664fmr16859025ad.25.1768913457332;
        Tue, 20 Jan 2026 04:50:57 -0800 (PST)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dd582sm124973815ad.52.2026.01.20.04.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 04:50:56 -0800 (PST)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com
Cc: deller@gmx.de,
	pavel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v2 2/2] backlight: gpio: add support for multiple GPIOs for backlight control
Date: Tue, 20 Jan 2026 18:20:36 +0530
Message-Id: <20260120125036.2203995-3-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120125036.2203995-1-tessolveupstream@gmail.com>
References: <20260120125036.2203995-1-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpio-backlight driver currently supports only a single GPIO to
enable or disable a backlight device. Some panels require multiple
enable GPIOs to be asserted together.

Extend the driver to support an array of GPIOs for a single backlight
instance. All configured GPIOs are toggled together based on the
backlight state.

Existing single-GPIO Device Tree users remain unaffected.

Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 drivers/video/backlight/gpio_backlight.c | 66 ++++++++++++++++--------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 728a546904b0..11d21de82cf5 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -14,17 +14,29 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/bitmap.h>
 
 struct gpio_backlight {
 	struct device *dev;
-	struct gpio_desc *gpiod;
+	struct gpio_descs *gpiods;
+	unsigned long *bitmap;
 };
 
 static int gpio_backlight_update_status(struct backlight_device *bl)
 {
 	struct gpio_backlight *gbl = bl_get_data(bl);
+	unsigned int n = gbl->gpiods->ndescs;
+	int br = backlight_get_brightness(bl);
 
-	gpiod_set_value_cansleep(gbl->gpiod, backlight_get_brightness(bl));
+	if (br)
+		bitmap_fill(gbl->bitmap, n);
+	else
+		bitmap_zero(gbl->bitmap, n);
+
+	gpiod_set_array_value_cansleep(n,
+				       gbl->gpiods->desc,
+				       gbl->gpiods->info,
+				       gbl->bitmap);
 
 	return 0;
 }
@@ -48,26 +60,43 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct gpio_backlight_platform_data *pdata = dev_get_platdata(dev);
 	struct device_node *of_node = dev->of_node;
-	struct backlight_properties props;
+	struct backlight_properties props = { };
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
-	int ret, init_brightness, def_value;
+	bool def_value;
+	enum gpiod_flags flags;
+	unsigned int n;
+	int words;
 
-	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
-	if (gbl == NULL)
+	gbl = devm_kcalloc(dev, 1, sizeof(*gbl), GFP_KERNEL);
+	if (!gbl)
 		return -ENOMEM;
 
 	if (pdata)
 		gbl->dev = pdata->dev;
 
 	def_value = device_property_read_bool(dev, "default-on");
+	flags = def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+
+	gbl->gpiods = devm_gpiod_get_array(dev, NULL, flags);
+	if (IS_ERR(gbl->gpiods)) {
+		if (PTR_ERR(gbl->gpiods) == -ENODEV)
+			return dev_err_probe(dev, -EINVAL,
+			"The gpios parameter is missing or invalid\n");
+		return PTR_ERR(gbl->gpiods);
+	}
 
-	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
-	if (IS_ERR(gbl->gpiod))
-		return dev_err_probe(dev, PTR_ERR(gbl->gpiod),
-				     "The gpios parameter is missing or invalid\n");
+	n = gbl->gpiods->ndescs;
+	if (!n)
+		return dev_err_probe(dev, -EINVAL,
+			"No GPIOs provided\n");
+
+	words = BITS_TO_LONGS(n);
+	gbl->bitmap = devm_kcalloc(dev, words, sizeof(unsigned long),
+				   GFP_KERNEL);
+	if (!gbl->bitmap)
+		return -ENOMEM;
 
-	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = 1;
 	bl = devm_backlight_device_register(dev, dev_name(dev), dev, gbl,
@@ -81,21 +110,16 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	if (!of_node || !of_node->phandle)
 		/* Not booted with device tree or no phandle link to the node */
 		bl->props.power = def_value ? BACKLIGHT_POWER_ON
-					    : BACKLIGHT_POWER_OFF;
-	else if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
+						    : BACKLIGHT_POWER_OFF;
+	else if (gpiod_get_value_cansleep(gbl->gpiods->desc[0]) == 0)
 		bl->props.power = BACKLIGHT_POWER_OFF;
 	else
 		bl->props.power = BACKLIGHT_POWER_ON;
 
-	bl->props.brightness = 1;
-
-	init_brightness = backlight_get_brightness(bl);
-	ret = gpiod_direction_output(gbl->gpiod, init_brightness);
-	if (ret) {
-		dev_err(dev, "failed to set initial brightness\n");
-		return ret;
-	}
+	bl->props.brightness = def_value ? 1 : 0;
 
+	gpio_backlight_update_status(bl);
+
 	platform_set_drvdata(pdev, bl);
 	return 0;
 }
-- 
2.34.1

