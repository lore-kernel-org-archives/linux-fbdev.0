Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AEB3E7BB5
	for <linux-fbdev@vger.kernel.org>; Tue, 19 May 2026 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180230; cv=none; b=DCGqBJpiKtVDVTMM5+amjH4MVWr+i0H95ZlW1dP3Yu+5qsg5ofbtVZ3mchI8NHz4boLwUn1KcmFe2MszSoQPJRA2hL5/m6PEDYcYYqwX7zMIF/xbOX9W+9Dp7qQW3O3+Q5c6s2zLZRv0qyYD3eRgOwfefpu8EIo6xtEdHTLMdxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180230; c=relaxed/simple;
	bh=8cCbXbkb6HowjU8II83CA2d+DXwOgvOAWQTPrH5Iibs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZTlBHErt0sdkhApxAWZ7QQfYjlK8UMqeLY4lFS1SPZSX7T9Wl/fuxfZXE3YTohHtZiv5N3IpgpsaCqKRIoE/IHri3mStPqQ8Lc65ArnVj+OHq+cTVoSqq6hFsQ1kP4PK5wFg+zaz9AAB0hKhmfUVl2lAVbVTvzbnTcvQG4nDrEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QswO8Rwi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QswO8Rwi"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso27540785e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 19 May 2026 01:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779180224; x=1779785024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFOILrRBRgckVtvDGiEi9gDf/W6MgY2gnxmqTdTmRWk=;
        b=QswO8RwiNxHnf+Ko/sHU9mdrH1xZd03JQ2jtagViah/JUdLeUUkHZW5+PKM+Axxw5t
         LsfZRjJOQK7P7CAavirOfUDfpGB2kWrRTZVraeGBj+F5GnLl1xMiXBt0twBjQYmM1ql/
         whDEgOSI6IX3GLIDfLaqm5EmT1Ys3BvEMCIzWRYLE7ROOriYeYBuu9Maqk7ClzDVvPEk
         vluBD/XdkJFx4euTLdJUiSbMc4HoL9P3UVnEqaIxmBFx+/+f0ELz8rEfn4YueTiUEP/T
         upBRC/CnAQ7IA6m2tnVdsbXX6cF4WOKIO2oUIuStt1p8uLkwCJJa8VwecOYM0rxm8ym8
         Icaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779180224; x=1779785024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fFOILrRBRgckVtvDGiEi9gDf/W6MgY2gnxmqTdTmRWk=;
        b=FakYR5tZ+a8H/Bdw0ApAY0nIP0CTAJd0RdRyu8Y5ILA3V2r3SQKRcPGijZj+e14Ofp
         2lCQe7z9BE6MW3q7Lu9qMQPX0HpCIipaFpcyWZa5KbLxF/PGORgpGHPpoV0n+vrOiI3Z
         Onqalc6b5zGrO9GVIBSofl56xiPRg2WFVoeKLDfYsvTfrilG9TIIQnqydYr+4TB7mzGx
         rXFCrvEIRphEeGYksG8rcjpxDydyRWuUi1lmicV50LM8c5drbsz89Zu8J+u0c/X42PWo
         5saOzw+p8FhZp7nbt1y2Dk6iH6Qq/u1gm3eEzxT4TNrHEDqIF3l4qQfk9Bk3gl1snbDH
         A8gg==
X-Forwarded-Encrypted: i=1; AFNElJ94WcvGnTBRUPIq95QaZ5BvsReFpwwKK0cyThJbKEz2OYGX4lYeGSptFNtiiWcfEvsrHk/H+9G0LeGNSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSIyN7httKer3uMkEEunrbZ6cncuOlMw6/Rk+YS2mBUMieFkQu
	JoogUP1kpWZtyhXfZAT2vbtRlqquO+pGzNCQEuDkuik4erv/FY1N8vbE3vmuXR9sFzQ=
X-Gm-Gg: Acq92OG3SAxmDLxNTxOlILErinLWMbG3/Z6mc3YD15UJinWtKbbu/O/3VjwS93Zh9qf
	9IaUlnZlodPD4Hg0jKTFik9QIl6gNeLU+bB+CArxJaekXnP7xMxPCYmZyKzthQrkWCXGm4j4T8c
	FBRy92mTWnnwu0ytXZceOG544mjqRWzhFLi7YF0jufr3qYa74XE0o/99p093ykSXo6Rt7RLYFAp
	2yakYqlyVc+39nUJmrZBsTgmXhOtOc1IZlbFgD/5LtEqlgKnQcQavIqo3VSSx65L9mF7oII7xn6
	8fdjMq0QEjg04QbbLMncc4BQVDNBjrvV5lFPMxBmrIs1zwoixBHCjbUaVAmW9Hceu/NYqH0EY7B
	Aqa81HXg4MKbGUddtEaCkbAXKno4e+nZs3VN71oB8baZ34FEv+oujtCjjUQ9Bldo8I8CnXaosyV
	HmEcRndasKAB8weo0ovKc9OwczdOS2HQIxeUKC58zQ95dX
X-Received: by 2002:a05:600c:8485:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-48fe5fcdec2mr293014265e9.4.1779180223901;
        Tue, 19 May 2026 01:43:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe1a41sm47709855f8f.31.2026.05.19.01.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:43:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 May 2026 10:43:38 +0200
Subject: [PATCH v3 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-1-ec8194bbc885@linaro.org>
References: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
In-Reply-To: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDCK96WwH4hgb3wMp/YLCG0boCUSM8fPKp7kUCNHx
 leNu4Y+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCagwivQAKCRB33NvayMhJ0QArD/
 wNtM06BNVLHlOhCE1L1Qhmq4FyldFL2yOXfAbSOsnHWfnbxsf/NCSW5jx5Mn1yGLM8SYB+oj3Fb1ou
 U0bNBZDCeO6B4P1cI8VhwADxeew7DUQyiqFzuMzzrdgznPwsN4PqmLCXDcHeA0Ue6W3KY5IDYJvgc1
 5ZXU8Z1xY9vK6CXQGnz5FCbonIY5CUsJZWPI6ZdW83trF4lLb5XxC4h3J/xnjpT1Xn/cEvAHgiDfUw
 lsQeAh6cX1APzyzVUWz4esNhKEHkZcKPXrbM67DZpikLNfXbMq2PFodXyiDFf5Wqe2nOb7ZgWVKVym
 yGlgKnKgy1tFeNLrFUKKQpeLiY3x/FooJ8Y3Cc7dDBSe73h+MTWL5lRQnPOtJfMxJ+JwCK4ikJOMOq
 PZ3M0SEpU+IHaxSfo7V7cn0WD3l68dS8dt4S9BSdhbkdTWeFhFFlPpObn5DY4MYOt79OejVmFquhvD
 2iOpSUYFgBjy025KSDSuyL+ankye2q3M/l/PPU2XpvzM2kH9t7zc9wMELyq9XqwfG3WkhsTkPyxg71
 ff8FuNjTVwQH4/YyYmOaH0NX83RS6rHnmdtxpIYje+zu5ah5ea9pvGwtewgmqxIIZxqPg3JUTHn5bn
 RoaSG7rLlGwG5IaeXXCtMMAkWr5Jfy85JvVNmDkjb8VjJmNJJVYwHuXPZ0CA==
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

