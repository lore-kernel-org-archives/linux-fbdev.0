Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263238423B
	for <linux-fbdev@vger.kernel.org>; Thu, 21 May 2026 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350887; cv=none; b=QQWZyNJGukHOZKoYe9Sz+qfgZfuRFQZBHPNzUZsBPQwl+/gSC4CGUoHjk74G+OU2ve7BX/dCKqaarApDIKUuFqqq7mUNZVydopU695eQupK4Vi1HAwSOffEy/dkSH4i7VaOZKsRqfEJJjKVqT+IRtcyDwkskCeIrvnGjgcOxaak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350887; c=relaxed/simple;
	bh=8cCbXbkb6HowjU8II83CA2d+DXwOgvOAWQTPrH5Iibs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=goyz11QATNow+cE/NJT820HbsX2/w3a7XVW55qSjcHYyaUnfqwB5BrsHSx6BIPVZlh/p+Hd3ULLPYBfQJVzlSRl9N8GqsKCR4BPSe/gSP1aQRgdK4mwGaImqjKA6Tg2HihBDKXn1Y/7Vf/aejGdzK++9moQy01BMinyHpsm2otM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tcAE6PJl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcAE6PJl"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so2842943f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 21 May 2026 01:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779350885; x=1779955685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFOILrRBRgckVtvDGiEi9gDf/W6MgY2gnxmqTdTmRWk=;
        b=tcAE6PJlXKeamfEINF5lEegA/8W7OmNegkVK9RY1phJHcCo5mXvweTnE00tkGxIhKA
         lUDFeUwF90pXQ0vMJIW9A+45sdfsrIA5kRhuSLxQFN8yv1pXr3xky9WxMePdkXmfOXVH
         6/VsLIvD4ZROpdBF39KRlVB0QbibJ71UV2f2EDk/AU+BVHyhBOE6JcaZQ5xCUXAO0/17
         sAla2WodXasGe01HAh0QTm0ZAw94zA1N4le17B/XUj593yeJ2cr8Immg6wtJKBqHghkl
         aRQ0JiisZPq3pB44/dZPWeIACDByrjSqNx+xjov1P9QUi4fNacs3VNhzjHez2FH4qWvh
         cZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350885; x=1779955685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fFOILrRBRgckVtvDGiEi9gDf/W6MgY2gnxmqTdTmRWk=;
        b=oockgpFbd8NrNyUKlFyj73DerKxhc1iUyAz+T96D5kTsID4H94L+4qKq1NLTbnfZe+
         bjgUOJTuI/U3t6MY33tfT1jn9Pxx7zjN0/FxL636yXEy/NJa+FJqeIdJhEZKf4tA4/0h
         Rd3CCpvcHb4GIrHqZ6mKwwOZVVCOuBbOBiFPb0DF7B7WlCIeLeBNVLwrAayH6jM5+7K3
         FC2qmhTEscoGejTrVzAi3SUEjoKxY8SBve9lLqUdRFTlEt70fQCr+3YNPT2cv3iq6B7X
         xTAjcufr4n6fpo+0b51lHXMhuadnUU9aj9EX18vnynC0Hw0VNfvPcTSgZ+EY7yW7JZd6
         v4gw==
X-Forwarded-Encrypted: i=1; AFNElJ9dM8RqgPA67V1OaIbIBtbN0y2jlzLW7v9URCVZWDTXmAbR6/jRXMB4ux6mjpJx8yAZNOw6o/FR3GU2ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBAuhtDtF16NB7I5i10VwR81UWAVkjfadcGWQt5ZOSFXrHj6dy
	OqiGAj8diDMZWmlYJe4Am42oYawVL7kDgPK4mIy5ldXiXsKCKD9IR6fqsEx66jWzPX7Gj5EqcsY
	BQeb5
X-Gm-Gg: Acq92OFMZEOfgoex6ohiwmY6bKMpAouuDQyInpdGxT8VAmaYjm33xdBrr0RiIu71w7D
	+PfgkDglrx+GxQBfqsaMYVWi4vbczj+7f31cI7l1+w6tABWNVA6fqWLwdblYmPGjygyyCcykMEn
	9Ptnn91Qb7fqoYEf/dCshRE3O+n7JmYyBacKTp6DQD3vCZG7kbDOfuO+yDmNoBbLGkjKa4TxEOv
	L9rQfDcXhP+NBU3b6lVAaL8UcNlsnsqLWltcjeZ+1RY1MoRkaer2vThOeK//4l8rGe6OD7L1JPW
	BoXSZbaDTtipQl1QeyEoyxnLNKX95quGhtJk3fgsDMSi4bOuDOGcPlgsDtWmzB6uf//m/Qm+GG3
	d76Ms6OGVB7FTuSnjmcr1k01IDK7j56q10GDH2Pa5yjX0HkSbwSfjZSoTVqta/jyippm/6GiJL9
	VPonCUjQc6xhaXTl7IUwRAc52FuarPMzJvXKZqsKBm9roff/VA61NbdLw=
X-Received: by 2002:a05:6000:2908:b0:43d:a37f:8d5c with SMTP id ffacd0b85a97d-45ea38c6abcmr3068464f8f.17.1779350884569;
        Thu, 21 May 2026 01:08:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa92ca4esm814369f8f.22.2026.05.21.01.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:08:04 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 May 2026 10:08:00 +0200
Subject: [PATCH v4 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-topic-sm8650-ayaneo-pocket-s2-sy7758-v4-1-73c732615e4a@linaro.org>
References: <20260521-topic-sm8650-ayaneo-pocket-s2-sy7758-v4-0-73c732615e4a@linaro.org>
In-Reply-To: <20260521-topic-sm8650-ayaneo-pocket-s2-sy7758-v4-0-73c732615e4a@linaro.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8cCbXbkb6HowjU8II83CA2d+DXwOgvOAWQTPrH5Iibs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDr1hbxFzE0LGxpw+DnlzsdozjsO+qCoWZ0ZTpcTy
 q+M/nAeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCag69YQAKCRB33NvayMhJ0cCzD/
 9P0KBP/zTJ6nGmlwjWlNwROl2dERvX/SFSbXnIEh2rA1eW3NB/XqDkGznJ1xUIeVRX/PUMAwqYtDhZ
 uFwnR3PQ3qdx2nJ1BopB/+0SkUsN1uqay5VJz7hE61ypR+oKJHcgUxPOlMUlFznO7UgvWzc/x97H7R
 01R3o51yWvAygLpWkS1vbypHAEGZU2C/j4AyQT57b0WuL3f4hEDzM7jWMKJzAqwpDg1EZtdDbTgg3H
 boZhlwfW0zRk3SayixjO2+tLbWLXz16sSo0sRPKxF637WkW+tV13pX8mr0LVnt1zfm1J9WCe0ZKl3N
 24tBVKzXLTWpYVHdozTtdMCdAbSGBE4xdcXtHJrmydWLKI1mBh2/yldsY19AzPYykP4fT7tzabROpu
 f4g4e+fBHtgJXMGmgFoW1vQ7A/oVB/MDSX30VRoLwX4zgBCDvC/pbRcvOrnW3o7v1bGgpsu8IqsglZ
 5n42enEgiWXwE6+j/CxviJ8Zj/d1BQgiZKZFDhPZspOb8e9CxMIE222CSBpHnkKbg/p2ZKd8Fwm1HV
 2ZmBmYMlUIi0wrnBmESs6NBv8ATuYDNPknfM6Uzx59DLTVRcCyP2IOVlHNz9MbXo0ChPa5bJSV/wnW
 Z0ntz2XW9wV3yKoKqwGpfyt+hFq84JqYgXZlM0wUzlrIVr6SPHqtcFk5lr1A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Silergy SY7758 6-channel High Efficiency LED Driver
used for backlight brightness control.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/leds/backlight/silergy,sy7758.yaml    | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
new file mode 100644
index 000000000000..80e978d691c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/silergy,sy7758.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silergy SY7758 6-channel High Efficiency LED Driver
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description:
+  Silergy SY7758 is a high efficiency 6-channels LED backlight
+  driver with I2C brightness control.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: silergy,sy7758
+
+  reg:
+    maxItems: 1
+
+  vddio-supply: true
+
+  enable-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - enable-gpios
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
+        backlight@11 {
+            compatible = "silergy,sy7758";
+            reg = <0x11>;
+            vddio-supply = <&bl_vddio>;
+            enable-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
+        };
+    };

-- 
2.34.1

