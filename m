Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490C3EA960
	for <linux-fbdev@vger.kernel.org>; Tue,  4 Aug 2026 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876986; cv=none; b=UfbWjZjXfZfF78WmGgV7sYc/tTFU9x+cjQY0GxbLJ06DtHhGuPw0ztI/gKNTVDotr3AiOJXxRvMoSpE5PqvWjojXMRcsvVHhOI1H1EuQV6Xdf73M/jrbCJen7Wp38OwcnYLKdgM3gpYvn/t0vyN6U8DUtaHZ+hzsNqHzsa4oFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876986; c=relaxed/simple;
	bh=ejJKKlrYGwvN9qLYU2KaaWwD3fSRaEkfSRQt+Gx4QQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eI8/EPGlbdsJ6k8YVa97dgD4Yu6Cez3WsoNK9H7IC4b1ln8axWFgEYJfn8/bVT49kc9XUkej9cFg09lwqO9GB6ThFIQcWuDvYLVntyXz5ZAgr7y6XZj3o3b9KZVq+ffvQnYuwchh+ATAw036mKn8tP0YeoP8fliVMyPedOXX9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EV+lMMqi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV+lMMqi"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so2322445e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Aug 2026 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785876983; x=1786481783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FsSyzNurkU2AZCAgXzFDhA+4Szt1QyFprpuh+Ygbe6g=;
        b=EV+lMMqi43j3dOA2ThaWHAyvtxmWuHDbi/yiD9bCIaoOllDS4xOICsEcYSswj6Y7FQ
         OtMmhLsKmfGEjktM+qoPDzyckK5rO4Fzoqi/JlJuDWGcA/1ZvuQNvhppMHVylq17e/eS
         +4mILgWElzPtxFWYrBOeiPbMKYHAWE5EbDjymfnW2bdqodpo8VtvjM02QlI7V3fFCmNy
         pd04yHZbnO7dPGxTxLdDFkh7hucKmWpmibv/lVB36e2/V9vHur7wYOmKR3Bd1B+buRwz
         PaCAWL2Y8UC4uHyfQNNotCJ7usJGeFbJMloZ3SS36v7MWTaz3Kq70p5cwnmiEEaHZ+cY
         tC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876983; x=1786481783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FsSyzNurkU2AZCAgXzFDhA+4Szt1QyFprpuh+Ygbe6g=;
        b=LP6BRUhmLqouSv8gtV17gn/OO8HOZmvTZiQRwdf48GYHdQ+vEv+KNEhdbwGhW6iAFX
         vSm2h58LPUwmOu+yNVYJyggkpR6Day8Ib//Ra1xWh2ECLfDTEbOj2OnI4v6NPW58FG2I
         Qc9S2QYENgyzXJDw0vWvZbCrd9ELpSRh9zLVmiCBGzcKbB3dszno8CnnSA2oFg0gAKHQ
         i9syBvVfPkRvx3IzFIlCOuOXH/bYshChhwavhnpMwGXGzoUvjKwIALNhwRu5cQQlkVjT
         AIrka92oVTmNKiylWcej/nwrHH2UfTnkuQDCzAW3praiJbIIqjAQzFVS0Q94q5pysplC
         P9NA==
X-Forwarded-Encrypted: i=1; AHgh+RrgyMzVBAqUSZrAc3uUz8WMkKJGlROfSk58Uj0uuhH8BItnbj9knxDndrcR/BUrfXIopERcsMkFgQ9mqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJWfqzFAxFtploVIyYuDFLfMvmRBpAtGOD1ZS29e9naeKqepZ
	wuUbhfVnb4qhPJ7BvxOu3mh1Xl1nUa1M1AqXYSm5EGgjP7DARdMTjQQ7
X-Gm-Gg: AR+sD12NZAxIW+JqFnNH0P42VNqkjYQ0Shd9xURW5uG6vcVen0ht+tYiuI53uZYeohV
	CTJ37oF+eDq7gglwjvXDSqzl0b7LSn4Ud68TmnBTOoIxaXZ0qFMeB3sgDeidFBlG/zIHnXnSKFP
	yMZnquIT2gLFnyzGcmf2jVhJE5xOoBbIdnDLWiB04SDhwtBLgpbIyJebHbRpI6JEl3xgJO6BwvD
	H0bLCg87Mfdcy5Bm3y9H5lowtWVwfQO1yv9hhSwK4RtpMPa03y45KA0mpJ7TxZp0vEpD8S1thcB
	FsaFS9WWu7p07ISUIlMGpFgAbtV9zl1w2SJKlnWCO6uoEbYNLZrEXvhLa1cIYTGAWPFowcZJrS9
	QYoesIGgaDQ66LrJkiH7aSGZzPOFe3NsLkPqU8+iLmulkqChZHQ9K7p/KucxqJUc6j2wPDQHXS0
	4lry0hGvnbtmeCUeV9BCkn/7VBV/vDIeELjmdKkt57O4ypMz3D66ER7OAM4gXMJ7sHQxjpocMnV
	sOdhiQkIOqzDmqeY8MH93yihw==
X-Received: by 2002:a05:600c:4e94:b0:497:ff73:68d5 with SMTP id 5b1f17b1804b1-4994e6c5eafmr12299005e9.0.1785876983257;
        Tue, 04 Aug 2026 13:56:23 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.176.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf820sm12070645e9.0.2026.08.04.13.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:56:22 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v2 1/6] dt-bindings: display: add a device tree supplied boot logo
Date: Wed,  5 Aug 2026 00:56:12 +0200
Message-Id: <20260804225617.264861-2-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260804225617.264861-1-maximpedraza@gmail.com>
References: <20260804225617.264861-1-maximpedraza@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embedded products frequently need a product specific boot logo. Today the
only way to get one is to replace one of the logo_*_clut224.ppm files in
the kernel source tree, which bakes the image into the kernel image: a
change of branding, or a second product sharing the same board support,
requires a separate kernel build.

Add a binding for a "linux,boot-logo-clut224" node, which carries the logo
in the same paletted format the built-in CLUT224 logos already use, plus a
few optional properties describing where on the screen it is drawn.

The palette size is derived from the length of the "clut" property rather
than spelled out separately, and "data" holds plain palette indices; the
32 entry offset the frame buffer layer reserves for the console is an
implementation detail and is applied by the kernel, not by the binding.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 .../display/linux,boot-logo-clut224.yaml      | 131 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml

diff --git a/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
new file mode 100644
index 000000000..a6a206964
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/linux,boot-logo-clut224.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Boot logo supplied by the device tree
+
+maintainers:
+  - Max Pedraza <maximpedraza@gmail.com>
+
+description: |
+  Embedded systems commonly need a product specific boot logo. Today that
+  means pointing CONFIG_LOGO_LINUX_CLUT224_FILE at a different image, which
+  bakes it into the kernel image: changing the logo means building and
+  deploying a new kernel.
+
+  This node lets the boot logo be described by the device tree instead, so that
+  a single kernel image can serve several products, or several revisions of the
+  same product, that only differ in branding.
+
+  Since a logo is configuration rather than a description of the hardware, the
+  node lives under /chosen, next to the other things firmware hands to the
+  operating system. Open Firmware, which the device tree descends from, carried
+  a boot logo in the same spirit as the oem-logo variable under /options.
+
+  The image is stored in the same paletted format the in-kernel CLUT224 logos
+  use: a palette of at most 224 RGB entries plus one palette index per pixel.
+
+properties:
+  compatible:
+    const: linux,boot-logo-clut224
+
+  width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Logo width in pixels.
+    minimum: 1
+    maximum: 65535
+
+  height:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Logo height in pixels.
+    minimum: 1
+    maximum: 65535
+
+  clut:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description:
+      Colour lookup table, as consecutive red, green and blue bytes per entry.
+      The number of entries is derived from the property length and must not
+      exceed 224.
+    minItems: 3
+    maxItems: 672
+
+  data:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description:
+      One byte per pixel, left to right and top to bottom, each byte being an
+      index into the colour lookup table. The property length must be equal to
+      width multiplied by height.
+
+  logo-position:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      X and Y coordinates, in pixels, of the top left corner of the logo.
+      Defaults to the top left corner of the screen.
+    items:
+      - description: X coordinate
+      - description: Y coordinate
+
+  logo-offset:
+    $ref: /schemas/types.yaml#/definitions/int32-array
+    description:
+      X and Y displacement, in pixels, applied after the logo has been placed.
+      Mostly useful together with logo-centered.
+    items:
+      - description: X displacement
+      - description: Y displacement
+
+  logo-centered:
+    type: boolean
+    description:
+      Centre the logo on the screen, overriding logo-position.
+
+  logo-rotation:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Rotation applied to the logo before it is drawn.
+    enum: [none, cw, ccw, ud]
+    default: none
+
+required:
+  - compatible
+  - width
+  - height
+  - clut
+  - data
+
+# The image either lives in the device tree or in a reserved memory region,
+# never both.
+oneOf:
+  - required:
+      - width
+      - height
+      - clut
+      - data
+  - required:
+      - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    // A 4x2 logo using three colours, centred on the screen.
+    / {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        chosen {
+            logo {
+                compatible = "linux,boot-logo-clut224";
+                width = <4>;
+                height = <2>;
+                clut = /bits/ 8 <0xff 0x00 0x00
+                                 0x00 0xff 0x00
+                                 0x00 0x00 0xff>;
+                data = /bits/ 8 <0x00 0x01 0x01 0x00
+                                 0x02 0x00 0x00 0x02>;
+                logo-centered;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5114e6db7..8cf5163b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10269,6 +10269,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
+F:	Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
 F:	Documentation/fb/
 F:	drivers/video/
 F:	include/linux/fb.h
-- 
2.39.5

