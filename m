Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9BB328259
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Jan 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603110; cv=none; b=WrDp2ZVRLn6XV6iR3wXLYQi1NVxpgExkdIuL4WTt6E+ZjrYXrcdcvzuukT/+n92/3HYSm+GtyilYJXr1XEAEj/YCRB9AcCdho5/UNkFp3bQ09edUGfIJmgEFkSqbYq2OzzOjapxEBiLxFfqXD3tYkfHpc2lyeUcM3VWmOwkn2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603110; c=relaxed/simple;
	bh=ZQ6Y7IFZTaEd6ktsVoxdPOs72CPIs+7PsUG1QLPNjHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qmnFjjXCg2eGD60w1RFs5cUZT5HZ6EEZPtqdjuxbm+51xto1oQjjsDidihFP0xbARdE2z8hmXXwUZibq2Kj+rzMHR6a9f1oKsOOqKQFrkZazN/UQkZaQxUP0ou3eGZejQOPoA76owF0A7POnLJKaqfmEjmx7q2VrWr5LB0zhKdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVKa/TFv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVKa/TFv"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34b75fba315so14894699a91.3
        for <linux-fbdev@vger.kernel.org>; Mon, 05 Jan 2026 00:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767603104; x=1768207904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFt+oA/6TnGUcf1mQLhvyTPCz7K2SXMiNJhoCpH+0PQ=;
        b=fVKa/TFvf8XIfjlirfLhfwDttkkYRLbl0EB2WfX0NiEgjrgaMKeUci0BORuosejzsW
         v4AXvruwrwxC5Bi1VpHCv/B2VswHBLIa4YYYvVDXUYqcADYjqUkLvtrVM73RLhh9WygU
         CgBNmGEjTF2R4Zs+VnjT17r/4Ho6gWCukz3bbOPmtio0Vkqp1sE34w8ElpkagVKeKKkX
         cqfJ+kMW0hwzDViK0RNQVHGOADhuHeZve/cDTzI3zSYgvxDs+2EwSbBGONCRqnpONzj1
         x/ceBlTCPwdtjxVGhbwg1sso0UNuLevOceR9akSqgLBScHnAMVjI74ywOxCEjQsl8kUD
         U3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767603104; x=1768207904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bFt+oA/6TnGUcf1mQLhvyTPCz7K2SXMiNJhoCpH+0PQ=;
        b=QAaHjFeALNJYr1RWvtZQq2Sbw7k4Ky7CRVpVSnWCVdibYC4ZGBI9O+WDFri7T1VAmH
         JqPY/WzypgUkxjebXoWVlRPRffKv4CT+qQqnYHIes5lWEo36ee/aknP66KsA9zZL3Gy0
         j/wThizztquSPb7xmcDrb4VMcn244NVdhL4fDcK6gUzFLQuBZ0FkLgAXujpEPg7FFeu6
         YkVrLhjBxKq5Ho9TAuIMLiV3Ejomu8+3gnYFshhoWmnw/RVwX8/eeihlZtP15mbY6jGj
         1FujpZirWSnTf2vbyOYqzvnTX3xy9awKKjwlM3Aow/BKY1L5WIapgEDGh76He0cu2HCH
         a0BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhQKangA60OY+MQ3SXI6pQV1+7yPBh/5EQ4Hr6g0D3UAvcLaNbO6gGwneszL+Y6ixSXbUPpJUXYmsZxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdnovTKN9UHNNI0OQi6PKcA6hWLCv30FGRHIwZxs50l1RK2Qu
	nAH7J4q+5A4Ikj4ICjVSGoT4jA24Zw5qYGqfxs0VqVV9jzTbglU32hRy
X-Gm-Gg: AY/fxX5jMyjaEcMSemQvD4OFtUz+ZET/pq3Rc6yiLks7hnH4+zYXIHp0TVdskUvBrqv
	uj5SBxLjt0TUDCquJbLxFEkMfCWs7+zl4l90oZhl7si7QUhPsEqm/QzWABog+ctBhf3f3Yi+bwh
	1Z9Q87ZPDLlDI8cl6xVm8JgE398mV0aukKb0ZqrOhuG63z8VeNAyp4njT2MlX/qpnj59XH3XuZj
	HYd0gjQAXL4bpuep7W5AUg4ijKy5ci/8L1P4g2/+n3F/oOY761vZiDh59t1Au3umXGwFNlo/sfV
	YKNVMFnZheaIownJ42QllbWEAYchBH8ex7zYBG2q+GUBG8eUy84pkJs9GNt3rUMCWRhVhiIQ6su
	biyue6PSEjnKI1qmiT6e00uisEzcE7cZ34nSES45ZDGPMUc8kNde+Fc6A8eErys6VrBrb0/REAg
	X0lwXh4B3hTDr2vOaPz5nyIoGvqriS/LUugFc0
X-Google-Smtp-Source: AGHT+IE9h/a5pga/RcO3GaC9CZMJm/hBktjxAoM256+iS35FTfAipE1WuhDdgjBTuxYdSkDNtweQhg==
X-Received: by 2002:a17:90a:d60c:b0:34c:4c6d:ad0f with SMTP id 98e67ed59e1d1-34e921f0e35mr38658346a91.37.1767603103621;
        Mon, 05 Jan 2026 00:51:43 -0800 (PST)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476fab12sm5631951a91.5.2026.01.05.00.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:51:43 -0800 (PST)
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
Subject: [PATCH v1 2/2] backlight: gpio: add support for multiple GPIOs for backlight control
Date: Mon,  5 Jan 2026 14:21:20 +0530
Message-Id: <20260105085120.230862-3-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105085120.230862-1-tessolveupstream@gmail.com>
References: <20260105085120.230862-1-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the gpio-backlight driver to handle multiple GPIOs instead of a
single one. This allows panels that require driving several enable pins
to be controlled by the backlight framework.

Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 drivers/video/backlight/gpio_backlight.c | 61 +++++++++++++++++-------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 728a546904b0..037e1c111e48 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -17,14 +17,18 @@
 
 struct gpio_backlight {
 	struct device *dev;
-	struct gpio_desc *gpiod;
+	struct gpio_desc **gpiods;
+	unsigned int num_gpios;
 };
 
 static int gpio_backlight_update_status(struct backlight_device *bl)
 {
 	struct gpio_backlight *gbl = bl_get_data(bl);
+	unsigned int i;
+	int br = backlight_get_brightness(bl);
 
-	gpiod_set_value_cansleep(gbl->gpiod, backlight_get_brightness(bl));
+	for (i = 0; i < gbl->num_gpios; i++)
+		gpiod_set_value_cansleep(gbl->gpiods[i], br);
 
 	return 0;
 }
@@ -52,6 +56,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
 	int ret, init_brightness, def_value;
+	unsigned int i;
 
 	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
 	if (gbl == NULL)
@@ -62,10 +67,22 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 
 	def_value = device_property_read_bool(dev, "default-on");
 
-	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
-	if (IS_ERR(gbl->gpiod))
-		return dev_err_probe(dev, PTR_ERR(gbl->gpiod),
-				     "The gpios parameter is missing or invalid\n");
+	gbl->num_gpios = gpiod_count(dev, NULL);
+	if (gbl->num_gpios == 0)
+		return dev_err_probe(dev, -EINVAL,
+			"The gpios parameter is missing or invalid\n");
+	gbl->gpiods = devm_kcalloc(dev, gbl->num_gpios, sizeof(*gbl->gpiods),
+				   GFP_KERNEL);
+	if (!gbl->gpiods)
+		return -ENOMEM;
+
+	for (i = 0; i < gbl->num_gpios; i++) {
+		gbl->gpiods[i] =
+			devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
+		if (IS_ERR(gbl->gpiods[i]))
+			return dev_err_probe(dev, PTR_ERR(gbl->gpiods[i]),
+					"Failed to get GPIO at index %u\n", i);
+	}
 
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_RAW;
@@ -78,22 +95,34 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	}
 
 	/* Set the initial power state */
-	if (!of_node || !of_node->phandle)
+	if (!of_node || !of_node->phandle) {
 		/* Not booted with device tree or no phandle link to the node */
 		bl->props.power = def_value ? BACKLIGHT_POWER_ON
-					    : BACKLIGHT_POWER_OFF;
-	else if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
-		bl->props.power = BACKLIGHT_POWER_OFF;
-	else
-		bl->props.power = BACKLIGHT_POWER_ON;
+						    : BACKLIGHT_POWER_OFF;
+	} else {
+		bool all_high = true;
+
+		for (i = 0; i < gbl->num_gpios; i++) {
+			if (gpiod_get_value_cansleep(gbl->gpiods[i]) != 0) {
+				all_high = false;
+				break;
+			}
+		}
+
+		bl->props.power =
+			all_high ? BACKLIGHT_POWER_ON :  BACKLIGHT_POWER_OFF;
+	}
 
 	bl->props.brightness = 1;
 
 	init_brightness = backlight_get_brightness(bl);
-	ret = gpiod_direction_output(gbl->gpiod, init_brightness);
-	if (ret) {
-		dev_err(dev, "failed to set initial brightness\n");
-		return ret;
+
+	for (i = 0; i < gbl->num_gpios; i++) {
+		ret = gpiod_direction_output(gbl->gpiods[i], init_brightness);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					"failed to set gpio %u direction\n",
+					i);
 	}
 
 	platform_set_drvdata(pdev, bl);
-- 
2.34.1

