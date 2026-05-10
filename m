Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCDC36604F;
	Sun, 10 May 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778432886; cv=none; b=F3aspuW/iwQlh3ednmc6s0R4Zk7BhAmLG9+RpBXZVs/v72hLw5OTQRkQtozLFLvZNSl0JAgQN8pVUccgwfIVpfSp0uvrvXlNRkKFt7QxJ6PWp6xdOpUQk3XF2RUSTl4iPEAOlpOMXVcaV2H5/dpHXjgkFr8hbGkbRIH1kOL509Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778432886; c=relaxed/simple;
	bh=iKJneMRztolsBk2xzLjaNWEDzTv7OmrvEYBQz5gU7G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8KU7Kf9S9Em6XxQdGnqGwgJ3Q12jl2QVef/F10xMzACICOCowAsttziHfOSyyrMJCOht7jI1xDyJ+wMffloNpi9gIbmYtfNiWh9gw9waIbMclHLW5AzJp6VPe5blA+LIXUD49fjNUsDGYQ9Lvcdc2GdMsHErBo0eIhHdxF0+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5Nm4NS4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5Nm4NS4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB2F2C2BCF7;
	Sun, 10 May 2026 17:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778432885;
	bh=iKJneMRztolsBk2xzLjaNWEDzTv7OmrvEYBQz5gU7G8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z5Nm4NS47RlFa/yJvv8bOJgkOY6xa2uIP+Znmq2M2xggs+6Czb8XrGvAwsBse9yrA
	 0pYD0ZUi9UZU3Sw3fpXj7iDflCV6ecLRMWo7+H3cDbtUokxZ4b06nKmBsl1mrXxzkf
	 pVNlEbjcTLKK/yzizOtHhLeoRYFZyekln7aUA9dOnlzHlQDPwKtlNlasqTB9sVrkRQ
	 QgecNyiU4Tmh6EJEjyo1qWR+pKYfb+u4As78WYgzfVMFifbW4k3NIOOvEx4w3f+vzd
	 QI8QRZXRVTCtxh6X/mx3fuAELMBWzo1MzDPJche2AI3wrOVDJVhVFcFR/cpT7Y/Iw2
	 GlatG+sknGuKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12CFCD37B2;
	Sun, 10 May 2026 17:08:05 +0000 (UTC)
From: Alexandre Hamamdjian via B4 Relay <devnull+azkali.limited.gmail.com@kernel.org>
Date: Mon, 11 May 2026 00:08:02 +0700
Subject: [PATCH 1/2] dt-bindings: leds: backlight: add Silergy SY7758
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-sy7758-v1-1-999a33081304@gmail.com>
References: <20260511-sy7758-v1-0-999a33081304@gmail.com>
In-Reply-To: <20260511-sy7758-v1-0-999a33081304@gmail.com>
To: Philippe Simons <simons.philippe@gmail.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, 
 Alexandre Hamamdjian <azkali.limited@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778432883; l=3003;
 i=azkali.limited@gmail.com; s=20260510; h=from:subject:message-id;
 bh=xa2gZ/M/2jO0IM2Gtg+AOrWfpBhxUQx0L8Qoyix2bVo=;
 b=DxgLwuNJfSbI2yI5k29rOgZdxFvMMfYx54mJ/frpVx8GFiAEsKty/2JyRUjzlvgNcuxzvaujX
 KmiCoAYPBz7B0UI9ooWk3FIrHaAHhAm9xZGCOdseABRJlrLblChR6FN
X-Developer-Key: i=azkali.limited@gmail.com; a=ed25519;
 pk=I0Z0IdCdQJqNGX+FQUnXhrHg950u3cM6Xzz3YT6JOyQ=
X-Endpoint-Received: by B4 Relay for azkali.limited@gmail.com/20260510 with
 auth_id=774
X-Original-From: Alexandre Hamamdjian <azkali.limited@gmail.com>
Reply-To: azkali.limited@gmail.com

From: Alexandre Hamamdjian <azkali.limited@gmail.com>

The Silergy SY7758 is an I2C-controlled multi-channel LED backlight
driver typically used to drive the edge-lit LED strings of LCD panels
in handheld and embedded devices. Brightness is programmed as a 12-bit
linear value through two 8-bit registers.

Document the binding for the new compatible "silergy,sy7758" so it can
be referenced by board device trees and the matching driver, and add a
MAINTAINERS entry covering both the binding and the upcoming driver.

Co-developed-by: Philippe Simons <simons.philippe@gmail.com>
Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
---
 .../bindings/leds/backlight/silergy,sy7758.yaml    | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
new file mode 100644
index 000000000000..408029e19e2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/silergy,sy7758.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silergy SY7758 I2C LED backlight controller
+
+maintainers:
+  - Alexandre Hamamdjian <azkali.limited@gmail.com>
+  - Philippe Simons <simons.philippe@gmail.com>
+
+description:
+  The Silergy SY7758 is an I2C-controlled multi-channel LED backlight
+  driver typically used to drive the edge-lit LED strings of LCD panels
+  in handheld and embedded devices. Brightness is programmed as a 12-bit
+  linear value through two 8-bit registers.
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
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        backlight@36 {
+            compatible = "silergy,sy7758";
+            reg = <0x36>;
+            max-brightness = <4080>;
+            default-brightness = <1500>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f877e5aaf2c7..9c132394ca41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24561,6 +24561,13 @@ S:	Maintained
 F:	drivers/input/touchscreen/silead.c
 F:	drivers/platform/x86/touchscreen_dmi.c
 
+SILERGY SY7758 BACKLIGHT DRIVER
+M:	Alexandre Hamamdjian <azkali.limited@gmail.com>
+M:	Philippe Simons <simons.philippe@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
+F:	drivers/video/backlight/sy7758.c
+
 SILICON LABS WIRELESS DRIVERS (for WFxxx series)
 M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
 L:	linux-wireless@vger.kernel.org

-- 
2.54.0


