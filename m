Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA135331EBA
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534650; cv=none; b=NzUv4/HeKnkRBLljMVvBpBesW33zrAKqPno39zjH/2znc+v5ZhgVjfX5KIIinQ7uRdYOQ9Owty6e7ySp8HHOS59+NrlChGt3qQPgbKv7PLSUdlb2LTfNxFFAyiUrK/ecbIHJzpXrvJev7VTgqVnQN+kiQul2arAlh2W49LOnPK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534650; c=relaxed/simple;
	bh=ZLAM9BbgNPYw/mC8BH1vW2Quj4ZGWesTFdSgyL5Rgpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4H5V3CFoj7R4vxqUGt79+jCEC1FiBd90p7s3V9bxINhbkfj0zF+fL2d3238K/zbnz4LO+xZBT2NBwfwT2ADQv+fLofgsp4RQxFCDW4nlbx1fEvHG8HH3baAEYpNfxj/T10vNDb5s+oJhedpDUdqxRS/X6CEnwvsiueWXcL4dF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWWO20uI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWWO20uI"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f84023916so1557666f8f.3
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785534647; x=1786139447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ne8gXxsmxHvirJEKTA6WZrzb+m1RGc3+hgsbJk4xAkg=;
        b=QWWO20uIGmnoQE0eRWMAbH9X/TdGiIY6+A8MxrjXLEgBzqMQpUlDlGqK8265FpnzCg
         OFtscShnRcfyeW/WXQTalwbLorb5b8xhTx9yDZ7vmPmL5pJgC23j4vGJRtUPbQkgjOL+
         7in7eidEbpf9y4yv68KCANz70AB8fCOx7TXtDhDyLQwgMoslOLT3CmRXlMmligW+B3q9
         wXsLvlGaujexpmDMvUNITaGIlTQW2lwTp8wrbZ70ahKL2Qvrg1LayTCJa8ameiwRAh6T
         hM3HZC/CaTr3OSV3Og1BTnsz4WhLX+Wzi9OPcU4dd1mnnPf4jcciBRdDQil1C9/qzWt0
         QccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534647; x=1786139447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ne8gXxsmxHvirJEKTA6WZrzb+m1RGc3+hgsbJk4xAkg=;
        b=LNqrd3NKLni7MjeEMBoXQjvjk3TfPrgweSPDuCEDtHRjOLsUgMBYDrdQ/lZF6b/xGY
         oMMkOqpBxgZEIQbc/YZmJXXyCrRaOTwN5mhQpdFxRmmu9/8usYnR4ppP1ucKoZ/s4Bga
         UBXv1U9n9ttis09ZNPV0lUCdyP3sAVR+Q9st3C1u7QxSYtCZBjnOKUGmaQjvtVSoAt0F
         fFFXNiPuR1C95DbM6t/qzVugtKeGs3lviNePpTpVuPCdmlR1ayfvDLHMF3U1ByauyX63
         LheaTKcQOgMNdVbs3EihrGljqGOYGH9n9gZJYIJRYtjL73qEX+3QVReqCOqL6RSOcaFT
         Mi4A==
X-Forwarded-Encrypted: i=1; AHgh+Rr374836rHknji2OEsD9MGR1Ws3zpWZlVJLjrzVQp3sebyfUTxU6a8iOmpNXwlNwnaahgcXQMjRkxPgjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMqu+vhKhfoL40P6iJllo4f+YP+So7rxRDxIzu0GzyNiAwh2G
	Non4WRiUSdvqSZbG05SOddKHuSSf2pntpOlLWLq4q5IFRR84RE40uLIt
X-Gm-Gg: AR+sD13lNa/h+Nh0YugbMxrK6zYB81DOgLkWR3DX5iGM10B62f8EA1hKy6c+8DiONhN
	zGOnJ7gen5WKhiYlN8VNQNL+Kc3MoHPrW+B9RFEZ9tylTTbl8pKHKXzqoNqrEbSFEljGqFjIQM6
	9MkohRu48uHDNrboxUeP/nkgJoB6RowGINl2X2OxncW3kFbkloNtKMIxQb9ez8nnANVemVped74
	1UQy0aqRd252AEjVY2Ms58HRRVXgfu/ozrvdTktmEsNRkHdKBB8dHmbRr05fXJQB/LO8mN2aAzd
	zOp0wuf9lFh1wMraWcKw/AjIkJBRf+JnI5Gq2njpm+zBsGAK8FqK1azefEOheC+fOdH3YZoJD0V
	c2MlcsaB4GFsLHveTCAe7nROtE+goUu8k2+v7GwNwuqDFJwJu1zYs4I8T/KGZZcxY/5ZF4EorqN
	lTgHMEHK+cSD72wTROQUpD5hzXu4gf9FHBS5IhsKHfcWs5+9UmDlBagkNv0X9JCzScCiI/Asajy
	1YvV4aCBDjtJSjHe9tneRtkAA==
X-Received: by 2002:a05:6000:607:b0:475:f0d1:eb63 with SMTP id ffacd0b85a97d-47fd7320f88mr2386045f8f.48.1785534646973;
        Fri, 31 Jul 2026 14:50:46 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.62.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2484sm10186342f8f.11.2026.07.31.14.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 14:50:46 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Pedraza <maximpedraza@gmail.com>
Subject: [RFC PATCH 1/6] dt-bindings: display: add a device tree supplied boot logo
Date: Fri, 31 Jul 2026 23:50:38 +0200
Message-Id: <20260731215043.30392-2-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260731215043.30392-1-maximpedraza@gmail.com>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
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
 .../display/linux,boot-logo-clut224.yaml      | 108 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml

diff --git a/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
new file mode 100644
index 000000000..10845378d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
@@ -0,0 +1,108 @@
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
+  Embedded systems commonly need a product specific boot logo. Today the only
+  way to get one is to replace one of the logo_*_clut224.ppm files in the
+  kernel source tree, which means the image is baked into the kernel image and
+  a new kernel has to be built and deployed to change it.
+
+  This node lets the boot logo be described by the device tree instead, so that
+  a single kernel image can serve several products, or several revisions of the
+  same product, that only differ in branding.
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
+additionalProperties: false
+
+examples:
+  - |
+    // A 4x2 logo using three colours, centred on the screen.
+    logo {
+        compatible = "linux,boot-logo-clut224";
+        width = <4>;
+        height = <2>;
+        clut = /bits/ 8 <0xff 0x00 0x00
+                         0x00 0xff 0x00
+                         0x00 0x00 0xff>;
+        data = /bits/ 8 <0x00 0x01 0x01 0x00
+                         0x02 0x00 0x00 0x02>;
+        logo-centered;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e08767323..3f0ede165 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9951,6 +9951,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
+F:	Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
 F:	Documentation/fb/
 F:	drivers/video/
 F:	include/linux/fb.h
-- 
2.39.5

