Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A21F462A
	for <linux-fbdev@vger.kernel.org>; Mon, 10 Feb 2025 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203978; cv=none; b=FqYnbWZZckKwflJmPBhloH8p8u7Vm42sKCqmyvv+aAnwfozeCR6Jt2qF/9YL46nF/fo+q0ThX9o6G4ej/ePTPZM8hiwnKMSxnSxTgz3Ev3F92V9InlA7beljDeO4Avp6LaXIsEzJUHCse0BpwLapRXXLc2z3vf/bxwlTLYdAT3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203978; c=relaxed/simple;
	bh=y7IjFtUIINl7cRYxyBtc6keo4179kmfVu625qHuoAp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpRcjBi6mYvQDrJ93X7+eFwERE8DN2Q/pUO60DIzhX9P0sF2I6rJWT5LYfJSwwoMnIGDUD/t43GZtf57Sfavk3BrIxUdnse7sqSMRRa74R3ppiAgqaajMq7+1PwN+Re7f3lgXkwTpBpU0wgQNjTg3cjNT7q9ClND7E6GKbUD/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2rJneaiX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2rJneaiX"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436281c8a38so30225235e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Feb 2025 08:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739203974; x=1739808774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVE2q3k6JdjZ4UFWVjIakaD9BHRuhH1Hcjnsp1m4Lmk=;
        b=2rJneaiXYkNjglL16S9xgk7vlN4F8+gkSOPikaxLqhmHsIOUneKK5tL27aW6KnCefH
         B7wo6RL4vt7yLkr84BP7h7iWDgcj2H1yUkWNTKYrOt0X23rtrGTSBOU1J4G46/rWTzCG
         HVQFS4qc/4+O30n3itfx0yX5saqOWeP11DH6sunTVGe8C+kg2Hrnz0XPF++NH/Q23zHk
         bwxBcfKtcjqCeJlBVxo7rcofUwPFLAqn87ivd0umJ/emQrEbB0qfOYfdt558OIAGD0kV
         xFNo3RvoJ8si/FJ3rirOFhKTJjSg0JUcid/Fr7HpVzJrz2gUlfZjQ95UnpEps1C2Inpf
         OVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203974; x=1739808774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVE2q3k6JdjZ4UFWVjIakaD9BHRuhH1Hcjnsp1m4Lmk=;
        b=w4Qnh9lB9d0VUT+egnZFPfosTTSsGLjAX1O2/jO43f0j5TWwcMWceToDFDVubOrJro
         fKfIYesOe/WrVx+EkPvVT7gfKv0FRxlBYHJJ12LurGJfW65yeXIFMIoWui8HKVIs3lY/
         UdamFUrOpLC4z5Gu8mVssgMm88luqF/gzjmXCti4aajdrD0iymq4Ze1C058ILPH+I9IO
         32gQYMeBVZ0mLZNZAb2X5f67xdHu9bbBIOoUQ8U2f7aePRJMzF/XstnXh77iOe6NS/0u
         fa2cuUpp94dfn8Bcyy0pbsf3akQWoWftKmqxb/u5RU899w/mWBxiOq2ZmGUZwBWh+Mko
         Pu/g==
X-Forwarded-Encrypted: i=1; AJvYcCX8Zgy+pkanOXu9rVH/10de4KyywDBwkEUFXK9ycYmTzgSpOm1GABDpokf/Lkd5I6GL7O/DrnwCCLQa1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdWahw0YdBCnt+29ikTjCf7G9Gl6ZMv4bXIyckhqkZKdvlwJd+
	76TZOtGOiTWXAFlZeVrD1XekKzXou5RELiXQEN3EbPUcb3B6wuYfB+L1P1dLeAPDepda72jrZTf
	k
X-Gm-Gg: ASbGncu40mCqMbElR7WOC4bBG7lzWUzapZqy2K6puctGRB5rja9gLZHVeb8uyBGDwg3
	WgY0MLD8p5ORV3Q5kYVTBJUp/zt3ikl28mqBVN7Xb4YdVebLSTBEasj/5ftq23WjN7Qxo/E6FN1
	ayU+MiazAsENRu/n2CSyQTFUNPB3bG3ZFHsFT4axLwppoUYUcW0DLfrmchiBUsbxTNj1iu1qmRA
	JW8iuJukPJLrIg8ZQVTe2wt+rXj8g0dmf3n1HRaPQM4VMo962sSLzQC8PGFOxIbbCznxtT+HTI+
	e9xdfxCN36NK2jaU2tgBWxFhQNoAiqhjAh0m4nGWpcA7fVHQ8bm6ZVVaPvxJ/A8=
X-Google-Smtp-Source: AGHT+IGzddC47+pjDSvR9mwpmYyJVcplPKxTatIFBpfXmDpOUncoCIJE66zoIcUqHQlugsyEqtyVjA==
X-Received: by 2002:a05:600c:4650:b0:439:403a:6b77 with SMTP id 5b1f17b1804b1-439403a6d76mr56761835e9.10.1739203973800;
        Mon, 10 Feb 2025 08:12:53 -0800 (PST)
Received: from [127.0.1.1] (host-87-8-15-130.retail.telecomitalia.it. [87.8.15.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ffcdsm146637945e9.15.2025.02.10.08.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:12:53 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 10 Feb 2025 17:10:55 +0100
Subject: [PATCH v4 5/9] iio: adc: adi-axi-adc: add platform children
 support
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-5-160df18b1da7@baylibre.com>
References: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
In-Reply-To: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

This is a preparation for the next commit adding support for register
read and write functions on AD7606.
Since sometimes a bus will be used, it has been agreed during ad3552's
driver implementation that the device's driver bus is the backend, whose
device node will be a child node.
To provide the special callbacks for setting the register, axi-adc needs
to pass them to the child device's driver through platform data.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606_bus_iface.h | 16 ++++++++++
 drivers/iio/adc/adi-axi-adc.c      | 65 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/iio/adc/ad7606_bus_iface.h b/drivers/iio/adc/ad7606_bus_iface.h
new file mode 100644
index 000000000000..f2c979a9b7f3
--- /dev/null
+++ b/drivers/iio/adc/ad7606_bus_iface.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2010-2024 Analog Devices Inc.
+ * Copyright (c) 2025 Baylibre, SAS
+ */
+#ifndef __LINUX_PLATFORM_DATA_AD7606_H__
+#define __LINUX_PLATFORM_DATA_AD7606_H__
+
+struct iio_backend;
+
+struct ad7606_platform_data {
+	int (*bus_reg_read)(struct iio_backend *back, u32 reg, u32 *val);
+	int (*bus_reg_write)(struct iio_backend *back, u32 reg, u32 val);
+};
+
+#endif /* __LINUX_PLATFORM_DATA_AD7606_H__ */
diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index b38e8a27af94..3e1a997ace76 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -334,6 +334,36 @@ static const struct regmap_config axi_adc_regmap_config = {
 	.reg_stride = 4,
 };
 
+static void axi_adc_child_remove(void *data)
+{
+	platform_device_unregister(data);
+}
+
+static int axi_adc_create_platform_device(struct adi_axi_adc_state *st,
+					  struct fwnode_handle *child)
+{
+	struct platform_device_info pi = {
+	    .parent = st->dev,
+	    .name = fwnode_get_name(child),
+	    .id = PLATFORM_DEVID_AUTO,
+	    .fwnode = child,
+	    .data = st->info->pdata,
+	    .size_data = st->info->pdata_sz,
+	};
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_register_full(&pi);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	ret = devm_add_action_or_reset(st->dev, axi_adc_child_remove, pdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static const struct iio_backend_ops adi_axi_adc_ops = {
 	.enable = axi_adc_enable,
 	.disable = axi_adc_disable,
@@ -417,6 +447,28 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register iio backend\n");
 
+	device_for_each_child_node_scoped(&pdev->dev, child) {
+		int val;
+
+		if (!st->info->has_child_nodes)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "invalid fdt axi-dac compatible.");
+
+		/* Processing only reg 0 node */
+		ret = fwnode_property_read_u32(child, "reg", &val);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "invalid reg property.");
+		if (val != 0)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "invalid node address.");
+
+		ret = axi_adc_create_platform_device(st, child);
+		if (ret)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "cannot create device.");
+	}
+
 	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
 		 ADI_AXI_PCORE_VER_MINOR(ver),
@@ -430,6 +482,19 @@ static const struct axi_adc_info adc_generic = {
 	.backend_info = &adi_axi_adc_generic,
 };
 
+static const struct ad7606_platform_data ad7606_pdata = {
+	.bus_reg_read = ad7606_bus_reg_read,
+	.bus_reg_write = ad7606_bus_reg_write,
+};
+
+static const struct axi_adc_info adc_ad7606 = {
+	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
+	.backend_info = &adi_axi_adc_generic,
+	.pdata = &ad7606_pdata,
+	.pdata_sz = sizeof(ad7606_pdata),
+	.has_child_nodes = true,
+};
+
 /* Match table for of_platform binding */
 static const struct of_device_id adi_axi_adc_of_match[] = {
 	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },

-- 
2.47.0

