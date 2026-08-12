Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5C2E7366;
	Wed, 12 Aug 2026 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.20.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786562545; cv=none; b=VyDB7z7+RXDdmZitC2ixAKoAeWIsQ9S9J1+P/FLc0LZQk36uuEzvyZxyDbZLrNkt5YjayfjMxgC+p3r7Wi26S1mk0RfL2zBJEQT1Z6FwoVZ7nfaxCPy8Xfbm8nuMjkyJCu2dNARNoRPyw1vWGgeHCyq5THJgnURvM3TPKzuw3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786562545; c=relaxed/simple;
	bh=/D1TyjjolyOpbbqlRf3O24pIbQmK5j0Q8e2sNNzvbfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L+NW3a0Wc99295l+vYjDXOruL4WE7SH6XaSLS6wYKY5q8dQhEPp9DD4v9wQBvhreVZ1Q6rA9E6QYZyYU2kovxby7iTKnhtR6K9a2Q1G2k4nxHfAWs0Mnd8/lJhtORSlLUG+u6paLRCuzkVjGoobGa13rI8F6gkwkVdopbUzmqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewith.io; spf=pass smtp.mailfrom=dewith.io; dkim=pass (1024-bit key) header.d=dewith.io header.i=@dewith.io header.b=APJmAMgb; arc=none smtp.client-ip=157.90.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewith.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dewith.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dewith.io header.i=@dewith.io header.b="APJmAMgb"
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by meve.dewith.io (Postfix) with ESMTPSA id 3685A1F9E8;
	Wed, 12 Aug 2026 19:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default;
	t=1786562536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4za2y1ou79cIvpCkyyLmILUA+4CrvvMOsp08HvbZVXg=;
	b=APJmAMgbk9uSoFJc5Kz/33eG0zIq/77C3ajSBlrgEDRR8M3aSnzVR5fq2vL/Rindb3Ba6W
	yuxFlI91ipRSRwAG+opVSceFPUUulmWDeWEl4+gZzPWwXYobN8hdxIFZ7gklompS1p1aRs
	UxDrZ+5CBASwA3qvtORud1q+5ek4brk=
From: Wim de With <wf@dewith.io>
Date: Wed, 12 Aug 2026 21:21:46 +0200
Subject: [PATCH v2 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-ocp8178-backlight-v2-1-4ad18b48bef8@dewith.io>
References: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
In-Reply-To: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
To: Wim de With <wf@dewith.io>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org
X-Mailer: b4 0.16.0

Add device tree bindings for the Orient Chip OCP8178 LED backlight
driver.

Signed-off-by: Wim de With <wf@dewith.io>
---
 .../bindings/leds/backlight/ocs,ocp8178.yaml       | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
new file mode 100644
index 0000000000000..57c44d3383b88
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/ocs,ocp8178.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Orient Chip OCP8178 backlight
+
+maintainers:
+  - Wim de With <wf@dewith.io>
+
+description:
+  The Orient Chip OCP8178 is a white LED backlight driver controlled by a single
+  GPIO line with a vendor-specific onewire protocol.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: ocs,ocp8178
+
+  enable-gpios:
+    description: GPIO to use to enable/disable and dim the backlight.
+    maxItems: 1
+
+  default-brightness:
+    maximum: 31
+
+  max-brightness:
+    maximum: 31
+
+required:
+  - compatible
+  - enable-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    backlight {
+        compatible = "ocs,ocp8178";
+        enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
+        default-brightness = <13>;
+        max-brightness = <31>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index cfee5d47b214d..3ca99d9c32ef1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19678,6 +19678,11 @@ F:	drivers/mfd/ocelot*
 F:	drivers/net/dsa/ocelot/ocelot_ext.c
 F:	include/linux/mfd/ocelot.h
 
+OCP8178 BACKLIGHT DRIVER
+M:	Wim de With <wf@dewith.io>
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
+
 OCXL (Open Coherent Accelerator Processor Interface OpenCAPI) DRIVER
 M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
 R:	Andrew Donnellan <andrew+kernel@donnellan.id.au>

-- 
2.55.0

