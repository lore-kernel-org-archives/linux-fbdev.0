Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A57A40245D
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Apr 2026 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542446; cv=none; b=nIflc5LDE4WE2I1ZY1Q32mSAKDipcwKz4DO6bH1+dp5JZeEtOBnWbZvkKzEWf2j6c0BqbHssC+yHTKZfkA2Vph6IdVWwHWCmX0dhZsPG8YI+Fh0FHwz9wWEBRLteY2u1z+L8bU9E1QsOvLMgc+DkDnnB8nPy90xqAglSAUS/Gc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542446; c=relaxed/simple;
	bh=8cCbXbkb6HowjU8II83CA2d+DXwOgvOAWQTPrH5Iibs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5/kNoP6Gy6U6NtQRalAYLw+7YQgvKvdEGN9fQ2Ig6v4S88/vTvUAslaD96lz0cSSFd9itwk/nW2D1pNywrm571Ru8CXRik3tq4oupjjM0dL3bDLNB9g7Tqh51LX8yqHt4UrWDB5ZT6v5+gQIBBTCe6Dm4yCPP4buk52Pwptlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eexJNnp/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eexJNnp/"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891cd41959so6469325e9.3
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Apr 2026 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777542443; x=1778147243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFOILrRBRgckVtvDGiEi9gDf/W6MgY2gnxmqTdTmRWk=;
        b=eexJNnp/sIsC/fFZAoNHQobm+uaOSGYKSo0LeSjN3Yj0WNu5kLsD3rMeQwJ8t/N3Qz
         n2sVFDQ0WSZUIesK+vKyO672DN3GIwqNKwGY4v4R0rCOam3T+K1UgyXT6wppn+gBx47T
         +tXuQAipixDw53xTKHWCFuCu8T6sEJgRqKt+uzFRvr0Hfbp1x6nlRyXkI+Q2p+tHsaMa
         A0TRob2QnUpgkiINyoKZKVVlgPqQGCU8rnGhKnhq4r8yYPUnGquXG3RlGAo6mq71qu8K
         wwTE1LNLZ6L72sWQrhejI5QxhxQDENtpq25gSiyO9okuH0KXbc00QyEeZdJJFC6iKnBw
         FGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777542443; x=1778147243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fFOILrRBRgckVtvDGiEi9gDf/W6MgY2gnxmqTdTmRWk=;
        b=mj9iYMCp7Zdb1VESwKUiKDHrmHgAIB3rlvMrsOEYiUsIrJg4bketOnFrfTjHE8hrb/
         Buaza++NLxs4NOacngXhMEX/8thklv/3h1y7wQZrN0vRmc0d3Q2d3GPyNv6Ya//aRgkm
         qOP8t6ZhHutVN823jRU8t3G1dZPDC4dn2XMbYOppBHnzDaqIz+2OhAweIPOE0CBkc6m+
         gjLv8/X5hHKjBXdfdcXPwkB09AEGT3SxMCqHVBadXB3mMO6cMaAVkw+XbQZdyZviSK/D
         Qb8N0IeNdF7yRUvSAbaa5t6B5hqwzorCNHJs01eooWxRgI64CPTyFEvfgxNkNSyw2Fc3
         hsyg==
X-Forwarded-Encrypted: i=1; AFNElJ/+aQnwXDTbMArMvB6a15ZYM8GknEj2f5SjjIIDj+0mcnmiFk9ax7+djYPU72tKGJ+3HnG3DFw/e/mrFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZ7kS7nRw+OWApMaIfYsBjX7gME5Nnt/XIeDuACKUzBwITTqV
	3SnJn+KI4gflm6Mk4Yl5Ts8I/7CWkx7byAXfGq/ct/ztGbaExsbYlkjT76PsDGStQ1A=
X-Gm-Gg: AeBDieuDe2cIhojcdv08zIoR9DX1A+Ag5I4xFFfm601kz3nE505UrAPaepricx/Qlip
	5cEbHXrAFd/CyuOOBo/MSCZqIcAMy3/qOniv7eOETMJRJcFH7unor8bvgqOo+FWRSbTdXlYrqBg
	IdrThBGIdIZodGZo/Av1JgKGEhVhftozNkuzvQX7x/KTCpGgc1q1t5LYHANvpB20VQ2LLWBuitk
	uYHvsXKEsJ+2t/7L9ObAvdw89p8d49cKq4+8cNw8KknKKRKoXEqwKBsKXnjGi37jMkircSbftoK
	o9XnxOqeNT31pDZmbb8O2fNiPIifIIfTi09Zq3Vd6YP0zkaEIA/QapIv+586Sk7YNyWvQkFhIM5
	yHVLm1usbwdToMptmywp/KSXuzzrXuQfqkr2eMZoiW7ESkWzUNcjKEAwwzNRZE6rSxFidiDNa91
	GbXcaoXbEurtWaDsgeILraSgg2Z7W5c4KOmnzR7I3hEVLGz9vZTihwerg=
X-Received: by 2002:a05:600c:1d1a:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48a84458d16mr38530725e9.21.1777542442688;
        Thu, 30 Apr 2026 02:47:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81b9493bsm48984745e9.0.2026.04.30.02.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 02:47:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 30 Apr 2026 11:47:15 +0200
Subject: [PATCH v2 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-1-308140640de9@linaro.org>
References: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org>
In-Reply-To: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp8yUnzS9s/rNYIg4dn9FI8VZvUMuIuqoBd+WZtYZI
 QPZ3Z6eJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafMlJwAKCRB33NvayMhJ0eVOD/
 4iGxCE+8I/QFYrllxJKnhUZFHl8HMTtdxoFG7PFzk+6AybCIPeTgtXhV628A+jBtobbwOmpa8lYmTw
 bw5tb0FkOZw/kL6p6ukGxjwco5q5ugX0hz9/FynTkud8ZA9audIzPz71rbv12BYNHSWZ99usLzVm7K
 DGQhfdRnczkmhK9O87HOO/dLd4rk/t6PRwYcy9WIKUawl11vZnvxePmBid56ePdc/JvP5+21nv+QtQ
 b9cH7qagTCEqGjMzbJKXMISqn4yYYQUvVww4UDmuUleN03Fe6F/4xzKK987/Z9+/8fbl2ZG+I39RB6
 wnwXNWQ+jDAU4r7Hv46jh2eriog2NLULu1KmbV5vtc87au1OYzUKjxcRmOPoVZgE8roCwI5apcZQri
 uC709c3kvzNVFIhLHnRomoTHAleHemKFNJobfAOaj0JGZE2FERK443MmcB20oKSNcl4EE8pV7wDpq5
 R9xYgmrskFChg35b6q0CygN7e1AA6Zn0Mnwd8b0NH251vrv8FZFIdMz3jCyUWkN+EtzHKXELoo7Uz6
 9mporJIAv7Sk8deTPHunmWbKkkdfUfFcunUPy3gdhcfFm4cqZhyAXV6oHB0Dra3jIhQqFf1fVK15QQ
 y4bGSD4xh54d5p5ngNo55iIK0Pr9Wao00VF+bLK4PUxzFnWYVVQjXKAxlDfg==
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

