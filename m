Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029F0391822
	for <linux-fbdev@vger.kernel.org>; Fri, 16 Oct 2026 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168168; cv=none; b=UIdEEnNg+hbpV82Q5zCTvLeRj+bXH46+GxwqXaKzEtc8zU7RUcFkCwPpBDhZwkUidBnoD6B/FcfRe1daXn2RrBDFxcFyDbLhQdaZuB3KcXB6Q06vi4aiYSU7F1C2FSsjtLb3vT1G3HkbcNggx4OeTDQwNwFFGj4B+6W+A14GRJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168168; c=relaxed/simple;
	bh=OxV1RuzyJ3U0pIeECN5+q2tSH4wIzfJ7OS3s+Ly4mTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lsdzm9TymTQ+eJg2qqMNZFoYh0P1NcGssUt4dGFGBjkKAF4yPv8SwpEQ51djLDV2fgXa9dNrzIdWrCYLxgBO0ck8mOaM6rGkb2c7KC15xOoO6sFdDlwku6QE559J7rddErFCnbUmWX77og0cnOeKrpSOG98069n3CJCb7Olke1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMUCZWZw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMUCZWZw"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4be28b82so15544f8f.2
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Oct 2026 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168161; x=1792772961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F/XhYMGu1EQRHViVghAn6A1D98GsvwIcwrZbeCelmr8=;
        b=EMUCZWZw6yshhCZS3dhk5lGJ8xENGATXGOjfW35kGRHN2uJ38jOmIE0zFAhTk0l1u2
         BygMTOXTB0zDEb37zp/qF+BCtau9lEfaVTkiHAKXSEmqq252HEdpOd6II4JQWd6IJ4wW
         GY1WrVAD7dIcAkBxrPvT0979McL3MEaDoLcpDw2SMFBJzzH9oOuBJEyRO9cVQefUbXxE
         Czh2/DQjFW0KYc0iExBcQsHr1vBUUg5J8gmvq9Ne8Z8S2GrMXPX+ybJ6k+Ss6O8iGMP2
         SPdp5AZCMVtJMbtNpoIUAefmHtToMBYdJZIwkynAOmVBFZC3AbyIw3UWa9a5tWmgIDam
         kOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168161; x=1792772961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F/XhYMGu1EQRHViVghAn6A1D98GsvwIcwrZbeCelmr8=;
        b=opVWhQrryxV9U2ptrsRCnO7qsT8QEMVKHD6Drg0YvF1O5YXZj86MHv1J5KbxRjorGZ
         uHkI4YL14fOPalNkmcf4+XNhBdpTK8HolD5sbURwZl3q0C6DjW3JzkP2VelslQCEaehC
         U/4xJuga9zX94uZhInIDmyp/U7eumy8g2sj8Gzp0oCD0Cg4kPeySpsL3H4oqu5/jxCes
         EdySoXUXmrdrz7jCqnYxjACNb3oMVyWbDgwFcw3I46YIFIcms62upluyfZAl7KvgjhgY
         EQD/sA8bgiAaIZDcfFWMZsjYWTUKJK9pblMWyGuksIcu6Hs7iH/ypqMgAsiXxeEaMVi1
         ZSeQ==
X-Forwarded-Encrypted: i=1; AKwUvBxauzdJ7ngJQ603fgegXL7tHwnDq+a8aa1ZPqSmgDSe0GQPH9FWGFC2vIc4vZl/rv7PfMkyDjmJFHifTw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKwy+mMwa7ExyxCiBQs1mwXSpn1nq40BN810KcMKB+EqObq7P/+
	bzjlUqjMgDB1TXOMqAV4GJ8kAYRWWgWuJfG0yzwJr9GLM0rGki9oP+cs
X-Gm-Gg: AYBFou2GdpJ+qOM85as3s46rmLaHMTkp7kvbXiI6i3VhTzZzr6IbYbB+fsei5zMW+ks
	TrEE6uyLC5X3ZUFkhcrKFxqqbABmPORCS32atVEDHuzz34peX//qIryQnKfD4QGUr/0DO8XtGLA
	ll7SI2DcNWGOfHYn94NEXltXymw2l4ziX/vBo/h944Z0+aX2YkfjpkLLZDMOTDnUp56YkF6daRe
	CUERODYj0hv4Csei3wzv7MTiUJ/PuNyjKKyZjlCJA/t5atbAMmd4sH5W4BQ6QJfeWnF1ZBDLAN1
	7BuXZb2LomcX77/U6ajH4x10lC/5pd5Il0hhy4aPUpl1cH9BXOfwy41tpLt2S5SDDqt43uu12aJ
	Ou1YJiglMOpNmnGAMf7c7Ot9FTPV7N5WCEFvvWfysOzij7LewKP6fzxDZsD9PCvcnB0uvErPX8D
	ulS1eTy9gTkAh+dl6Uh5HBtV/f5yF+YDyHhnzJ2eCnYvHy9fWKoi6SZ06FH2AmVy2eI9UdpO2Qf
	z+nSHY/14EX4KOrRGTjNCXUbx9uL8OHLpoMYrVu8o8D1BX6Ss0XGX1O7X3Eu8zPecpggNW2iefz
	Cw==
X-Received: by 2002:a05:6000:4a0a:b0:48d:f14a:9183 with SMTP id ffacd0b85a97d-48e07bbc619mr219403f8f.15.1792168160937;
        Fri, 16 Oct 2026 09:29:20 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::103c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5942sm9404317f8f.16.2026.10.16.09.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:29:20 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	pavel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 1/2] dt-bindings: leds: backlight: Add Awinic AW99703 backlight
Date: Fri, 16 Oct 2026 18:29:11 +0200
Message-ID: <20261016162912.64581-2-lukapanio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016162912.64581-1-lukapanio@gmail.com>
References: <20261016162912.64581-1-lukapanio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Awinic AW99703 is a 3-string WLED driver converter with an
integrated boost converter and 11-bit brightness control over I2C,
optionally combined with a PWM input.

Signed-off-by: Luka Panio <lukapanio@gmail.com>
---
 .../leds/backlight/awinic,aw99703.yaml        | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/awinic,aw99703.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/awinic,aw99703.yaml b/Documentation/devicetree/bindings/leds/backlight/awinic,aw99703.yaml
new file mode 100644
index 000000000000..62e8cc3118f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/awinic,aw99703.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/awinic,aw99703.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic AW99703 WLED Backlight Driver
+
+maintainers:
+  - Luka Panio <lukapanio@gmail.com>
+
+description:
+  The AW99703 is a 3-string WLED driver with an integrated boost converter
+  and 11-bit I2C (optionally PWM) brightness control.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: awinic,aw99703
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO connected to the HWEN pin.
+    maxItems: 1
+
+  awinic,led-strings:
+    description: Number of enabled LED strings, starting with CH1.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 3
+    default: 3
+
+  awinic,iled-max-microamp:
+    description:
+      Full-scale current of each LED string, reached at the maximum
+      brightness code (and 100% PWM duty cycle if PWM dimming is used).
+    minimum: 4800
+    maximum: 29600
+    multipleOf: 800
+    default: 20000
+
+  awinic,ramp-on-time-us:
+    description: Current sink ramp-up time when leaving standby.
+    enum: [512, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000,
+           256000, 512000, 1024000, 2048000, 4096000, 8192000, 16384000]
+    default: 8000
+
+  awinic,ramp-off-time-us:
+    description: Current sink ramp-down time when entering standby.
+    enum: [512, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000,
+           256000, 512000, 1024000, 2048000, 4096000, 8192000, 16384000]
+    default: 8000
+
+  awinic,pwm-trans-time-ms:
+    description:
+      Transition time between brightness levels set by the PWM input,
+      for a change over the full duty cycle range.
+    enum: [2, 4, 8, 16, 32, 64, 128, 256]
+    default: 2
+
+  awinic,i2c-trans-time-ms:
+    description:
+      Fixed transition time between brightness levels set over I2C,
+      independent of the size of the change. When absent the brightness
+      ramps with a fixed slope of 1 us per brightness code instead.
+    enum: [128, 192, 256, 320, 384, 448, 512, 576, 640, 768, 1024, 1280,
+           1536, 2560, 4096]
+
+  awinic,ovp-microvolt:
+    description: Boost over-voltage protection threshold.
+    enum: [17500000, 24000000, 31000000, 38000000, 41500000]
+    default: 38000000
+
+  awinic,ocp-microamp:
+    description: Boost over-current protection threshold.
+    enum: [900000, 1800000, 2700000, 3400000]
+    default: 2700000
+
+  awinic,sw-freq-hz:
+    description: Boost switching frequency.
+    enum: [500000, 1000000]
+    default: 1000000
+
+  awinic,inductor-nanohenry:
+    description: Boost inductor value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [4700, 10000]
+    default: 4700
+
+  awinic,pwm-input:
+    description: Combine the PWM input pin with the I2C brightness.
+    type: boolean
+
+  awinic,exponential-map:
+    description: Use the exponential brightness curve instead of linear.
+    type: boolean
+
+  default-brightness:
+    maximum: 2047
+
+  max-brightness:
+    maximum: 2047
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        backlight@36 {
+            compatible = "awinic,aw99703";
+            reg = <0x36>;
+            enable-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
+            awinic,led-strings = <2>;
+            awinic,iled-max-microamp = <20000>;
+            awinic,ocp-microamp = <3400000>;
+            awinic,inductor-nanohenry = <10000>;
+        };
+    };
-- 
2.55.0

