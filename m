Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB9346E4C;
	Fri, 23 Jan 2026 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769167892; cv=none; b=HHjD2GUW2m2g230Yfl0vnpZXZUI2LXCRdq7qkHDev9kc41LDC59iBEB/1IedDMShJ3U1j2pPJYl4H5APhhu0eO7sJj08F/0oeixAT9qDMRglltqg/xGFfFHHQNq06QceYWNPWRsulmsUGzdzm+0IgtkqB3hxfljLTtgV+D/qF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769167892; c=relaxed/simple;
	bh=CCx/kqDg6I83wk0E8eM9gJ1Oj6SxG/mFU/iGTdPjvGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3IDVaAm7bJST9uDv/TzedwfjTv3EHN4vMM3oaY2e0QIASaaJKS2l2f93VeXIhcZkpx/Lq9gfbxzN883fiKUDDsMGiRutKhOuT5Xd8sfCQao3IStgvZwU0C8xKxeAnkIIYexmHqtVQvRpx7ruEXEkxUL+ALq7LOf+N7Pr9tAjQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYPz1AY0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYPz1AY0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97BC1C2BC87;
	Fri, 23 Jan 2026 11:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769167892;
	bh=CCx/kqDg6I83wk0E8eM9gJ1Oj6SxG/mFU/iGTdPjvGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aYPz1AY0ymxNIwETkFIdBQje9rN4kyXNJg3qNXes/0bcCL40nBWrkruy8SaW3J5cW
	 oUPREw71CvO4BoKKXvde3qdoExyvVo/2rt+eOVSHUhIa3s6mBP0Mf7yioFbtBWsXkf
	 1fj/pwgFj5CepcDX+Wn0AgpRgE5lESr6Igjk8Oi8/e5Ybj+fDoOsXaEJo1PVhnLf/B
	 JTvYcmlS5Pibjk/Tu+AYOr0sFadmo54W+Y3rlrhhgRPl9I66H6txwrZIGNyzJcErWN
	 hkBzMuvGBZQkVeRTiUx6Q/W0YU9IBUAuyYMMeMULTcQAFHv0KPIBYJYEQbwUu7DNub
	 AfwtHktxho0CA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB64D7236C;
	Fri, 23 Jan 2026 11:31:32 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Fri, 23 Jan 2026 12:31:33 +0100
Subject: [PATCH v7 4/4] arm64: dts: freescale:
 moduline-display-av123z7m-n17: add backlight
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-max25014-v7-4-15e504b9acc7@gocontroll.com>
References: <20260123-max25014-v7-0-15e504b9acc7@gocontroll.com>
In-Reply-To: <20260123-max25014-v7-0-15e504b9acc7@gocontroll.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769167891; l=1565;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=h3zqJBjPWCRRFOamEmSYnLNeMhZkUwqVa+0eK4+1+KA=;
 b=URPfA67ijU720rzLEbQWlfOakMi8xMeNSO5lod3dESL/XDlERHc1UehgPCXECcGLOAP0DoU/+
 aGAQTPzvL3YAKCu55+Z4zgQXKQhYJLYXTwKd84m2SE/Fvj4M7ngA78r
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add the missing backlight.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 ...tx8p-ml81-moduline-display-106-av123z7m-n17.dtso | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av123z7m-n17.dtso b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av123z7m-n17.dtso
index 3eb665ce9d5d..66d98a18d898 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av123z7m-n17.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av123z7m-n17.dtso
@@ -16,6 +16,7 @@
 
 	panel {
 		compatible = "boe,av123z7m-n17";
+		backlight = <&backlight>;
 		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		pinctrl-0 = <&pinctrl_panel>;
 		pinctrl-names = "default";
@@ -91,10 +92,28 @@ lvds1_out: endpoint {
 		};
 	};
 
-	/* max25014 @ 0x6f */
+	backlight: backlight@6f {
+		compatible = "maxim,max25014";
+		reg = <0x6f>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		default-brightness = <50>;
+		enable-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight>;
+		maxim,iset = <7>;
+		maxim,strings = <1 1 1 1>;
+	};
 };
 
 &iomuxc {
+	pinctrl_backlight: backlightgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO04__GPIO1_IO04
+				(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
 	pinctrl_lvds_bridge: lvdsbridgegrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SAI1_TXD2__GPIO4_IO14

-- 
2.52.0


