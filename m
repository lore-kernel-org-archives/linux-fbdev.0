Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794339542;
	b=Zm4Xeu4bRsOt+cQkw4Qqf06Nhxrf0KPkmZwRYsua3Pf9UzwTCRwVhK0bMhSyDje+gbCt
	 Url5UAow1ByJFs72USotvOYgdPFCCwf/IZfytMx4d2gcR3iR+1MqZez5spN8ZfXDVAzw9
	 8FVm1brshCajUr5GMp7jF8lixSjFT4xhDz4JQoZYUnt9rff31upQCygU1Tfq6AdWpqKhu
	 sEDvvAW47PBSEadSCxva4XT8oz1kyr983SQln4a2ue+Gv+ywSysH8mkZNGt25/zQahf5F
	 kzICpI4yU4Czh7JA763K4HDTEvoZ4Oe9YTCyVv74mGOIoCersxmEeb2GkCOZpYhXaNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339542;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=O/+BGesOKU5f0xAJukpRQmBDKIxhREPLINqlcSYLPdk=;
	b=BASKcFSry5ldmiM0KQVZracZu8s1l45vNcZK8eU298eTG8Yum2voRTDGl3/oLScz++YN
	 piGrPcbjEFffqCCHA10L7q4/J67fyJLuYHKmVlGNsGgJqRyevxTGX1gv1i8txuRMeanoE
	 5t4niTOxwHCqfe2T/LodoJt8BmpDVZnuIE/Lzfa6zJWZQ2Bz+j6DDtOHyVPv+d4nlZod4
	 SwJ4Z7igwOkB5ZNid/JR7gOC4lWDGWQ4Ewp9rDHF6VPU+7AxffUn51UqiLwV/P9PEKEqp
	 FWjNaTOc1ytsfvRKZTtgqKJBERdMSr8dBUuDm8Uip04Zg7JHBQIAH8H0rmWZ8YDN7Ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fs5wWVQ9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E6606A326;
	Tue, 10 Nov 2026 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fs5wWVQ9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794339541;
	b=SgfQH3I/znuL2Axg2SOodpLx+aPqGiPEg0J8wURUtaIciE9ZX+98C5ZVOZ5pknQ3UxO4
	 EM3V6DfCPgRRBg9pp0V93IBrQJ/rsPCSM/lopUTK3GT2fy8Y6gZyrqjw7LEGnDnkSaYlX
	 0sG77t+YjX7WTzTV8ZFRDawWzCqGgTOdddmnXHCOu7e+9Y91atf9NasIcEhiI+18ewQlQ
	 oXy3Rw7So0uuxLKY/qm9VnWiBeBfBkbzmc/ztkoz1CX0l2X9NgAyHeGmsHCiqn8jBLxL2
	 7rp3do4W2Jxt6rrnTlW8/Ag43RGRyRlJbv0B/Qd2k7KkSz4pdP5IYpBihOo+U+M3OhQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794339541;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=O/+BGesOKU5f0xAJukpRQmBDKIxhREPLINqlcSYLPdk=;
	b=t7rPXXHztJZ+8fNIhoksPjM7ukqiuIUwe9MQ7a3BWYoAKarzeuEn4jj5VdvMWLK5csf2
	 k4OBoyxDvhQWVIZCa53FyxkGjaKpOESj4FYa5rfLtLXvRQZNZjUwDtKzYQpuxPO9mn0Ot
	 nCvjRbccdiN/eLSjb1nB/BG+KZhZVcyBpu8BQSRXpLVSKDT9qReTvvsTWc5UBGNrPSJkB
	 dXQkeYVVNKHkx1vn4ZlZ/UNemuvpRX750QDWJJ92we22SUEvs+MuOgB9Ns7cMnv18IZNq
	 50hNFLc1RNWecKvYG414hqUTVMqJHEW15+Zk6oTsC5oWjsaHLmF95q2W9Fu/HcYIQtw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2CBF31F008A1;
	Tue, 10 Nov 2026 19:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339541;
	bh=O/+BGesOKU5f0xAJukpRQmBDKIxhREPLINqlcSYLPdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Fs5wWVQ9DRuQlfuGHi2dEh6TabYmSmovIcxCr9hxeIeAf0LxdUkAslEh6vKeL6u59
	 eAF2RhW5BkEfDBNAqC6mnpiMbkiXWmjIcP8S+wXLHM5Tem0Ir7OoiEwVWLxfE7+hmE
	 rxj/kcsb2FwY8s09WRtLqRPmgtDE9X1gnJdetMvkyANUDjKbL/XJ3VvoiYOmPgJoeC
	 9GWsEPMI56+NqLWhyqq8VVjqrSAedoWcJeCdQn/zyHxaeo8OnHvAhZbpQ2IIAG6ay/
	 2L+o5H1XdGPe8BbgDd9ak+PQVWRgkUVJXZ+xd2PRhCsQkj7M7ke1lBdMG+DGOfqRFO
	 n7T0GpRRa0qwA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 934B448C6C;
	Tue, 10 Nov 2026 19:38:59 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 10 Nov 2026 21:38:51 +0200
Subject: [PATCH v2 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-6768-ktd3137-v2-1-9496c51efea4@protonmail.com>
References: <20261110-6768-ktd3137-v2-0-9496c51efea4@protonmail.com>
In-Reply-To: <20261110-6768-ktd3137-v2-0-9496c51efea4@protonmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794339538; l=2696;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=wz/jtLWDL8VTmHtvudHzOrZOpQLPXPR2qqe1YTY2l1E=;
 b=wcqnle9jBXjKD6xEgKBnYadw8tjD9NTKRW5ZvHInS1AsjtKeLnJS0u4iIAMzaPrjTaKY1bkYN
 peexlp5JTXqC3+31JpeEadG9zpndWz/UBMAyF6h7cYFDdCTJb4oXlBO
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Kinetic KTD3137 is an LED IC, used in various mobile devices for the
display backlight. Add devicetree bindings documentation for this chip.

Datasheet: https://www.kinet-ic.com/uploads/KTD3137-04a.pdf

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 .../bindings/leds/backlight/kinetic,ktd3137.yaml   | 63 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml
new file mode 100644
index 000000000000..4d2bd5e9797f
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktd3137.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kinetic Technologies KTD3137 LED Backlight
+
+maintainers:
+  - Roman Vivchar <rva333@protonmail.com>
+
+description:
+  The Kinetic Technologies KTD3137 is an I2C LED backlight driver for medium
+  to large size LCD panels.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: kinetic,ktd3137
+
+  reg:
+    maxItems: 1
+
+  default-brightness:
+    maximum: 2047
+    default: 2047
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO connected to the HWEN pin.
+
+  led-max-microamp:
+    minimum: 5000
+    maximum: 29800
+    default: 20200
+
+  vin-supply: true
+
+required:
+  - compatible
+  - reg
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
+        backlight@36 {
+            compatible = "kinetic,ktd3137";
+            reg = <0x36>;
+            enable-gpios = <&pio 160 GPIO_ACTIVE_HIGH>;
+            led-max-microamp = <20200>;
+            default-brightness = <2047>;
+            vin-supply = <&vsys>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 15c7dc516f7c..24dd5b43f167 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14618,6 +14618,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2801.yaml
 F:	drivers/video/backlight/ktd2801-backlight.c
 
+KTD3137 BACKLIGHT DRIVER
+M:	Roman Vivchar <rva333@protonmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml
+
 KTEST
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	John Hawley <warthog9@eaglescrag.net>

-- 
2.56.0


