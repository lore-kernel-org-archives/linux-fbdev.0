Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718DD1B415C
	for <linux-fbdev@vger.kernel.org>; Wed, 29 Jan 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148703; cv=none; b=O7lUON5N90OgFNMp3bJhbhndFjkmk1/1qVFguhgPJgeCiIEb34Ds142WiD6tc0PnLR+YtbelfumCW2r6PG2LdcncPci6Pwvcj3+OPs93bzbsJ9Ay/Q8Haepp5o41prQOtJfZ9i6ruFBdmnqAyg1yeNMdsn59qvTTCWF0JmvDjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148703; c=relaxed/simple;
	bh=cnVjGzTMN2TPaWEc4tBzgCPSdtCmJYQ6NezfGmcnYHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHoz3UgB0sJwuW3hXTICsZVJ+CfHP74Sp8HLUjXLP4QoTTurQIMSQZs+fB7OMcuzzGSrp7h+IdcFIajQWt1ktNauLZ2w0GYWxFkv6ZJkf3DupIRFtGpGNReFyE/0yY0KEpZAdiAYhC6peBXd/EIvIsb8HoBF84H0P1kYwglYd6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zkMbT9Wk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zkMbT9Wk"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43626213fffso3558225e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 29 Jan 2025 03:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738148699; x=1738753499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/0RoFqTCD5DMTJ3Smbits6g5SDLM5bAcIh9sicHZS8=;
        b=zkMbT9WkPQks7OCYPjNEeAEyxrDJMvWEzxmT0teydkpJ8Qci57b76k+M06sJW/Q3Xf
         QouadG6ykCFIYvLDclp2n6OH4SDmoWOozWogcQtIU02dUUZDU78WkUV3RNaXMgt/TdrM
         c1Mlb4r4NgAT1UJQWszbDW/aNTG6KdwnDsp5Gk89HVHG5RIXtL5H20mRiJ31Qy6wAkwE
         iFm15YRRXNIgUtXv0JoEu/VgDyDDVjLDbIV/es/1NY8ceJdM7QUsdAzI2QKu0yO/bhMJ
         mcx5xiJqkTf7FdgdwY0vKzPK+fmwrGQdXIrdqpkTgPfRiz/Ko7wFOV6Rm1et0WHag5lR
         2sXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738148699; x=1738753499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/0RoFqTCD5DMTJ3Smbits6g5SDLM5bAcIh9sicHZS8=;
        b=kjg5Kr5i7/TG/bJ/hPIB71FChQftRAx0qX91yOxNC1Nj8mAAjkOXMw2So1U+/6r7XK
         8+FCOs1nWg0Hl2SFMSPvFu35MPa2XaITeM9kJkmA8xBHS4krG9KoiTrYb9rXgVHMDJls
         j35uWC+/fnRf3rNTEzM5VCOU/TcalNfzMKANUlo1N2RVvJr+odJXmD7U+Mbz0S6wirGW
         Mtg97r2F+9MjDzkYNNcu8PKZ/VF7Nwl5xEI2ljLsGHwmFWmliUm67XTmb5j1nyYQ9t7Q
         g7hKY7cCluRQLwLGMxpWlDLTzaG00xoYIby8erSGsVDTkxG8rtsMFA/87u38bng0i8Fs
         Qv5w==
X-Forwarded-Encrypted: i=1; AJvYcCViX5JsE3bKUUn6rD2xg1WKwF4J0vB4zSI1WzcD3vSufmaPpOAoD0Tlo1La6KhobvEegXz8x34OBa8r8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oVJ0uMg73FDSjI9UG7Y2h3sogMesL856mns1FIoPPO5Cdop6
	WJXG+/GivBXfkZ+NgYu4tFZQx/dDsLEd0X2iNRfuyEYVy6R8nqBbQF+ybxUJKRbgmG1zyBS3UYt
	8
X-Gm-Gg: ASbGncvxuS2bqYcyVhF2gpuTMVUeWdIL3w9a1e6y0UcFa5nWJSaNFr/zZV8NS086Wub
	GJ7hDgFapOc010/3p/QJJsw4mjCZWlXcWElMvrkca4zhgMn3eo5r1f/kbsfxP/FptRXHmbEcMhG
	M5HYs4t4KerWN/AtrHeTiOxFf21WvQwGiY0IkJGI5TC5jVJbIQyRPUpU2+AYCD00UHO2N1S5eB5
	prQRZ+/n6ilnVjmco9BI0V2itwGmw+TY1SG4L73eu2shu7QsEqr96CcTL5YGyYHqB45H2rvBkP1
	qoR86i4wZB2cIdnsZhXuo+AcWVICy8xZt5HVzFcB1nKjoOWPHzA56xx2lv0sxDaPQy0hCiA=
X-Google-Smtp-Source: AGHT+IFBn2p+/DJKFxVKospqHngi1hJUPJKLIlntYQuHgPLs/sEFjOQJayjg0+HqA9m/QLDPtJ23iw==
X-Received: by 2002:a05:600c:4f0f:b0:438:a313:cda9 with SMTP id 5b1f17b1804b1-438d599b9a0mr59366575e9.10.1738148699584;
        Wed, 29 Jan 2025 03:04:59 -0800 (PST)
Received: from [127.0.1.1] (host-95-245-235-245.retail.telecomitalia.it. [95.245.235.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d7a7sm17107364f8f.32.2025.01.29.03.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 03:04:58 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 29 Jan 2025 12:03:03 +0100
Subject: [PATCH v3 02/10] dt-bindings: iio: dac: adi-axi-adc: add ad7606
 variant
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-2-c3aec77c0ab7@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
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

From: Guillaume Stols <gstols@baylibre.com>

A new compatible is added to reflect the specialized version of the HDL.
We use the parallel interface to write the ADC's registers, and
accessing this interface requires to use ADI_AXI_REG_CONFIG_RD,
ADI_AXI_REG_CONFIG_WR and ADI_AXI_REG_CONFIG_CTRL in a custom fashion.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   | 70 +++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index e1f450b80db2..4fa82dcf6fc9 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -17,13 +17,23 @@ description: |
   interface for the actual ADC, while this IP core will interface
   to the data-lines of the ADC and handle the streaming of data into
   memory via DMA.
+  In some cases, the AXI ADC interface is used to perform specialized
+  operation to a particular ADC, e.g access the physical bus through
+  specific registers to write ADC registers.
+  In this case, we use a different compatible which indicates the target
+  IP core's name.
+  The following IP is currently supported:
+    - AXI AD7606x: specialized version of the IP core for all the chips from
+      the ad7606 family.
 
   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+  http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
 
 properties:
   compatible:
     enum:
       - adi,axi-adc-10.0.a
+      - adi,axi-ad7606x
 
   reg:
     maxItems: 1
@@ -47,17 +57,48 @@ properties:
   '#io-backend-cells':
     const: 0
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^adc@[0-9a-f]+$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+    additionalProperties: true
+    required:
+      - compatible
+      - reg
+
 required:
   - compatible
   - dmas
   - reg
   - clocks
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: adi,axi-ad7606x
+    then:
+      properties:
+        '#address-cells': false
+        '#size-cells': false
+      patternProperties:
+        "^adc@[0-9a-f]+$": false
+
 additionalProperties: false
 
 examples:
   - |
-    axi-adc@44a00000 {
+    adc@44a00000 {
         compatible = "adi,axi-adc-10.0.a";
         reg = <0x44a00000 0x10000>;
         dmas = <&rx_dma 0>;
@@ -65,4 +106,31 @@ examples:
         clocks = <&axi_clk>;
         #io-backend-cells = <0>;
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    parallel_bus_controller@44a00000 {
+        compatible = "adi,axi-ad7606x";
+        reg = <0x44a00000 0x10000>;
+        dmas = <&rx_dma 0>;
+        dma-names = "rx";
+        clocks = <&ext_clk>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7606b";
+            reg = <0>;
+            pwms = <&axi_pwm_gen 0 0>;
+            pwm-names = "convst1";
+            avcc-supply = <&adc_vref>;
+            vdrive-supply = <&vdd_supply>;
+            reset-gpios = <&gpio0 91 GPIO_ACTIVE_HIGH>;
+            standby-gpios = <&gpio0 90 GPIO_ACTIVE_LOW>;
+            adi,range-gpios = <&gpio0 89 GPIO_ACTIVE_HIGH>;
+            adi,oversampling-ratio-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH
+                            &gpio0 87 GPIO_ACTIVE_HIGH
+                            &gpio0 86 GPIO_ACTIVE_HIGH>;
+            io-backends = <&parallel_bus_controller>;
+        };
+    };
 ...

-- 
2.47.0

