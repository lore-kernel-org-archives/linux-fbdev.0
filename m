Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED341FE44A
	for <linux-fbdev@vger.kernel.org>; Sun,  9 Nov 2025 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762658579; cv=none; b=Jo3+g7qy2jV/DxFEuzcabB4H+7vRD7n2SFvy+n81pMJw+M4HjwWp16mkvJM9zJhyWGirkR0BbgniqNsxyZ9LeqR42iW+q992O57JIdjMi5KVgDVFHEtApf+b0n9ckc8zXTQ6Hndpg3iildCIk+w/pRG8+m4+SGx6ogrS5T7yry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762658579; c=relaxed/simple;
	bh=vPxJ/by/abaOom4AmLg1ViOmOazh60+nNoiMNG82d74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgIcSbwErkmZ+FXShT34vq2+gP1iyawJAWlhHl1f8JlSjqV+nh+8l0Py5MPgCUDA6iMEAuT/q1Mn5xzcsSK8PgVGShLSRWl6aqaCiGkcGRM9aHCG+aBRNS8+xutnApOR5BVYI0mZuzwGSZ1GmZFS4YKmB3uVl1WfgFSvhSrcmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfddiPDC; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfddiPDC"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-297f35be2ffso6239895ad.2
        for <linux-fbdev@vger.kernel.org>; Sat, 08 Nov 2025 19:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762658577; x=1763263377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6/p/VFD5rODc41UaByBAjykLqoESbzOCT7V1sUMyAw=;
        b=hfddiPDCarXNEqvx+7tfRgkgfELETkr8OyRsosTfj4Ta10Kb5r0pH5+h24qTjspwTU
         1utRdfvoqgcGfTfuBvsxs+hD/JgLxZUn3dqTHcLO0R1kReBQojGSe3+XYSG/zuo0TVrg
         qF8zEvu0tH7i/AZ8Oyb9jwsL7EItUqFUYhSsOpr7sCvy3vmGHuEI6Pb873yaZGIX5pCs
         NyXOWRFRoKhsaafSqAUYFEfF0p98y+4iCVqqepKYmwU6LkyRHdD+MWE/5FQyPTOPyi7c
         gpxJ36a3eAQqU/gNN30WPsuVvw1UWZx2Vhtod1E+lp5Uctm4MmmnGlY0wFWy1juttwVo
         dECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762658577; x=1763263377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y6/p/VFD5rODc41UaByBAjykLqoESbzOCT7V1sUMyAw=;
        b=dlAXovG+c+3SMC3A96OM8kqmll2uB0lTvbKWQU67F89raM1+CiTlRBQ/Wd8Qzoc7TE
         1/BVY/AimIIBbumGCUaK4Ga6VXdvqG27Y6aY3tYIMmMKJiaruueNfzjs7m5b96p+tt2q
         kYfWZlcsD7tW5NF/yc/2CzzT+mBpjpJ4YgACRkCOAQoddEoPDcAIJFXGOHWlGos4daDB
         9QMC/V/+yBAKigNdoODj+c9w71OB2oY/YWljRtI/c41by8iOXDehd76n6vaOjpkqeFNt
         MVzegdarW6pMWCc9ymroeLO9NaisRcNDZpr2dm0kpGhwRQnzHtD4cPEwoenrwS10OwfC
         L+vA==
X-Forwarded-Encrypted: i=1; AJvYcCX7obwH7arwQYUi8+rzvXS52obWlnEIoao3nmA5wyBPH4bjmsYMM+tssgtsJieImm6+C0DZOOTG8vXCHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIrcY791S6HpA05z6vU0JuaJB4xVQN5XewVMZGf3YYlhjo/e4g
	biCCt7P7QkAPcs7k4i9EDZwndb6xuhtTLxCElaCwYIJEzjfJ7+XWsQuk
X-Gm-Gg: ASbGncvlySRS9jrCmN0aloURqgffsCqpk3J8XfhanEcGYLj4nwdobiXzNw4+wUHc/g5
	mw4JjeSmtrucCbGwKVVgcJYi542uxp+a2qdf12iHbg1RJLG1n64bb6+w5CJx/FmFiWZLrL7DrTF
	7l7drrzASCSd4RpxvYJ1bEajr9yVnRIBMbyMFFWiKBeD83dhnmpJ4xYzPhmqmq8QcBD8QM/ObbS
	WdA6tu9D/mQ6gZPaKmqxdc3ESwoB7RMoA2aK0de+nMAWwWJ3w89H5NN+DGyUF3PtwiB4ogmNP9c
	E7e8qzRnetd6dQtVX/UINXWTF6Z1VzaBSv0xWx0EUasaJ5fTnK1ly75kikZzhx+5iMfIzh/XVZr
	6Ia1QWv8NX4z78T6K9Z2nEiRyRNE6AQ0vG4CYMLTDWyItNMA75PaScfe8xKE75fm7cnCHnLghKU
	E2ST8TfVE=
X-Google-Smtp-Source: AGHT+IGjUSrbW6m1DH+9XkPyVh7AhctSYExE5kfh2YwM8eVJ3y2QK60XKY2TAgRvk2wScpvMqkmDcw==
X-Received: by 2002:a17:903:3ba4:b0:295:70bd:b04b with SMTP id d9443c01a7336-297e5708ef8mr48929025ad.55.1762658576771;
        Sat, 08 Nov 2025 19:22:56 -0800 (PST)
Received: from VM-0-14-ubuntu.. ([43.134.26.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509682casm101941215ad.22.2025.11.08.19.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 19:22:56 -0800 (PST)
From: Junjie Cao <caojunjie650@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Junjie Cao <caojunjie650@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: leds: backlight: Add Awinic AW99706 backlight
Date: Sun,  9 Nov 2025 11:22:39 +0800
Message-ID: <20251109032240.3422503-2-caojunjie650@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251109032240.3422503-1-caojunjie650@gmail.com>
References: <20251109032240.3422503-1-caojunjie650@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Awinic AW99706 backlight binding documentation.

Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
---
Changes in v3:
- breaking a long line (Krzysztof)
- rename backlight node (Krzysztof)
- Link to v2: https://lore.kernel.org/linux-leds/20251103110648.878325-2-caojunjie650@gmail.com

Changes in v2:
- use proper units for properties (Krzysztof)
- drop non-fixed properties (Krzysztof)
- add properties(max-brightness, default-brightness) (Krzysztof)
- Link to v1: https://lore.kernel.org/linux-leds/20251026123923.1531727-2-caojunjie650@gmail.com

 .../leds/backlight/awinic,aw99706.yaml        | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml b/Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml
new file mode 100644
index 000000000..f48ce7a34
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/awinic,aw99706.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic AW99706 6-channel WLED Backlight Driver
+
+maintainers:
+  - Junjie Cao <caojunjie650@gmail.com>
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: awinic,aw99706
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO to use to enable/disable the backlight (HWEN pin).
+    maxItems: 1
+
+  awinic,dim-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      Select dimming mode of the device.
+        0 = Bypass mode.
+        1 = DC mode.
+        2 = MIX mode(PWM at low brightness and DC at high brightness).
+        3 = MIX-26k mode(MIX mode with different PWM frequency).
+    enum: [ 0, 1, 2, 3 ]
+    default: 1
+
+  awinic,sw-freq-hz:
+    description: Boost switching frequency in Hz.
+    enum: [ 300000, 400000, 500000, 600000, 660000, 750000, 850000, 1000000,
+            1200000, 1330000, 1500000, 1700000 ]
+    default: 750000
+
+  awinic,sw-ilmt-microamp:
+    description: Switching current limitation in uA.
+    enum: [ 1500000, 2000000, 2500000, 3000000 ]
+    default: 3000000
+
+  awinic,iled-max-microamp:
+    description: Maximum LED current setting in uA.
+    minimum: 5000
+    maximum: 50000
+    multipleOf: 500
+    default: 20000
+
+  awinic,uvlo-thres-microvolt:
+    description: UVLO(Under Voltage Lock Out) in uV.
+    enum: [ 2200000, 5000000 ]
+    default: 2200000
+
+  awinic,ramp-ctl:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      Select ramp control and filter of the device.
+        0 = Fade in/fade out.
+        1 = Light filter.
+        2 = Medium filter.
+        3 = Heavy filter.
+    enum: [ 0, 1, 2, 3 ]
+    default: 2
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
+        backlight@76 {
+            compatible = "awinic,aw99706";
+            reg = <0x76>;
+            enable-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+            default-brightness = <2047>;
+            max-brightness = <4095>;
+            awinic,dim-mode = <1>;
+            awinic,sw-freq-hz = <750000>;
+            awinic,sw-ilmt-microamp = <3000000>;
+            awinic,uvlo-thres-microvolt = <2200000>;
+            awinic,iled-max-microamp = <20000>;
+            awinic,ramp-ctl = <2>;
+        };
+    };
+
+...
-- 
2.51.1.dirty

