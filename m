Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3931426693
	for <linux-fbdev@vger.kernel.org>; Tue, 28 Apr 2026 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384759; cv=none; b=X1Ih/RSBT0ZuHchvcprl/S9n7WggS/FPg2qsTDfx5AUnyvqBbC4pm2piIp/iBNXfh+p6Mu14ecQlRL+Dbew/+v5YztbMWsNqupL/ilUEF3KfpvJFbkmgDnlE1lC2BJqWPk1HaUUTzgvzriMdCbcu5wclWjTqL05KG5dOss0CHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384759; c=relaxed/simple;
	bh=333uUG2C6Ne2A4QjGhhNw1YJTlVuEP5rcGs1oRWNx80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJ4jUlnV6O8VYvk/YXW1YLcEDIA7DBSSF4sIne5+tkcXdEuD5WGeZmALW5iOizc+O59ROzMw2d8BtHy8dcdLgjGqBRAGP7Dw4VcqlyxEnJ0cu15QA9m+Hrsx48HZZQ3DTQ536rV24OBcLYrTzx7+XGLGIXCnNoJ46ONbg7ZWuZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hebD+Nsx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hebD+Nsx"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so105341945e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Apr 2026 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777384755; x=1777989555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cNFpNsHWTlH2CArmHKw2g8Cqw++ZFKef2xJKHsmC7s=;
        b=hebD+NsxQMe3x9WYsfNKPvB7pEkhKl/mjUCnQRSq1SRkIaTwLomwxvwkyHj5pop1l6
         hmI/0S3+ftmenuPZnxwc6HtOIxLGB6ptjMVAXUK26jYUlWyxw3ytQ0oAwty9+V6KlhhB
         Mr0vhM3WkIg9jMQl+TvQcNP2q1LI7r6/5tslsX+kb1tUm5peq/ZwAU/8+BvR/zRLHdHj
         mBESegebOBj69QDlR7RBfOKW2nItlj8ooDFcdlu6gSxYt1pUYKG4PUM8/bNCGmEE0VNc
         Jv9hQ5d6rpghI3eGUJiGPFPqWg8lzkrQ9oCClqvQKIUh7pKyJEl2EtSGnUIB4WtaVSOi
         tA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777384755; x=1777989555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3cNFpNsHWTlH2CArmHKw2g8Cqw++ZFKef2xJKHsmC7s=;
        b=ZjQZmoX1Kf9fzWlIgU18CxoPzJaVqhgUa77rWhfB10C99mUylJs/8z5HUKcNAub8m2
         Pnbf93llkXhU7gwBJ+2wa/ogxzS6KJVYCIhvnFoj0ky3qDv6Yh6H3+BnFVtIf9LV0icA
         xHHfRCze4oTnbntht3aL05wEiZBba/nKPdfAUSGeqaPm9wwi/QRnDoybpXNJ97KZZBwl
         t3ivV6XthYf7udSpXjHXuWUCww5Iv0R55IgEuRybGp4+vxap3LS+lqqXl9LgJfFhyT/A
         CST/9iDSI+Ykk2BVs5PbvGaIqjmlYxY/KvRIpg+kiW0d8LGQtEttsFm6Pet6LX+4WFmV
         RRFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8v3ne2vt7u2XcVkVhqmrAswS7UQRPq2lo5gptAPpSpRmonv0nuLO/fTnSu2ewGNBl3U3diaaGkqSi+OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqHUMmopof1P19ckBsuBR6YEWKplt8LdS4ij9EKxZQIf3c/PqC
	Ind4gx0LHJxP7FvmbzndnJq45kuYgSw+aAMqfWTon9CkTryas5NTifdHKbBc4uNzClk=
X-Gm-Gg: AeBDietv3dzcD0rNNavEHoDoaDhQucqUexCvc/Qb4YpqZUFPRAFEboTa8RG7ZKHl9l2
	vv6zaNssyRKzHDfJm33vh15/sTF+u/C1AuKYhEi0pZI6F382yzphZPkk3sq08tONlNf4wBmVeGv
	GE/06VJdVyw5ShufhPY6pP1HTWTF3/9FuwXRUlC9l+ZKn4p2vE543TbKXkxbuzbc1iORekkAbR3
	bY6r8j9w2zd1AN6CEN8xCftCXcR+M0N2of1oANtWurXEWKtzMP6j28aWc2Z57AjvlWRSR13WGkh
	KR3xyLMH75u+gGZ6A4SFK9Bk3yKy6a1SVRmbSoVaQ77bmBqdPXrfdiosmzzTYfLhtG3aC5lzNIa
	7UrpYgrEhi+qcXSdq8Bhs9s5pvxGlnQU0KdhSOm33yESe3X0/Yb9emFqO+mUi/04q2PdX+vwf/y
	SbQUWtfEoIEa1iI0ZZ4Gh+YTrAiqtwZ7y1MCJjUOphBce1XeQaJyIVZfQ=
X-Received: by 2002:a05:600c:3507:b0:488:af7f:7707 with SMTP id 5b1f17b1804b1-48a77b1db5emr53077915e9.18.1777384755114;
        Tue, 28 Apr 2026 06:59:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773efe04sm60811155e9.12.2026.04.28.06.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:59:14 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 28 Apr 2026 15:59:11 +0200
Subject: [PATCH 1/2] dt-bindings: regulator: document the SY7758 6-channel
 High Efficiency LED Driver
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-1-0caade5fdb32@linaro.org>
References: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org>
In-Reply-To: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=333uUG2C6Ne2A4QjGhhNw1YJTlVuEP5rcGs1oRWNx80=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp8L0wK6EZCu2c15EL7r3pT23eeIFET1SCFmxKUwzL
 E4ZkWL2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafC9MAAKCRB33NvayMhJ0X21D/
 9uPq2s4LaBUNeHgTZA6TA2qn8iA2HAkkGx+vn4HSGvvBXuk7CMpE6eC7Ib+dhvcNT6oN20/7nMCjiA
 l0iU6+x7sItuA8TueTBzkmSb6typOWrxFSMeEDPj7PPhnJNJOQXrEzVR5So4jaiUz19D9NEq+m2+Er
 ztoTSZNaNxbMAilz6bJXtRkhFTgrM7qsic1ZTLJho3d3LH7P0xWMBP2mY3bgw/7lF+pzhtIhYsEBD3
 9lgMXa9sbqm7UHbXePZ7uBDoYwMGeGK83+VC2SOxcTSgMdP4/1ox2BDC5niOpqayIKnfvB16zN873P
 rRKrjQg3aTnTWnoXG2n6eV0wDc/zowYZJg4BjEt/7scw3FqbDhniHS8QaYenAPcEt6VTwZIH6O7DDl
 zPkaa5NVUncIBKso8yhCRzxagqJ1bK9ju1hexM7qw5e4suNM7WBn5N0qKI3ym7Dgh6RbLU7iiVzhbI
 joVAwGp2Z7vBBMVvjV8FElPbXEuigqAp3e+daggvy6fgj6kc4/dYjatMY/EQaCJ7zlEFFZ7iDBiDU8
 9dI2lLspdfVJDk3XFkvsvI7ed1v7xvFc9Yunj4Lw0YGkBk289oBQO8AHgpV66DBkM1iTTs3S9uo5R6
 mJKYMYxqAgXmRILL0dPfslptoi1Iu6xMlinE9V/wBsEYNn1kbD0i5eT57gmQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Silergy SY7758 6-channel High Efficiency LED Driver
used for backlight brightness control.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/leds/backlight/silergy,sy7758.yaml    | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
new file mode 100644
index 000000000000..dc44b3b502e2
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
+description: |
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

