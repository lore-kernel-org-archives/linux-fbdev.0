Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19A39B486
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082596; cv=none; b=s3+AbWFWmknynVc98URu8E2jF4Tb7/4Mdg/xB7AV7qQ/LsV2pnU/xe923KYl4zWSGUeHf+w0vMT3KCB5UvCq89l/PyPpaNZu/NqodyL+uEYQIbqKRHUPNajT4XSEUZYboBA62Cunna6vqz8EW0WR1LM0vlplBVptMlEOqOBz2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082596; c=relaxed/simple;
	bh=1lKQMpd6PjiypUs8OsPV66H2sccTnVhP4zdDuQTSTj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b5ZOySNa9wvGV52xFWo/pdA/mkpRx346OE4gCH8jxYlwEU2pkmTwYnKmn1B5IOT5z+M8d7Yt1dVVA6x0gnP5TPFreQK+2s0/ELo52pg0dpe0VApXvyk3SHfK2/cfsFNkbIvKgNhsJMpJcR5Ex5OS1iEK591F/TcI3SEmbfipmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f8mBNurh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8mBNurh"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so147719005e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 12:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780082594; x=1780687394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SY/pjFoVkR+l6EebkjB4dxdDrLLE9cCLnfyxSl7hmkg=;
        b=f8mBNurhZtCOdMOAUK20Ep8+l5bZaGig9m+PZX4B4+BSRxIfsJMB/gVAEZGcbge0zR
         MWLmpDBWzRRpGMas3vxqkaWoYaxRifKOMRqJqI1Ugqy5MUdcmzDR7AdrDCk8+LQN3ji4
         xclGGUWnfAdV0LBuqSPYlWuNx3rJOcIovZAOfgnuxL+KBrHBo4oLZSAClujUL4pN4UD3
         vJ6TTes+uBXZTN+TQYitRqQv+fTRDdAurYuleOSn2CDI22GS2Wh544NqhGlVASczOuDy
         VOUOlkML7Ly5RbvmI9gGHXSMC1uSa99hDb5YmNsfCgJrS2AurQ5cGR3ZJZpDWWt54veW
         42mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780082594; x=1780687394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SY/pjFoVkR+l6EebkjB4dxdDrLLE9cCLnfyxSl7hmkg=;
        b=BHLr1ejHcRmJ66EJivADSXo9ji2YV4e1yBVWyqv8SJDJfHukc1fLsX5eNxIU5HZ2ta
         OWYR3Q7QayX+ozh1HlKBMYLiJlQvom2zrGuXDK8+4SI4LVf5mBbqmC2nD82Ls/8BEYYL
         accI9R/oRRJeB1HDGRPNcNzNxtzqDx0HmsX49b3QAnNSgyMynclsvTwub62e9q0VEvqD
         a2m3Ve+SHXHItby6IDzlIEa+XPn+kjF/2+NYbucbgqZF7teX5yW1/lHlKR1PUD7JuUbo
         ULH7kVyyWQy8pgF2G60XLB7XrKsh2sSgBfY8lCQI9YLr5Z3so8UjO6KSwz/sGwk0uZfp
         JRug==
X-Forwarded-Encrypted: i=1; AFNElJ/miyg6E/msbvxQWFy+hFqyuAUdLn/tMRj+/ShXIFbMnuww0dwC45wGBHrE1+605VsuMenM/irRk64XNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUtLDhi2g026wYcPFKyKPv1QizZ8Y1S9YGqn1o+l/pFAU3saZ1
	Eqd+/mYuKbiGHSuJcnkxNZECpYTUUGA4aHsMrPHziId/6ulcfx9CsAFeXqV5Ibq71iA=
X-Gm-Gg: Acq92OE3YBXnqFpGvThrU2eQOyY8n1GMciOW1RSKWo3dwGujDj+nuCg8oNqCZk9T5Tt
	Q9epepLfuWbvjp2VCrSKj62osuTPOTwywvjPZXn1SS2bwkM3MwBjfBDyzqY6Wv69aAmpRCxg9rB
	6iP+mhNEEKzGi5ss/ocsvGn9VE15Qa0Wa5NsWfZ7+JJYLMv93bg645chWQTymA0lK2aZEfkybh1
	jxOnm9U8ySwoeJR5lKQ9DNQnxxPEJdJnOEKK1OiGTQTqgrsYhIailc61aFhDpr8YPfTqBRReX1F
	TgDR1m9VS+ZjWkNna9xVFq4gwLIvCPdQ1471rfhziVfWyYek93cfM67rgb3Mi+43nIA9tO3l8WR
	+nBENd4WPDeXm1VRtGpNEZL5CHT0eE0X1kZaiVHFQYU2myOIytkqnDMTghUaX9EfLEEpOl622RG
	q1sONMelYKq87aMb9bG6kqA4QMdciEeyl5mXV3+sHMfq25/zy8nd+36oE=
X-Received: by 2002:a05:600c:1d11:b0:48e:8741:fd42 with SMTP id 5b1f17b1804b1-490a291fa6fmr16006735e9.12.1780082593552;
        Fri, 29 May 2026 12:23:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm28692545e9.9.2026.05.29.12.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 12:23:12 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 29 May 2026 21:23:08 +0200
Subject: [PATCH v5 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-1-03aacd49747c@linaro.org>
References: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-0-03aacd49747c@linaro.org>
In-Reply-To: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-0-03aacd49747c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1lKQMpd6PjiypUs8OsPV66H2sccTnVhP4zdDuQTSTj8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqGeed1GduH+zhZEZfWhRDG5HUSICoERZsYkY7py4I
 4iauz6uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCahnnnQAKCRB33NvayMhJ0Ux2EA
 C2/rldx7AzNQpSI6oGa6TVKXBueQo7tV06QD4RVu5M7Wh9MF24Se+5JfvyF7UoQJTxxgQK+NtrjfcH
 1FCcYQ2fse8Y/gwVjrPhqu2zJt8Svau12tMdhq5moU2Wd6A3q7O9/NsQYyTNeupEHACebcsaF+YVUY
 gRbQOQUChV30r625YZQwO0pmJ6cBuF78+RkhMtCl7faQTPyKCysz7aZ0DuJBL5fAnfCy+uZDMIGBDV
 HLFFfwK/Y1WSzyYKpJcIgHRmRORYu9LFnFfxaL0hX671eaYbdwBuliSY1yupcFsHV5YEfbc8QZlnU7
 3XI5T6PCmGepKbP0dnsYHoEepvwO/6yOCRHGJWvHYsJTIhIvrtLdF62NVhla/THvFfe5aPu76SYRF/
 ghUz8m3kj/x6AAYEX6jJiwtYBqo91LvdW6YUq9Nze32GU1NIn87YEU/+ZXTqV4QBqGsrmtpAXOm2Rx
 lbsmgfBsQk2tort4Mb/VIfcxfp7/P6ZMeNhfOs5qHhvDAOdvco2UyhzBw90OyHEB/sFkphVKFeQIsh
 XPYf+aLToFFnJyYxDNSmSlxFP/1JYf/YJuXmGkN8Hm3oCEh+7lpe5ywqNl9vGqSRu44ufXoGQwaba0
 ZfYx3+mr/DiaIMm7DGAM2nXygeDCW3eI1c7gbrn7ulkckq9f2RptCQwwCkng==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Silergy SY7758 6-channel High Efficiency LED Driver
used for backlight brightness control.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/leds/backlight/silergy,sy7758.yaml    | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
new file mode 100644
index 000000000000..64af6b34641a
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
@@ -0,0 +1,52 @@
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
+  vdd-supply: true
+
+  enable-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
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
+            vdd-supply = <&bl_vdd>;
+            enable-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
+        };
+    };

-- 
2.34.1

