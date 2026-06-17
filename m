Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822E3BE178
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683250; cv=none; b=tptsTmk0Z7aOE0cBP3ObX77etr2Owuc6GR5ulXVsSdYFjf/uIOMlaDZ1PydWmUa0gN/MlCUtuecdh9+nkr4s790NL3qTtDs1NhPv6mlqWgRkqgeQ062qQFWflH1f8/ASvx+lBA51JAAkuGpNIIaOqDVj7SodbRwhphggqyuz4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683250; c=relaxed/simple;
	bh=+FVn7I0SU+WvGF4zaZR2cSNhgCh5jRVwEclr5YXwXx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IyBzQvepOUyiUV4u5Se+yX6mL1RqaNwZUsg9OBnQ/oJDa7A6PTnS2Lh5V9fHgGlRMhChpLpz+bEQjDubLbmqgWBVok98ioAV126rl1+J0CWxCcAJLidiRBK4CWYiT0a71V/OaNhJOR/IK3kdxTEQmEHSJItsQ+//0B9NM0BqsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2BCbfzs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2BCbfzs"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-beb2a97cc9aso1025545766b.2
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683243; x=1782288043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ii8B/Bl1uGr/K9YKOBOD4s3MlpIX4b4/6A+c69jOwh0=;
        b=S2BCbfzsnmbtPYcJh6ANAIRirdJLnTk3uxafgjhpXm1L3DJje8AHTHqP75lWu+01mj
         er46X3ScZi3EwZRnqB0rtug0SWmbcy6lIOtCu8F84z7egVtiSmYWmH9OLvJlCSQI6lWu
         0qoCfa+1crJf9MAL77eqqMCgarERvEYdWQpryxa9wRdyvxE6joW+0BR6DoMlP6cFTYHc
         q2MXzQeRqFNa7/JEAIBB15NBm0OZAk+gGZ/sGAT8NWbyOurEE+sO6E4OGFM73Lh9q3di
         tNqOHDAVTmcVCHnmIxNZ2hkQ25vxiR29wful4AWLPW5rhmnXGIth9+WScEH+HqR7Ekgu
         fWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683243; x=1782288043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ii8B/Bl1uGr/K9YKOBOD4s3MlpIX4b4/6A+c69jOwh0=;
        b=U647HWL9eKrCJpqWgvdFeV34J4gjyx5192TUAjYbUfEtwV8V4l2ggxBgyi5O92E6cP
         ptwGmpmtYy0Kdp0QaFhZda25dRH4Wp29qyOUPvegXGjW+QKUKkVAgKE//5IEY+EC7JiS
         ZtLclq7h6kE7r/1LqnWcyK44MBTpEirEydRAfcR4hX/ZKzxTJuWnQmFzK+oyadzzH8EU
         fZ2I3+oOdHZXNzQRX5vjP4IBA6fAPSIkRz3CLhK1+iIWgaCIvJ2HZoTui5k+cldBDq2c
         suPvdnwcn4cRh0nS8iZdDSRFsXkXJfuZeLbVUaQZsc9D9LdXxxwH3o8BX8bhoRJEZI5z
         rCEw==
X-Forwarded-Encrypted: i=1; AFNElJ8hjBubjxehHvW+f8NoSwuTQNcFRIP+RvASrMRL9vFWWRHkBZz73twnUcqrrXR0IQgkSU+rnTNVnydBkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkxm9zSmLtFHRETsiYLVSgm0pMMEIKifqQAvFyOsdsJFhjiZm3
	kGh8dPHmCub0CLPnoTf4gNM9mSwBHzdwMBEGD16LPfWi+TPwRK4oKLOG
X-Gm-Gg: Acq92OHzYJ2cfso5Wr8XP1JThUl8BmUH1xZip/DhEFreVqB0SueDdLho5W26l0U1K7g
	lXNEz4Tvdm7BLntMyqZnw9EpMSX3HG3si+mkIujScZCvsGHTA+k8l7f1QxFfoQOTEPoAXcrelxb
	55azTRsHhOfWUKZq3cu1yUvP0lIdu09T4/y6554D5MET/f+TdNZLJPyLKbjgJlku+OD2oWgtPmJ
	xdfmiGUBL8NLF9cD6QbJSCksH4rsS/Pb3Ovj4Je4cccMJyxijd/pHUHTY/dHwmUjb2VFJKCKSWs
	jXX369iKxinH42IEeMixtLMeDTgZSC0zK3jDuqyanyiFXUZBI6GBtas+wQLR15oedUd8FMozms0
	84jifXdKBE+vtygBPpCFZYyPZPPaclJoYz/VzmbBK9D8zKr63iskHBmiGCXY97z+OLNJ4Uo99TG
	M89g==
X-Received: by 2002:a17:907:3d51:b0:bdd:f2c9:80cc with SMTP id a640c23a62f3a-c05a56ffe3cmr186749566b.21.1781683242709;
        Wed, 17 Jun 2026 01:00:42 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:00:42 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v5 01/14] dt-bindings: leds: Document TI LM3533 LED controller
Date: Wed, 17 Jun 2026 11:00:18 +0300
Message-ID: <20260617080031.99156-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617080031.99156-1-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the LM3533 - a complete power source for backlight, keypad and
indicator LEDs in smartphone handsets. The high-voltage inductive boost
converter provides the power for two series LED strings display backlight
and keypad functions.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org> #for light sensor
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backlight
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../leds/backlight/ti,lm3533-backlight.yaml   |  69 +++++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  67 +++++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 169 ++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
new file mode 100644
index 000000000000..a25846e9b375
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/ti,lm3533-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LM3533 high voltage series LED strings
+
+description:
+  This is part of the TI LM3533 MFD device. It represents two high voltage series
+  LED strings for display backlight controlled by the TI LM3533.
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: /schemas/leds/backlight/common.yaml#
+
+properties:
+  compatible:
+    const: ti,lm3533-backlight
+
+  reg:
+    description: Control bank selection (0 = bank A, 1 = bank B).
+    maximum: 1
+
+  led-max-microamp:
+    description: maximum current in uA with a 800 uA step.
+    minimum: 5000
+    maximum: 29800
+    default: 5000
+
+  led-sources:
+    description: |
+      HVLED strings associated with this control bank:
+        0 - HVLED1
+        1 - HVLED2
+    minItems: 1
+    maxItems: 2
+    items:
+      maximum: 1
+
+  ti,pwm-config-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Control Bank PWM Configuration Register mask that allows to configure
+      PWM input in Zones 0-4
+      BIT(0) - PWM Input is enabled
+      BIT(1) - PWM Input is enabled in Zone 0
+      BIT(2) - PWM Input is enabled in Zone 1
+      BIT(3) - PWM Input is enabled in Zone 2
+      BIT(4) - PWM Input is enabled in Zone 3
+      BIT(5) - PWM Input is enabled in Zone 4
+    default: 0
+
+  ti,linear-mapping-mode:
+    description:
+      Enable linear mapping mode. If disabled, then it will use exponential
+      mapping mode in which the ramp up/down appears to have a more uniform
+      transition to the human eye.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+# see ti,lm3533.yaml for an example
diff --git a/Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml b/Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
new file mode 100644
index 000000000000..d8dbefef3323
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/ti,lm3533-leds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LM3533 low voltage control banks for individual LEDs
+
+description:
+  This is part of the TI LM3533 MFD device. It represents four low voltage
+  control banks for individual LEDs provided by the TI LM3533.
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: /schemas/leds/common.yaml#
+
+properties:
+  compatible:
+    const: ti,lm3533-leds
+
+  reg:
+    description:
+      Control bank selection (2 = bank C, 3 = bank D, 4 = bank E, 5 = bank F).
+    minimum: 2
+    maximum: 5
+
+  led-max-microamp:
+    description: maximum current in uA with a 800 uA step.
+    minimum: 5000
+    maximum: 29800
+    default: 5000
+
+  led-sources:
+    description: |
+      LVLED associated with this control bank. May be more than 1 source per bank.
+        0 - LVLED1
+        1 - LVLED2
+        2 - LVLED3
+        3 - LVLED4
+        4 - LVLED5
+    minItems: 1
+    maxItems: 5
+    items:
+      maximum: 4
+
+  ti,pwm-config-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Control Bank PWM Configuration Register mask that allows to configure
+      PWM input in Zones 0-4
+      BIT(0) - PWM Input is enabled
+      BIT(1) - PWM Input is enabled in Zone 0
+      BIT(2) - PWM Input is enabled in Zone 1
+      BIT(3) - PWM Input is enabled in Zone 2
+      BIT(4) - PWM Input is enabled in Zone 3
+      BIT(5) - PWM Input is enabled in Zone 4
+    default: 0
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+# see ti,lm3533.yaml for an example
diff --git a/Documentation/devicetree/bindings/leds/ti,lm3533.yaml b/Documentation/devicetree/bindings/leds/ti,lm3533.yaml
new file mode 100644
index 000000000000..bdc05a9f3d66
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/ti,lm3533.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/ti,lm3533.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LM3533 Complete Lighting Power Solution
+
+description: >
+  The LM3533 is a complete power source for backlight, keypad, and indicator LEDs
+  in smartphone handsets. The high-voltage inductive boost converter provides the
+  power for two high voltage series LED strings for display backlight and four low
+  voltage control banks for individual LEDs. Additionally, LM3533 features an
+  interface for an external light sensor.
+
+  https://www.ti.com/product/LM3533
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+properties:
+  compatible:
+    const: ti,lm3533
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO connected to the HWEN pin.
+    maxItems: 1
+
+  vin-supply:
+    description: Supply connected to the IN line (2.7 V to 5.5 V).
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  ti,boost-ovp-microvolt:
+    description: boost OVP select (16V, 24V, 32V, 40V)
+    enum: [ 16000000, 24000000, 32000000, 40000000 ]
+    default: 16000000
+
+  ti,boost-freq-hz:
+    description: boost frequency select (500KHz or 1MHz)
+    enum: [ 500000, 1000000 ]
+    default: 500000
+
+  light-sensor:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: ti,lm3533-als
+
+      interrupts:
+        maxItems: 1
+
+      ti,resistor-ohms:
+        description:
+          Internal configuration resistor value when light sensor is in
+          Analog Sensor mode and PWM mode is disabled. The expectation is
+          the input is a current from the external analog light sensor and
+          this is used to convert it to a voltage within the target range.
+        minimum: 1575
+        maximum: 200000
+
+      ti,pwm-mode:
+        type: boolean
+        description:
+          Switch for mode in which light sensor interface is running. If
+          this property is set then the light sensor interface is running
+          in PWM mode, internal resistor value is set to high-impedance (0)
+          and ti,resistor-ohms property is ignored.
+
+    required:
+      - compatible
+
+    oneOf:
+      - required:
+          - ti,resistor-ohms
+      - required:
+          - ti,pwm-mode
+
+patternProperties:
+  "^backlight@[01]$":
+    $ref: /schemas/leds/backlight/ti,lm3533-backlight.yaml#
+
+  "^led@[2-5]$":
+    $ref: /schemas/leds/ti,lm3533-leds.yaml#
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@36 {
+            compatible = "ti,lm3533";
+            reg = <0x36>;
+
+            enable-gpios = <&gpio 110 GPIO_ACTIVE_HIGH>;
+            vin-supply = <&vdd_3v3_bat>;
+
+            ti,boost-ovp-microvolt = <24000000>;
+            ti,boost-freq-hz = <500000>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            backlight@0 {
+                compatible = "ti,lm3533-backlight";
+                reg = <0>;
+
+                default-brightness = <113>;
+
+                led-max-microamp = <23400>;
+                led-sources = <0 1>;
+            };
+
+            led@2 {
+                compatible = "ti,lm3533-leds";
+                reg = <2>;
+
+                led-max-microamp = <23400>;
+                led-sources = <0 1>;
+            };
+
+            led@4 {
+                compatible = "ti,lm3533-leds";
+                reg = <4>;
+
+                led-max-microamp = <23400>;
+                led-sources = <2>;
+            };
+
+            led@5 {
+                compatible = "ti,lm3533-leds";
+                reg = <5>;
+
+                led-max-microamp = <23400>;
+                led-sources = <3 4>;
+            };
+
+            light-sensor {
+                compatible = "ti,lm3533-als";
+
+                interrupt-parent = <&gpio>;
+                interrupts = <80 IRQ_TYPE_LEVEL_LOW>;
+
+                ti,pwm-mode;
+            };
+        };
+    };
+...
-- 
2.53.0

