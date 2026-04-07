Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897126FA6F;
	Tue,  7 Apr 2026 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572906; cv=none; b=Ew8p10YkWyg2OOsKa+qG+iHvvEDIF3b7kRt9yX/oWe6/zoKQuE3pxTsESgAGOWJBn9MiCltS5wP7jeiwWXWR3pu25NmViTq2dg7DUoYw8Tl/uUeyX6YBkiJTRo+IEG0fuPbJAQ324Gxc4L1eUIW0XRjWYpw9qr1kzdYFdte3VOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572906; c=relaxed/simple;
	bh=RzDcyPpemAgfYuOygoQAvIaSmqDPhC/cS4bP5B6vsvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S2VaG9m0GP8fipjWprsZ0rEDkSFgl6extB0JwteX4qQdYun004P2aT+olXtrIf47bsGX1zG7cqFbjbT33Kkk9pDEHzzsmDHg497rc/0XA9AYq00QdLLj24KrnMbyTK6Ugp/lcWkbOgRrH1w2xd4efQxf3K7lsebd7fNpYpn+7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdC2ZRum; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdC2ZRum"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A0E1C2BCB1;
	Tue,  7 Apr 2026 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775572906;
	bh=RzDcyPpemAgfYuOygoQAvIaSmqDPhC/cS4bP5B6vsvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KdC2ZRummxRlxnxpEdSJ+S5oaMhp8Fel7VS4LiwcfzuZWVqMu1KPxHaLSpLBTxep9
	 VZUzRhh7euUVECUqu43UNIE4fiHkXHVnrW8fRfXEmSR9BBKXaJ4u2+Vu8WPaa6ffvt
	 DENSBYWARF3c/8AmI6kOXuW3Yxeme7rzz7sGQAXj+CHiC5Fc9WmYTcabYvzeoRWu0/
	 4hDg0sUDP1asWXW1dfcQbQIlxewn/wZoWNx3tmjPKiB6CjL37CYcugp3/UbvO7Kt7M
	 RjG6FlZQF1jkgzw8ByB81l3jvZgQslbyDn3aDtFJ5OAM5jt1heJk36wVFXrZ26rex3
	 Rp3b2aAHgAAsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4096BFEEF49;
	Tue,  7 Apr 2026 14:41:46 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Tue, 07 Apr 2026 16:41:44 +0200
Subject: [PATCH v8 3/4] arm64: dts: freescale:
 moduline-display-av101hdt-a10: add backlight
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-max25014-v8-3-14eac7ed673a@gocontroll.com>
References: <20260407-max25014-v8-0-14eac7ed673a@gocontroll.com>
In-Reply-To: <20260407-max25014-v8-0-14eac7ed673a@gocontroll.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775572904; l=1537;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=+1ZENSjRFgYpM2Bg8jk7rZIWi1Ty068ZRlt35oCUryc=;
 b=0ktw1f1QYWGRXyCye0CHAz+5y7kZhEL1jZgm01VD72KtioV07SuLqeQAX+BgbSC7KnRqOhQGs
 S2CXzIuvk6GChmPwln6g//DfN/g6Qoz3HY20ADDvfX8tlw8TxOsWz8s
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add the missing backlight driver.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 ...x8p-ml81-moduline-display-106-av101hdt-a10.dtso | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dtso b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dtso
index c6fc5d5b1e5fa..23e4bf64b28b5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dtso
@@ -17,6 +17,7 @@
 
 	panel {
 		compatible = "boe,av101hdt-a10";
+		backlight = <&backlight>;
 		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		pinctrl-0 = <&pinctrl_panel>;
 		pinctrl-names = "default";
@@ -40,7 +41,30 @@ reg_vbus: regulator-vbus {
 	};
 };
 
+&i2c4 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	backlight: backlight@6f {
+		compatible = "maxim,max25014";
+		reg = <0x6f>;
+		default-brightness = <50>;
+		enable-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight>;
+		maxim,iset = <7>;
+		maxim,strings = <1 1 1 0>;
+	};
+};
+
 &iomuxc {
+	pinctrl_backlight: backlightgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO04__GPIO1_IO04
+				(MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
+		>;
+	};
+
 	pinctrl_panel: panelgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07

-- 
2.53.0


