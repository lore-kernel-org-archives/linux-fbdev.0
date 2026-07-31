Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B793C3E49CB
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497811; cv=none; b=QmfaGOFNoCG8p1/mOSMHh6jmFWEdQxUd74uGIyxqaFLbRqRbfXgWf/SE8/+UZA8ylhKsXGfIxLWpRkJe4RX6QALyAd3Gb12wqlna9fxuG4CRrjI2jYcTDc52ad2g9wDwksYs5cZ3yE+ILqKKYBV9tYtm1iPyFNaBZFfvKUj/SUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497811; c=relaxed/simple;
	bh=TgwZvkFjSTdTJgaU8gWevJlYHfdDyqZRMlOnH0eNcEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUOCFaHaf++zVW2zmZtoDf8+SICvPihvxmsvqId1Rmrp1QDAUZiSFLZ4NQ074sbDLRdHa0LrHC/j3nalvXCtTl+Kg0/czHdhcE44q9jKYEuFv2ZVwjvDJZgBcv//geTS3l+veZHznrUpPMlJ0B4nxiPKCZjsSF10r31C9jg7v4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFRwYRla; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFRwYRla"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f96c5b722so536835f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 04:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497808; x=1786102608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KxjF07XaiPPK+mbqb4b4lYayj7w9l8UJAtcXf/7KZEk=;
        b=BFRwYRlaWLw7rkyPGzWseHqMHFAFAofwo+2+DcCsGPFJLnAVHdo1vpMLS8yC5zoa+q
         41aI2o3pamxaEDfejZlnEvpkzcpCKBAHnx1JBSIpAEn9ShKpRTgkwwvsmDMoMYZuMLuJ
         Z3rlX+imB70kK0fs/tax4UpXwSRu4HiqseMVkyQLW//aiXBMJqpaEzwuLW+uVZwmou9d
         YO9XkGfXzGNxSnksYMecu+ZuB//VjkVC/qc484ITWRNIqY6sIvOv/cGq4Wja8SIv4Eur
         BK0rJGUIJDgqvT3E6PaqA5VnAPQs1uc6+x1xQKRzFjnBPN8+5ffWruyNJL03eravB4DL
         shzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497808; x=1786102608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KxjF07XaiPPK+mbqb4b4lYayj7w9l8UJAtcXf/7KZEk=;
        b=RxvSYRuT7nqfFBJxkrb/zMSjCRKXdNcPtGpwZr5DdaZigN8NFIBjr3KM9xE7V33jAR
         SfqKyD4v28qnMq7JD77gzr6fd7YiNTSrl7q8+BW7qATQ4jCydWNIzXOCaiqGtNdNbsMj
         KmAenYiB+24DcgPIgKG231XIGg5+x+4L1D5rDdUwS3qWxPWR9XOlyWlW5V85ArtXcFOB
         L5sG1HGE6YW07Y+IGTliZmF8cDIOQ50SRTWG8L4GcIqtuLFVWgZoBe7f2k57ch+OaHMa
         9C+uFsKuQ3Sq3YSwXd/IFzaEuIxEx9ucLms9fTUW2ZmrOyBgz2h4IQYcWWYOuXT7oLBn
         8zNQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHnoxIDuDugWTyQz6O/kt1w6eftmvOxQXM+LgrFMRQ5cvdWnblHXaLpOoM6fzJJHSYTh1ikxpQbZSABA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb7bAJ1ccK3cKq9UfCkVexvBIHnMbL67fjeoRwyxf3CFXDtEhd
	sL5BEXwoCyZV+57Cxk0rwCHsLmRT9YUzuBTbxPQ/PIroV0iDjcfwz+Fp
X-Gm-Gg: AR+sD13Yv9jVLnjczYj01ewNiI9JX/29zFo3sSfqh7b1wuyvkeWHS46y+XUi5XiQ4UZ
	3shwMjDTE+eMjs92rTY7mGD9OHZbLU9ZXvU2hjq86VM7cpLLD5CN2Z/aBdIUWV4o/6+85ZV9ywe
	uQQ0NJIf4Y0vgdO8euXgNtwb2iI3w5+XiUebVurpB3/u4W+GkZxnN/HaWG6Z41cPuIE4VXumCZd
	Bgi6dTLOTcw8xWzeseeFIrq50BE3gwzSJ3fZIlhpt59G+A211sWiq613iafOt3gB4uX+Q7at1uz
	oF7jtbPty2r54EUaXueqOGn7Jt9wmykR5sqynnIPXspqI5i11wqmlEleg2dwy6fjrxW1ppFc03J
	cLGdRk8T/Ujzz52A4d8n765XcXZ0MQ0Q4Z/cqMHIJ+p8vY2gOJ/U4Mk44iXxi62Q9fnDrECz+t6
	OIiYaqgb1r8OHAwr6V2TNIc2vl8tF7Yepizh24OSWuc5Q0Xp3gcRnZ+4uOYJ2vmpbiG8fqRxi7j
	0bqAWfkOg==
X-Received: by 2002:a5d:6e04:0:b0:47f:8465:2712 with SMTP id ffacd0b85a97d-47fd2b7189bmr2707405f8f.56.1785497807849;
        Fri, 31 Jul 2026 04:36:47 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:36:46 -0700 (PDT)
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
	mfd@lists.linux.dev,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v6 01/14] dt-bindings: leds: Document TI LM3533 LED controller
Date: Fri, 31 Jul 2026 14:36:19 +0300
Message-ID: <20260731113632.158440-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
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
index 0000000000000..a25846e9b3752
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
index 0000000000000..d8dbefef3323e
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
index 0000000000000..bdc05a9f3d663
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

