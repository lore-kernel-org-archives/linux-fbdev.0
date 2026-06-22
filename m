Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65ED376A17
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Jun 2026 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141923; cv=none; b=lDgxujAYClmLSQZjVV0ZK657Vk//UKxzDhAuGKVr5hsxPUozHMKzC9SL7INh5bHE7pzqp9gr39s6lA5Oo2g+hrNvHYHuV4Ym/Oi46VdtYXj5BfAVdcQKIAw5IqTrMdLpJc0oz3ZYLuGaCbBSbEa7j4eHV0tW8mO6RAlI0CH2lbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141923; c=relaxed/simple;
	bh=pemz1FNNs0kpzhepFGC9w+PchSrHijunkMIG4FZdyOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoRN+IwFXkjRzXnSDphLv2UOZ0dsvai6K78kNGozbfztScyLcTlECej88YRX6svnpTGUBG8YrScEXX6zPrnv6lQPbiNahX790WNWCg2fj0JT9LAjWLV3cUwlc+MDKQXk/Fkqia6X8Ry7Ey6DzFuaLIE6yjZ4b0M+mQosE3MicEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj2z23wa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj2z23wa"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so26863975e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Jun 2026 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782141920; x=1782746720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0qw7KTWnyC881EwxaOjThj92Q0RuccaSWAdkHLFKrM=;
        b=Yj2z23waq+NALnA19SSDhi6xbiqyTgQNy2HLPg2C9ZaCojDbU3Ht53/2GMoB15BCk2
         +IHqGKg5sxsfoIK8cSP7iPF3OLQifrLNod+XUP3NwyC+/14amaSAG8ihwOFYma+xV0Q3
         F+w6kI2aK5fpA0Der8RU3rjtVIe0v+XJb+46BZxvfjD8ltYQyKd9W0uiUwNa76Nm/pvm
         kkalPMd9wRN4+BzjECvgqLlwdCOEfOTPtutnrZZlwLTVmI1BdFTpyDIbap0f7gL+IQSe
         cdUwSTmhLj5o8EouDdhIMYKQN6kPNS7dbNzehzYvg7dcK9efamGlKHXkj5lJKIalAoxP
         oz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782141920; x=1782746720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z0qw7KTWnyC881EwxaOjThj92Q0RuccaSWAdkHLFKrM=;
        b=mN1zPVa87cGrTzBQq9d+eVKIK8LuZVgFmp0DstkAM3AmvAsYFaHFOLEqxt/cjyu8sy
         QdAaHZo/Xu1OCjWH4tnBIj1rpPqpKAlOkyhI7EzHqNvJ7vnx3fgTVUz6pZ0XHuw4uCbI
         tz6eK+azYkiyuzknJolk9hRI3e4HXFxhvBWO7aMrIKQZfJ/8gZv3x446h/TxYug9P2gJ
         G7PnAoSWV9HlUYWBqwV/Mqn1TsBNWfHIrEaJiFI7k8m7AEXMUKIgFA8kvP5qkY5+7P6M
         FpJbz1yGJALwuayvzw4Csok8ZHQG2UE0ti21bOlkzyc9tF3AGAQwLW7MkcY/3ixETUEf
         nAXA==
X-Forwarded-Encrypted: i=1; AFNElJ/9l2w6uTg43NPjeC19JyR9ZYrRyAtC9JV3+6+FI9SQbKU9C+NCFMSHQue80aUwxndax425+poNhEAUuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAi5KzAmOyifRgAT68yxOhluNH16c9laqcca8qWhQdn1BDkugI
	63jNw/6A4aRCZw3Jy+5Lrt58WPWwPCxDO5ls/blAz1Bkp2RI2Q/FsAtD
X-Gm-Gg: AfdE7cngC870gSeu6IhXcVHx5F0auJtuQeZ2QcSHGOjwAFZNGZYLATI4lz6K3dPN/ht
	0LIRlj7QRukgmk7MJ8YQWFoKH6uxKdHSa3VyDZePY+qjE4UnArsPC6m4ZwrAMDjLY++ni3pZZKf
	Y7NkBROzkIqq+hLPGck2HYbx5EDcDDE4QyEEnjqe/BaNCcGGR6cOIOnTvD4lm+460zDWw26hZyi
	TkvvfeczBdDuqPQ9/TXFZ8+No7SfwKTwsiAYGyuRfwUAQMhfSd8ZootR35I2fO4jE3QI2NCbhoB
	GtjO9KRyNH4XMHuXpp3Wj/0b5Rkybhrtn31B1nbJ+zyboIV9VLFp972O25m+06LTEPjQDnnR1S/
	ZEN2N6pjDH+hipzr4e3qpI8mj3OfrCOeqEW3eioMysBa20Jh8LZ0zKhcC4V3kv0rZSFJ+X2nGUR
	EVDWVWxnJmdzlV4bcEJrvGBTBmCwU=
X-Received: by 2002:a05:600c:3b15:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-4923ef47e73mr298830265e9.3.1782141920248;
        Mon, 22 Jun 2026 08:25:20 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492492338dasm217883655e9.1.2026.06.22.08.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:25:19 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	deller@gmx.de
Cc: azuddinadam@gmail.com,
	chintanlike@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: display: Add Solomon SSD1351 OLED controller
Date: Mon, 22 Jun 2026 18:25:03 +0300
Message-ID: <20260622152506.78627-2-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622152506.78627-1-amit.barzilai22@gmail.com>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a device tree binding for the Solomon SSD1351, a 128x128 65k-color
RGB OLED display controller driven over a 4-wire SPI bus. The binding
builds on the shared solomon,ssd-common.yaml properties already used by
the other Solomon display controllers.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 .../bindings/display/solomon,ssd1351.yaml     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
new file mode 100644
index 000000000000..80850c2ab5b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/solomon,ssd1351.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Solomon SSD1351 OLED Display Controller
+
+maintainers:
+  - Amit Barzilai <amit.barzilai22@gmail.com>
+  - Javier Martinez Canillas <javierm@redhat.com>
+
+allOf:
+  - $ref: solomon,ssd-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - solomon,ssd1351
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        oled@0 {
+            compatible = "solomon,ssd1351";
+            reg = <0x0>;
+            reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+            dc-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
+            spi-max-frequency = <10000000>;
+        };
+    };
-- 
2.54.0

